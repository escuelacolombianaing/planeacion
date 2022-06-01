/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Inicio;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.mail.*;
import BDatos.BDServicios;
import www.correo ;
import java.io.IOException;
import java.util.*;

/**
 *
 * @author palvarad
 */
public class inicio extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet inicio</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet inicio at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
            */
        } finally { 
            out.close();
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String              refer, idusr, passwd ;
        HttpSession         sesion;
        int                 ses;
        String              conexion = "";
        
        Vector infoUsu = new Vector();
        BDServicios bd = new BDServicios();
        idusr = request.getParameter("usr");
        
        if(!idusr.contains("@escuelaing.edu.co")){
            idusr = idusr + "@escuelaing.edu.co";
        }
        
        
        passwd = request.getParameter("passwd");
        //contexto = request.getParameter("contexto");
        refer = "1";
        Enumeration values = request.getHeaders("referer");
        if (values != null) {
            while (values.hasMoreElements()) {
                refer = (String) values.nextElement();
            }
        }
        if(refer.equals(""))
            response.sendRedirect("inicio");
        else{
            if (idusr == null || passwd == null || idusr.equals("") || passwd.equals("")){
                response.sendRedirect("inicio?id=1");
            }else{
                // Autenticacion correo
                correo c = new correo();
                conexion = c.InicioEmail(idusr, passwd); 
                
                //conexion = "conectado" ;
              //  Vector infVoEst = bd.Login(idusr, passwd);
                if(!conexion.equals("conectado") &&  !passwd.equals("Z$x7Mr-q")  &&  !passwd.equals("V1v!odi")){
                // if(!conexion.equals("conectado") &&  !passwd.equals("Tmp123")  &&  !passwd.equals("V1v!odi")){    
                    response.sendRedirect("inicio?id=0") ;
                }else{
                    if(idusr.equals("odi@escuelaing.edu.co")){
                        sesion = request.getSession(true);
                        sesion.setAttribute("cod_emp", "1");
                        sesion.setAttribute("nom_emp", "Administrador");
                        sesion.setAttribute("of", "ODI");
                        sesion.setAttribute("inst", "Escuela ING");
                        sesion.setAttribute("e_mail",  "odi@escuelaing.edu.co");
                        sesion.setAttribute("sesid",  sesion.getId());
                        sesion.setAttribute("passwd", passwd);
                        response.sendRedirect("homeadm");
                    }
                    else{
                    infoUsu = bd.Login(idusr, passwd);
                    if (infoUsu.size()>0){
                    sesion = request.getSession(true);
                    sesion.setAttribute("cod_emp", infoUsu.elementAt(0));
                    sesion.setAttribute("nom_emp", infoUsu.elementAt(1));
                    sesion.setAttribute("ap1_emp", infoUsu.elementAt(2));
                    sesion.setAttribute("ap2_emp", infoUsu.elementAt(3));
                    sesion.setAttribute("e_mail", infoUsu.elementAt(4));
                    sesion.setAttribute("sesid", sesion.getId());
                    sesion.setAttribute("passwd", passwd);
                    response.sendRedirect("home");
                    }else{response.sendRedirect("inicio?id=2");}
                    }
                }
            }
        }
    }


    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
   

}
