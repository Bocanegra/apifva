package feriantes_grails

import grails.transaction.Transactional

@Transactional
class AccesoService {

    def crearAcceso(def tipo, def recurso, def perfil, def comentarios=null) {
        Acceso acceso = new Acceso(tipo:tipo, recurso:recurso,
                                   perfil:perfil.toString(), comentarios:comentarios)
        acceso.save(flush:true)
    }

}
