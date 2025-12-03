package controller;

import dao.PedidoDAO;
import model.Pedido;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/gestionar-ventas")
public class GestionarVentasController extends HttpServlet {
    private final PedidoDAO pedidoDAO = new PedidoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        Usuario user = (Usuario) session.getAttribute("usuario");
        if (!"admin".equals(user.getRol()) && !"empleado".equals(user.getRol())) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Lógica para obtener datos de ventas
        double ingresosTotales = pedidoDAO.calcularIngresosTotales();
        int ventasTotales = pedidoDAO.contarVentasTotales();
        int clientesUnicos = pedidoDAO.contarClientesUnicos();
        List<Double> ventas7Dias = pedidoDAO.obtenerVentasUltimos7Dias();
        List<Pedido> listaPedidos = pedidoDAO.obtenerTodos();

        // Enviar datos al JSP
        request.setAttribute("kpiIngresosTotales", ingresosTotales);
        request.setAttribute("kpiVentasTotales", ventasTotales);
        request.setAttribute("kpiClientesUnicos", clientesUnicos);
        request.setAttribute("ventas7Dias", ventas7Dias);
        request.setAttribute("listaPedidos", listaPedidos);
        
        request.getRequestDispatcher("/administrador/gestionar_ventas.jsp").forward(request, response);
    }
}