/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import BDatos.BDServicios;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juan Vanzina
 */
public class NuevoEJEFactoresC extends HttpServlet {

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
            out.println("<title>Servlet NuevoEJEFactoresC</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NuevoEJEFactoresC at " + request.getContextPath() + "</h1>");
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
        
        String fin, factor, idp;
        String [] caracteristicas;
        
        Vector resultado = new Vector();
        
        caracteristicas = request.getParameterValues("caracsel");
        fin             = request.getParameter("finesauto");
        factor          = request.getParameter("factor");
        idp             = request.getParameter("idp");
        
        BDServicios bd = new BDServicios();
        
         for(String s : caracteristicas){
         
             resultado = bd.consultaejefactorCaracter(fin, factor, s);
         
             int retorno = 1;
             
             if(bd.ConsultaVerificaEJE(idp, resultado.elementAt(0).toString()).size()<=0){
             
                 retorno = bd.AsociarProyectoEJE(idp, resultado.elementAt(0).toString());
             }
             
             if(retorno!=0){  //String idp, String idfin, String idfac, String nomcaract, String idfacint
             
                 int retorno2 = bd.AsociarFactorIntegral(idp, fin, factor, s, resultado.elementAt(1).toString(), resultado.elementAt(0).toString());
                 
             }
         }
         
         String returntip = request.getParameter("returntip");
         
        if(returntip.equals("U")){
             response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseFour");
        }else{
             response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseFour");
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
