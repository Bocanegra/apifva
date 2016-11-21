package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityService
import grails.transaction.Transactional
import org.docx4j.dml.wordprocessingDrawing.Inline
import org.docx4j.jaxb.Context
import org.docx4j.model.fields.merge.*
import org.docx4j.openpackaging.packages.WordprocessingMLPackage
import org.docx4j.openpackaging.parts.WordprocessingML.BinaryPartAbstractImage
import org.docx4j.wml.*

import static org.springframework.http.HttpStatus.*


class BarriosController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def grailsResourceLocator
    def springSecurityService
    def accesoService

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def index() {
        def listaSocios = Socio.list(sort:"numeroSocio", order:"asc")
        if (params.barrio) {
            def barrio = Barrio.get(params.barrio)
            render(view: "index", model:[sociosList: listaSocios,
                                         lugares: obtenerDistintosLugares(),
                                         sociosTxt: barrio.socios,
                                         nosociosTxt: barrio.nosocios])

        } else {
            render(view: "index", model:[sociosList: listaSocios,
                                         lugares: obtenerDistintosLugares()])
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def nuevo_barrio() {
        if (params.nuevo_lugar) {
            accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoBarrios, springSecurityService.currentUser, params.nuevo_lugar)
            def newBarrio = new Barrio(lugar:params.nuevo_lugar)
            newBarrio.anyo = Calendar.instance.get(Calendar.YEAR).toString()
            newBarrio.save(flush:true)
            log.error("Creado Barrio ${newBarrio}")
        }
        redirect(view: "index")
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def generar_fichero() {
        guardarDatos(request, params)

        // Generar fichero doc
        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoDocumentos, springSecurityService.currentUser, params.lugar)
        def docxFile = grailsResourceLocator.findResourceForURI("/BARRIOS.docx")
        if (!docxFile) {
            flash.message = "Plantilla para el tipo de informe no encontrada"
            redirect (view: "index")
        } else {
            WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.load(docxFile.inputStream)
            // Se rellenan todos los campos posibles de las plantillas
            def mappings = new HashMap<DataFieldName, String>()
            mappings.put(new DataFieldName("Lugar"), params.lugar.toUpperCase())
            mappings.put(new DataFieldName("TextSocios"), params.socios)
            mappings.put(new DataFieldName("TextNoSocios"), params.nosocios)
            // Se añade la imagen
            def imageFile = request.getFile("plano")
            if (imageFile.filename && imageFile.filename != "") {
                P image = newImage(wordMLPackage, imageFile.getBytes(), null, null, 0, 1);
                wordMLPackage.getMainDocumentPart().addObject(image);
            }
            MailMerger.setMERGEFIELDInOutput(MailMerger.OutputField.KEEP_MERGEFIELD);
            MailMerger.performMerge(wordMLPackage, mappings, true);
            File tmpFile = File.createTempFile("barrios-", ".docx")
            wordMLPackage.save(tmpFile)
            // Devolver el contenido del fichero
            response.setHeader("Content-Disposition", "attachment; filename=barrios.docx");
            response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
            response.outputStream << tmpFile.readBytes()
            tmpFile.delete()
        }
    }

    def guardarDatos(request, params) {
        def year = Calendar.instance.get(Calendar.YEAR).toString()
        def barrio = Barrio.findByAnyoAndLugar(year, params.lugar)
        if (!barrio) {
            // Si no existe para ese año, se crea
            accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoBarrios, springSecurityService.currentUser, params.lugar)
            barrio = new Barrio(anyo:year, lugar: params.lugar)
            log.error("Creado nuevo Barrio")
        }
        log.error("Barrio ${barrio}")
        // Y se actualiza con los nuevos datos
        accesoService.crearAcceso(Tipo.TipoModificar, Recurso.RecursoBarrios, springSecurityService.currentUser, params.lugar)
        barrio.socios = params.socios
        barrio.nosocios = params.nosocios
//        def planoFile = request.getFile("plano")
//        barrios.planoFilename = planoFile.originalFilename
//        barrios.planoFiledata = planoFile.getBytes()
        barrio.save(flush:true)
    }

    // Obtiene de la base de datos de Barrios todos los años distintos
    private static def obtenerDistintosAnyos() {
        def results = Barrio.withCriteria {
            projections {
                distinct("anyo")
            }
        }
        return results
    }

    private static def obtenerDistintosLugares() {
        def results = Barrio.withCriteria {
            projections {
                distinct("lugar")
            }
        }
        return results
    }

    /**
     * Create image, without specifying width
     */
    private static def newImage(WordprocessingMLPackage wordMLPackage,
                                byte[] bytes,
                                String filenameHint, String altText,
                                int id1, int id2) {

        BinaryPartAbstractImage imagePart = BinaryPartAbstractImage.createImagePart(wordMLPackage, bytes);

        Inline inline = imagePart.createImageInline( filenameHint, altText,
                id1, id2, false);

        // Now add the inline in w:p/w:r/w:drawing
        org.docx4j.wml.ObjectFactory factory = Context.getWmlObjectFactory();
        org.docx4j.wml.P  p = factory.createP();
        org.docx4j.wml.R  run = factory.createR();
        p.getContent().add(run);
        org.docx4j.wml.Drawing drawing = factory.createDrawing();
        run.getContent().add(drawing);
        drawing.getAnchorOrInline().add(inline);

        return p;
    }

    //
    // Scafolding
    //
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Barrio.list(params), model:[barrioCount: Barrio.count()]
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def show(Barrio barrio) {
        respond barrio
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def create() {
        respond new Barrio(params)
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    @Transactional
    def save(Barrio barrio) {
        if (barrio == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (barrio.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond barrio.errors, view:'create'
            return
        }

        barrio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'barrios.label', default: 'Barrio'), barrio.id])
                redirect barrio
            }
            '*' { respond barrio, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def edit(Barrio barrio) {
        accesoService.crearAcceso(Tipo.TipoModificar, Recurso.RecursoBarrios, springSecurityService.currentUser, barrio.id)
        respond barrio
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    @Transactional
    def update(Barrio barrio) {
        accesoService.crearAcceso(Tipo.TipoModificar, Recurso.RecursoBarrios, springSecurityService.currentUser, barrio.id)
        if (barrio == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        if (barrio.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond barrio.errors, view:'edit'
            return
        }
        barrio.save(flush:true)

        respond barrio, view:'show'
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    @Transactional
    def delete(Barrio barrio) {
        if (barrio == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        accesoService.crearAcceso(Tipo.TipoBorrar, Recurso.RecursoBarrios, springSecurityService.currentUser, barrio.id)
        barrio.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'barrios.label', default: 'Barrio'), barrio.id])
                redirect action:"list", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'barrios.label', default: 'Barrio'), params.id])
                redirect action: "list", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

}
