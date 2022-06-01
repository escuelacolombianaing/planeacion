<%-- 
    Document   : login
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%

String nMsg = request.getParameter("id");
        String mensaje = new String("");
if (nMsg != null) {
            /* Si la sesion no existe */
            HttpSession sesion = request.getSession();
            sesion.invalidate();
        if (nMsg != null) {
            if (nMsg.equals("0")) {
                %>
                <script>alert("Usuario o clave incorrecta.")</script>
                <%
            } else if (nMsg.equals("1")) {
                %>
                <script>alert("Complete los campos Usuario y Contraseña.")</script>
                <%
            } else if (nMsg.equals("2")) {
                %>
                <script>alert("Usted no está Autorizado.")</script>
                <%
            } else if (nMsg.equals("3")) {
                %>
                <script>alert("Sesión cerrada correctamente.")</script>
                <%
                }
            } else if (nMsg.equals("4")) {
                %>
                <script>alert("Error en inicio de Sesión.")</script>
                <%
                }  
}

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
    <link rel="stylesheet" href="css/seguimiento.css">     
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Arsenal" rel="stylesheet">

</head>
<body>

<header>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <center><img src="img/img-header.jpg" class="img-responsive"></center>
            </div>
        </div>
    </div>
</header>
<!--CONTENIDOS-->
<section>
    <div class="jumbotron">
        <div class="container inscripcion">
            <div class="row">
                <div class="col-sm-7 col-md-6 col-md-offset-1">
                    <h1>Plataforma de seguimiento a la planeación - PSP</h1>
                </div>
                <div class="col-sm-5 col-md-5">
                    <div class="formulario">
                        <form class="form-horizontal" method="POST" action="Login">
                      <div class="form-group">
                        <label class="col-sm-9 col-md-5 control-label">Usuario:   </label>
                        <div class="col-sm-12 col-md-7">
                          <input type="text" class="form-control"  placeholder="Usuario" name="usr">
                        </div>
                      </div>
                      <div class="form-group">
                        <label  class="col-sm-8 col-md-5 control-label">Contraseña:   </label>
                        <div class="col-sm-12 col-md-7">
                          <input type="password" class="form-control" placeholder="Password" name="passwd">
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="col-md-offset-5 col-md-7">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox"> Recordar
                            </label>
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="col-md-offset-5 col-md-7">
                          <button type="submit" class="btn btn-default">Entrar</button>
                        </div>
                      </div>
                    </form>
                    </div>
                </div>
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
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
