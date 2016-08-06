package feriantes_grails

public enum Tipo {
    TipoDesconocido ("TD"),
    TipoBorrar      ("TB"),
    TipoCrear       ("TC"),
    TipoModificar   ("TM"),
    TipoEditar      ("TE"),
    TipoAcceder     ("TA"),
    TipoOtro        ("TO")

    String id
    Tipo(String id) { this.id = id }

}
