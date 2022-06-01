<%-- 
    Document   : historial
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="BDatos.BDServiciosAdmin"%>
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
        
        
        BDServiciosAdmin bda = new BDServiciosAdmin();
        
        Vector planes   = new Vector();
        Vector ejes     = new Vector();
        Vector rubros   = new Vector();
        Vector aux      = new Vector();
        Vector unidades = new Vector();
        Vector paramet  = new Vector();
        
        planes      = bda.ConsultaPlanes();
        ejes        = bda.ConsultaEJES();
        rubros      = bda.ConsultaRubros();
        unidades    = bda.ConsultaUnidades();
        paramet     = bda.ConsultaParametros();
        
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
                <img src="img/img-historial.jpg" alt="portada" class="img-responsive">
        </div>
    </header>

    <nav>
        <div class="container">
<ul class="nav nav-pills nav-justified">
          <li role="presentation"><a href="/planeacion/homeadm"><span class="glyphicon glyphicon-home"></span> Inicio</a></li>
          <li role="presentation"><a href="/planeacion/proyectosactadm"><span class="glyphicon glyphicon-duplicate"></span>Consulta de Proyectos Activos</a></li>
          <li role="presentation"><a href="/planeacion/seguimientoadm"><span class="glyphicon glyphicon-eye-open"></span> Seguimiento Proyectos</a></li>
          <li role="presentation"><a href="/planeacion/allproyectos"><span class="glyphicon glyphicon-lamp"></span> Todos los Proyectos</a></li>
          <li role="presentation" class="active"><a href="/planeacion/historialadm"><span class="glyphicon glyphicon-list-alt"></span> Parametros del Sistema</a></li>
          <li role="presentation"><a href="/planeacion/reportesadm"><span class="glyphicon glyphicon-file"></span> Reportes Administrador</a></li>
        </ul>
        </div>
    </nav>

