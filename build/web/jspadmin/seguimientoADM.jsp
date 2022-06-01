<%-- 
    Document   : seguimiento
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="BDatos.BDServiciosAdmin"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@page import="java.util.*, java.io.File, java.text.SimpleDateFormat"%>
<%@ include file="secure.jsp" %>
<%@page contentType="text/html; charset=iso-8859-1" pageEncoding="iso-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");
        String ccemp = session.getAttribute("cod_emp").toString();
        String nomus = session.getAttribute("nom_emp").toString(); 
        String apus1 = session.getAttribute("of").toString();
        String apus2 = session.getAttribute("inst").toString();
        String mailus = session.getAttribute("e_mail").toString();
        
        BDServicios bd = new BDServicios();
        
        BDServiciosAdmin bda = new BDServiciosAdmin();
        
        Vector proyectos = new Vector();
        Vector aux       = new Vector();
        Vector fecseg    = new Vector();
        
        proyectos   = bda.ConsultarProyectosAdminEJEC();
        fecseg      = bda.ConsultarUltFechasSeg();
        
         DecimalFormat formatea = new DecimalFormat("###,###.##");
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
                <img src="img/img-seguimiento.jpg" alt="portada" class="img-responsive">
        </div>
    </header>

    <nav>
        <div class="container">
       <ul class="nav nav-pills nav-justified">
          <li role="presentation"><a href="/planeacion/homeadm"><span class="glyphicon glyphicon-home"></span> Inicio</a></li>
          <li role="presentation"><a href="/planeacion/proyectosactadm"><span class="glyphicon glyphicon-duplicate"></span>Consulta de Proyectos Activos</a></li>
          <li role="presentation" class="active"><a href="/planeacion/seguimientoadm"><span class="glyphicon glyphicon-eye-open"></span> Seguimiento Proyectos</a></li>
          <li role="presentation"><a href="/planeacion/allproyectos"><span class="glyphicon glyphicon-lamp"></span> Todos los Proyectos</a></li>
          <li role="presentation"><a href="/planeacion/historialadm"><span class="glyphicon glyphicon-list-alt"></span> Parametros del Sistema</a></li>
          <li role="presentation"><a href="/planeacion/reportesadm"><span class="glyphicon glyphicon-file"></span> Reportes Administrador</a></li>
        </ul>
        </div>
    </nav>

