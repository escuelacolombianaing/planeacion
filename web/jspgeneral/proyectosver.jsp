<%-- 
    Document   : proyectos
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigInteger"%>
<%@page import="javax.activation.MimetypesFileTypeMap"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@page import="java.util.*, java.io.File, java.text.SimpleDateFormat"%>
<%@ include file="secure.jsp" %>
<%@page contentType="text/html; charset=iso-8859-1" pageEncoding="iso-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");

        String down = (String) request.getParameter("down");

        String ccemp = session.getAttribute("cod_emp").toString();
        String nomus = session.getAttribute("nom_emp").toString(); 
        String apus1 = session.getAttribute("ap1_emp").toString();
        String apus2 = session.getAttribute("ap2_emp").toString();
        String mailus = session.getAttribute("e_mail").toString();
        
        String mensaje = "";
        
        String idp     = request.getParameter("idp");
        
        BigInteger TotalRubros;
        
        TotalRubros = BigInteger.valueOf(0);
        
        mensaje = request.getParameter("m");
        
        
        BDServicios bd = new BDServicios();
        
        Vector aux          = new Vector();
        Vector planes       = new Vector();
        Vector empleados    = new Vector();
        Vector snies        = new Vector();
        Vector estadopr     = new Vector();
        Vector estadoejec   = new Vector();
        Vector prioridad    = new Vector();
        Vector datosb       = new Vector();
        Vector objetivosg   = new Vector();
        Vector objetivose   = new Vector();
        Vector metas        = new Vector();
        Vector actividades  = new Vector();
        Vector presupuesto  = new Vector();
        Vector rubro        = new Vector();
        Vector indicadores  = new Vector();
        Vector auxin        = new Vector();        
        Vector archivos     = new Vector();
        Vector auxh         = new Vector();
        Vector valores      = new Vector();
        Vector ejes         = new Vector();
        Vector ejesasoc     = new Vector();
        Vector infoeje      = new Vector();
        Vector auxeje       = new Vector();
        Vector auxobje      = new Vector();
        Vector fines        = new Vector();
        Vector unidades     = new Vector();
        Vector caracfac     = new Vector();
        Vector seguimientos = new Vector();
        
        DecimalFormat formatea = new DecimalFormat("###,###.##");
        
        ejes        = bd.ConsultaEJE();
        planes      = bd.Planes();
        empleados   = bd.usuario();
        snies       = bd.SNIES_CCosto();
        estadopr    = bd.parametros("1");
        estadoejec  = bd.parametros("2");
        prioridad   = bd.parametros("3");
        archivos    = bd.Consultafiles(idp);
        fines       = bd.fines("0");
        unidades    = bd.Consultaunidades();
        
        ejesasoc    = bd.ConsultaEJEasociado(idp);
        actividades = bd.ConsultaActividades(idp);
        rubro       = bd.PreRubrosPL();
        indicadores = bd.ConsultaIndProyecto(idp);
        caracfac    = bd.ConsultaCarFac(idp);
        
        datosb = bd.ConsultaDatosProyecto(idp);
        seguimientos = bd.ConsultaSeguimientosPRY(idp);
        
        String Valor="", Cadena="", ValorDed="", ValorEro="";
        String vigencia = bd.vigenciaproy(idp);
        int numero_archivo = 0;
        int porcentajact = 0;
        
        int agnoinicial = 0;
        int agnofinal   = 0;
        
        if(vigencia.length()>=9){
        String[] vigenciapart = vigencia.split(" - ");
            agnoinicial = Integer.parseInt(vigenciapart[0]);
            agnofinal = Integer.parseInt(vigenciapart[1]);
        }
        
        if(down!=null){ // Solicitud de Descarga de archivos
       
           String filename = down;   
           //String filepath = "C:\\Users\\Desarrollo\\Desktop\\Proyectos\\ZPruebasCarga\\";   
           String filepath = "/home/shares/ODI/";  
           MimetypesFileTypeMap mimetypesFileTypeMap=new MimetypesFileTypeMap();
           response.setContentType(mimetypesFileTypeMap.getContentType(filename));   
           response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   

           java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  

            int i;   
            while ((i=fileInputStream.read()) != -1) {  
              out.write(i);   
            }   
            fileInputStream.close();   
       }
        
        BigInteger TDed;
        BigInteger TEro;
        BigInteger TotalPR;
        
        TDed        = BigInteger.valueOf(0);
        TEro        = BigInteger.valueOf(0);
        TotalPR     = BigInteger.valueOf(0); 
        
%>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
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
    <script type="text/js.usuario" src="js.usuario/update_inf.js"></script>
    <script language="javascript" type="text/javascript" src="js.usuario/update_inf.js" ></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="app.js"></script>
    
    
<script src="js/jquery-1.11.1.js" type="text/javascript"></script>




<script>
$(document).ready(function() {

$('#finesauto').change(function() {
        var fin = $("select#finesauto").val();
        $.get('consultafactor', {
                Fines : fin
        }, function(response) {

        var select = $('#factor');
        select.find('option').remove();
          $('<option>').val('').text('Seleccione el Factor').appendTo(select);
          $.each(response, function(index, value) {
          $('<option>').val(index).text(value).appendTo(select);
      });
        });
        });
        
$('#factor').change(function() {
        var fin = $("select#finesauto").val();
        var fac = $("select#factor").val();
        $.get('consultacaracterist', {
                Fines : fin,
                Factor : fac
        }, function(response) {

        var select = $('#tab_caract');
        select.find('tr').remove();
          $.each(response, function(index, value) {
          $('#tab_caract').append( '<tr><td><input type="checkbox" name="caracsel" value="'+value+'"></td><td>' + value + '</td></tr>' );
      });
        });
        });

});
</script>
    
