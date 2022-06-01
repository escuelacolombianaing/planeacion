/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import BDatos.BDServicios;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juan Vanzina
 */
public class ActualizaHoras extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ActualizaHoras</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActualizaHoras at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String idpersonal,idact,idp;
        
        BDServicios bd = new BDServicios();
        
        idact       = request.getParameter("idact");
        idp         = request.getParameter("idp");
        //agno        = request.getParameter("agno");
        //horas       = request.getParameter("horas");
        idpersonal  = request.getParameter("idpersonal");
        
        String [] CantPer = request.getParameterValues("CantPer");        
        String [] agno    = request.getParameterValues("agno");
        String [] horas    = request.getParameterValues("horas");
        
        int resp = 0;
        
          for(int wi = 0; wi < agno.length; wi ++){
          
              resp = bd.ActualizarHorasPers(idpersonal, agno[wi], horas[wi],CantPer[wi]);
          }

          String returntip = request.getParameter("returntip");
            if(returntip.equals("U")){
                           response.sendRedirect("/planeacion/DetalleActividad?idp="+idp+"&act="+idact+"#dedicacion"); 
            }else{
                           response.sendRedirect("/planeacion/editact?idp="+idp+"&act="+idact+"#dedicacion"); 
            }
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
