<%@ page import="grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
        <asset:stylesheet src="jquery-ui.css"/>
        <asset:javascript src="jquery-2.2.0.min.js"/>
        <asset:javascript src="jquery-ui.min.js"/>

        <g:javascript>
            function to_check(doc_id, campo) {
                $.ajax({url:'${g.createLink(controller:"validacion", action:"check")}',
                        data:{'id':doc_id, 'campo': campo }
                });
            }

            function open_calendar(doc_id, field) {
                jQuery(field).datepicker({
				    dateFormat: "dd-mm-y",
				    onSelect: function(dateText, inst) {
                                  $.ajax({url:'${g.createLink(controller:"validacion", action:"update_fechas")}',
                                      data:{'id':doc_id, 'campo':field.name, 'fecha':dateText }
                                  });
				    },
				    onClose: function() {
				        jQuery(field).datepicker("destroy");
				    }
			    }).datepicker("show");
            }
        </g:javascript>

    </head>

    <body>
        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div id="content" class="feriantes_table" role="main">
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

                            <td width="7%" class="${docInstance.f_pliego && docInstance.f_pliego > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="pliego" value="${docInstance.pliego}" onclick="to_check(${docInstance.id}, 'pliego')"/>
                                <br/><g:field id="pliego_${docInstance.id}" name="f_pliego" type="text" size="5" readonly="true"
                                              value="${docInstance.f_pliego?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_hacienda && docInstance.f_hacienda > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="hacienda" value="${docInstance.hacienda}" onclick="to_check(${docInstance.id}, 'hacienda')"/>
                                <br/><g:field id="hacienda_${docInstance.id}" name="f_hacienda" type="text" size="5"
                                              value="${docInstance.f_hacienda?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_autonomo && docInstance.f_autonomo > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="autonomo" value="${docInstance.autonomo}" onclick="to_check(${docInstance.id}, 'autonomo')"/>
                                <br/><g:field id="autonomo_${docInstance.id}" name="f_autonomo" type="text" size="5"
                                              value="${docInstance.f_autonomo?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_seguro && docInstance.f_seguro > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="seguro" value="${docInstance.seguro}" onclick="to_check(${docInstance.id}, 'seguro')"/>
                                <br/><g:field id="seguro_${docInstance.id}" name="f_seguro" type="text" size="5"
                                              value="${docInstance.f_seguro?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_poliza && docInstance.f_poliza > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="poliza" value="${docInstance.poliza}" onclick="to_check(${docInstance.id}, 'poliza')"/>
                                <br/><g:field id="poliza_${docInstance.id}" name="f_poliza" type="text" size="5"
                                              value="${docInstance.f_poliza?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_verificacion && docInstance.f_verificacion > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="verificacion" value="${docInstance.verificacion}" onclick="to_check(${docInstance.id}, 'verificacion')"/>
                                <br/><g:field id="verificacion_${docInstance.id}" name="f_verificacion" type="text" size="5"
                                              value="${docInstance.f_verificacion?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_extintores && docInstance.f_extintores > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="extintores" value="${docInstance.extintores}" onclick="to_check(${docInstance.id}, 'extintores')"/>
                                <br/><g:field id="extintores_${docInstance.id}" name="f_extintores" type="text" size="5"
                                              value="${docInstance.f_extintores?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_alimentos && docInstance.f_alimentos > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="alimentos" value="${docInstance.alimentos}" onclick="to_check(${docInstance.id}, 'alimentos')"/>
                                <br/><g:field id="alimentos_${docInstance.id}" name="f_alimentos" type="text" size="5"
                                              value="${docInstance.f_alimentos?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_boletin && docInstance.f_boletin > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="boletin" value="${docInstance.boletin}" onclick="to_check(${docInstance.id}, 'boletin')"/>
                                <br/><g:field id="boletin_${docInstance.id}" name="f_boletin" type="text" size="5"
                                              value="${docInstance.f_boletin?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_fotos && docInstance.f_fotos > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="fotos" value="${docInstance.fotos}" onclick="to_check(${docInstance.id}, 'fotos')"/>
                                <br/><g:field id="fotos_${docInstance.id}" name="f_fotos" type="text" size="5"
                                              value="${docInstance.f_fotos?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_dni && docInstance.f_dni > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="dni" value="${docInstance.dni}" onclick="to_check(${docInstance.id}, 'dni')"/>
                                <br/><g:field id="dni_${docInstance.id}" name="f_dni" type="text" size="5"
                                              value="${docInstance.f_dni?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>

                            <td width="7%" class="${docInstance.f_solicitud && docInstance.f_solicitud > new Date() ? 'black' : 'red'}">
                                <g:checkBox name="solicitud" value="${docInstance.solicitud}" onclick="to_check(${docInstance.id}, 'solicitud')"/>
                                <br/><g:field id="solicitud_${docInstance.id}" name="f_solicitud" type="text" size="5"
                                              value="${docInstance.f_solicitud?.format('dd-MM-YY')}"
                                              onclick="open_calendar(${docInstance.id}, this)"/>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>

        </div>

    </body>
</html>
