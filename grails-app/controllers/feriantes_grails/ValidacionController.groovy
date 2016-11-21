package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.springframework.dao.DataIntegrityViolationException


@Transactional(readOnly = true)
class ValidacionController {

    def springSecurityService
    def accesoService

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_GESTORIA'])
    def index() {
        // Comprobar si hay alguna de este año
        def list = obtenerDocumentaciones()
        if (list && list.size() > 0) {
            render(view: "index", model: ["documentacionList": list])
        } else {
            render(view: "create")
        }
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def create() {
        // Comprobar si hay alguna de este año
        def list = obtenerDocumentaciones()
        if (list && list.size() > 0) {
            flash.message = "Ya hay documentaciones creadas con ese año. No debe existir ninguna."
        } else {
            def anyoActual = Calendar.instance.get(Calendar.YEAR).toString()
            accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoValidacion, springSecurityService.currentUser, anyoActual)
            // Crear una documentación por cada Feriante para este año
            Feriante.findAllByAnyo(anyoActual).each { feriante ->
                def documentacion = new Documentacion(anyo: anyoActual, feriante: feriante)
                documentacion.save(flush: true)
                feriante.save(flush:true)
                log.error("Creada: ${documentacion}")
            }
        }
        redirect(view: "index")
    }

    @Transactional
    @Secured(['ROLE_ADMIN','ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def delete() {
        accesoService.crearAcceso(Tipo.TipoBorrar, Recurso.RecursoValidacion, springSecurityService.currentUser, params.year)

        // Comprobar si hay alguna de este año
        Documentacion.findAllByAnyo(params.year).each { doc ->
            try {
                doc.feriante.documentacion = null
                doc.feriante.save()
                doc.delete(flush:true)
            } catch (DataIntegrityViolationException e) {
                log.error("No se ha podido eliminar ${it}")
            }
        }
        redirect(view: "index")
    }

    @Transactional
    @Secured(['ROLE_ADMIN','ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_GESTORIA'])
    def filter() {
        accesoService.crearAcceso(Tipo.TipoAcceder, Recurso.RecursoValidacion, springSecurityService.currentUser, "Filtrado")

        // Comprobar si hay alguna de este año
        def now = new Date()
        def filtered = obtenerDocumentaciones().grep { doc ->
            (doc.f_pliego && doc.f_pliego < now) ||
            (doc.f_hacienda && doc.f_hacienda < now) ||
            (doc.f_autonomo && doc.f_autonomo < now) ||
            (doc.f_seguro && doc.f_seguro < now) ||
            (doc.f_poliza && doc.f_poliza < now) ||
            (doc.f_verificacion && doc.f_verificacion < now) ||
            (doc.f_extintores && doc.f_extintores < now) ||
            (doc.f_alimentos && doc.f_alimentos < now) ||
            (doc.f_boletin && doc.f_boletin < now) ||
            (doc.f_fotos && doc.f_fotos < now) ||
            (doc.f_dni && doc.f_dni < now) ||
            (doc.f_solicitud && doc.f_solicitud < now)
        }
        render(view: "index", model: ["documentacionList": filtered])
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_GESTORIA'])
    def check() {
        // Llamada remota AJAX
        def doc = Documentacion.get(params.id)
        def campo = params.campo
        if (doc && campo) {
            doc[campo] = !doc[campo]
            doc.save()
        }
        render ""
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_GESTORIA'])
    def update_fechas() {
        // Llamada remota AJAX
        def doc = Documentacion.get(params.id)
        def campo = params.campo
        def fecha = params.date("fecha", "dd-MM-yy")
        if (doc && campo && fecha) {
            doc[campo] = fecha
            doc.save()
        }
        render ""
    }

    private static def obtenerDocumentaciones() {
        // Comprobar si hay alguna de este año
        def year = Calendar.instance.get(Calendar.YEAR).toString()
        return Documentacion.findAllByAnyo(year, [sort: 'feriante.parcela'])
    }

}