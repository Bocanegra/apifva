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
    </g:javascript>
</head>

<body>
<content tag="nav">
    <g:render template="/menu"/>
</content>

<div id="content" class="content scaffold-list" role="main">
    <section class="row colset-2-its">
        <h1>Documento informativo, año <b>${Calendar.instance.get(Calendar.YEAR)}</b></h1>
        <p>Revisa la plantilla con el texto a enviar, y selecciona todos los usuarios a los que quieras enviar el email.</p>
        <p>Los campos entre «...» se rellenan automáticamente. Pulsa "Enviar" cuando esté todo correcto.</p>
        <p><b>OJO A LOS CAMPOS DE FECHAS DE PAGO, HAY QUE RELLENAR TODOS LOS ***FECHA ...***</b></p>
        </p>

        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>

        <g:form controller="email">
            <table>
                <h2>Título</h2>
                <g:textField name="titulo" value="Ferias Vírgen de San Lorenzo Valladolid ${Calendar.instance.get(Calendar.YEAR)} - documento informativo" class="email_table"/>
                <h2>Mensaje</h2>
                <g:textArea name="template" value="${template}" rows="45" class="email_table"/>
                <br/>

                <h1 align="center">
                    <g:actionSubmit action="sendEmails" value="Enviar" class="email_buttons"
                                    onclick="return confirm('¿Procedemos con el envío de los emails?');"/>
                </h1>
                <br/>

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
