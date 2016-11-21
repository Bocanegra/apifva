<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'socio.label', default: 'Socio')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-socio" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-socio" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.socio}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.socio}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form resource="${this.socio}" method="PUT">
                <g:hiddenField name="version" value="${this.socio?.version}"/>
                <fieldset class="form">
                    <f:field bean="socio" property="numeroSocio"/>
                    <f:field bean="socio" property="nombre"/>
                    <f:field bean="socio" property="direccion"/>
                    <f:field bean="socio" property="codigoPostal"/>
                    <f:field bean="socio" property="poblacion"/>
                    <f:field bean="socio" property="provincia"/>
                    <f:field bean="socio" property="nombre1"/>
                    <f:field bean="socio" property="movil1"/>
                    <f:field bean="socio" property="nombre2"/>
                    <f:field bean="socio" property="movil2"/>
                    <f:field bean="socio" property="nombreFijo"/>
                    <f:field bean="socio" property="telefonoFijo"/>
                    <f:field bean="socio" property="email"/>
                    <f:field bean="socio" property="negocios">
                        <g:textArea name="negocios" cols="50" rows="5" value="${this.socio?.negocios}"/>
                    </f:field>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
