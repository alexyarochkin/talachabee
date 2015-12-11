/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package talachabee;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.sqlUpdate;
import util.encrypt;

/**
 *
 * @author ayarochkin
 */
public class updateInfo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        
        if ((request.getSession(false) != null) && (request.getSession(false).getAttribute("user")!=null))
        {
        String siteId = request.getParameter("siteId");
        String className = request.getParameter("className");
        String recordId = request.getParameter("recordId");
        String ip = request.getParameter("ip");
        String name = request.getParameter("name");
        String model = request.getParameter("model");
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String url = request.getParameter("url");
        
        String passwordEncrypted = encrypt.xor_encrypt(password, "ic3t4l4ch4b1");
        
        
        
        sqlUpdate myUpdate = new sqlUpdate();
        myUpdate.sqlUpdateRecord(siteId, className, recordId, ip, name, model, login, passwordEncrypted, url);
        
        response.sendRedirect("core/main.jsp");
        }
        else 
        {
            response.sendRedirect("index.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
