package controller;

import dao.CategoriaDAO;
import dao.ProductoDAO;
import model.Categoria;
import model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

@WebServlet("/admin/gestionar-productos")
@MultipartConfig // Habilita la recepción de archivos
public class GestionarProductosController extends HttpServlet {
    private final ProductoDAO productoDAO = new ProductoDAO();
    private final CategoriaDAO categoriaDAO = new CategoriaDAO();
    // Ruta fija en tu disco duro para guardar las imágenes
    private static final String UPLOAD_DIR = "C:/uploads/peruvianstyle/productos";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Producto> listaProductos = productoDAO.obtenerTodos();
        request.setAttribute("listaProductos", listaProductos);

        List<Categoria> listaCategorias = categoriaDAO.obtenerTodas();
        request.setAttribute("listaCategorias", listaCategorias);
        
        request.getRequestDispatcher("/administrador/gestionar_productos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        // Casos simples que no manejan archivos
        if ("toggle_status".equals(action)) {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            Producto prod = productoDAO.obtenerPorId(idProducto);
            if (prod != null) {
                if ("activo".equals(prod.getEstado())) {
                    productoDAO.desactivarProducto(idProducto);
                } else {
                    productoDAO.activarProducto(idProducto);
                }
            }
        } else if ("delete".equals(action)) {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            productoDAO.eliminarProductoFisico(idProducto);
        }
        
        // Casos que SÍ pueden manejar subida de archivos (multipart)
        else if ("create".equals(action) || "update".equals(action)) {
            
            Producto producto;
            if ("update".equals(action)) {
                int idProducto = Integer.parseInt(request.getParameter("idProductoUpdate"));
                producto = productoDAO.obtenerPorId(idProducto);
            } else {
                producto = new Producto();
            }

            if (producto != null) {
                // Recoger datos del formulario
                producto.setNombre(request.getParameter("nombre"));
                producto.setDescripcion(request.getParameter("descripcion"));
                producto.setPrecio(new BigDecimal(request.getParameter("precio")));
                producto.setStock(Integer.parseInt(request.getParameter("stock")));
                producto.setId_categoria(Integer.parseInt(request.getParameter("idCategoria")));

                // *** INICIO: LÓGICA CORREGIDA PARA ACTUALIZAR LA IMAGEN ***
                Part filePart = request.getPart("imagen");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                if (fileName != null && !fileName.isEmpty()) {
                    // Si se sube una nueva imagen, guárdala
                    File uploadDir = new File(UPLOAD_DIR);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    
                    String filePath = UPLOAD_DIR + File.separator + fileName;
                    try (InputStream fileContent = filePart.getInputStream()) {
                        Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                    }
                    // Actualiza el nombre del archivo en el objeto
                    producto.setImagen(fileName); 
                } else if ("create".equals(action)) {
                    // Si es un producto nuevo sin imagen, usa la de por defecto
                    producto.setImagen("default.png");
                }
                // Si es un "update" y no se sube una nueva imagen, el nombre de la imagen existente se conserva.
                // *** FIN: LÓGICA CORREGIDA ***
                
                // Guardar los cambios en la BD
                if ("update".equals(action)) {
                    productoDAO.actualizarProducto(producto);
                } else {
                    productoDAO.crearProducto(producto);
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/gestionar-productos");
    }
}