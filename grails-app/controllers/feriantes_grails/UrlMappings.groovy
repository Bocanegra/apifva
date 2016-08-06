package feriantes_grails

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:'feriante', action:'index')
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
