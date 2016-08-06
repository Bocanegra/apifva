package feriantes_grails

class Feriante {

    public static String anyoBase = "0"

    Integer parcela
    String anyo
    String nombre
    String negocio
    String direccion
    String codigoPostal
    String poblacion
    String provincia
    String telefono
    Integer superficie1 = 0
    Integer precio1 = 0
    Integer superficie2 = 0
    Integer precio2 = 0
    String dni
    Integer gastos
    Integer luzAgua
    Integer vivienda
    Integer maquinas
    Integer deuda
    Integer sancion
    String motivoSancion
    Integer fianza
    String email
    String IBAN

    Documentacion documentacion
//    static hasOne = [documentacion: Documentacion]

    Date dateCreated
    Date lastUpdated

    static constraints = {
        anyo (nullable:false, blank:false)
        parcela (nullable:false)
        nombre (nullable:true, blank:true)
        negocio (nullable:true, blank:true)
        direccion (nullable:true, blank:true)
        codigoPostal (nullable:true)
        poblacion (nullable:true)
        provincia (nullable:true)
        telefono (nullable:true)
        superficie1 (nullable:true)
        precio1 (nullable:true)
        superficie2 (nullable:true)
        precio2 (nullable:true)
        dni (nullable:true)
        gastos (nullable:true)
        luzAgua (nullable:true)
        vivienda (nullable:true)
        maquinas (nullable:true)
        deuda (nullable:true)
        sancion (nullable:true)
        motivoSancion (nullable:true)
        fianza (nullable:true)
        email (email:true, nullable:true)
        IBAN (nullable:true)
        documentacion (nullable:true)
    }

    static mapping = {
        table 'Feriantes'
    }

    int getSitio() {
        superficie1 * precio1 + superficie2 * precio2
    }

    int getTotal() {
        sitio + gastos + luzAgua + vivienda + maquinas + deuda + sancion
    }

    int getPago1() {
        total * 0.5
    }

    int getPago2() {
        total - pago1
    }

    @Override
    String toString() {
        return "${parcela}-[${anyo}]-${nombre?:""}"
    }
}
