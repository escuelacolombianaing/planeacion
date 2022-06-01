/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import BDatos.BDServicios;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Juan Vanzina
 */
public class CargaArchivos extends HttpServlet {

    String usr;
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
            out.println("<title>Servlet CargaArchivos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CargaArchivos at " + request.getContextPath() + "</h1>");
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
        
            String idart, tipo, numerosig, verif, NaArch = "NotName", Name="";
            int NumeroAr = 0;
                    
             idart      = "";
             tipo       = "";
             numerosig  = "";
             verif      = "";
             
             HttpSession    sesion;
             sesion       = request.getSession(true);
             usr = sesion.getAttribute("cod_emp").toString();
        
             //String archivourl = "C:\\Users\\Desarrollo\\Desktop\\Proyectos\\ZPruebasCarga";
             String archivourl = "/home/shares/ODI";
             
             try {

                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(10 * 1024 * 1024); 
                factory.setRepository(new File(archivourl));
                ServletFileUpload upload = new ServletFileUpload(factory);
             
                 List<FileItem> partes = upload.parseRequest(request);
             
                  BDServicios c = new BDServicios();

                 for(FileItem items: partes){
                    
                     if (items.isFormField()) {

                            if (items.getFieldName().equals("idp")) {
                                 idart = items.getString();
                             }
                            if (items.getFieldName().equals("numerosig")) {
                                 numerosig = items.getString();
                             }
                            if (items.getFieldName().equals("obsar")) {
                                 verif = items.getString();
                             }
                            if (items.getFieldName().equals("inicial")) {
                                 tipo = items.getString();
                             }
                     }
                     else{  

                                 NaArch = items.getName();   
                                 String Ext = FilenameUtils.getExtension(NaArch);
                                 Name = tipo+idart+"-"+numerosig+"."+Ext;
                                 File file = new File(archivourl, Name);
                                 items.write(file);
                             
                     }
                 }
                     
                     int retorno = bd.RegistrarArchivo(Name, NaArch, idart, "0", "1", verif, "0");
                     
                     
                     if(usr.equals("1")){
                                response.sendRedirect("/planeacion/editpr?idp="+idart+"#collapseFive");
                     }else{
                                response.sendRedirect("/planeacion/detalleproy?idp="+idart+"#collapseFive");
                     }
                  
                } catch (Exception e) {
                 
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