</head>
<body onload="testshow2()">

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
            <center><img src="img/img-proyectos.jpg" alt="portada" class="img-responsive"></center>
    </header>

    <nav>
        <div class="container">
        <ul class="nav nav-pills nav-justified">
          <li role="presentation"><a href="/planeacion/home"><span class="glyphicon glyphicon-home"></span> Inicio</a></li>
          <li role="presentation"><a href="/planeacion/proyectosact"><span class="glyphicon glyphicon-duplicate"></span> Proyectos activos</a></li>
          <li role="presentation"><a href="/planeacion/seguimiento"><span class="glyphicon glyphicon-eye-open"></span> Seguimiento</a></li>
          <li role="presentation"><a href="/planeacion/historial"><span class="glyphicon glyphicon-list-alt"></span> Historial</a></li>
          <li role="presentation"><a href="/planeacion/reportes"><span class="glyphicon glyphicon-file"></span> Reportes</a></li>
        </ul>
        </div>
    </nav>

<!--CONTENIDOS-->
    <section>
        <div class="container">
            
            <div class="colorFormulario">
                <%if(datosb.elementAt(21).equals("M")){%><a>MEGAPROYECTO</a><%}%>
                <center>
                    <strong>Id. Proyecto:           </strong>           <a><%=idp%></a>  
                    <strong>Nombre del Proyecto:    </strong>           <a><%=datosb.elementAt(0)%></a>  <br>
                    <strong>Estado Proyecto:        </strong>           <a><%=bd.parametrosEsp("1", datosb.elementAt(1).toString())%></a>
                    <strong>Avance:                 </strong>           <a><%=datosb.elementAt(14)%>%</a>
                    <strong>Plan:                   </strong>           <a><%=bd.nombreplan(datosb.elementAt(3).toString())%></a>
                    <strong>Vigencia:               </strong>           <a><%=vigencia%></a>
                    <strong>Director:               </strong>           <a><%=bd.usuarioconscc(datosb.elementAt(6).toString())%></a>
                    <br>
                    <marquee SCROLLDELAY=40 WIDTH=30% ><font color="blue">Detalle del Proyecto</font></marquee>
                    <br><br>
                    <button class="btn btn-group-sm" onclick="window.open('/planeacion/ResumenPlaneacion?idp=<%=idp%>')">Ver Resumen Proyecto</button>
                </center>
            </div>
           

<!--VALIDAR PROPIETARIOS -->

<%if(!bd.ConsultaSiPerteneceAMegapro(idp).equals("0")){%>** Este proyecto pertenece al MegaProyecto <%=bd.ConsultaSiPerteneceAMegapro(idp)%> <br> <%}%>

<%if(!bd.ConsultaSiPerteneceAMegapro(idp).equals("0") && bd.ValidarDirectorResponMegapro(ccemp).equals("1")){%><input class="btn btn-danger" type="button" value="Ver MegaProyecto" name="volver atrás2" onclick="location.href='/planeacion/verproyecto?idp=<%=bd.ConsultaSiPerteneceAMegapro(idp)%>#collapseThree'" /><br><br><%}%>

