package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured
import jxl.Cell
import jxl.Sheet
import jxl.Workbook

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SocioController {

    def springSecurityService
    def accesoService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def index(Integer max) {
        params.max = Math.min(max ?: 50, 100)
        params.sort = 'numeroSocio'
        respond Socio.list(params), model:[socioCount: Socio.count()]
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def show(Socio socio) {
        respond socio
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def create() {
        respond new Socio(params)
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def save(Socio socio) {
        if (socio == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (socio.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond socio.errors, view:'create'
            return
        }

        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoSocios, springSecurityService.currentUser, socio.nombre)
        socio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'socio.label', default: 'Socio'), socio.id])
                redirect socio
            }
            '*' { respond socio, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def edit(Socio socio) {
        respond socio
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def update(Socio socio) {
        if (socio == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (socio.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond socio.errors, view:'edit'
            return
        }

        accesoService.crearAcceso(Tipo.TipoModificar, Recurso.RecursoSocios, springSecurityService.currentUser, socio.nombre)
        socio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'socio.label', default: 'Socio'), socio.id])
                redirect socio
            }
            '*'{ respond socio, [status: OK] }
        }
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def delete(Socio socio) {

        if (socio == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        accesoService.crearAcceso(Tipo.TipoBorrar, Recurso.RecursoSocios, springSecurityService.currentUser, socio.nombre)
        socio.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'socio.label', default: 'Socio'), socio.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'socio.label', default: 'Socio'), params.id])
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

        if (Socio.count > 0) {
            flash.message = "Ya hay Socios cargados, no se pueden volver a cargar"
            render(view: 'importer')
            return
        }

        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoSocios, springSecurityService.currentUser, "Carga desde Excel")
        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0)
        // skip first row (row 0) by starting from 1
        for (int row = 1; row < sheet.getRows(); row++) {
            Cell numSocio = sheet.getCell(0, row)
            Cell nombre = sheet.getCell(1, row)
            Cell direccion = sheet.getCell(2, row)
            Cell codigoPostal = sheet.getCell(3, row)
            Cell poblacion = sheet.getCell(4, row)
            Cell provincia = sheet.getCell(5, row)
            Cell movil1 = sheet.getCell(6, row)
            Cell nombreMovil1 = sheet.getCell(7, row)
            Cell movil2 = sheet.getCell(8, row)
            Cell nombreMovil2 = sheet.getCell(9, row)
            Cell fijo = sheet.getCell(10, row)
            Cell nombreFijo = sheet.getCell(11, row)

            Socio socio= new Socio(
                    numeroSocio: preparaCelda(numSocio, Integer),
                    nombre: preparaCelda(nombre, String),
                    direccion: preparaCelda(direccion, String),
                    codigoPostal: preparaCelda(codigoPostal, String),
                    poblacion: preparaCelda(poblacion, String),
                    provincia: preparaCelda(provincia, String),
                    movil1: preparaCelda(movil1, String),
                    nombre1: preparaCelda(nombreMovil1, String),
                    movil2: preparaCelda(movil2, String),
                    nombre2: preparaCelda(nombreMovil2, String),
                    telefonoFijo: preparaCelda(fijo, String),
                    nombreFijo: preparaCelda(nombreFijo, String))
            if (socio.save()) {
                log.debug("Socio creado con éxito")
            } else {
                log.error("Error al crear Socio ${row}")
                log.error("Error al crear Socio ${socio.errors}")
            }
        }
        redirect(action: 'index')
    }

    private static def preparaCelda(Cell celda, tipo) {
        FerianteController.preparaCelda(celda, tipo)
    }
}