<!--CONTENIDOS-->
    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-12 filaCompleta">
                    <h3>A continuación se presentan los <strong>Parametros para los Usuarios del Sistema:</strong></h3><br>
                    <h4>Planes</h4>
                    <%if(planes.size()>0){%>
                    <table class="table table-hover">
                      <tr>
                        <th width="5%">Id. PLAN</th>
                        <th width="70%">Nombre PLAN</th>
                        <th width="30%">Estado</th>
                      </tr>
                      <% for ( int m = 0 ; m < planes.size() ; m++ ){
                        aux = (Vector)planes.elementAt(m);
                      %>
                      <tr>
                        <td><input class="form-control" type="text" name="idplan" value="<%=aux.elementAt(0)%>" readonly></td>
                        <td><input class="form-control" type="text" name="nombre" value="<%=aux.elementAt(1)%>"></td>
                        <td>
                            <select class="form-control" >      
                                          <option value="0">Inactivo</option>      
                                          <option value="1">Activo</option>
                                          <%if(aux.elementAt(2).equals("0")){%>
                                          <option value="0" selected>Inactivo</option>
                                          <%}else{%>
                                          <option value="1" selected>Activo</option>
                                          <%}%>
                            </select>
                        </td>
                      </tr>
                      <%}%>
                    </table>
                    <center><input type="submit" class="btn btn-lg" value="Guardar Cambios"></center>
                    <%}%>
                    <input type="checkbox" id="adplan" onclick="adplan()"> <a>Agregar Plan</a>
                    
                    <div class="row" id="newplan" style="display: none;">
                                <div class="col-md-12 filaCompleta">
                                    <form action="NuevoEJE" method="POST" class="colorFormulario">
                                        <div class="row">
                                            <div class="col-md-offset-1 col-md-10">
                                                <div class="form-group">
                                                    <label for="">Defina el nombre del PLAN:</label> 
                                                    <input class="form-control" type="text" name="nombrepl" required>
                                                </div>
                                            </div>
                                        </div>
                                        <center><input type="submit" class="btn-lg" value="Agregar PLAN"></center>
                                    </form> <br>

                                </div>
                            </div>
                    
                    <hr>
                    <h4>EJES</h4>
                    <p>
                    <%if(ejes.size()>0){%>
                    <table class="table table-hover">
                      <tr>
                        <th width="5%">Id. EJE</th>
                        <th width="30%">Nombre EJE</th>
                        <th width="50%">Objetivo General</th>
                        <th width="10%">Estado</th>
                      </tr>
                      <% for ( int m = 0 ; m < ejes.size() ; m++ ){
                        aux = (Vector)ejes.elementAt(m);
                      %>
                      <tr>
                        <td><input class="form-control" type="text" name="idplan" value="<%=aux.elementAt(0)%>" readonly></td>
                        <td><input class="form-control" type="text" name="nombre" value="<%=aux.elementAt(1)%>"></td>
                        <td><textarea class="form-control" rows="5"><%=aux.elementAt(2)%></textarea></td>
                        <td>
                            <select class="form-control" >      
                                          <option value="0">Inactivo</option>      
                                          <option value="1">Activo</option>
                                          <%if(aux.elementAt(4).equals("0")){%>
                                          <option value="0" selected>Inactivo</option>
                                          <%}else{%>
                                          <option value="1" selected>Activo</option>
                                          <%}%>
                            </select>
                        </td>
                      </tr>
                      <%}%>
                    </table>
                    <center><input type="submit" class="btn btn-lg" value="Guardar Cambios"></center>
                    <%}%>
                    <input type="checkbox" id="adeje" onclick="adeje()"> <a>Agregar EJE</a>
                    
                    <div class="row" id="neweje" style="display: none;">
                                <div class="col-md-12 filaCompleta">
                                    <form action="NuevoEJE" method="POST" class="colorFormulario">
                                        <div class="row">
                                            <div class="col-md-offset-1 col-md-10">
                                                <div class="form-group">
                                                    <label for="">Defina el nombre del EJE:</label> 
                                                    <input class="form-control" type="text" name="nombrepl" required>
                                                </div>
                                            </div>
                                        </div>
                                        <center><input type="submit" class="btn-lg" value="Agregar EJE"></center>
                                    </form> <br>

                                </div>
                     </div>
                    
                    <hr>
                    <h4>Unidades Ejecutoras</h4>
                    <p>
                    <%if(unidades.size()>0){%>
                    <table class="table table-hover">
                      <tr>
                        <th width="5%">Id. UNIDAD</th>
                        <th width="70%">Nombre UNIDAD</th>
                        <th width="30%">Estado</th>
                      </tr>
                      <% for ( int m = 0 ; m < unidades.size() ; m++ ){
                        aux = (Vector)unidades.elementAt(m);
                      %>
                      <tr>
                        <td><input class="form-control" type="text" name="idplan" value="<%=aux.elementAt(0)%>" readonly></td>
                        <td><input class="form-control" type="text" name="nombre" value="<%=aux.elementAt(1)%>"></td>
                        <td>
                            <select class="form-control" >      
                                          <option value="0">Inactivo</option>      
                                          <option value="1">Activo</option>
                                          <%if(aux.elementAt(2).equals("0")){%>
                                          <option value="0" selected>Inactivo</option>
                                          <%}else{%>
                                          <option value="1" selected>Activo</option>
                                          <%}%>
                            </select>
                        </td>
                      </tr>
                      <%}%>
                    </table>
                    <center><input type="submit" class="btn btn-lg" value="Guardar Cambios"></center>
                    <%}%>
                    <input type="checkbox" id="adunidad" onclick="adunidad()"> <a>Agregar Unidad Ejecutora</a>
                    
                    <div class="row" id="newunidad" style="display: none;">
                                <div class="col-md-12 filaCompleta">
                                    <form action="NuevoEJE" method="POST" class="colorFormulario">
                                        <div class="row">
                                            <div class="col-md-offset-1 col-md-10">
                                                <div class="form-group">
                                                    <label for="">Defina el nombre del PLAN:</label> 
                                                    <input class="form-control" type="text" name="nombrepl" required>
                                                </div>
                                            </div>
                                        </div>
                                        <center><input type="submit" class="btn-lg" value="Agregar PLAN"></center>
                                    </form> <br>

                                </div>
                            </div>
                    
                    <hr>
                    <h4>Rubros Planeación</h4>
                    <p>
                    <%if(rubros.size()>0){%>
                    <table class="table table-hover">
                      <tr>
                        <th width="5%">Id. RUBRO</th>
                        <th width="30%">Nombre RUBRO</th>
                        <th width="30%">Tipo Rubro</th>
                        <th width="15%">Estado</th>
                      </tr>
                      <% for ( int m = 0 ; m < rubros.size() ; m++ ){
                        aux = (Vector)rubros.elementAt(m);
                      %>
                      <tr>
                        <td><input class="form-control" type="text" name="idplan" value="<%=aux.elementAt(0)%>" readonly></td>
                        <td><input class="form-control" type="text" name="nombre" value="<%=aux.elementAt(1)%>"></td>
                        <td>
                            <select class="form-control" >      
                                          <option value="1">Inversión</option>      
                                          <option value="2">Otros Gastos</option>
                                          <%if(aux.elementAt(2).equals("1")){%>
                                          <option value="1" selected>Inversión</option>
                                          <%}else{%>
                                          <option value="2" selected>Otros Gastos</option>
                                          <%}%>
                            </select>
                        </td>
                        <td>
                            <select class="form-control" >      
                                          <option value="0">Inactivo</option>      
                                          <option value="1">Activo</option>
                                          <%if(aux.elementAt(3).equals("0")){%>
                                          <option value="0" selected>Inactivo</option>
                                          <%}else{%>
                                          <option value="1" selected>Activo</option>
                                          <%}%>
                            </select>
                        </td>
                      </tr>
                      <%}%>
                    </table>
                    <center><input type="submit" class="btn btn-lg" value="Guardar Cambios"></center>
                    <%}%>
                    <input type="checkbox" id="adrubro" onclick="adrubro()"> <a>Agregar RUBRO</a>
                    
                    <div class="row" id="newrubro" style="display: none;">
                                <div class="col-md-12 filaCompleta">
                                    <form action="NuevoEJE" method="POST" class="colorFormulario">
                                        <div class="row">
                                            <div class="col-md-offset-1 col-md-10">
                                                <div class="form-group">
                                                    <label for="">Defina el nombre del RUBRO:</label> 
                                                    <input class="form-control" type="text" name="nombrepl" required>
                                                </div>
                                            </div>
                                        </div>
                                        <center><input type="submit" class="btn-lg" value="Agregar RUBRO"></center>
                                    </form> <br>

                                </div>
                     </div>
                    
                    
                    <hr>
                    <h4>Estados Generales</h4>
                    <p>
                    <%if(paramet.size()>0){%>
                    <table class="table table-hover">
                      <tr>
                        <th width="5%">Id. Estado</th>
                        <th width="30%">Nombre Estado</th>
                        <th width="30%">Descripción</th>
                        <th width="15%">Estado</th>
                      </tr>
                      <% for ( int m = 0 ; m < paramet.size() ; m++ ){
                        aux = (Vector)paramet.elementAt(m);
                      %>
                      <tr>
                        <td><input class="form-control" type="text" name="idplan" value="<%=aux.elementAt(0)%>" readonly></td>
                        <td><input class="form-control" type="text" name="nombre" value="<%=aux.elementAt(2)%>"></td>
                        <td>
                            <input class="form-control" type="text" name="nombre" value="<%=aux.elementAt(3)%>">
                        </td>
                        <td>
                            <select class="form-control" >      
                                          <option value="0">Inactivo</option>      
                                          <option value="1">Activo</option>
                                          <%if(aux.elementAt(3).equals("0")){%>
                                          <option value="0" selected>Inactivo</option>
                                          <%}else{%>
                                          <option value="1" selected>Activo</option>
                                          <%}%>
                            </select>
                        </td>
                      </tr>
                      <%}%>
                    </table>
                    <center><input type="submit" class="btn btn-lg" value="Guardar Cambios"></center>
                    <%}%>
                    <input type="checkbox" id="adparametro" onclick="adparametro()"> <a>Agregar ESTADO GENERAL</a>
                    
                    <div class="row" id="newparametro" style="display: none;">
                                <div class="col-md-12 filaCompleta">
                                    <form action="NuevoEJE" method="POST" class="colorFormulario">
                                        <div class="row">
                                            <div class="col-md-offset-1 col-md-10">
                                                <div class="form-group">
                                                    <label for="">Defina el nombre del ESTADO:</label> 
                                                    <input class="form-control" type="text" name="nombrepl" required>
                                                </div>
                                            </div>
                                        </div>
                                        <center><input type="submit" class="btn-lg" value="Agregar PARAMETRO"></center>
                                    </form> <br>

                                </div>
                     </div>
                    
                </div>
            </div>
        </div>
    </section>

<script>
    
    
    function adplan(){
        
        if( document.getElementById("adplan").checked == true){
            
            document.getElementById('newplan').style.display = 'block';
        }
        else{
            
            document.getElementById('newplan').style.display = 'none';
        }
        
    }
    
        function adeje(){
        
        if( document.getElementById("adeje").checked == true){
            
            document.getElementById('neweje').style.display = 'block';
        }
        else{
            
            document.getElementById('neweje').style.display = 'none';
        }
     }
     
     
     function adrubro(){
        
        if( document.getElementById("adrubro").checked == true){
            
            document.getElementById('newrubro').style.display = 'block';
        }
        else{
            
            document.getElementById('newrubro').style.display = 'none';
        }
        
    }
    
    function adunidad(){
        
        if( document.getElementById("adunidad").checked == true){
            
            document.getElementById('newunidad').style.display = 'block';
        }
        else{
            
            document.getElementById('newunidad').style.display = 'none';
        }
        
    }
    
     function adparametro(){
        
        if( document.getElementById("adparametro").checked == true){
            
            document.getElementById('newparametro').style.display = 'block';
        }
        else{
            
            document.getElementById('newparametro').style.display = 'none';
        }
        
    }
    
</script>

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
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