<!--CONTENIDOS-->
    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-12 filaCompleta">
                    
                    <script language="javascript">
                        function doSearch() {
                            var tableReg = document.getElementById('regTable');
                            var searchText = document.getElementById('searchTerm').value.toLowerCase();
                            for (var i = 1; i < tableReg.rows.length; i++) {
                                var cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
                                var found = false;
                                for (var j = 0; j < cellsOfRow.length && !found; j++) {
                                    var compareWith = cellsOfRow[j].innerHTML.toLowerCase();
                                    if (searchText.length == 0 || (compareWith.indexOf(searchText) > -1)) {
                                        found = true;
                                    }
                                }
                                if (found) {
                                    tableReg.rows[i].style.display = '';
                                } else {
                                    tableReg.rows[i].style.display = 'none';
                                }
                            }
                        }
                    </script>

                    <div class="filaCompleta">Filtrar por: <input id="searchTerm" type="text" onkeyup="doSearch()" class="input-sm  text-center col-md-12"/></div>
                    <br><br>
                    <form action="HabDesSeguimiento" method="Post" onsubmit="return confirm('Esta Seguro de cambiar el estado a todos los proyectos');">
                        <input type="hidden" value="0" name="tipoact">
                        <input type="hidden" value="0" name="idseg">
                        <input type="submit" value="Cerrar Seguimientos sin Enviar" class="btn btn-group-lg btn-info">
                    </form>
                    
                    <h3>A continuación se presentan <strong>los proyectos bajo su responsabilidad con seguimiento  a la fecha:</strong></h3>Total consultados: <%=proyectos.size()%><br><br>
                    <p>
                    Para ordenar, clic sobre el titulo de la columna. <img src="img/order.png" alt="Smiley face" height="30" width="30">.
                    <table class="table table-hover" id="regTable">
                      <thead>
                      <tr>
                        <th>Id. Proyecto</th>
                        <th>Nombre</th>
                        <th>Plan</th>
                        <th>Unidad Ejecutora</th>
                        <th>Estado</th>
                        <th>Fecha Creación</th>
                        <th>Tipo</th>
                  <!--  <th>Editar</th> -->
                        <th>Seguimiento</th>
                        <th>Detalle</th>
                        <th>Acceso</th>
                      </tr>
                      </thead>
                      <tbody>
                      <% for ( int m = 0 ; m < proyectos.size() ; m++ ){
                        aux = (Vector)proyectos.elementAt(m);
                        
                        String estadoseg = "";
                        String segver = "";
                                
                        if(bd.ConsultarEstadoSeg(aux.elementAt(0).toString()).size() > 0){
                            
                            Vector TMP = new Vector();
                            TMP = bd.ConsultarEstadoSeg(aux.elementAt(0).toString()); 
                            
                            estadoseg = TMP.elementAt(0).toString();
                            segver    = TMP.elementAt(1).toString();
                        }
                        
                      %>
                      <tr>
                        <td><%=aux.elementAt(0)%></td>
                        <td><u><%=aux.elementAt(1)%></u></td>
                        <td><%=aux.elementAt(2)%></td>
                        <td><%=aux.elementAt(6)%></td>
                        <td><font color="Blue"><strong><%=aux.elementAt(3)%></strong></font></td>
                        <td><%=aux.elementAt(4)%></td>                        
                        <td><%=aux.elementAt(7)%></td>  
                        <!--<td align="center"><a href="seguimientoPR?idp=<%=aux.elementAt(0)%>"><img src="img/seguim.png" width="25" height="25" border="0"></a></td>-->
                  <!-- <td><a href="editpr?idp=<%=aux.elementAt(0)%>"><img src="img/pen.png" width="20" height="22" border="0"></a></td>   -->
                        <%if(segver.equals("1")){%>
                        <td><a href="seguimientoPR?idp=<%=aux.elementAt(0)%>&seg=<%=estadoseg%>"><b><font color="Orange">Continuar Seguimiento</font></b></a></td>
                        <%}else if(segver.equals("")){ if(bd.ConsultaRagoFechasPermitirSegAdmin().equals("1")){%>
                        <td><a href="InicarSeguimiento?idp=<%=aux.elementAt(0)%>"><b><font color="Red">Iniciar Seguimiento</font></b></a></td>
                        <%}else{%>
                        <td><a><b><font color="Red">Iniciar Seguimiento</font></b></a></td>
                        <%}}else{%>
                        <td><b><a href="seguimientoPR?idp=<%=aux.elementAt(0)%>&seg=<%=estadoseg%>"><font color="Green">Segumiento Realizado</font></a></b></td>
                        <%}%>
                        <td><a href="detalleproyadm?idp=<%=aux.elementAt(0)%>&est=2"><img src="img/detalle.png" width="20" height="22" border="0"></a></td>
                        <%if(segver.equals("")){%>
                        <td><a ><img src="img/na.png" width="20" height="22" border="0"></a></td>
                        <%}else if(segver.equals("1")){%>
                        <td>
                            <form action="HabDesSeguimiento" id="myformac<%=estadoseg%>" method="Post">
                            <input type="hidden" value="1" name="tipoact">
                            <input type="hidden" value="<%=estadoseg%>" name="idseg">    
                                <a href="#" onclick="document.getElementById('myformac<%=estadoseg%>').submit();"><img src="img/openpadlock.png" width="20" height="22" border="0"></a>
                            </form>
                        </td>
                        <%}else{%>
                        <td>
                            <form action="HabDesSeguimiento" id="myformac2<%=estadoseg%>"" method="Post">
                            <input type="hidden" value="2" name="tipoact">
                            <input type="hidden" value="<%=estadoseg%>" name="idseg">
                                <a href="#" onclick="document.getElementById('myformac2<%=estadoseg%>').submit();"><img src="img/closepadlock.png" width="20" height="22" border="0"></a>
                            </form>
                        </td>
                        <%}%>
                      </tr>
                      <%}%>
                      </tbody>
                      
                    </table>
                    
                      
                      <div class="colorFormulario">
                      
                    <center>
                        <h4><b>Fechas de Seguimiento recientes</b></h4><br>
                    <table class="table table-hover">
                  <tr> 
                      <th>Fecha Inicio</th>
                      <th>Fecha Fin</th>
                      <th>Fecha Inicio Usuarios</th>
                      <th>Fecha Fin Usuarios</th>
                      <th>Estado</th>
                     
                  </tr>  
                  <% for ( int m = 0 ; m < fecseg.size() ; m++ ){
                  
                      aux = (Vector)fecseg.elementAt(m);
                  %>
                  <tr>
                      <td><%=aux.elementAt(0)%></td>
                      <td><%=aux.elementAt(1)%></td>
                      <td><%=aux.elementAt(3)%></td>
                      <td><%=aux.elementAt(4)%></td>
                      <td><%=aux.elementAt(2)%></td>
                      <%if(m == 0){%>
                      <%}else{%>
                      
                      <%}%>
                  </tr>
                  <%}%>
                  
                  </table>
                    </center>
                  
                  <br> 
                  <br>
                  <center>
                  <form action="NuevaFechaSeg" method="POST">
                  <div class="row">
                              <div class="col-md-2">
                                  <b>Periodo A Evaluar (Inicio):</b> <input type="text" name="feciniseg" class="form-control" placeholder="dd/mm/aaaa" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}" id="datepicker" required>    
                              </div>
                              <div class="col-md-2">
                                  <b>Periodo A Evaluar (Fin):</b>    <input type="text" name="fecfinseg" class="form-control" placeholder="dd/mm/aaaa" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}" id="datepicker2" required>
                              </div>
                              <div class="col-md-2">
                                  <b>Seguimiento (Inicio):</b> <input type="text" name="fecinisegusu" class="form-control" placeholder="dd/mm/aaaa" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}" id="datepicker3" required>    
                              </div>
                              <div class="col-md-2">
                                  <b>Seguimiento (Fin):</b>    <input type="text" name="fecfinsegusu" class="form-control" placeholder="dd/mm/aaaa" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}" id="datepicker4" required>
                              </div>
                              <br>
                              <div class="col-md-3">
                                <input type="submit" value="Registrar nueva fecha de seguimiento" class="btn btn-danger">
                              </div>
                          </div>
                  </form>
                  </center>
                      </div>
                    </p>
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
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-latest.jS"></script>
    <script src="js/bootstrap.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/sorter/jquery-latest.js"></script>
    <script language="javascript" type="text/javascript" src="js/sorter/jquery.tablesorter.js" ></script>

	
	<script type="text/javascript">
	$(function() {
		
           $("table").tablesorter({debug: true}).tablesorterPager({container: $("#pager")});
           
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
	});
	</script>
    
       

    <script src="js/bootstrap.min.js"></script>
</body>
</html>
