<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

        <style type="text/css">
        @page {
            size: 210mm 297mm;
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
            <h1>Listado de Feriantes</h1>
            <div>
                <table class="table" width="100%">
                    <thead>
                        <tr>
                            <g:each in="['Parcela', 'Nombre', 'Tipo negocio', 'Superficie 1', 'Superficie 2']" var="cabecera">
                                <th>${cabecera}</th>
                            </g:each>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${ferianteList}" var="feriante" status="i">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td>${feriante.parcela}</td>
                                <td>${feriante.nombre}</td>
                                <td>${feriante.negocio}</td>
                                <td>${feriante.superficie1}</td>
                                <td>${feriante.superficie2}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </body>

</html>
