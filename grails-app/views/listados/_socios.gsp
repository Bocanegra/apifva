<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

        <style type="text/css">
        @page {
            size: 297mm 210mm;
            @bottom-center {
                content: counter(page);
            }
        }
        @font-face {
            font-family: "Helvetica Neue";
        }
        body {
            font-family: "Helvetica Neue", Arial, sans-serif;
        }
        h1 {
            text-align: center;
        }
        </style>
    </head>

    <body>

        <div id="list-feriante" class="content scaffold-list" role="main">
            <h1>Listado de Socios ${Calendar.instance.get(Calendar.YEAR).toString()}</h1>
            <div>
                <table class="table" width="100%">
                    <thead>
                        <tr>
                            <g:each in="['Socio', 'Nombre', 'Dirección', 'Población', 'Provincia', 'Teléfono fijo', 'Móvil', 'Email']" var="cabecera">
                                <th>${cabecera}</th>
                            </g:each>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${sociosList}" var="socio" status="i">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td>${socio.numeroSocio}</td>
                                <td>${socio.nombre}</td>
                                <td>${socio.direccion}</td>
                                <td>${socio.codigoPostal}-${socio.poblacion}</td>
                                <td>${socio.provincia}</td>
                                <td>${socio.telefonoFijo}</td>
                                <td>${socio.movil1}</td>
                                <td>${socio.email}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </body>

</html>
