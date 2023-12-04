<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int id = -1;
    String fecha = null;
    String equipo1 = null;
    int puntos_equipo1 = -1;
    String equipo2 = null;
    int puntos_equipo2 = -1;
    boolean flagValidaId = false;
    boolean flagValidaFecha = false;
    boolean flagValidaEquipo = false;
    boolean flagValidapuntosEquipo1 = false;
    boolean flagValidaEquipo2 = false;
    boolean flagValidapuntosEquipo2 = false;
    try {
        id = Integer.parseInt(request.getParameter("id"));
        id = Integer.parseInt(request.getParameter("id"));
        flagValidaId= true;
        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("fecha"));
        flagValidaFecha = true;
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("fecha").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaFecha = true;
        fecha = request.getParameter("fecha");
        if (request.getParameter("equipo1").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaEquipo = true;
        fecha = request.getParameter("equipo1");
        estatura = Integer.parseInt(request.getParameter("estatura"));
        flagValidaEstatura = true;
        edad = Integer.parseInt(request.getParameter("edad"));
        flagValidaEdad = true;
        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("localidad"));
        //CONTRACT nonBlank
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("localidad").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaLocalidad = true;
        localidad = request.getParameter("localidad");
    } catch (Exception ex) {
        ex.printStackTrace();
        if (!flagValidaNumero) {
            session.setAttribute("error", "Error en número.");
        } else if (!flagValidaNombreNull || !flagValidaNombreBlank) {
            session.setAttribute("error", "Error en nombre.");
        } else if (!flagValidaEdad) {
            session.setAttribute("error", "Error en edad.");
        } else if (!flagValidaEstatura) {
            session.setAttribute("error", "Error en estatura.");
        } else if (!flagValidaLocalidad) {
            session.setAttribute("error", "Error en localidad.");
        }
        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN
    if (valida) {
        Connection conn = null;
        PreparedStatement ps = null;
// 	ResultSet rs = null;
        try {
            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "user", "user");
//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<
            String sql = "INSERT INTO socio VALUES ( " +
                    "?, " + //socioID
                    "?, " + //nombre
                    "?, " + //estatura
                    "?, " + //edad
                    "?)"; //localidad
            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, Id);
            ps.setString(idx++, nombre);
            ps.setInt(idx++, estatura);
            ps.setInt(idx++, edad);
            ps.setString(idx++, localidad);
            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }
        out.println("Partido dado de alta.");
        //out.println("Socio dado de alta.");
        //response.sendRedirect("detalleSocio.jsp?socioID="+numero);
        //response.sendRedirect("pideNumeroSocio.jsp?socioIDADestacar="+numero);
        session.setAttribute("socioIDADestacar", numero);
        response.sendRedirect("listadoPartidos.jsp");
    } else {
        out.println("Error de validación!");
        //out.println("Error de validación!");
        response.sendRedirect("formularioPartido.jsp");
    }
%>

</body>
</html>