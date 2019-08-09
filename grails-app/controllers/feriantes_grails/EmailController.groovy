package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured

class EmailController {

    def grailsResourceLocator
    def springSecurityService

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    def index() {
        render(view: 'index')
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    def informativo() {
        def feriantes = feriantesAnualesConEmail()
        def txtFile = grailsResourceLocator.findResourceForURI("/informativo.txt").getFile()
        render(view: "/email/informativo", model: ["ferianteList": feriantes, "template": txtFile.text])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    def justificante() {
        def feriantes = feriantesAnualesConEmail()
        def txtFile = grailsResourceLocator.findResourceForURI("/justificante.txt").getFile()
        render(view: "/email/justificante", model: ["ferianteList": feriantes, "template": txtFile.text])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    def generico() {
        def feriantes = feriantesAnualesConEmail()
        render(view: "/email/generico", model: ["ferianteList": feriantes])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE', 'ROLE_VOCAL'])
    def sendEmails() {
        def ids_feriantes = (params.feriantes instanceof String) ? [params.feriantes] : params.feriantes
        def bodyHtml = params.bodyHtml ?: false
        def justificantePago = params.justificantePago ?: false
        def year = Calendar.instance.get(Calendar.YEAR).toString()
        int emailsEnviados = 0
        // Check de pagado si es el justificante de pago de un feriante (v1.5.1)
        if (justificantePago) {
            Feriante feriante = Feriante.get(ids_feriantes[0])
            if (feriante != null) {
                feriante.todoPagado = true
                feriante.save()
            }
        }
        // Se envía un mail a cada feriante con sus datos
        ids_feriantes.each { f_id ->
            Feriante feriante = Feriante.get(f_id)
            String template = params.template
            try {
                // Reemplazar huecos en la plantilla por datos del feriante
                template = template.replaceAll("«Anyo»", year)
                template = template.replaceAll("«Nombre»", feriante.nombre ?: "")
                template = template.replaceAll("«Parcela»", feriante.parcela.toString())
                template = template.replaceAll("«Sup_1»", feriante.formatSuperficie1())
                template = template.replaceAll("«Sup_2»", feriante.formatSuperficie2())
                template = template.replaceAll("«Total»", toDecimalString(feriante.getTotal()))
                template = template.replaceAll("«Pago1»", toDecimalString(feriante.getPago1()))
                template = template.replaceAll("«Pago2»", toDecimalString(feriante.getPago2()))
                template = template.replaceAll("«Fianza»", toDecimalString(feriante.getFianza()))
                template = template.replaceAll("«Sitio»", toDecimalString(feriante.getSitio()))
                template = template.replaceAll("«Gastos»", toDecimalString(feriante.getGastos()))
                template = template.replaceAll("«LuzAgua»", toDecimalString(feriante.getLuzAgua()))
                template = template.replaceAll("«Vivienda»", toDecimalString(feriante.getVivienda()))
                template = template.replaceAll("«Maquinas»", toDecimalString(feriante.getMaquinas()))
                template = template.replaceAll("«Deuda»", toDecimalString(feriante.getDeuda()))
                template = template.replaceAll("«Sanciones»", toDecimalString(feriante.getSancion()))
                template = template.replaceAll("«MotivoSanciones»", feriante.motivoSancion ?: "")
                sendMail {
                    to feriante.email
                    subject params.titulo ?: "Ferias Vírgen de San Lorenzo Valladolid ${year}"
                    if (bodyHtml) {
                        html template
                    } else {
                        text template
                    }
                }
                emailsEnviados++
            } catch (Exception e) {
                log.error("Error al enviar email a ${feriante}", e)
            }
        }
        flash.message = "Emails enviados con éxito ${emailsEnviados}: " + new Date()
        redirect(view: "index")
    }

    def feriantesAnualesConEmail() {
        // Comprobar si ya se han creado los feriantes de este año
        def year = Calendar.instance.get(Calendar.YEAR).toString()
        def feriantes = Feriante.findAllByAnyo(year, [sort: 'parcela']).findAll {
            return it.email != null
        }
        return feriantes
    }

    def toDecimalString(int valor) {
        return valor.toString().replaceFirst('^(\\d+)(\\d{3})(\\.|$)', '$1.$2$3')
    }

}
