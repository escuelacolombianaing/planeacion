<%-- 
    Document   : reportes
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@ include file="secure.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");
        String ccemp = session.getAttribute("cod_emp").toString();
        String nomus = session.getAttribute("nom_emp").toString(); 
        String apus1 = session.getAttribute("of").toString();
        String apus2 = session.getAttribute("inst").toString();
        String mailus = session.getAttribute("e_mail").toString();
        
        
        BDServicios bd = new BDServicios();
         
        Vector planes       = new Vector();
        Vector ejes         = new Vector();
        Vector estados      = new Vector();
        Vector estadosseg   = new Vector();
        Vector unidadej     = new Vector();
        Vector nomproyecto     = new Vector();
        
        planes      = bd.Planes();
        ejes        = bd.EJES();
        estados     = bd.parametros("1");
        unidadej    = bd.Consultaunidades();
        estadosseg  = bd.parametros("2");
        nomproyecto = bd.ConsultanomProy();
%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SEGUIMIENTO A LA PLANEACIÓN - ESCUELA COLOMBIANA DE INGENIERÍA JULIO GARAVITO</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Language" content="ES" />
    <meta name="language" content="spanish" />
    <meta name="author" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
    <meta name="copyright" content="Copyright (c) 2017" />
    <meta name="description" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
    <meta name="abstract" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">     
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Arsenal" rel="stylesheet">
    <link rel="stylesheet" href="css/seguimiento.css"> 

</head>
<body>

    <header>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <center><img src="img/img-header-2.jpg" class="img-responsive"></center>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 franjaColor">
                    <center><h4>.:: Plataforma de seguimiento a la planeación ::.</h4><div align="right"><input class="btn-danger" type="button" align="right" value="Cerrar Sesión" onclick="location.href = '/planeacion/LogOut';"></center></div>
                </div>
            </div>
                <img src="img/img-reportes.jpg" alt="portada" class="img-responsive">
        </div>
    </header>

    <nav>
        <div class="container">
            <ul class="nav nav-pills nav-justified">
              <li role="presentation"><a href="/planeacion/homeadm"><span class="glyphicon glyphicon-home"></span> Inicio</a></li>
              <li role="presentation"><a href="/planeacion/proyectosactadm"><span class="glyphicon glyphicon-duplicate"></span>Consulta de Proyectos Activos</a></li>
              <li role="presentation"><a href="/planeacion/seguimientoadm"><span class="glyphicon glyphicon-eye-open"></span> Seguimiento Proyectos</a></li>
              <li role="presentation"><a href="/planeacion/allproyectos"><span class="glyphicon glyphicon-lamp"></span> Todos los Proyectos</a></li>
              <li role="presentation"><a href="/planeacion/historialadm"><span class="glyphicon glyphicon-list-alt"></span> Parametros del Sistema</a></li>
              <li role="presentation" class="active"><a href="/planeacion/reportesadm"><span class="glyphicon glyphicon-file"></span> Reportes Administrador</a></li>
            </ul>
        </div>
    </nav>

