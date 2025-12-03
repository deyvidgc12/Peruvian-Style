package controller;

import dao.ProductoDAO;
import dao.PedidoDAO;
import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Usuario;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    private final ProductoDAO productoDAO = new ProductoDAO();
    private final PedidoDAO pedidoDAO = new PedidoDAO();
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        int productosDisponibles = productoDAO.contarActivos();
        int ventasHoy = pedidoDAO.contarVentasHoy();
        int clientesRegistrados = usuarioDAO.contarClientesActivos();
        double ingresosHoy = pedidoDAO.calcularIngresosHoy();
        
        List<Usuario> clientesRecientes = usuarioDAO.obtenerClientesRecientes15Dias();
        
        request.setAttribute("kpiProductos", productosDisponibles);
        request.setAttribute("kpiVentas", ventasHoy);
        request.setAttribute("kpiClientes", clientesRegistrados);
        request.setAttribute("kpiIngresos", ingresosHoy);
        request.setAttribute("clientesRecientes", clientesRecientes);
        
        request.getRequestDispatcher("/administrador/admin_dashboard.jsp").forward(request, response);
    }
}