<% if(ccemp.equals(datosb.elementAt(17).toString()) || ccemp.equals(datosb.elementAt(6).toString()) || ccemp.equals(datosb.elementAt(7).toString()) || bd.ValidarDirectorResponMegapro(ccemp).equals("1")){%>
                
<!--DATOS BASICOS-->

            <div class="colorFormulario">
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne">
                      <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                          <span class="glyphicon glyphicon-paperclip"></span> DATOS BÁSICOS
                        </a>
                      </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                      
                        <br>En la sección datos básicos usted encontrara la información general del Proyecto seleccionado. El responsable y director de cada proyecto tendrán acceso a la edición de información unicamente en la etapa de planeación.<br><br>
                        
                        <div class="panel-body">
                            <div class="colorFormulario">
                          

				<div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
                                            <input type="hidden" value="<%=idp%>" name="idp" id="idp">
			                	<div class="form-group espaciado">
									<label for="">Nombre del Proyecto</label>
                                                                        <input type="text" class="form-control" name="nomproy" placeholder="Nombre del Proyecto" id="nomproy" value="<%=datosb.elementAt(0)%>" required>
								</div>
					</div>
                                </div>
                               <div class="row" style="display: none;">
		                	<div class="col-xs-12 col-md-3 col-lg-6">
			                	<div class="form-group espaciado">
									<label for="">Estado Proyecto</label>
                                                                        <select name="estpr" value="<%=datosb.elementAt(1)%>" id="estpr" class="form-control" >
                                                                            <%if (estadopr.size() > 0){
                                                                                    for (int ii = 0; ii < estadopr.size(); ii++) { 
                                                                                            Vector infusu = (Vector)estadopr.elementAt(ii);
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(1).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                                <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%}  if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";} 
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option> <%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
					</div>
                                        <div class="col-xs-12 col-md-3 col-lg-6">
			                	<div class="form-group espaciado">
									<label for="">Estado Ejecución</label>
                                                                        <select name="estejec" class="form-control" id="estejec" >
                                                                            <%if (estadoejec.size() > 0){ 
                                                                                    for (int ii = 0; ii < estadoejec.size(); ii++) {
                                                                                            Vector infusu = (Vector)estadoejec.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(2).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
					</div>
                                </div>
                                <div class="row" style="display: none;">
                                       
		                	<div class="col-xs-12 col-md-5 col-lg-3">
			                	<div class="form-group espaciado">
									<label for="">Valor Proyectado</label>
                                                                        <input type="number" class="form-control" name="valproyectado" value="<%=datosb.elementAt(11)%>" id="valproyectado" >
								</div>
							</div>
		                	<div class="col-xs-12 col-md-4 col-lg-3">
		                		<div class="form-group espaciado">
									<label for="">Valor Ejecutado</label>
									<input type="number" class="form-control" name="valejecutado" value="<%=datosb.elementAt(12)%>" id="valejecutado" >
								</div>
		                	</div>	
                                        <div class="col-xs-12 col-md-4 col-lg-3">
		                		<div class="form-group espaciado">
									<label for="">Porcentaje Ejecución Sistema</label>
									<input type="number" min="0" max="100" class="form-control" name="porcejesis" value="<%=datosb.elementAt(13)%>" id="porcejesis" >
								</div>
		                	</div>
                                        <div class="col-xs-12 col-md-4 col-lg-3">
		                		<div class="form-group espaciado">
									<label for="">Porcentaje Ejecución Director</label>
									<input type="number" min="0" max="100" class="form-control" name="porcejedir" value="<%=datosb.elementAt(14)%>" id="porcejedir" >
								</div>
		                	</div>
		                </div>
                                <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-4">
                                            <div class="form-group espaciado">
									<label for="">Plan</label>
									<select name="plan" id="plan" class="form-control" required>
                                                                            <%if (planes.size() > 0){
                                                                                    for (int ii = 0; ii < planes.size(); ii++) {
                                                                                            Vector infusu = (Vector)planes.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(3).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
                                                </div>
                                        
                                        </div><div class="col-xs-12 col-md-3 col-lg-4">
                                            <div class="form-group espaciado">
									<label for="">SNIES</label>
									<select name="sniespr" value="<%=datosb.elementAt(1)%>" id="sniespr" class="form-control" required>
                                                                            <%if (snies.size() > 0){
                                                                                    for (int ii = 0; ii < snies.size(); ii++) { 
                                                                                            Vector infusu = (Vector)snies.elementAt(ii);
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(4).toString()+"        ")){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                                <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%}  if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";} 
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option> <%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
                                        </div>
                                        <%if(datosb.elementAt(3).toString().equals("1")){%>                                
                                        <div class="col-xs-12 col-md-3 col-lg-4">
		                		<div class="form-group espaciado">
									<label for="">Prioridad</label>
									<select name="prioridad" id="prioridad" class="form-control" required>
                                                                            <%if (prioridad.size() > 0){
                                                                                    for (int ii = 0; ii < prioridad.size(); ii++) {
                                                                                            Vector infusu = (Vector)prioridad.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(5).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
		                	</div>
                                                                        <%}else{%>
                                                                        <input type="hidden" name="prioridad" value="0">                                                                        
                                                                        <%}%>
                                                                        
                                </div>
                                
                                <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-4">
                                            <div class="form-group espaciado">
									<label for="">Unidad Ejecutora</label>
									<select name="unidadejec" value="<%=datosb.elementAt(1)%>" id="sniespr" class="form-control" required>
                                                                            <%if (unidades.size() > 0){
                                                                                    for (int ii = 0; ii < unidades.size(); ii++) { 
                                                                                            Vector infusu = (Vector)unidades.elementAt(ii);
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(18).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                                <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%}  if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";} 
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option> <%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
                                        </div>
                                
		                	<div class="col-xs-12 col-md-3 col-lg-4">
		                		<div class="form-group espacio">
									<label for="">Director del Proyecto</label>
									<select name="director" id="director" class="form-control" required>
                                                                            <%if (empleados.size() > 0){
                                                                                    for (int ii = 0; ii < empleados.size(); ii++) {
                                                                                            Vector infusu = (Vector)empleados.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(6).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
					</div>
                                    
                                
                                        <div class="col-xs-12 col-md-3 col-lg-4">
		                		<div class="form-group espacio">
									<label for="">Responsable del Proyecto</label>
									<select name="responsable" id="responsable" class="form-control" required>
                                                                            <%if (empleados.size() > 0){ 
                                                                            %><option value="">Seleccione el Responsable</option><%
                                                                                    for (int ii = 0; ii < empleados.size(); ii++) {
                                                                                            Vector infusu = (Vector)empleados.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(datosb.elementAt(7).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
							</div>
                                </div>
		                <div class="row">
                                       
		                	<div class="col-xs-12 col-md-5 col-lg-4">
			                	<div class="form-group espaciado">
									<label for="">Fecha Inicio (dd/mm/aaaa)</label>
                                                                        <input type="text" class="form-control" name="fecini" id="fecini" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}"  value="<%=datosb.elementAt(8).toString()%>" required>
								</div>
							</div>
		                	<div class="col-xs-12 col-md-4 col-lg-4">
		                		<div class="form-group espaciado">
									<label for="">Fecha Fin (dd/mm/aaaa)</label>
									<input type="text" class="form-control" name="fecfin" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}" value="<%=datosb.elementAt(9).toString()%>" id="fecfin" required>
								</div>
		                	</div>	
                                        <div class="col-xs-12 col-md-4 col-lg-4">
		                		<div class="form-group espaciado">
									<label for="">Fecha Creación (dd/mm/aaaa)</label>
									<input type="text" class="form-control" name="fecins" value="<%=datosb.elementAt(10).toString()%>" readonly>
								</div>
		                	</div>
		                </div>
		                <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
                                            <div class="form-group espaciado" style="display: none;">
									<label for="">Meta</label>
                                                                        <textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="metapr" id="metapr"><%=datosb.elementAt(15)%></textarea>
								</div>
							</div>
                                </div>
                                <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
		                		<div class="form-group espaciado">
									<label for="">Justificación</label>
									<textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="justifpr" id="justifpr" required><%=datosb.elementAt(16)%></textarea>
								</div>
		                	</div>
                                </div>
                                    
                                                                
                                
                      </div>
                        </div>
                    </div>
                  </div>
                                                                
<!--ALINEACION ESTRATEGICA-->
                
                     
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFour">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                          <span class="glyphicon glyphicon-paperclip"></span> ALINEACIÓN ESTRATEGICA
                        </a>
                      </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                        
                        <br>En la sección alineación estrategica se definen el(los) eje(s) del plan de desarrollo de la Escuela Colombiana de Ingeniería a los que apunta el proyecto.<br><br>
                       
                        <div class="panel-body">
                            
                            
                            <%if(caracfac.size()>0){%>
                                <div class="colorFormulario" align="center">
                                
                                    <h3>Factores y Caracteristicas del Proyecto</h3><br>
                                    
                                <table>
                                    <tr>
                                        <th>Fin Autoevaluación</th>
                                        <th>Factor</th>
                                        <th>Caracteristica</th>
                                        <th>Factor Integral</th>
                                        <th>Eje</th>
                                        
                                    </tr>
                                    <%for(int iq = 0 ; iq < caracfac.size(); iq++){
                                           Vector auxespec = (Vector)caracfac.elementAt(iq);                                    
                                    %>
                                    <tr>
                                        <td><input type="text" class="form-control" value="<%=auxespec.elementAt(1)%>" readonly></td>
                                        <td><input type="text" class="form-control" value="<%=auxespec.elementAt(2)%>" readonly></td>
                                        <td><input type="text" class="form-control" value="<%=auxespec.elementAt(3)%>" readonly></td>
                                        <td><input type="text" class="form-control" value="<%=auxespec.elementAt(4)%>" readonly></td>
                                        <td><input type="text" class="form-control" value="<%=auxespec.elementAt(5)%>" readonly></td>
                                        <td>
                                                                            
                                        </td>
                                    </tr>
                                    <%}%>
                                </table>
                                    
                                </div>
                                
                                <%}%>
                              
    
                            <%  
                                if(ejesasoc.size() > 0){
                                for(int wi = 0; wi < ejesasoc.size() ; wi++){
                                    
                                    Vector temp = (Vector)ejesasoc.elementAt(wi);
                                    auxeje  = bd.ConsultaDatosEJE(temp.elementAt(0).toString());
                                    auxobje = bd.ConsultaObjEspecEJE(temp.elementAt(0).toString());
                            %>
                            <div class="colorFormulario">
                            
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
                                            <input type="hidden" value="<%=idp%>" name="idp" id="idp">
			                	<div class="form-group espaciado">
                                                                        <%if((datosb.elementAt(3).toString().equals("1") || datosb.elementAt(3).toString().equals("3"))){if(temp.elementAt(1).equals("1")){%>
                                                                        <div align="right"><button name="action" value="blue" class="btn btn-primary"><img src="img/starsel.png" width="20" height="22" border="0"> EJE Principal. </button></div>
                                                                        <%}else{%>
                                                                        <div align="right"><button name="action" value="blue" class="btn btn-primary"><img src="img/star.png" width="20" height="22" border="0"> EJE Principal. </button></div>
                                                                        <%}}%>
									<label for="">Nombre EJE</label>
                                                                        <input type="text" class="form-control" name="nomproy" placeholder="Nombre del Proyecto" id="nomproy" value="<%=auxeje.elementAt(1)%>" readonly>
                                                                        <label for="">Objetivo General</label>
                                                                        <textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="obj" id="" readonly><%=auxeje.elementAt(2)%></textarea>
                                                                        
                                                                        <%if((!datosb.elementAt(3).toString().equals("2"))){%>
                                                                        
                                                                        <label for="">Objetivo(s) Especifico(s) a los que apunta el Proyecto.</label><br><br>
                                                                        <div class="col-xs-12 col-md-3 col-lg-12">
                                                                            
                                                                            <form action="NuevaListaObjetivosEE" method="POST">
                                                                            <table>
                                                                            <tr style="height: 30px;">
                                                                                <th>Selección</th>
                                                                                <th><center>Descripción</center></th>
                                                                            </tr>
                                                                               <%for(int iq = 0 ; iq < auxobje.size(); iq++){
                                                                                   Vector auxespec = (Vector)auxobje.elementAt(iq);
                                                                                   
                                                                               %>
                                                                            <tr>
                                                                                <%if(bd.ValidarObEJEProyecto(idp, auxespec.elementAt(0).toString(), temp.elementAt(0).toString()).size() > 0){%>
                                                                                <td><input type="checkbox" name="objespec" value="<%=auxespec.elementAt(0)%>" checked></td>
                                                                                <%}else{%>
                                                                                <td><input type="checkbox" name="objespec" value="<%=auxespec.elementAt(0)%>"></td>
                                                                                <%}%>
                                                                                <td><%=auxespec.elementAt(1).toString()%></td><input type="hidden" name="idp" value="<%=idp%>"><input type="hidden" name="ejesel" value="<%=temp.elementAt(0).toString()%>">
                                                                            </tr>
                                                                            <%}%>
                                                                            </table> 
                                                                            
                                                                            </form>
                                                                            
                                                                        </div>
                                                                        <%}%>
								</div>
					</div>
                            </div>
                            </div>
                            <%}}else{%>
                            
                            <center><strong>El proyecto aun no tiene EJES asociados </strong></center>
                            
                            <%}%>
                        
                            <%if(datosb.elementAt(3).toString().equals("2")){%> 
                                
                                
                                <%}%>
                            
                            <%if((datosb.elementAt(3).toString().equals("1") || datosb.elementAt(3).toString().equals("3")) && ejesasoc.size() < 1){%>
                                 
                            <%}%>
                            
                        </div>
                    </div>
                  </div>

                                                                
<!--OBJETIVOS-->
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingTwo">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                          <span class="glyphicon glyphicon-paperclip"></span> OBJETIVOS - METAS - INDICADORES
                        </a>
                      </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                        
                        <br>En esta seccion se definen los objetivos, metas e indicadores del Proyecto.<br><br>
                        
                        <%
                        
                            objetivosg  = bd.ConsultaObjetivosProyecto(idp,"1");
                            objetivose  = bd.ConsultaObjetivosProyecto(idp,"2");
                            metas       = bd.ConsultaObjetivosProyecto(idp,"3");
                            
                        %>
                        
                        <div class="panel-body">
                            <div class="colorFormulario">
                            <div class="row">
                                <h4><strong>Objetivo General</strong></h4>
                                
                                    <% for ( int m = 0 ; m < objetivosg.size() ; m++ ){
                                      aux = (Vector)objetivosg.elementAt(m); 
                                    %>
                                        <form action="ActualizaObjetivo" method="POST">
                                        <table class="table table-hover">
                                          <tr>
                                            <td width="5%"><%=(m+1)%><input type="hidden" name="idobj" value="<%=aux.elementAt(0)%>"><input type="hidden" name="idpr" value="<%=idp%>"></td>
                                            <td width="90%"><textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="obj" id="" required><%=aux.elementAt(1)%></textarea></td>
                                            
                                          </tr>
                                        </table>
                                        </form> 
                                            
                                      <%}%>
                                      
                                    
                            </div>
                                                        
                            <div class="row">
                                <h4><strong>Objetivo(s) Especificos(s)</strong></h4>
                                
                                <% for ( int m = 0 ; m < objetivose.size() ; m++ ){
                                      aux = (Vector)objetivose.elementAt(m); 
                                    %>
                                        <form action="ActualizaObjetivo" method="POST">
                                        <table class="table table-hover">
                                          <tr>
                                            <td width="5%"><%=(m+1)%><input type="hidden" name="idobj" value="<%=aux.elementAt(0)%>"><input type="hidden" name="idpr" value="<%=idp%>"></td>
                                            <td width="90%"><textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="obj" id="" required><%=aux.elementAt(1)%></textarea></td>
                                            
                                          </tr>
                                        </table>
                                        </form>
                                           
                                            
                                           
                                      <%}%>
                                
                                
                            </div>
                                    
                            <div class="row">
                                <h4><strong>Meta(s) del Proyecto</strong></h4>
                                
                                <% for ( int m = 0 ; m < metas.size() ; m++ ){
                                      aux = (Vector)metas.elementAt(m); 
                                    %>
                                        <form action="ActualizaObjetivo" method="POST">
                                        <table class="table table-hover">
                                          <tr>
                                            <td width="5%"><%=(m+1)%><input type="hidden" name="idobj" value="<%=aux.elementAt(0)%>"><input type="hidden" name="idpr" value="<%=idp%>"></td>
                                            <td width="90%"><textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="obj" id="" required><%=aux.elementAt(1)%></textarea></td>
                                            
                                          </tr>
                                        </table>
                                        </form> 
                                            
                                            
                                      <%}%>
                                
                                
                            </div>
                                    
                            
                                    <div class="row">
                            <h4><strong>Indicador(es) del Proyecto:</strong></h4>
                            
                                      
                                      <div class="panel-body">
                                              <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        <%if(indicadores.size()>0){%>
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Periodicidad de Medición</th>
                                                                  <th>Descripción</th>
                                                                  <th>Cálculo</th>
                                                                  
                                                                </tr>
                                                                <% for ( int m = 0 ; m < indicadores.size() ; m++ ){
                                                                  auxin = (Vector)indicadores.elementAt(m);
                                                                %>
                                                                <tr>
                                                                  <td><%=auxin.elementAt(1)%></td>
                                                                  <td><%=auxin.elementAt(3)%></td>
                                                                  <td><%=auxin.elementAt(7)%></td>
                                                                  <td><%=auxin.elementAt(2)%></td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                          <%}%>
                                              </div>
                                                              <table align="">
                                                                      <tr>
                                                                      
                                                                      </tr>
                                                                      <tr height="20">
                                                                      </tr>
                                                                      
                                                                      <tr height="20">
                                                                      </tr>
                                                                </table>
                                      </div>
                                    </div>
                                    
                        </div>
                        </div>
                    </div>
                  </div>

<!--ACTIVIDADES-->

<%if(datosb.elementAt(21).equals("P")){%>

                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingThree">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                          <span class="glyphicon glyphicon-paperclip"></span> ACTIVIDADES Y PRESUPUESTO
                        </a>
                      </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                        
                        <br>En la sección actividades de presentan las acciones definidas por el responsable y director del proyecto para la ejecución del proyecto.<br><br>
                        
                      <div class="panel-body">
                          
                                <h3>Actividad(es) y Presupuesto</h3><br>
                                
                               <div class="colorFormulario">
                                 
                                <%if(actividades.size()>0){%>
                                <table class="table table-hover">
                                    <tr>
                                      <th>Actividad Nro.</th>
                                      <th>Nombre Actividad</th>
                                      <th>Fecha Inicio</th>
                                      <th>Fecha Fin</th>
                                      <th>Porcentaje en Proyecto</th>
                                      <th>Porcentaje avance</th>
                               <!--   <th>Detalle</th>  -->
                                      
                                    </tr>
                                    <% for ( int m = 0 ; m < actividades.size() ; m++ ){
                                      aux = (Vector)actividades.elementAt(m);
                                    %>
                                    <tr>
                                      <td><%=(m+1)%></td>
                                      <td><%=aux.elementAt(1)%></td>
                                      <td><%=aux.elementAt(3)%></td>
                                      <td><%=aux.elementAt(4)%></td>
                                      <td><%=aux.elementAt(6)%>%</td>
                                          <%porcentajact = porcentajact + Integer.parseInt(aux.elementAt(6).toString());%>
                                      <td><%=aux.elementAt(5)%>%</td>
                                 <!-- <td><a onClick="if (window.open) { window.open('/planeacion/DetalleActividad?idp=<%=idp%>&act=<%=aux.elementAt(0)%>', return false; }" href="DetalleActividad?idp=<%=idp%>&act=<%=aux.elementAt(0)%>"<%=aux.elementAt(0)%>><img src="img/detallevin.png" width="20" height="22" border="0" ></a></td> -->
                                      
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><button class="btn btn-success" onclick="location.href='/planeacion/actividadver?idp=<%=idp%>&act=<%=aux.elementAt(0)%>'">(Ver/Editar) Detalle Actividad <%=(m+1)%></button></td>        
                                    </tr>
                                    <%}%>
                                  </table>
                                <%}else{%>
                                
                                <center><label>Su proyecto aun no registra actividades en la plataforma.</label></center>
                                
                                <%}%>
                                    
                               </div>     
                          
                      </div>
                    </div>
                  </div>
                                
<%}else if(datosb.elementAt(21).equals("M")){


    Vector listProyectos   = new Vector();
    Vector ProyectosMegaPro   = new Vector();
    ProyectosMegaPro = bd.ConsultaProyectosAsociadosMegaPro(idp);
    listProyectos = bd.ConsultaProyectosMegaPro();
    
%> 

                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingThree">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                          <span class="glyphicon glyphicon-paperclip"></span> PROYECTOS ASOCIADOS
                        </a>
                      </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                        
                        <br>En la sección proyectos asociados, se presentan los proyectos pertenecientes a un MegaProyecto.<br><br>
                        
                      <div class="panel-body">
                          
                                <h3>Proyectos asociados al Megaproyecto</h3><br>
                                
                               <div class="colorFormulario">
                                 
                                <%if(ProyectosMegaPro.size()>0){%>
                                <table class="table table-hover">
                                    <tr>
                                      <th>ID Proyecto.</th>
                                      <th>Nombre</th>
                                      <th>Fecha Inicio</th>
                                      <th>Fecha Fin</th>
                                      <th>Porcentaje avance</th>
                                    </tr>
                                    <% for ( int m = 0 ; m < ProyectosMegaPro.size() ; m++ ){
                                      aux = (Vector)ProyectosMegaPro.elementAt(m);
                                    %>
                                    <tr>
                                      <td><%=aux.elementAt(0)%></td>
                                      <td><%=aux.elementAt(1)%></td>
                                      <td><%=aux.elementAt(2)%></td>
                                      <td><%=aux.elementAt(3)%></td>
                                      <td><%=aux.elementAt(4)%>%</td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><button class="btn btn-success" onclick="location.href='/planeacion/verproyecto?idp=<%=aux.elementAt(0)%>'">Ver Proyecto Asociado</button></h5></td>        
                                    </tr>
                                    <%}%>
                                    
                                  </table>
                                <%}else{%>
                                
                                <center><label>Su Megaproyecto aun no registra proyectos asociados en la plataforma.</label></center>
                                
                                <%}%>
                                    
                               </div>     
                          
                      </div>
                    </div>
                  </div>

<%}%>
                                
                                
<!--SEGUIMIENTOS-->
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingSeven">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
                          <span class="glyphicon glyphicon-paperclip"></span> SEGUIMIENTOS
                        </a>
                      </h4>
                    </div>
                    <div id="collapseSeven" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSeven">
                        
                        <br>En la sección seguimientos se presentan los diferentes seguimientos realizados luego de ser aprobado.<br><br>
                        
                      <div class="panel-body">
                          
                                <div class="colorFormulario">
                                <%if(seguimientos.size()>0){%>
                                <table class="table table-hover">
                                    <tr>
                                    <th>Id. Seg</th>
                                    <th>Fecha de seguimiento</th>
                                    <th>Estado del Seguimiento</th>
                                    <th>Avance</th>
                                    <th>Detalle</th>
                                    </tr>
                                    <%for ( int m = 0 ; m < seguimientos.size() ; m++ ){
                                        aux = (Vector)seguimientos.elementAt(m);
                                    %>
                                    <tr>
                                    <td><%=aux.elementAt(0)%></td>
                                    <td><%=aux.elementAt(1)%></td>
                                    <td><%=aux.elementAt(2)%></td>
                                    <td><%=aux.elementAt(3)%>%</td>
                                    <td><a class="glyphicon glyphicon-equalizer"  target="_blank" href="/planeacion/seguimientoPR?idp=<%=idp%>&seg=<%=aux.elementAt(0)%>"> VerSeguimiento</a></td>
                                    </tr>
                                    <%}%>
                                </table>  
                                <%}else{%>
                                <center><h3>El proyecto no registra ningún seguimiento...</h3></center>
                                <%}%>
                               </div>     
                          
                      </div>
                    </div>
                  </div>
                                
<!--ARCHIVOS-->
                
                     
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFive">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                          <span class="glyphicon glyphicon-paperclip"></span> ARCHIVOS ASOCIADOS
                        </a>
                      </h4>
                    </div>
                    <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                        
                        <br>En la sección archivos, encontrara todos los documentos que soportan la creación y el proceso de seguimiento del proyecto.<br><br>
                        
                        <div class="panel-body">
                        
                        <div class="colorFormulario">  
                                      <%if(archivos.size() > 0){%>
                                      <label>Archivos</label>
                                      <div class="row">
                                          <table class="table">
                                              <tr>
                                                  <th>Número</th>
                                                  <th>Nombre Archivo</th>
                                                  <th>Tipo</th>
                                                  <th>Observación</th>
                                                  <th>Descargar</th>
                                                  
                                              </tr>
                                              <% for ( int m = 0 ; m < archivos.size() ; m++ ){
                                                                  auxin = (Vector)archivos.elementAt(m);
                                                                  numero_archivo = m+2;
                                              %>
                                              <tr>
                                                  <td><%=(m+1)%></td>
                                                  <td><%=auxin.elementAt(2)%></td>
                                                  <td><%=auxin.elementAt(4)%></td>
                                                  <td><%=auxin.elementAt(5)%></td>
                                                  <td><a href="/planeacion/descarga?idp=<%=idp%>&down=<%=auxin.elementAt(1)%>" download><img src="img/descargar.png" width="20" height="22" border="0"></td>
                                              </tr>
                                              <%}%>
                                          </table>
                                      </div>
                                      <%}%>
                                                    
                                  </div>
                        </div>
                    </div>
                  </div>
<!-- RESUMEN -->  
<%if(datosb.elementAt(21).equals("P")){%>
                 <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingSix">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                          <span class="glyphicon glyphicon-paperclip"></span> RESUMEN
                        </a>
                      </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                        
                        <br>En la sección resumen, encontrara los valores de erogación y de dedicación de personal de todas las actividades por año.<br><br>
                        
                        <div class="panel-body">
                        
                        <div class="colorFormulario">
                            
                      <h3>Resumen de Presupuesto del Proyecto - <%=datosb.elementAt(0)%></h3>
                      <br>
                      
                      <table class="table table-hover">
                      <tr>
                        <th>Actividades / Año</th>
                        <th>SubTotal Dedicación</th>
                        <th>SubTotal Erogación</th>
                        <th>Total Actividad</th>
                      </tr>
                      <tr>
                          <td></td>

                          <td></td>
                      </tr>
                      <% for ( int m = 0 ; m < actividades.size() ; m++ ){
                                      aux = (Vector)actividades.elementAt(m);
                                      
                                      BigInteger TotalEct, TotalDed, TotalAc;

                                        TotalEct = BigInteger.valueOf(0);
                                        TotalDed = BigInteger.valueOf(0);                                      
                                        TotalAc  = BigInteger.valueOf(0);
                                    %>
                      <tr>
                        <td><%=aux.elementAt(1)%></td>
                        <%for(int q = agnoinicial; q <= agnofinal; q++){
                            
                            ValorDed = bd.consultavalordedper(aux.elementAt(0).toString(), Integer.toString(q));
                            ValorEro = bd.consultavalorerog(aux.elementAt(0).toString(), Integer.toString(q));
                            
                            TotalDed = TotalDed.add(new BigInteger(ValorDed));
                            TotalEct = TotalEct.add(new BigInteger(ValorEro)); 
                        }
                        TotalAc = TotalDed.add(TotalEct);
                        %>
                        <td>$ <%=formatea.format(new BigInteger(TotalDed.toString()))%></td>
                        <td>$ <%=formatea.format(new BigInteger(TotalEct.toString()))%></td>
                        <td>$ <%=formatea.format(new BigInteger(TotalAc.toString()))%></td>
                      </tr>
                      <%  TDed    = TDed.add(TotalDed);
                          TEro    = TEro.add(TotalEct);  
                          TotalPR = TotalPR.add(TotalAc);
                      }
                      %>
                      <tr>
                          <th>Total</th>
                          <th>$ <%=formatea.format(new BigInteger(TDed.toString()))%></th>
                          <th>$ <%=formatea.format(new BigInteger(TEro.toString()))%></th>
                          <th>$ <%=formatea.format(new BigInteger(TotalPR.toString()))%></th>
                      </tr>
                    </table>
                    <br>
                    <a href="/planeacion/resumenpre?idp=<%=idp%>" target="_blank">Ver Detalle de presupuesto en Ventana Emergente</a>
                    <br>
                    <a href="/planeacion/resumenRubro?idp=<%=idp%>" target="_blank">Ver Detalle de presupuesto por Rubro en Ventana Emergente</a>
                    
                    <center><label>Total Proyecto</label><input class="form-control" value="$ <%=formatea.format(new BigInteger(TotalPR.toString()))%>"></center>
                    <%bd.ActualizarValorPlaneado(idp, TotalPR.toString());
                    bd.ActualizarValorPlaneadoErPer(idp,TDed.toString(),TEro.toString());%>        
                                  </div>
                        </div>
                    </div>
                  </div>
   <!--SECCIÓN  EN CASO DE SER MEGAPROYECTO (PROYECTOS ASOCIADOS)-->
<%}else if(datosb.elementAt(21).equals("M")){

    Vector ActividadesMegaPro   = new Vector();
    ActividadesMegaPro = bd.ConsultaActividadesMegaPro(idp);
    
%>    



<div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingSix">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                          <span class="glyphicon glyphicon-paperclip"></span> RESUMEN
                        </a>
                      </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                        
                        <br>En la sección resumen, encontrara los valores de erogación y de dedicación de personal de todas las actividades por año.<br><br>
                        
                        <div class="panel-body">
                        
                        <div class="colorFormulario">
                            
                      <h3>Resumen de Presupuesto del Proyecto - <%=datosb.elementAt(0)%></h3>
                      <br>
                      
                        <table class="table table-hover">
                        <tr>
                          <th>Proyecto</th>
                          <th>Actividades / Año</th>
                          <th>SubTotal Dedicación</th>
                          <th>SubTotal Erogación</th>
                          <th>Total Actividad</th>
                        </tr>
                        <tr>
                            <td></td>

                            <td></td>
                        </tr>
                        <% for ( int m = 0 ; m < ActividadesMegaPro.size() ; m++ ){
                                        aux = (Vector)ActividadesMegaPro.elementAt(m);

                                        BigInteger TotalEct, TotalDed, TotalAc;

                                          TotalEct = BigInteger.valueOf(0);
                                          TotalDed = BigInteger.valueOf(0);                                      
                                          TotalAc  = BigInteger.valueOf(0);
                                      %>
                        <tr>
                          <td><%=aux.elementAt(10)%></td>
                          <td><%=aux.elementAt(1)%></td>
                          <%for(int q = agnoinicial; q <= agnofinal; q++){

                              ValorDed = bd.consultavalordedper(aux.elementAt(0).toString(), Integer.toString(q));
                              ValorEro = bd.consultavalorerog(aux.elementAt(0).toString(), Integer.toString(q));

                              TotalDed = TotalDed.add(new BigInteger(ValorDed));
                              TotalEct = TotalEct.add(new BigInteger(ValorEro)); 
                          }
                          TotalAc = TotalDed.add(TotalEct);
                          %>
                          <td>$ <%=formatea.format(new BigInteger(TotalDed.toString()))%></td>
                          <td>$ <%=formatea.format(new BigInteger(TotalEct.toString()))%></td>
                          <td>$ <%=formatea.format(new BigInteger(TotalAc.toString()))%></td>
                        </tr>
                        <%  TDed    = TDed.add(TotalDed);
                            TEro    = TEro.add(TotalEct);  
                            TotalPR = TotalPR.add(TotalAc);
                        }
                        %>
                        <tr>
                            <th>Total</th>
                            <th></th>
                            <th>$ <%=formatea.format(new BigInteger(TDed.toString()))%></th>
                            <th>$ <%=formatea.format(new BigInteger(TEro.toString()))%></th>
                            <th>$ <%=formatea.format(new BigInteger(TotalPR.toString()))%></th>
                        </tr>
                      </table>
                      <br>
                      <a href="/planeacion/resumenpre?idp=<%=idp%>" target="_blank">Ver Detalle de presupuesto en Ventana Emergente</a>

                      <center><label>Total Proyecto</label><input class="form-control" value="$ <%=formatea.format(new BigInteger(TotalPR.toString()))%>"></center>
                      <%bd.ActualizarValorPlaneado(idp, TotalPR.toString());
                        bd.ActualizarValorPlaneadoErPer(idp,TDed.toString(),TEro.toString());%>      
                                  </div>
                        </div>
                    </div>
                  </div>



<%}%>
                                                                                    
            </div>  
        </div>                                                                
<br>
                                                                                 
    </section>

<%}else{%>
<br>    <br>    <br>    
<center><strong><label><font color="red">Comuniquese con el Administrador de la Oficina de Desarrollo Institucional. Usted no tiene acceso a este proyecto :(</font></label></strong></center>
<br>    <br>    <br>    
<%}%>

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


<script>
    
    //document.getElementById('collapseOne').style.display = 'block';
    
    $(document).ready(function() {
    var hashVal = window.location.hash.split("#")[1];
    
        $("#"+hashVal).collapse();

    
    });
    
    function alineacionestr(){
        
        if( document.getElementById("alineacion").checked == true){
            
            document.getElementById('Estrategica').style.display = 'block';
        }
        else{
            
            document.getElementById('Estrategica').style.display = 'none';
        }
        
    }
    
     function caracteristicasp(){
        
        if( document.getElementById("caracteristicas").checked == true){
            
            document.getElementById('addcarac').style.display = 'block';
        }
        else{
            
            document.getElementById('addcarac').style.display = 'none';
        }
        
    }
    
    function creactividad(){
        
        if( document.getElementById("creact").checked == true){
            
            document.getElementById('Creactividad').style.display = 'block';
        }
        else{
            
            document.getElementById('Creactividad').style.display = 'none';
        }
        
    }
    
    function crearubro(){
        
        if( document.getElementById("crearub").checked == true){
            
            document.getElementById('CreaRubro').style.display = 'block';
        }
        else{
            
            document.getElementById('CreaRubro').style.display = 'none';
        }
        
    }
    
    
    
    function crearind(){
        
        if( document.getElementById("creaind").checked == true){
            
            document.getElementById('CreaInd').style.display = 'block';
        }
        else{
            
            document.getElementById('CreaInd').style.display = 'none';
        }
        
    }
    
</script>

    

    <!--SCRIPT BOOTSTRAP-->
    <script src="js/jquery.js"></script>
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script src="js/bootstrap.min.js"></script>

</body>
</html>