<!--CONTENIDOS-->
    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-12 filaCompleta">
                   
                   <center>
                    
                    <h3>Informes Enfoque Cualitativo</h3>
                    <br><br>
                   </center>
                    
                    <table class="table table-responsive">
                        <tr>
                            <th>Nombre del Filtro</th>
                            <th>Valor</th>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <tr>
                            <td>Rango de Fechas</td>
                            <td> 
                              <div class="col-md-offset-1 col-md-3">
                                                <div class="form-group">
                                                    <label for="">Fecha inicio (dd/mm/aaaa)</label>
                                                    <input type="text" maxlength="999" class="form-control" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}" name="fcinirep" placeholder="dd/mm/aaaa" id="datepicker">
                                                </div>
                                </div>
                                 <div class="col-md-offset-1 col-md-3">
                                                <div class="form-group">
                                                    <label for="">Fecha fin (dd/mm/aaaa)</label>
                                                    <input type="text" maxlength="999" class="form-control" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}" name="fcfinacrep" placeholder="dd/mm/aaaa" id="datepicker2">
                                                </div>
                                            </div>
                            </td>
                            
                        </tr>
                        
                            <td>Plan</td>
                            <td> 
                                <select name="plan" id="plan" class="form-control" required>
                                    <%if (planes.size() > 0){ 
                                    %><option value="1,2,3,4">Todos</option><%
                                            for (int ii = 0; ii < planes.size(); ii++) {
                                                    Vector infusu = (Vector)planes.elementAt(ii) ;%>
                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                            <%}
                                    }%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>EJE</td>
                            <td> 
                                <select name="eje" id="eje" class="form-control" required>
                                    <%if (ejes.size() > 0){ 
                                    %><option value="0,1,2,3,4,5,6,7,8">Todos</option><%
                                            for (int ii = 0; ii < ejes.size(); ii++) {
                                                    Vector infusu = (Vector)ejes.elementAt(ii) ;%>
                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                            <%}
                                    }%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Estado General del Proyecto</td>
                            <td> 
                                <select name="est" id="est" class="form-control" required>
                                    <%if (estados.size() > 0){ 
                                    %><option value="1,2,3,4,5,6,7,8,9">Todos</option><%
                                            for (int ii = 0; ii < estados.size(); ii++) {
                                                    Vector infusu = (Vector)estados.elementAt(ii) ;%>
                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                            <%}
                                    }%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Estado de Ejecución del Proyecto</td>
                            <td> 
                                <select name="estseg" id="estseg" class="form-control" required>
                                    <%if (estadosseg.size() > 0){ 
                                    %><option value="0,1,2,3,4,5,6,7,8,9">Todos</option><%
                                            for (int ii = 0; ii < estadosseg.size(); ii++) {
                                                    Vector infusu = (Vector)estadosseg.elementAt(ii) ;%>
                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                            <%}
                                    }%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Unidad Ejecutora</td>
                            <td> 
                                <select name="uniej" id="uniej" class="form-control" required>
                                    <%if (unidadej.size() > 0){ 
                                    %><option value="0">Todos</option><%
                                            for (int ii = 0; ii < unidadej.size(); ii++) {
                                                    Vector infusu = (Vector)unidadej.elementAt(ii) ;%>
                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                            <%}
                                    }%>
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Nombre del Proyecto</td>
                            <td> 
                                <select name="nomproy" id="nomproy" class="form-control" required>
                                    <%if (nomproyecto.size() > 0){ 
                                    %><option value="0">Selecione un proyecto</option><%
                                            for (int ii = 0; ii < nomproyecto.size(); ii++) {
                                                    Vector infusu = (Vector)nomproyecto.elementAt(ii) ;%>
                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(0)+" - "+infusu.elementAt(1)%></option>
                                    
                                            <%}
                                    }%>
                                </select>
                            </td>
                        </tr>
                        
                    </table>
                    <center>   
                            <button class="btn btn-info btn-group-lg" onclick="window.location = '/planeacion/ResumenAvance?tipor=1&plan='+document.getElementById('plan').value+'&eje='+document.getElementById('eje').value+'&estado='+document.getElementById('est').value+'&estseg='+document.getElementById('estseg').value+'&uniej='+document.getElementById('uniej').value+'&nomproy='+document.getElementById('nomproy').value+'&fcinirep='+document.getElementById('datepicker').value+'&fcfinacrep='+document.getElementById('datepicker2').value+'&formato=word';">Generar Informe de Planeación</button>
                        <button class="btn btn-success btn-group-lg" onclick="window.location = '/planeacion/ResumenAvance?tipor=2&plan='+document.getElementById('plan').value+'&eje='+document.getElementById('eje').value+'&estado='+document.getElementById('est').value+'&estseg='+document.getElementById('estseg').value+'&uniej='+document.getElementById('uniej').value+'&nomproy='+document.getElementById('nomproy').value+'&fcinirep='+document.getElementById('datepicker').value+'&fcfinacrep='+document.getElementById('datepicker2').value+'&formato=word';">Generar Informe de Avance</button>
                    
                        
                <br><br><br>
                
                <h3>Informes Enfoque Cuantitativo</h3>
                
                <br><br>
                
                <table class="table table-responsive">
                    <tr>
                            <th>Nombre del Filtro</th>
                            <th>Valor</th>
                        </tr>
                    <tr>
                            <td>Estado General del Proyecto</td>
                            <td> 
                                <select name="General" id="General" class="form-control" required>
                                    <%if (estados.size() > 0){ 
                                    %><option value="1,2,3,4,5,6,7,8,9">Todos</option><%
                                            for (int ii = 0; ii < estados.size(); ii++) {
                                                    Vector infusu = (Vector)estados.elementAt(ii) ;%>
                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                            <%}
                                    }%>
                                </select>
                            </td>
                        </tr>
                </table>
                
                <br>
                        
                         <button class="btn btn-danger btn-group-lg" onclick="window.open('/planeacion/ResumenGeneral')">Generar Informe Plan / Unidad Ejecutora</button>                
                         <button class="btn btn-warning btn-group-lg" onclick="window.open('/planeacion/ResumenGeneral_1')">Generar Informe Plan / Estado Ejecución</button>                
                         <button class="btn btn-success btn-group-lg" onclick="window.open('/planeacion/ResumenGeneral_2')">Generar Informe Eje / Unidad Ejecutora</button>                
                         <button class="btn btn-info btn-group-lg" onclick="window.open('/planeacion/ResumenGeneral_3')">Generar Informe Eje / Estado Ejecución</button>                
                         
              
               <br><br><br>
                
                <h3>Informe General (Resumen)</h3>
                
                <br><br>
                        
                         <button class="btn btn-lg btn-group-lg" onclick="window.open('/planeacion/ResumenProyectos')">Generar Informe General</button>                               

                </center>                         
                                
                </div>
            </div>
            
        </div>
    </section>



