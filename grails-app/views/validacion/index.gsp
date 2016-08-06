<%@ page import="grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
        <g:javascript>
            function to_check(doc_id, campo) {
                $.ajax({url:'${g.createLink(controller:"validacion",
                                            action:"check")}',
                        data:{'id':doc_id, 'campo': campo }
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
                        <td width="7%"><g:checkBox name="pliego" value="${docInstance.pliego}" onclick="to_check(${docInstance.id},'pliego')"/></td>
                        <td width="7%"><g:checkBox name="hacienda" value="${docInstance.hacienda}" onclick="to_check(${docInstance.id},'hacienda')"/></td>
                        <td width="7%"><g:checkBox name="autonomo" value="${docInstance.autonomo}" onclick="to_check(${docInstance.id},'autonomo')"/></td>
                        <td width="7%"><g:checkBox name="seguro" value="${docInstance.seguro}" onclick="to_check(${docInstance.id},'seguro')"/></td>
                        <td width="7%"><g:checkBox name="poliza" value="${docInstance.poliza}" onclick="to_check(${docInstance.id},'poliza')"/></td>
                        <td width="7%"><g:checkBox name="verificacion" value="${docInstance.verificacion}" onclick="to_check(${docInstance.id},'verificacion')"/></td>
                        <td width="7%"><g:checkBox name="extintores" value="${docInstance.extintores}" onclick="to_check(${docInstance.id},'extintores')"/></td>
                        <td width="7%"><g:checkBox name="alimentos" value="${docInstance.alimentos}" onclick="to_check(${docInstance.id},'alimentos')"/></td>
                        <td width="7%"><g:checkBox name="boletin" value="${docInstance.boletin}" onclick="to_check(${docInstance.id},'boletin')"/></td>
                        <td width="7%"><g:checkBox name="fotos" value="${docInstance.fotos}" onclick="to_check(${docInstance.id},'fotos')"/></td>
                        <td width="7%"><g:checkBox name="dni" value="${docInstance.dni}" onclick="to_check(${docInstance.id},'dni')"/></td>
                        <td width="7%"><g:checkBox name="solicitud" value="${docInstance.solicitud}" onclick="to_check(${docInstance.id},'solicitud')"/></td>
                    </tr>
                </g:each>
                </tbody>
            </table>

        </div>

    </body>
</html>
