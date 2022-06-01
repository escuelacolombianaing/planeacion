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
public class NuevoObjetivoPr extends HttpServlet {

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
            out.println("<title>Servlet NuevoObjetivoPr</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NuevoObjetivoPr at " + request.getContextPath() + "</h1>");
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
        
        BDServicios bd = new BDServicios();
        
        PrintWriter pw = response.getWriter();
        String result;
        int retorno = 0;
        
        String idp, tipob, tipoac;
                
        idp    = request.getParameter("idpr");
        tipob  = request.getParameter("tipoob");
        tipoac = request.getParameter("tipoac");
        
        if(tipoac.equals("0")){
        retorno =  bd.CreacionObjetivoPr(idp, tipob);
        }

        /*
        result = "<resultado>";
        result = result + "<dato>" + String.valueOf(retorno) + "</dato>";
        if (retorno > 0) {
                result += "<valor>Operación Exitosa</valor>";
            } else {
                result += "<valor>Fallo en la Operación</valor>";
            }
            result += "</resultado>";
            //Enviar Respuesta
            response.setContentType("text/xml");
            pw.write(result);
            pw.flush();
            pw.close();
        */
        
        String returntip = request.getParameter("returntip");
        if(returntip.equals("U")){
            response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseTwo"); 
        }else{
            response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseTwo"); 
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
