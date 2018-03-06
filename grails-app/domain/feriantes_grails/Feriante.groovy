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
//    Integer superficie1 = 0
//    Integer precio1 = 0
//    Integer superficie2 = 0
//    Integer precio2 = 0
    Double dSuperficie1 = 0.0
    Double dPrecio1 = 0.0
    Double dSuperficie2 = 0.0
    Double dPrecio2 = 0.0
    String dni
    String email
    String IBAN
    // Pagos
    Integer gastos
    Integer luzAgua
    Integer vivienda
    Integer maquinas
    Integer deuda
    Integer sancion
    String motivoSancion
    Integer fianza
    Integer pagado

    Documentacion documentacion

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
//        superficie1 (nullable:true)
//        precio1 (nullable:true)
//        superficie2 (nullable:true)
//        precio2 (nullable:true)
        dSuperficie1 (nullable:true)
        dPrecio1 (nullable:true)
        dSuperficie2 (nullable:true)
        dPrecio2 (nullable:true)
        dni (nullable:true)
        gastos (nullable:true)
        luzAgua (nullable:true)
        vivienda (nullable:true)
        maquinas (nullable:true)
        deuda (nullable:true)
        sancion (nullable:true)
        motivoSancion (nullable:true)
        fianza (nullable:true)
        pagado (nullable:true)
        email (email:true, nullable:true)
        IBAN (nullable:true)
        documentacion (nullable:true)
    }

    static mapping = {
        table 'Feriantes'
    }

    @Override
    String toString() {
        return "${parcela}-[${anyo}]-${nombre?:""}"
    }

    def beforeUpdate() {
        normalizaValores()
    }

    def beforeInsert() {
        normalizaValores()
    }

    def normalizaValores() {
        if (gastos == null) {
            gastos = 0
        }
        if (luzAgua == null) {
            luzAgua = 0
        }
        if (vivienda == null) {
            vivienda = 0
        }
        if (maquinas == null) {
            maquinas = 0
        }
        if (deuda == null) {
            deuda = 0
        }
        if (sancion == null) {
            sancion = 0
        }
    }

    int getSitio() {
        ((dSuperficie1 * dPrecio1 + dSuperficie2 * dPrecio2) * 10).intValue() / 10
    }

    int getTotal() {
        try {
            return sitio + gastos + luzAgua + vivienda + maquinas + deuda + sancion
        } catch (Exception exc) {
            log.error("Error al obtener Total: "+exc)
            return 0
        }
    }

    int getPago1() {
        total * 0.5
    }

    int getPago2() {
        total - pago1
    }

    int getPendiente() {
        total - (pagado ? pagado : 0)
    }

    String formatSuperficie1() {
        return dSuperficie1.toString().replace(".", ",")
    }

    String formatSuperficie2() {
        return dSuperficie2.toString().replace(".", ",")
    }

    String formatPrecio1() {
        return dPrecio1.toString().replace(".", ",")
    }

    String formatPrecio2() {
        return dPrecio2.toString().replace(".", ",")
    }

}
