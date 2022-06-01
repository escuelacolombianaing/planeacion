/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var idp;

function conectarMethod(url, funcion, met){
    // Obtener la instancia del objeto XMLHttpRequest
    http_request = false;
    
    if (window.XMLHttpRequest) { // Mozilla, Safari,...
        http_request = new XMLHttpRequest();
    } else if (window.ActiveXObject) { // IE
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e){}
        }
    }

    if (!http_request) {
        alert('No se Instanciado el Objeto XMLHttpRequest');
        return false;
    }
    if (http_request.overrideMimeType) {
        http_request.overrideMimeType('text/xml');
    }

    //Preparar funcion de respuesta
    http_request.onreadystatechange = funcion;

    //Enviar Peticion
    
    http_request.open(met, url, true);
    http_request.send(null);
    return false;
}


function ActualizaProyecto() {
    if(http_request.readyState == 4) {

        if(http_request.status == 200) {
            var xmldoc = http_request.responseXML;
            var respuesta=xmldoc.getElementsByTagName("resultado")[0];
            var resul=respuesta.getElementsByTagName("valor")[0].firstChild.nodeValue;
                  alert(resul);
                  //window.location= "detalleproy?idp="+idp;
                  // response.sendRedirect("EstMov" );
            if(respuesta.getElementsByTagName("dato")[0]!=null){//if(resul=="Operación Exitosa"){
                eval(respServlet+"("+");");
            }
        }
    }
}

function getValores(Datos){
    var resul=Datos[0]+"="+document.getElementById(Datos[0]).value;
    idp = document.getElementById(Datos[0]).value;
    var val;
    
    for(var i = 1 ; i < Datos.length ; i++){
        val = document.getElementById(Datos[i]).value;
        resul=resul + "&" + Datos[i] + "=" + val;
    }

    return resul;
}

/*
function sendInfo(){
    var url='ActualizarDatosBasicos?'+ getValores(['idp','nomproy','estpr','estejec','plan','sniespr','prioridad','director','responsable','fecini','fecfin','valejecutado','porcejesis','porcejedir','metapr','justifpr']);
    conectarMethod(url, ActualizaProyecto, 'POST')
}

function sendInfoB(){
    var url='NuevoObjetivoPr?'+ getValores(['tipoob','tipoac','idpr']);
    conectarMethod(url, ActualizaProyecto, 'POST')
}


function sendInfoC(){
    var url='ActualizaObjetivo?'+ getValores(['idobj','obj']);
    conectarMethod(url, ActualizaProyecto, 'POST')
}
*/


function eliminar(idp, idsol, tiposol){
    
    confirm("¿Seguro que desea eliminar el registro?")
    
    
    
}