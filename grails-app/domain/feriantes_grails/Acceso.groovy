package feriantes_grails

//import org.grails.orm.hibernate.cfg.IdentityEnumType

class Acceso {

    Tipo tipo
    Recurso recurso
    String perfil
    String comentarios

    Date dateCreated

    static constraints = {
        tipo (nullable:false)
        recurso (nullable:false)
        perfil (nullable:false)
        comentarios (nullable:true)
    }

    @Override
    String toString() {
        "${tipo}-${recurso}: ${perfil}->${comentarios?:""}"
    }

}
