<%-- 
    Document   : historial
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@ include file="secure.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");
        String ccemp = session.getAttribute("cod_emp").toString();
        String nomus = session.getAttribute("nom_emp").toString(); 
        String apus1 = session.getAttribute("ap1_emp").toString();
        String apus2 = session.getAttribute("ap2_emp").toString();
        String mailus = session.getAttribute("e_mail").toString();
        
        String idp = request.getParameter("idp");
        String act = request.getParameter("act");
        
       String mensaje="";
        
        mensaje = request.getParameter("m");
        
        BDServicios bd = new BDServicios();
        
        Vector aux          = new Vector();
        Vector personal     = new Vector();
        Vector empleados    = new Vector();
        Vector cargos       = new Vector();
        Vector indicadores  = new Vector();
        Vector horas        = new Vector();
        Vector auxh         = new Vector();
        Vector auxin        = new Vector();
        Vector rubro        = new Vector();
        Vector presupuesto  = new Vector();
        Vector datosb       = new Vector();
        Vector actividad    = new Vector();
        
        int Validar = bd.ValidarIDPrAc(idp, act, "1");
        
        if(Validar > 0){
        
        actividad   = bd.ConsultaInfoActividad(act);
        presupuesto = bd.ConsultaPresupuestoActi(act);
        personal    = bd.ConsultaPersonal(act,"0");
        empleados   = bd.usuario();
        indicadores = bd.ConsultaIndActividad(act);
        rubro       = bd.PreRubrosPL();
        datosb      = bd.ConsultaDatosProyecto(idp);
        cargos      = bd.cargoseci();
        
        
        }
        String vigencia = bd.vigenciaproy(idp);

        BigInteger TotalRubros;
        
        TotalRubros = BigInteger.valueOf(0);
        
        String Valor="", Cadena="";
        
        DecimalFormat formatea = new DecimalFormat("###,###.##");
         
        int q  = bd.Consultaagnofechas(act);
        int agno   = Integer.parseInt(bd.consultagnoiniact(act)); 
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
<body onload="testshow(), testshow2(), testshow3(), ini()">

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
            <center><img src="img/img-historial.jpg" alt="portada" class="img-responsive"></center>
        </div>
    </header>

