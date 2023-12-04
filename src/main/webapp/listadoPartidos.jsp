<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado Partidos</title>
</head>
<body>
<h1>Listado de Partidos</h1>
<%
    //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
    //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/juego","user", "user");

    //UTILIZAR STATEMENT SÓLO EN QUERIES NO PARAMETRIZADAS.
    Statement s = conexion.createStatement();
    ResultSet listado = s.executeQuery ("SELECT * FROM partido");

    while (listado.next()) {
        out.println(listado.getString("equipo1") + " " + listado.getString ("puntos_equipo1") + " " + listado.getString("equipo2") + " " + listado.getString("puntos_equipo2") + "<br>");

    }


    %>
<form class="d-inline" method="get" action="formularioPartido.jsp">
<input class="btn btn-primary"  type="submit" value="Crear Partido">
</form>

<input class="btn btn-primary"  type="submit" value="Editar Partido">
<input class="btn btn-primary"  type="submit" value="Borrar Partido">


        <%
    listado.close();
    s.close();
    conexion.close();
%>
</body>
</html>