package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/image-server")
public class ImageServer extends HttpServlet {

    // La misma ruta física que usas para guardar las imágenes
    private static final String IMAGE_DIR = "C:\\Users\\PC\\Documents\\NetBeansProjects\\Web_ProyectoFinal\\src\\main\\webapp\\img";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Obtener el nombre del archivo desde la URL (ej: ?file=mi-imagen.jpg)
        String filename = request.getParameter("file");
        if (filename == null || filename.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta el parámetro 'file'.");
            return;
        }

        // 2. Construir la ruta completa al archivo físico
        Path path = Paths.get(IMAGE_DIR, filename);
        File file = path.toFile();

        // 3. Verificar si el archivo existe y servirlo
        if (file.exists() && !file.isDirectory()) {
            // Determinar el tipo de contenido (MIME type)
            String contentType = getServletContext().getMimeType(filename);
            if (contentType == null) {
                contentType = "application/octet-stream"; // Tipo genérico si no se reconoce
            }
            response.setContentType(contentType);

            // Escribir el contenido del archivo en la respuesta
            Files.copy(path, response.getOutputStream());
        } else {
            // 4. Si el archivo no existe, enviar un error 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}