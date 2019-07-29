<%@ page import="feriantes_grails.TipoInformes; feriantes_grails.Feriante; grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>
        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
        <g:javascript>
            function checkAll() {
                $("input[type='checkbox']").prop("checked", true);
            }
            function checkNone() {
                $("input[type='checkbox']").prop("checked", false);
            }
            function showPagoOpts() {
                if ($('#tipo_informe option:selected').index() == 0) {
                    $('#info_doc_pago').show();
                } else {
                    $('#info_doc_pago').hide();
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
                <h1>Generación de informes año <b>${Calendar.instance.get(Calendar.YEAR)}</b></h1>
                <p>
                    Elige el tipo de informe y selecciona a todos los usuarios para los que haya que generarlo, y pulsa
                    en el botón "Generar".
                </p>

                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <g:form controller="informes">
                    <div align="center">
                        <g:select id="tipo_informe" name="tipo" from="${TipoInformes.values()}" value="${TipoInformes}"
                                  optionKey="key" onchange="showPagoOpts()"/>
                        <g:actionSubmit action="generar" value="Generar"/>
                    </div>
                    <br/>

                    <table id="info_doc_pago">
                        <tr>
                            <td colspan="2">Información sólo para el Documento de pago</td>
                        </tr>
                        <tr>
                            <td width="30%">Cuenta corriente (IBAN) de la Asociación:</td>
                            <td><g:field type="text" name="iban" value="ES84-0182-4641-1700-0017-0375 BBVA" size="60"/></td>
                        </tr>
                        <tr>
                            <td>Fecha límite <b>Primer pago</b>:</td>
                            <td><g:field type="text" name="fecha_primer_pago"/></td>
                        </tr>
                        <tr>
                            <td>Fecha límite <b>Segundo pago</b>:</td>
                            <td><g:field type="text" name="fecha_segundo_pago"/></td>
                        </tr>
                        <tr>
                            <td>Fecha límite <b>Fianza</b>:</td>
                            <td><g:field type="text" name="fecha_fianza"/></td>
                        </tr>
                        <tr>
                            <td>Fecha límite <b>Presentación de documentación</b>:</td>
                            <td><g:field type="text" name="fecha_documentacion"/></td>
                        </tr>
                    </table>

                    <table>
                        <thead>
                            <tr>
                                <th width="2">
                                    <g:field name="todos" type="button" value="Todos" onclick="checkAll()"/><br/>
                                    <g:field name="ninguno" type="button" value="Ninguno" onclick="checkNone()"/>
                                </th>
                                <g:sortableColumn property="anyo" title="Año"/>
                                <g:sortableColumn property="parcela" title="Parcela"/>
                                <g:sortableColumn property="nombre" title="Nombre"/>
                                <g:sortableColumn property="negocio" title="Negocio"/>
                                <g:sortableColumn property="dSuperficie1" title="Superficie 1"/>
                                <g:sortableColumn property="dSuperficie2" title="Superficie 2"/>
                                <g:sortableColumn property="email" title="Email"/>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${ferianteList}" status="i" var="ferianteInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    <td><g:field type="checkbox" name="feriantes" value="${ferianteInstance.id}"/></td>
                                    <td>${ferianteInstance.anyo}</td>
                                    <td>${ferianteInstance.parcela}</td>
                                    <td>${ferianteInstance.nombre}</td>
                                    <td>${ferianteInstance.negocio}</td>
                                    <td>${ferianteInstance.dSuperficie1}</td>
                                    <td>${ferianteInstance.dSuperficie2}</td>
                                    <td>${ferianteInstance.email}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </g:form>

            </section>
        </div>

    </body>
</html>
