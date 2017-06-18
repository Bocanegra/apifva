<!DOCTYPE html>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>

<g:set var="locale" value="es_ES"/>

<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feriante.label', default: 'Feriante')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-feriante" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-feriante" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.feriante}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.feriante}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.feriante}" method="PUT">
                <g:hiddenField name="version" value="${this.feriante?.version}" />
                <fieldset class="form">
                    <f:field property="anyo" bean="feriante"/>
                    <f:field property="parcela" bean="feriante"/>
                    <f:field property="nombre" bean="feriante"/>
                    <f:field property="negocio" bean="feriante"/>
                    <f:field property="direccion" bean="feriante"/>
                    <f:field property="codigoPostal" bean="feriante"/>
                    <f:field property="poblacion" bean="feriante"/>
                    <f:field property="provincia" bean="feriante"/>
                    <f:field property="telefono" bean="feriante"/>
                    <div class="fieldcontain">
                        <label for="dSuperficie1">Superficie 1 (m2)</label>
                        <g:field type="text" name="dSuperficie1" value="${feriante.formatSuperficie1()}" id="dSuperficie1"/>
                    </div>
                    <div class="fieldcontain">
                        <label for="dPrecio1">Precio sup 1</label>
                        <g:field type="text" name="dPrecio1" value="${feriante.formatPrecio1()}" id="dPrecio1"/>
                    </div>
                    <div class="fieldcontain">
                        <label for="dSuperficie2">Superficie 2 (m2)</label>
                        <g:field type="text" name="dSuperficie2" value="${feriante.formatSuperficie2()}" id="dSuperficie2"/>
                    </div>
                    <div class="fieldcontain">
                        <label for="dPrecio2">Precio sup 2</label>
                        <g:field type="text" name="dPrecio2" value="${feriante.formatPrecio2()}" id="dPrecio2"/>
                    </div>
                    <f:field property="gastos" bean="feriante"/>
                    <f:field property="luzAgua" bean="feriante"/>
                    <f:field property="vivienda" bean="feriante"/>
                    <f:field property="maquinas" bean="feriante"/>
                    <f:field property="deuda" bean="feriante"/>
                    <f:field property="sancion" bean="feriante"/>
                    <f:field property="motivoSancion" bean="feriante"/>
                    <f:field property="fianza" bean="feriante"/>
                    <f:field property="pagado" bean="feriante"/>
                    <f:field property="dni" bean="feriante"/>
                    <f:field property="email" bean="feriante"/>
                    <f:field property="IBAN" bean="feriante"/>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
