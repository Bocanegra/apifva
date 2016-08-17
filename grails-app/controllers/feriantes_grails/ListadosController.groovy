package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured
import grails.plugins.rendering.pdf.PdfRenderingService
import grails.transaction.Transactional
import grails.util.Holders

import javax.servlet.http.HttpServletResponse


@Transactional(readOnly = true)
class ListadosController {

    PdfRenderingService pdfRenderingService
    def springSecurityService
    def accesoService

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def index() {
        def defaultGrailsDomainClass = Holders.applicationContext.getBean("feriantes_grails.Feriante")
        render(view: "index", model:[properties:defaultGrailsDomainClass.properties.keySet()])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def ayuntamiento() {
        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoDocumentos, springSecurityService.currentUser, "Listado ayto.")
        if (params.download) {
            response.contentType = "application/pdf"
            response.setHeader "Content-disposition", "attachment; filename=ayuntamiento.pdf"
        }
        def year = params.anyo ?: Calendar.instance.get(Calendar.YEAR).toString()
        pdfRenderingService.render([controller: 'listados',
                                    template: 'ayuntamiento',
                                    model:[ferianteList: feriantesAnuales(year)]
        ], response)
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def impresion() {
        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoDocumentos, springSecurityService.currentUser, "Listado impresión")
        if (params.download) {
            response.contentType = "application/pdf"
            response.setHeader "Content-disposition", "attachment; filename=impresion.pdf"
        }
        def year = params.anyo ?: Calendar.instance.get(Calendar.YEAR).toString()
        pdfRenderingService.render([controller: 'listados',
                                    template: 'impresion',
                                    model:[ferianteList: feriantesAnuales(year)]
        ], response)
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def pago() {
        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoDocumentos, springSecurityService.currentUser, "Listado IBAN")
        if (params.download) {
            response.contentType = "application/pdf"
            response.setHeader "Content-disposition", "attachment; filename=iban.pdf"
        }
        def year = params.anyo ?: Calendar.instance.get(Calendar.YEAR).toString()
        pdfRenderingService.render([controller: 'listados',
                                    template: 'iban',
                                    model:[ferianteList: feriantesAnuales(year)]
        ], response)
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def personalizado() {
        accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoDocumentos, springSecurityService.currentUser, "Listado personalizado")
        if (params.download) {
            response.contentType = "application/pdf"
            response.setHeader "Content-disposition", "attachment; filename=impresion.pdf"
        }
        def year = params.anyo ?: Calendar.instance.get(Calendar.YEAR).toString()
        def campos_on = params.findAll { it.value == "on" }
        log.error(campos_on.keySet().sort())
        pdfRenderingService.render([controller: 'listados',
                                    template: 'personalizado',
                                    model:[ferianteList: feriantesAnuales(year),
                                           fieldList: campos_on.keySet()]
        ], response)
        render ""
    }

    public static def feriantesAnuales(year) {
        return Feriante.findAllByAnyo(year)
    }
}

//        new File("ayuntamiento.pdf").withOutputStream { outputStream ->
//            pdfRenderingService.render([controller: 'listados',
//                                        template: 'ayuntamiento',
//                                        model:[ferianteList: Feriante.list()]
//            ], response)
//        }
//        render (template: 'ayuntamiento', model:[ferianteList: Feriante.list()])
