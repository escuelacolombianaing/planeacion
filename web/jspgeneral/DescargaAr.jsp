<%-- 
    Document   : DescargaAr
    Created on : 23/03/2017, 12:28:37 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="javax.activation.MimetypesFileTypeMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    String down = (String) request.getParameter("down");
    
            if(down!=null){ // Solicitud de Descarga de archivos

           //String filepath = "C:\\Users\\Desarrollo\\Desktop\\Proyectos\\ZPruebasCarga\\";   
          // String filepath = "C:\\Sun\\ODI\\";  //pruebas
          String filepath = "/home/shares/ODI/";   //produccion
       try{
      
        FileInputStream archivo = new FileInputStream(filepath+down);
        int longitud = archivo.available();
        byte[] datos = new byte[longitud];
        archivo.read(datos);
        archivo.close();
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition","attachment;filename="+down);
        ServletOutputStream ouputStream = response.getOutputStream();
        ouputStream.write(datos);
        ouputStream.flush();
        ouputStream.close();
      }catch(Exception e){ e.printStackTrace(); }  

          
            
       }
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      
    </body>
</html>
