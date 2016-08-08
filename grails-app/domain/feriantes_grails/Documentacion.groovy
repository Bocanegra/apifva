package feriantes_grails

class Documentacion {

    String anyo
    // Opciones
    Boolean pliego = false
    Boolean hacienda = false
    Boolean autonomo = false
    Boolean seguro = false
    Boolean poliza = false
    Boolean verificacion = false
    Boolean extintores = false
    Boolean alimentos = false
    Boolean boletin = false
    Boolean fotos = false
    Boolean dni = false
    Boolean solicitud = false

    Date f_pliego
    Date f_hacienda
    Date f_autonomo
    Date f_seguro
    Date f_poliza
    Date f_verificacion
    Date f_extintores
    Date f_alimentos
    Date f_boletin
    Date f_fotos
    Date f_dni
    Date f_solicitud

//    Feriante feriante
    static belongsTo = [feriante:Feriante]

    static constraints = {
        anyo (nullable:false)
        f_pliego (nullable:true)
        f_hacienda (nullable:true)
        f_autonomo (nullable:true)
        f_seguro (nullable:true)
        f_poliza (nullable:true)
        f_verificacion (nullable:true)
        f_extintores (nullable:true)
        f_alimentos (nullable:true)
        f_boletin (nullable:true)
        f_fotos (nullable:true)
        f_dni (nullable:true)
        f_solicitud (nullable:true)
    }

    @Override
    String toString() {
        return "Doc [${anyo}] para feriante: ${feriante}"
    }
}
