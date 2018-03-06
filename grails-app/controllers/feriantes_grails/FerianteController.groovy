package feriantes_grails

import org.springframework.dao.DataIntegrityViolationException

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import jxl.*
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityService


@Transactional(readOnly = true)
class FerianteController {

    def springSecurityService
    def accesoService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_GESTORIA', 'ROLE_VOCAL'])
    def index() {
        // Comprobamos el usuario de la gestoría para redireccionarle
        springSecurityService.authentication.authorities.each {
            if (it.role == 'ROLE_GESTORIA') {
                redirect(controller:"validacion")
            }
        }
        render(view: "index", model: [hasFeriantes: feriantesAnuales()!=null, anyos: obtenerDistintosAnyos(),
                                      notas: Nota.dameNotas()])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def actualizaNotas() {
        if (params.notas) {
            accesoService.crearAcceso(Tipo.TipoModificar, Recurso.RecursoNotas, springSecurityService.currentUser, params.notas.length())
            Nota.guardaNotas(params.notas)
        }
        redirect(view: "index")
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def newFeriantes() {
        def anyoActual = Calendar.instance.get(Calendar.YEAR).toString()
        if (params.anyo) {
            accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoFeriantes, springSecurityService.currentUser, "Feriantes año ${params.anyo}")
            Feriante.findAllByAnyo(params.anyo).each { oldFeriante ->
                def newFeriante = new Feriante(oldFeriante.properties)
                newFeriante.anyo = anyoActual
                newFeriante.documentacion = null
                newFeriante.save(flush:true)
                log.error("Creado Feriante ${newFeriante}")
            }
        } else {
            flash.message = "Falta el año de donde copiarlos"
        }
        redirect(view: "index")
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def deleteFeriantes() {
        if (params.anyo) {
            accesoService.crearAcceso(Tipo.TipoBorrar, Recurso.RecursoFeriantes, springSecurityService.currentUser, params.anyo)
            Documentacion.findAllByAnyo(params.anyo).each { doc ->
                try {
                    doc.delete(flush: true)
                } catch (DataIntegrityViolationException e) {
                    log.error("No se ha podido eliminar ${doc}")
                }
            }
            Feriante.findAllByAnyo(params.anyo).each { feriante ->
                try {
                    feriante.documentacion = null
                    feriante.delete(flush: true)
                } catch (DataIntegrityViolationException e) {
                    log.error("No se ha podido eliminar ${feriante}")
                }
            }
        } else {
            flash.message = "No se pueden eliminar los Feriantes originales"
        }
        redirect(action: "list")
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    def list() {
        def year = params.anyo ?: Calendar.instance.get(Calendar.YEAR).toString()
        def paramOrdered = params + [sort: 'parcela']
        render (view: "list",
                model:[anyos: obtenerDistintosAnyos(), ferianteList: Feriante.findAllByAnyo(year, paramOrdered)])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    def show(Feriante feriante) {
        respond feriante
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def create() {
        respond new Feriante(params)
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def save(Feriante feriante) {
        if (feriante == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (feriante.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond feriante.errors, view:'create'
            return
        }

        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoFeriantes, springSecurityService.currentUser, feriante.nombre)
        feriante.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'feriante.label', default: 'Feriante'), feriante.id])
                redirect feriante
            }
            '*' { respond feriante, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def edit(Feriante feriante) {
        respond feriante
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def update(Feriante feriante) {
        if (feriante == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (feriante.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond feriante.errors, view:'edit'
            return
        }

        accesoService.crearAcceso(Tipo.TipoModificar, Recurso.RecursoFeriantes, springSecurityService.currentUser, feriante.id)
        feriante.save(flush: true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'feriante.label', default: 'Feriante'), feriante.id])
                redirect feriante
            }
            '*'{ respond feriante, [status: OK] }
        }
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def delete(Feriante feriante) {
        if (feriante == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        accesoService.crearAcceso(Tipo.TipoBorrar, Recurso.RecursoFeriantes, springSecurityService.currentUser, feriante.id)
        feriante.delete flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'feriante.label', default: 'Feriante'), feriante.id])
                redirect action: "list", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'feriante.label', default: 'Feriante'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def importer() {

    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def importing() {
        // Importante para leer bien acentos y demás símbolos
        System.setProperty("file.encoding", "ISO-8859-1")

        def f = request.getFile("datosExcel")
        if (f.empty) {
            flash.message = "Es necesario un fichero Excel"
            render(view: 'importer')
            return
        }

        if (Feriante.count > 0) {
            flash.message = "Ya hay Feriantes cargados, no se pueden volver a cargar"
            render(view: 'importer')
            return
        }

        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoFeriantes, springSecurityService.currentUser, "Carga desde Excel")
        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0)
        // skip first row (row 0) by starting from 1
        for (int row = 1; row < sheet.getRows(); row++) {
            Cell parcela = sheet.getCell(0, row)
            Cell nombre = sheet.getCell(1, row)
            Cell negocio = sheet.getCell(2, row)
            Cell direccion = sheet.getCell(3, row)
            Cell codigoPostal = sheet.getCell(4, row)
            Cell poblacion = sheet.getCell(5, row)
            Cell provincia = sheet.getCell(6, row)
            Cell telefono = sheet.getCell(7, row)
            Cell superficie1 = sheet.getCell(8, row)
            Cell precio1 = sheet.getCell(9, row)
            Cell superficie2 = sheet.getCell(10, row)
            Cell precio2 = sheet.getCell(11, row)
            Cell gastos = sheet.getCell(13, row)
            Cell luzAgua = sheet.getCell(14, row)
            Cell vivienda = sheet.getCell(15, row)
            Cell maquinas = sheet.getCell(16, row)
            Cell deuda = sheet.getCell(17, row)
            Cell sancion = sheet.getCell(18, row)
            Cell motivoSancion = sheet.getCell(19, row)
            Cell fianza = sheet.getCell(23, row)
            Cell dni = sheet.getCell(24, row)

            Feriante feriante = new Feriante(
                    anyo: Feriante.anyoBase,  // Importante, el año "0" es el master de la base de datos
                    parcela: preparaCelda(parcela, Integer),
                    nombre: preparaCelda(nombre, String),
                    negocio: preparaCelda(negocio, String),
                    direccion: preparaCelda(direccion, String),
                    codigoPostal: preparaCelda(codigoPostal, String),
                    poblacion: preparaCelda(poblacion, String),
                    provincia: preparaCelda(provincia, String),
                    telefono: preparaCelda(telefono, String),
                    dSuperficie1: preparaCelda(superficie1, Integer),
                    dPrecio1: preparaCelda(precio1, Integer),
                    dSuperficie2: preparaCelda(superficie2, Integer),
                    dPrecio2: preparaCelda(precio2, Integer),
                    gastos: preparaCelda(gastos, Integer),
                    luzAgua: preparaCelda(luzAgua, Integer),
                    vivienda: preparaCelda(vivienda, Integer),
                    maquinas: preparaCelda(maquinas, Integer),
                    deuda: preparaCelda(deuda, Integer),
                    sancion: preparaCelda(sancion, Integer),
                    motivoSancion: preparaCelda(motivoSancion, String),
                    fianza: preparaCelda(fianza, Integer),
                    dni: preparaCelda(dni, String))
            if (feriante.save()) {
                log.debug("Feriante creado con éxito")
            } else {
                log.error("Error al crear Feriante ${row}")
                log.error("Error al crear Feriante ${feriante.errors}")
            }
        }

        redirect(action:'list', params:[anyo:"0"])
    }

    public static def preparaCelda(Cell celda, tipo) {
        if (tipo == Integer) {
            if (celda.type == CellType.LABEL) {
                return Integer.parseInt(((LabelCell)celda).string)
            } else if (celda.type == CellType.NUMBER) {
                return new Double(((NumberCell)celda).value).toInteger()
            } else {
                return 0
            }
        } else if (tipo == String) {
            if (celda.type == CellType.LABEL) {
                return ((LabelCell)celda).string
            } else if (celda.type == CellType.NUMBER) {
                return "" + new Double(((NumberCell)celda).value).toInteger()
            } else {
                return ""
            }
        }
    }

    public static def feriantesAnuales() {
        // Comprobar si ya se han creado los feriantes de este año
        def year = Calendar.instance.get(Calendar.YEAR).toString()
        return Feriante.findByAnyo(year)
    }

    // Obtiene de la base de datos de Feriantes todos los años distintos con algún Feriante
    private static def obtenerDistintosAnyos() {
        def results = Feriante.withCriteria {
            projections {
                distinct("anyo")
            }
        }
        return results
    }

}
