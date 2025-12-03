package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/mis-pedidos") // Corregido: URL más limpia
public class MisPedidosController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Validar Sesión
        if (request.getSession(false) == null || request.getSession(false).getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // 2. Lógica para obtener el historial de pedidos... (DAO)
        
        // 3. Reenviar al JSP correcto (dentro de la carpeta cliente)
        request.getRequestDispatcher("/cliente/mis_pedidos.jsp").forward(request, response);
    }
}