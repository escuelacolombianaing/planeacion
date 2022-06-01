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

/**
 *
 * @author palvarad
 */
public class logout extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        	throws IOException, ServletException {

        HttpSession         sesion;
        PrintWriter         out = response.getWriter();

        String tmp = "";
        
        sesion = request.getSession(false);
        if (sesion != null){
            tmp = sesion.getAttribute("cod_emp").toString();
            sesion.removeAttribute("cod_emp");
            sesion.removeAttribute("passwd");
            sesion.invalidate();
        }
        /* Sesion Cerrada */
        if(tmp.equals("1")){
          response.sendRedirect("inicio?id=3") ;
        }else{
        response.sendRedirect("https://empleados.escuelaing.edu.co/intraeci/Menu") ;
        }
    }
}

