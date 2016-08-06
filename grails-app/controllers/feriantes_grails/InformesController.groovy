package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured
import org.docx4j.model.fields.merge.DataFieldName
import org.docx4j.model.fields.merge.MailMerger
import org.docx4j.model.fields.merge.MailMergerWithNext
import org.docx4j.openpackaging.packages.*
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart
import java.util.zip.*


class InformesController {

    def grailsResourceLocator
    def springSecurityService
    def accesoService

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def index() {
        def feriantes = feriantesAnuales()
        render(view:"index", model:["ferianteList": feriantes])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def generar() {
        if (params.tipo && params.feriantes) {
            accesoService.crearAcceso(Tipo.TipoCrear, Recurso.RecursoInformes, springSecurityService.currentUser, params.tipo)

            params.feriantes = (params.feriantes instanceof String) ? [params.feriantes] : params.feriantes
            def docs = informes(params.tipo, params.feriantes)
            if (docs.size() > 0) {
                // Crear zip con los ficheros y devolver
                ByteArrayOutputStream baos = new ByteArrayOutputStream()
                ZipOutputStream zipFile = new ZipOutputStream(baos)
                docs.each {
                    File file = new File(it.getAbsolutePath())
                    zipFile.putNextEntry(new ZipEntry(it.name))
                    file.withInputStream { i ->
                        zipFile << i
                    }
                    zipFile.closeEntry()
                }
                zipFile.finish()
                response.setHeader("Content-disposition", "filename=\"${params.tipo}.zip\"")
                response.contentType = "application/zip"
                response.outputStream << baos.toByteArray()
                response.outputStream.flush()
                return
            }
        }
        redirect (view:"index")
    }

    def informes(tipo, ids_feriantes) {
        log.fatal("Generando informes de tipo ${tipo}")
        def docs = []
        def docxFile = grailsResourceLocator.findResourceForURI("/${tipo}.docx")
        if (!docxFile) {
            flash.message = "Plantilla para el tipo de informe no encontrada"
        } else if (tipo in [TipoInformes.INFORMATIVO.key, TipoInformes.JUSTIFICANTE.key]) {
            WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.load(docxFile.inputStream)
            ids_feriantes.each { f_id ->
                Feriante feriante = Feriante.get(f_id)
                def mappings = creaMappings(feriante)

                // Se rellenan todos los campos posibles de las plantillas
                MailMerger.setMERGEFIELDInOutput(MailMerger.OutputField.KEEP_MERGEFIELD);
                MailMerger.performMerge(wordMLPackage, mappings, true);
                File tmpFile = File.createTempFile("${tipo}-Parcela_${feriante.parcela}-", ".docx")
                wordMLPackage.save(tmpFile)
                docs.add(tmpFile)
            }
        } else if (tipo == TipoInformes.ETIQUETAS.key) {
            WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.load(docxFile.inputStream)
            def list_mappings = new ArrayList<Map<DataFieldName, String>>()
            ids_feriantes.each { f_id ->
                Feriante feriante = Feriante.get(f_id)
                if (feriante.direccion && feriante.provincia) {
                    list_mappings.add(creaMappings(feriante))
                }
            }

            // Las etiquetas son un caso particular de Merge
            File tmpFile = File.createTempFile("${tipo}-", ".docx")
            MailMerger.setMERGEFIELDInOutput(MailMerger.OutputField.KEEP_MERGEFIELD);
            MailMergerWithNext.performLabelMerge(wordMLPackage, list_mappings);
            wordMLPackage.save(tmpFile)
            docs.add(tmpFile)
        }
        return docs
    }

    def feriantesAnuales() {
        // Comprobar si ya se han creado los feriantes de este año
        def year = Calendar.instance.get(Calendar.YEAR).toString()
        return Feriante.findAllByAnyo(year)
    }

    def creaMappings(Feriante feriante) {
        def mappings = new HashMap<DataFieldName, String>()
        mappings.put(new DataFieldName("Anyo"), feriante.anyo)
        mappings.put(new DataFieldName("Parcela"), feriante.parcela.toString())
        mappings.put(new DataFieldName("Sup_1"), feriante.superficie1.toString())
        mappings.put(new DataFieldName("Sup_2"), feriante.superficie2.toString())
        mappings.put(new DataFieldName("Nombre"), feriante.nombre)
        mappings.put(new DataFieldName("Direccion"), feriante.direccion)
        mappings.put(new DataFieldName("CP"), feriante.codigoPostal)
        mappings.put(new DataFieldName("Poblacion"), feriante.poblacion)
        mappings.put(new DataFieldName("Provincia"), feriante.provincia)
        mappings.put(new DataFieldName("Sitio"), feriante.sitio.toString())
        mappings.put(new DataFieldName("Gastos"), feriante.gastos.toString())
        mappings.put(new DataFieldName("LuzAgua"), feriante.luzAgua.toString())
        mappings.put(new DataFieldName("Vivienda"), feriante.vivienda.toString())
        mappings.put(new DataFieldName("Maquinas"), feriante.maquinas.toString())
        mappings.put(new DataFieldName("Deuda"), feriante.deuda.toString())
        mappings.put(new DataFieldName("Sanciones"), feriante.sancion.toString())
        mappings.put(new DataFieldName("MotivoSanciones"), feriante.motivoSancion)
        mappings.put(new DataFieldName("Total"), feriante.total.toString())
        mappings.put(new DataFieldName("Pago1"), feriante.pago1.toString())
        mappings.put(new DataFieldName("Pago2"), feriante.pago2.toString())
        mappings.put(new DataFieldName("Fianza"), feriante.fianza.toString())

        return mappings
    }
}

public enum TipoInformes {

    INFORMATIVO('Documento informativo'),
    JUSTIFICANTE('Justificante de pagos'),
    ETIQUETAS('Etiquetas')

    final String value

    TipoInformes(String value) {
        this.value = value
    }

    @Override
    String toString(){ value }
    String getKey() { name() }
}
