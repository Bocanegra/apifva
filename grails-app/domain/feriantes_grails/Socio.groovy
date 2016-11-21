package feriantes_grails

class Socio {

    Integer numeroSocio
    String nombre
    String direccion
    String codigoPostal
    String poblacion
    String provincia
    String movil1
    String nombre1
    String movil2
    String nombre2
    String telefonoFijo
    String nombreFijo
    String email
    String negocios

    static constraints = {
        numeroSocio (nullable:false, blank:false)
        nombre (nullable:false, blank:false)
        direccion (nullable: true)
        codigoPostal (nullable: true)
        poblacion (nullable: true)
        provincia (nullable: true)
        movil1 (nullable: true)
        nombre1 (nullable: true)
        movil2 (nullable: true)
        nombre2 (nullable: true)
        telefonoFijo (nullable: true)
        nombreFijo (nullable: true)
        email (email:true, nullable:true)
        negocios (nullable:true, widget:'textarea')
    }

    static mapping = {
        table 'Socios'
    }

    String getNombreConNumero() {
        return "[${numeroSocio}]: ${nombre}"
    }

    @Override
    String toString() {
        def descrip = "[${numeroSocio}]-${nombre?:""}"
        if (negocios) {
            negocios.split("\n").each {
                descrip += "\n\t- "+it
            }
        }
        return descrip
    }
}
