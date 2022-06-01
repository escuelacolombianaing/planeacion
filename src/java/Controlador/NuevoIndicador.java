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
public class NuevoIndicador extends HttpServlet {

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
            out.println("<title>Servlet NuevoIndicador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NuevoIndicador at " + request.getContextPath() + "</h1>");
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
        
        String nombre, periodicidad, act, tipoind, idp, descripcioncal;
        
        BDServicios bd = new BDServicios();
        
        nombre         = request.getParameter("nombreind");
        periodicidad   = request.getParameter("periodicidad");
        act            = request.getParameter("idact");        
        tipoind        = request.getParameter("tipoind"); 
        idp            = request.getParameter("idp");
        descripcioncal = request.getParameter("descripcioncal");
        
        if(tipoind.equals("1")){
          
            int retorno = bd.CreacionIndicador(nombre, periodicidad, tipoind, idp, "NULL", descripcioncal);
            
            String returntip = request.getParameter("returntip");
         
            if(returntip.equals("U")){
                    response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseTwo"); 
            }else{
                    response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseTwo"); 
            }
            
        }
        else{
        
            int retorno = bd.CreacionIndicador(nombre, periodicidad, tipoind, "NULL", act, descripcioncal);
            
            String returntip = request.getParameter("returntip");
         
            if(returntip.equals("U")){
                    response.sendRedirect("/planeacion/DetalleActividad?idp="+idp+"&act="+act+"#indicadores");  
            }else{
                    response.sendRedirect("/planeacion/editact?idp="+idp+"&act="+act+"#indicadores");  
            }
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
