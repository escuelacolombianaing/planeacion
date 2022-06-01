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
public class NuevaActividadPr extends HttpServlet {

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
            out.println("<title>Servlet NuevaActividadPr</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NuevaActividadPr at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        
        String idp, tipoac, nomac, fciniac, fcfinac, descac, porcpr, responact;
        
        BDServicios bd = new BDServicios();
        
        PrintWriter pw = response.getWriter();
        String result;
        int retorno = 0;

        nomac     = request.getParameter("nomact");
        fciniac   = request.getParameter("fciniac");
        fcfinac   = request.getParameter("fcfinac");
        descac    = request.getParameter("descac");
        idp       = request.getParameter("idpr");
        tipoac    = request.getParameter("tipoac");
        porcpr    = request.getParameter("porcnt");
        responact = request.getParameter("responact");
        
        retorno =  bd.CreacionActividadPr(idp,tipoac,nomac,fciniac,fcfinac,descac,porcpr, responact);
        
        if(retorno!=0){
        String UAct = "";
                UAct = bd.LastActivtPr(idp);
                
                String returntip = request.getParameter("returntip");
                
                 if(returntip.equals("U")){
                            response.sendRedirect("/planeacion/DetalleActividad?idp="+idp+"&act="+UAct+"#dedicacion"); 
                 }else{
                            response.sendRedirect("/planeacion/editact?idp="+idp+"&act="+UAct+"#dedicacion"); 
                 }
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
