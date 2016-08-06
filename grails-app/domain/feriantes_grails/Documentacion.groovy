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

//    Feriante feriante
    static belongsTo = [feriante:Feriante]

    static constraints = {
        anyo (nullable: false)
    }

}
