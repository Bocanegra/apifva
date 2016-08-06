package feriantes_grails

class Nota {

    static String PERFIL_TODOS = "TODOS"

    String perfil
    String texto
    Date dateCreated
    Date lastUpdated

    static constraints = {
        perfil nullable:false
        texto nullable:true, type:"text"
    }

    static dameNotas() {
        return findByPerfil(PERFIL_TODOS)?.texto
    }

    static guardaNotas(texto) {
        Nota notas = findByPerfil(PERFIL_TODOS)
        if (notas) {
            notas.texto = texto
        } else {
            notas = new Nota(perfil:PERFIL_TODOS, texto:texto)
        }
        notas.save(flush:true)
    }

}
