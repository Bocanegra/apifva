package feriantes_grails

class Barrio {

    String anyo
    String lugar
    String ubicacion
    String fechaMontaje
    String fechaApertura
    String fechaDesmontaje
    String socios
    String nosocios
    String planoFilename
    byte[] planoFiledata

    static mapping = {
        socios sqlType: 'varchar(5000)'
        nosocios sqlType: 'varchar(5000)'
    }

    static constraints = {
        anyo (nullable:false)
        lugar (nullable:false)
        ubicacion (nullable:true)
        fechaMontaje (nullable:true)
        fechaApertura (nullable:true)
        fechaDesmontaje (nullable:true)
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
