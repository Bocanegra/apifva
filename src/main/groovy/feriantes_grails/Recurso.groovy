package feriantes_grails

public enum Recurso {
    RecursoDesconocido("DE"),
    RecursoFeriantes("FE"),
    RecursoSocios("SO"),
    RecursoNotas("NO"),
    RecursoInformes("IN"),
    RecursoValidacion("VA"),
    RecursoBarrios("BA"),
    RecursoDocumentos("DO"),
    RecursoOtro("OT")

    String id

    Recurso(String id) { this.id = id }

}