<!--FOOTER-->
<footer class="footerContainer">
    <div class="container">        
        <div class="row">
            <article class="col-sm-7 col-md-5">
                <p>                    
                    <strong>ESCUELA COLOMBIANA DE INGENIERÍA JULIO GARAVITO</strong><br/>
                    AK.45 No.205-59 (Autopista Norte)<br/>
                    <i>Contact center</i>: +57(1) 668 3600<br/>
                    Línea Nacional Gratuita: 018000112668<br/>
                    Información detallada en: www.escuelaing.edu.co<br/><br/>
                    <small>Personería Jurídica 086 de enero 19 de 1973. Acreditación Institucional de Alta Calidad Res. 002710 del 18 de marzo de 2019. (Vigencia 6 años).<br>
                    Vigilada Mineducación.</small><br><br>
                    Bogotá, D.C. - Colombia<br/>
                
            </article>
            <article class="col-sm-5 col-md-7">
                <p>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1987.9617427360993!2d-74.04338482936627!3d4.783148717834411!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f85e374627fe5%3A0x540783a0b074c84d!2sEscuela+Colombiana+de+Ingenier%C3%ADa!5e0!3m2!1ses!2ses!4v1424190444206" width="100%" height="280" frameborder="0" style="border:0"></iframe>
                </p>
            </article>
        </div> 
    </div>       
</footer>




    






























    <!--SCRIPT BOOTSTRAP-->
    <script src="js/jquery.js"></script>
    <script src="https://code.jquery.com/jquery-latest.jS"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
    $( function() {
      $( "#datepicker" ).datepicker({ dateFormat:      "dd/mm/yy",
                                      dayNamesMin:     ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                                      dayNamesShort:   ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                                      monthNames:      ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                                      monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun","Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]}).val();
      $( "#datepicker2" ).datepicker({dateFormat:      "dd/mm/yy",
                                      dayNamesMin:     ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                                      dayNamesShort:   ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                                      monthNames:      ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                                      monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun","Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]}).val();
      $( "#datepicker3" ).datepicker({dateFormat:      "dd/mm/yy",
                                      dayNamesMin:     ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                                      dayNamesShort:   ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                                      monthNames:      ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                                      monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun","Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]}).val();
      $( "#datepicker4" ).datepicker({dateFormat:      "dd/mm/yy",
                                      dayNamesMin:     ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                                      dayNamesShort:   ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                                      monthNames:      ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                                      monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun","Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]}).val();
    } );
    </script>

    <script src="js/bootstrap.min.js"></script>
    
</body>
</html>
