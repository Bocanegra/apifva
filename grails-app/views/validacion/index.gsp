<%@ page import="grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
        <asset:stylesheet src="jquery.simple-dtpicker.css"/>
        <asset:javascript src="jquery-2.2.0.min.js"/>
        <asset:javascript src="jquery.simple-dtpicker.js"/>
        <g:javascript>
            function to_check(doc_id, campo) {
                $.ajax({url:'${g.createLink(controller:"validacion", action:"check")}',
                        data:{'id':doc_id, 'campo': campo }
                });
            }
            function open_calendar(doc_id, field) {
                jQuery(field).appendDtpicker({
                    "locale": "es",
                    "dateFormat": "DD/MM/YY",
                    "dateOnly": true,
                    "closeButton": true,
                    "onHide": function(handler) {
                                    $.ajax({url:'${g.createLink(controller:"validacion", action:"update_fechas")}',
                                            data:{'id':doc_id, 'campo':field.id, 'fecha':$('#'+field.id).val() }
                                    });
									handler.destroy();
							  },
				    "onInit": function(handler) {
									handler.show();
							  }
                });
            }

        </g:javascript>

    </head>

    <body>
        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div id="content" class="content scaffold-list" role="main">
            <section class="row colset-2-its">
                <h1>Validación de documentaciones <b>${Calendar.instance.get(Calendar.YEAR)}</b></h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
            </section>

            <sec:ifAnyGranted roles='ROLE_ADMIN'>
                <ul class="property-list" role="navigation">
                    <li class="buttons">
                        <g:form action="delete">
                            Borrar documentaciones para el año:
                            <g:field name="year" type="text" size="4"/>
                            <g:field name="send" type="submit" value="Borrar" class="buttons"/>
                        </g:form>
                    </li>
                </ul>
                <br/>
            </sec:ifAnyGranted>

            <table>
                <thead>
                <tr>
                    <g:sortableColumn property="feriante" title="Feriante"/>
                    <g:sortableColumn property="pliego" title="Pliego"/>
                    <g:sortableColumn property="hacienda" title="Hacienda"/>
                    <g:sortableColumn property="autonomo" title="Autón."/>
                    <g:sortableColumn property="seguro" title="Seguro"/>
                    <g:sortableColumn property="poliza" title="Póliza"/>
                    <g:sortableColumn property="verificacion" title="Verif."/>
                    <g:sortableColumn property="extintores" title="Extintor"/>
                    <g:sortableColumn property="alimentos" title="Alims."/>
                    <g:sortableColumn property="boletin" title="Boletín"/>
                    <g:sortableColumn property="fotos" title="Fotos"/>
                    <g:sortableColumn property="dni" title="DNI"/>
                    <g:sortableColumn property="solicitud" title="Solic."/>
                </tr>
                </thead>
                <tbody>
                <g:each in="${documentacionList}" status="i" var="docInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td width="7%">${fieldValue(bean:docInstance, field:'feriante')}</td>
                        <td width="7%">
                            <g:checkBox name="pliego" value="${docInstance.pliego}" onclick="to_check(${docInstance.id},'pliego')"/>
                            <br/><g:field name="f_pliego" type="text" value="${docInstance.f_pliego}" size="6" onclick="open_calendar(${docInstance.id}, this)"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="hacienda" value="${docInstance.hacienda}" onclick="to_check(${docInstance.id},'hacienda')"/>
                            <br/><g:field name="f_hacienda" type="text" value="${docInstance.f_hacienda}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="autonomo" value="${docInstance.autonomo}" onclick="to_check(${docInstance.id},'autonomo')"/>
                            <br/><g:field name="f_autonomo" type="text" value="${docInstance.f_autonomo}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="seguro" value="${docInstance.seguro}" onclick="to_check(${docInstance.id},'seguro')"/>
                            <br/><g:field name="f_seguro" type="text" value="${docInstance.f_seguro}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="poliza" value="${docInstance.poliza}" onclick="to_check(${docInstance.id},'poliza')"/>
                            <br/><g:field name="f_poliza" type="text" value="${docInstance.f_poliza}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="verificacion" value="${docInstance.verificacion}" onclick="to_check(${docInstance.id},'verificacion')"/>
                            <br/><g:field name="f_verificacion" type="text" value="${docInstance.f_verificacion}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="extintores" value="${docInstance.extintores}" onclick="to_check(${docInstance.id},'extintores')"/>
                            <br/><g:field name="f_extintores" type="text" value="${docInstance.f_extintores}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="alimentos" value="${docInstance.alimentos}" onclick="to_check(${docInstance.id},'alimentos')"/>
                            <br/><g:field name="f_alimentos" type="text" value="${docInstance.f_alimentos}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="boletin" value="${docInstance.boletin}" onclick="to_check(${docInstance.id},'boletin')"/>
                            <br/><g:field name="f_boletin" type="text" value="${docInstance.f_boletin}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="fotos" value="${docInstance.fotos}" onclick="to_check(${docInstance.id},'fotos')"/>
                            <br/><g:field name="f_fotos" type="text" value="${docInstance.f_fotos}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="dni" value="${docInstance.dni}" onclick="to_check(${docInstance.id},'dni')"/>
                            <br/><g:field name="f_dni" type="text" value="${docInstance.f_dni}" size="6"/>
                        </td>

                        <td width="7%">
                            <g:checkBox name="solicitud" value="${docInstance.solicitud}" onclick="to_check(${docInstance.id},'solicitud')"/>
                            <br/><g:field name="f_solicitud" type="text" value="${docInstance.f_solicitud}" size="6"/>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>

        </div>

    </body>
</html>
