<%@ page import = "javax.servlet.http.HttpSession" %>
<%
String idusr = (String)session.getAttribute("nom_emp");

    //if(!session.getId().equals(session.getAttribute("sesid"))){
    if (!(idusr != null && !idusr.equals(""))) {
%>
		<jsp:forward page="inicio?id=4"/>
<%
    }else {
        if(session.getAttribute("nom_emp") == null || session.getAttribute("nom_emp").equals("")){
        %>
		<jsp:forward page="inicio?id=4"/>
<%
        }
    }
%>