<!--CONTENIDOS-->
    <section>
        <div class="container">
            
            <div class="colorFormulario">
                <center>
                    <strong>Id. Proyecto:           </strong>           <a><%=idp%></a>  
                    <strong>Nombre del Proyecto:    </strong>           <a><%=datosb.elementAt(0)%></a>  <br>
                    <strong>Estado Proyecto:        </strong>           <a><%=bd.parametrosEsp("1", datosb.elementAt(1).toString())%></a>
                    <strong>Avance:                 </strong>           <a><%=datosb.elementAt(14)%>%</a>
                    <strong>Plan:                   </strong>           <a><%=bd.nombreplan(datosb.elementAt(3).toString())%></a>
                    <strong>Vigencia:               </strong>           <a><%=vigencia%></a>
                    <strong>Director:               </strong>           <a><%=bd.usuarioconscc(datosb.elementAt(6).toString())%></a>
                    <br><br>
                    <button class="btn btn-group-sm" onclick="window.open('/planeacion/ResumenPlaneacion?idp=<%=idp%>')">Ver Resumen Proyecto</button>
                </center>
            </div>  
            
            <div class="row">
                <div class="col-md-12 filaCompleta">
                    <p>
                        
                        <div class="colorFormulario">
                            <center>
                                <h3><b><a>Datos Básicos Actividad</a></b></h3>
                               
                                    <table style="min-width: 900;   ">
                                    <tr><input type="hidden" name="act" value="<%=act%>"><input type="hidden" name="idp" value="<%=idp%>">
                                        <td >Nombre Actividad:</td><td colspan="3"><input class="form-control" value="<%=actividad.elementAt(1)%>" type="text" name="nom" required></td></tr>           
                                        <tr><td>Fecha Inicio: </td><td><input class="form-control" value="<%=actividad.elementAt(3)%>" type="text" name="feinicio" readonly></td>       
                                            <td>Fecha Fin:    </td><td><input class="form-control" value="<%=actividad.elementAt(4)%>" type="text" name="fefin" readonly></td></tr>        
                                        <tr>
                                        <td>Porcentaje (Peso) Actividad: </td><td><input class="form-control" value="<%=actividad.elementAt(6)%>" type="number" name="peso" min="1" max="100" required></td>       
                                        <td>Porcentaje Avance:   </td><td><input class="form-control" type="text" value="<%=actividad.elementAt(5)%>" name="poravance" readonly></td></tr>
                                        <tr><td>Responsable Actividad</td>
                                            <td colspan="3">
                                                <select name="responact" id="responsable" class="form-control" required>
                                                                            <%if (empleados.size() > 0){ 
                                                                            %><option value="">Seleccione el Responsable</option><%
                                                                                    for (int ii = 0; ii < empleados.size(); ii++) {
                                                                                            Vector infusu = (Vector)empleados.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(actividad.elementAt(10).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                               </select>                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Descripción:</td><td colspan="3"><textarea rows="6" cols="20" class="form-control" name="desc" required><%=actividad.elementAt(2)%></textarea></td>
                                        </tr>
                                </table>
                                <br>
                               
                                
                            </center>
                        </div>
                    
                                  <div class="row" style="display: block;">
                                      
                                      <br>
                                            <center><input class="btn btn-info" type="button" value="< Regresar al Proyecto" name="volver atrás2" onclick="location.href='/planeacion/verproyecto?idp=<%=idp%>#collapseThree'" /></center><br>
                                      <br>
                                      
                                      <div class="colorFormulario">
                                          <a name="dedicacion"><h4><strong>Dedicación de personal:</strong></h4></a>
                                      
                                      <div class="panel-body">
                                              <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        <%if(personal.size()>0){%>
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Cargo</th>
                                                                   <th>Horas y Cantidad por año</th>
                                                                </tr>
                                                                <% for ( int m = 0 ; m < personal.size() ; m++ ){
                                                                  aux = (Vector)personal.elementAt(m);
                                                                %>
                                                                <tr>
                                                                    <%if(aux.elementAt(1).toString().equals("Sin Definir")){%>
                                                                        <td><%=aux.elementAt(1).toString()%></td>
                                                                    <%}else{%>
                                                                        <td><%=bd.usuarioconscc2(aux.elementAt(1).toString())%></td>
                                                                    <%}%>
                                                                  
                                                                  <td><%=aux.elementAt(2).toString()%></td>
                                                                  <td>
                                                                       <table>
                                                                             <tr>
                                                                                 <th style="padding-right: 170px">Año</th>
                                                                          <th style="padding-right: 50px">Horas</th>
                                                                          <th>Cantidad Pers.</th>
                                                                          </tr>
                                                                      </table>
                                                                      <% horas = bd.ConsultarHoras(aux.elementAt(0).toString());
                                                                         for ( int s = 0 ; s < horas.size() ; s++ ){
                                                                         auxh = (Vector)horas.elementAt(s);
                                                                      %>
                                                                      
                                                                      <table>
                                                                          <td><input type="number" class="form-control" value="<%=auxh.elementAt(0)%>" name="agno" readonly></td>
                                                                          <td><input type="number" class="form-control" value="<%=auxh.elementAt(1)%>" name="horas" min="0" max="2920" onblur="">
                                                                               <%if(aux.elementAt(1).toString().equals("Sin Definir")){%>
                                                                                    <td><input type="number" class="form-control" value="<%=auxh.elementAt(2)%>" name="CantPer" min="0" max="2920" onblur="">
                                                                                 <%}else{%>
                                                                                    <td><input type="number" class="form-control" value="<%=auxh.elementAt(2)%>" name="CantPer" min="0" max="2920" onblur="" readonly>
                                                                                <%}%>
                                                                              <input type="hidden" value="<%=aux.elementAt(0)%>" name="idpersonal">
                                                                              <input type="hidden" value="<%=idp%>" name="idp">
                                                                              <input type="hidden" value="<%=act%>" name="idact">
                                                                          </td>
                                                                      </table>
                                                                      
                                                                      <%}%>
                                                                      
                                                                  </td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                              <%}else{%>
                                                                <center><label>Su actividad aun no registra dedicación de personal en la plataforma.</label></center><br>
                                                                <%}%>
                                              </div>
                                                              
                                      </div>
                                            
                                      </div>
                                      <div class="colorFormulario">
                    
                   
                                          <a name="erogacion"><h4><strong>Presupuesto Erogación</strong></h4></a>
                      
                            <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">
                                                          <input type="hidden" value="<%=idp%>" name="idp">    
                                                      </div>
                                                              <%if(presupuesto.size()>0){%>
                                                              <div class="colorFormulario">
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <!--<th>Actividad</th>-->
                                                                  <th>Rubro</th>
                                                                  <th>Tipo Rubro</th>
                                                                  <th>Año</th>
                                                                  <th>Valor</th>
                                                                  <th>Observación</th>
                                                                  
                                                                </tr>
                                                                <% for ( int m = 0 ; m < presupuesto.size() ; m++ ){
                                                                    aux = (Vector)presupuesto.elementAt(m);
                                                                    TotalRubros = TotalRubros.add(new BigInteger(aux.elementAt(6).toString()));
                                                                  %>
                                                                <tr>
                                                                  <!--<td><%=aux.elementAt(5)%></td>-->
                                                                  <td>
                                                                      <select name="rubrosel" id="rubro" class="form-control" required>
                                                                            <%if (rubro.size() > 0){ 
                                                                            %><option value="">Seleccione el Rubro</option><%
                                                                                    for (int ii = 0; ii < rubro.size(); ii++) {
                                                                                            Vector infusu = (Vector)rubro.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(aux.elementAt(2).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
                                                                  </td>
                                                                  <input type="hidden" name="iderog" value="<%=aux.elementAt(0)%>"><input type="hidden" name="idp" value="<%=idp%>">
                                                                  <td><%=aux.elementAt(1)%></td>
                                                                  <td><%=aux.elementAt(7)%></td>
                                                                  <td>$ <%=formatea.format(Integer.parseInt(aux.elementAt(6).toString()))%></td>
                                                                  <td><%=aux.elementAt(4)%></td>
                                                                  
                                                                  </tr>
                                                                  <%}%>
                                                                </table>
                                                                  
                                                                        <label>Total presupuesto de erogación: </label>
                                                                        <input type="text" name="" value="$   <%=formatea.format(Integer.parseInt(TotalRubros.toString()))%>" class="form-control" readonly>
                                                                        <br>
                                                                  
                                                                <%}else{%>
                                                                <center><label>Su actividad aun no registra valores de erogación en la plataforma.</label></center><br>
                                                                <%}%>
                                                               </div>
                                                              
                                                              
                                                              <br>
                                                              
                                                                        
                                              </div>
                      
                    
                                      </div>
                                      <div class="colorFormulario">                                             
                                                                                                                    
                                      <div class="row">
                                          
                                          
                                          <a name=""><h4><strong>Indicadores de la Actividad:</strong></h4></a>
                                             
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        <%if(indicadores.size()>0){%>
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Periodicidad de Medición</th>
                                                                  <th>Descricpión</th>
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
                                                          <%}else{%>
                                                                <center><label>Su actividad aun no registra indicadores en la plataforma.</label></center><br>
                                                         <%}%>
                                                                <a name="indicadores"></a>
                                                              
                                      
                                      </div>                    
                                      </div>
                                                                                                    
                                  </div>
                                  </div> 
                    </p>
            </div>                                 <center><input class="btn btn-info" type="button" value="< Regresar al Proyecto" name="volver atrás2" onclick="location.href='/planeacion/verproyecto?idp=<%=idp%>#collapseThree'" /></center><br>
                                                               
            </div>
        </div>
    </section>

<script>
    
    function ini(){
        
        $(".Box").show('slow');
        $(".Box3").show('slow');
        $(".Box4").show('slow');
    }
   
    function testshow(){
        
    $('input[type="radio"]').click(function(){
        if($(this).attr("value")=="N"){
            $(".Box").show('slow');
	    $(".Box2").hide('slow');
        }
        if($(this).attr("value")=="C"){
            $(".Box2").show('slow');
            $(".Box").hide('slow');
        }
        if($(this).attr("value")=="Q"){
            $(".Box").hide('slow');
	    $(".Box2").hide('slow');
        } 
    });
    }
    
     function testshow2(){
    $('input[type="radio"]').click(function(){
        if($(this).attr("value")=="X"){
            $(".Box3").hide('slow');
        }
        if($(this).attr("value")=="I"){
            $(".Box3").show('slow');
        }
    });
    }
    
     function testshow3(){
    $('input[type="radio"]').click(function(){
        if($(this).attr("value")=="RX"){
            $(".Box4").hide('slow');
        }
        if($(this).attr("value")=="RI"){
            $(".Box4").show('slow');
        }
    });
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
