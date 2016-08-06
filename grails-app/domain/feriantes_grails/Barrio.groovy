package feriantes_grails

class Barrio {

    String anyo
    String lugar
    String socios
    String nosocios
    String planoFilename
    byte[] planoFiledata

    static constraints = {
        anyo (nullable:false)
        lugar (nullable:false)
        socios (nullable:true)
        nosocios (nullable:true)
        planoFilename (nullable:true)
        planoFiledata (nullable:true, maxSize:1073741824)
    }

    @Override
    String toString() {
        "[${anyo}]-${lugar}"
    }

}
