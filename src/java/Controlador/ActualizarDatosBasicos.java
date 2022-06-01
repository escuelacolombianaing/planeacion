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
public class ActualizarDatosBasicos extends HttpServlet {

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
            out.println("<title>Servlet ActualizarDatosBasicos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActualizarDatosBasicos at " + request.getContextPath() + "</h1>");
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

           
            response.setContentType("text/html");
        
            BDServicios bd = new BDServicios();
            PrintWriter pw = response.getWriter();
        
        int retorno;
        String result = "";
        
        String idpr,nomproy,estpr,estejec,plan,snies,prioridad,director,responsable,fecini,fecfin,valejecutado,porcejesis,porcejedir,metapr,justifpr,unidadejec;  
        
        idpr            = request.getParameter("idp");
        nomproy         = request.getParameter("nomproy");
        estpr           = request.getParameter("estpr");
        estejec         = request.getParameter("estejec");
        plan            = request.getParameter("plan");
        snies           = request.getParameter("sniespr");
        prioridad       = request.getParameter("prioridad");
        director        = request.getParameter("director");  
        responsable     = request.getParameter("responsable");
        fecini          = request.getParameter("fecini");
        fecfin          = request.getParameter("fecfin");
        valejecutado    = request.getParameter("valejecutado");
        porcejesis      = request.getParameter("porcejesis");
        porcejedir      = request.getParameter("porcejedir");
        metapr          = request.getParameter("metapr");
        justifpr        = request.getParameter("justifpr");
        unidadejec      = request.getParameter("unidadejec");

        

        
        //String fechainicial=(fecini).substring(6,9)+"-"+(fecini).substring(0,1)+"-"+(fecini).substring(3,4);
        //String fechafinal=(fecfin).substring(6,9)+"-"+(fecfin).substring(0,1)+"-"+(fecfin).substring(3,4);
        
        retorno = bd.ActualizarInfA(idpr,nomproy,estpr,estejec,plan,snies,prioridad,director,responsable,fecini,fecfin,valejecutado,porcejesis,porcejedir,metapr,justifpr,unidadejec);
       
        
        /*
        result = "<resultado>";
        result = result + "<dato>" + String.valueOf(retorno) + "</dato>";
        if (retorno > 0) {
                result += "<valor>Operación Exitosa</valor>";
            } else {
                result += "<valor>Fallo en la Operación</valor>";
            }
            result += "</resultado>";
            response.setContentType("text/xml");
            pw.write(result);
            pw.flush();
            pw.close();
        */
        
        String returntip = request.getParameter("returntip");
                
         if(returntip.equals("U")){
            response.sendRedirect("/planeacion/detalleproy?idp="+idpr+"#collapseOne"); 
         }
         else{
           response.sendRedirect("/planeacion/editpr?idp="+idpr+"#collapseOne"); 
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
