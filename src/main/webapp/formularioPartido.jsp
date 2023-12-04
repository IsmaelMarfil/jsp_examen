
    <title>Formulario Partido</title>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
    <h2>Introduzca los datos del nuevo socio:</h2>
    <br method="get" action="grabaPartido.jsp">
        Id <input type="int" name="id"/></br>
        Nº socio <input type="text" name="fecha"/></br>
        Nombre <input type="text" name="equipo1"/></br>
        Estatura <input type="int" name="puntos_equipo1"/></br>
        Edad <input type="text" name="equipo2"/></br>
        Localidad <input type="int" name="puntos_equipo2"/></br>
        <input type="submit" value="Aceptar">
    </form>
    <%
        String error = (String)session.getAttribute("error");
        if (error != null){
    %>
    <span style="color: darkred"><%=error%></span>
    <%
            session.removeAttribute("error");
        }

    %>
    </body>
    </html>
</head>
<body>

</body>
</html>
