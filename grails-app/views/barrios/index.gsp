<%@ page import="feriantes_grails.Socio; feriantes_grails.Barrio" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
        <g:javascript>
            function appendSocio() {
                text = $('#socio').val();
                $('#socios').val($('#socios').val()+text+"\n");
                updateDoc();
            }
            function updateDoc() {
                text = "\nRELACIÓN DE FERIANTES QUE MONTARÁN EN \"";
                text += $('#lugar').val()+"\":\n\n";
                text += "RELACIÓN DE SOCIOS:\n";
                text += $('#socios').val()+"\n";
                text += "RELACIÓN DE NO SOCIOS:\n";
                text += $('#nosocios').val()+"\n\n";
                $('#notas').val(text);
            }
            function updateImg(evt) {
                var tgt = evt.target || window.event.srcElement;
                var files = tgt.files;
                // FileReader support
                if (FileReader && files && files.length) {
                    var fr = new FileReader();
                    fr.onload = function () {
                        document.getElementById('plano_img').src = fr.result;
                    }
                    fr.readAsDataURL(files[0]);
                }
            }
        </g:javascript>
    </head>

    <body>
        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div id="content" class="content scaffold-list" role="main">
            <section class="row colset-2-its">
                <h1>Generación de documentación para las Ferias</h1>

                <sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_SECRETARIO'>
                    <g:link action="list">Listado de Barrios</g:link>
                </sec:ifAnyGranted>

                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
            </section>

                <div id="barrios_left_col">
                    <table style="border-top-width:0">
                        <tr style="background-color: #66afe9">
                            <g:form action="index">
                                <td style="width:25%">
                                    <span>Cargar datos de</span>
                                </td>
                                <td style="width:60%">
                                    <g:select id="barrio" name="barrio" from="${Barrio.list()}" optionKey="id"/>
                                </td>
                                <td style="width:15%">
                                    <g:submitButton name="cargar" value="Cargar datos de este año"/>
                                </td>
                            </g:form>
                        </tr>

                        <tr style="background-color: #66afe9">
                            <g:form action="nuevo_barrio">
                                <td>
                                    <span>Nuevo Barrio</span>
                                </td>
                                <td>
                                    <g:field name="nuevo_lugar" type="text" size="30"/>
                                </td>
                                <td>
                                    <g:submitButton name="n_lugar_button" value="Crear nuevo"/>
                                </td>
                            </g:form>
                        </tr>

                        <g:uploadForm action="generar_fichero">
                            <tr>
                                <td></td>
                                <td><h2>Datos para la generación de documentación</h2></td>
                            </tr>
                            <tr>
                                <td><span>Ubicación de la instalación</span></td>
                                <td><g:textField name="ubicacion" value="${ubicacion}" size="40"/><br/></td>
                            </tr>
                            <tr>
                                <td><span>Fechas montaje</span></td>
                                <td><g:textField name="montaje" value="${montaje}" size="40"/><br/></td>
                            </tr>
                            <tr>
                                <td><span>Fechas apertura</span></td>
                                <td><g:textField name="apertura" value="${apertura}" size="40"/><br/></td>
                            </tr>
                            <tr>
                                <td><span>Fechas desmontaje</span></td>
                                <td><g:textField name="desmontaje" value="${desmontaje}" size="40"/><br/></td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Barrio</span>
                                </td>
                                <td>
                                    <g:select name="lugar" from="${lugares}" value="${lugar}" onchange="updateDoc()"/><br/>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <span>Socios</span>
                                </td>
                                <td>
                                    <g:select id="socio" name="socio" from="${sociosList}"
                                              optionValue="nombreConNumero"/>
                                </td>
                                <td>
                                    <g:field type="button" name="add_socio" value="Añadir" onclick="appendSocio()"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <g:textArea name="socios" value="${sociosTxt}" rows="10"
                                                class="barrios_text_area" onchange="updateDoc()"/>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="3">
                                    <span>No Socios</span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <g:textArea name="nosocios" value="${nosociosTxt}" rows="5"
                                                class="barrios_text_area" onchange="updateDoc()"/>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="3">
                                    <span>Apuntes (NO SE IMPRIMEN EN EL DOCUMENTO)</span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <g:textArea name="apuntes" value="${apuntesTxt}" rows="5"
                                                class="barrios_text_area"/>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <span>Plano de la Feria</span>
                                </td>
                                <td>
                                    <g:field name="plano" type="file" onchange="updateImg(this)"/>
                                    <br/>
                                    <img id="plano_img" src="" height="200">
                                </td>
                            </tr>

                            <tr>
                                <td/>
                                <td/>
                                <td><g:field type="submit" name="actualizar" value="Generar fichero y guardar"/></td>
                            </tr>

                        </g:uploadForm>

                    </table>
                </div>

                <div id="barrios_right_col">
                    <h2>Fichero a generar</h2>
                    <g:textArea name="notas" value="" rows="25" readonly="true" class="barrios_text_area_notas"/>
                    <br/><br/>
                </div>

        </div>

    </body>
</html>
