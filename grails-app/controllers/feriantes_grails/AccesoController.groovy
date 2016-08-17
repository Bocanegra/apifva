package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured

class AccesoController {

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def index(Integer max) {
//        log.error("Index: ${params}")
        params.max = Math.min(max ?: 50, 100)
        if (params.result) {
            respond params.result, model:[accesoCount: params.result.size()]
        } else {
            respond Acceso.list(params), model:[accesoCount: Acceso.count()]
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def filtrar() {
//        log.error("Filtrar: ${params}")
        def result
        if (params.filtrar_tipo && params.tipo) {
            result = Acceso.findAllByTipo(params.tipo)
        } else if (params.filtrar_recurso && params.recurso) {
            result = Acceso.findAllByRecurso(params.recurso)
        } else {
            Date desdeDate = params.date("desde", 'dd-MM-yyyy')
            Date hastaDate = params.date("hasta", 'dd-MM-yyyy')
            result = Acceso.findAllByDateCreatedBetween(desdeDate, hastaDate)
        }
        render (view:"index", model:[accesoList: result, accesoCount: result.size()])
    }

}
