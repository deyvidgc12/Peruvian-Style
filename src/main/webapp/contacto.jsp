<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contacto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style-footer.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/inicio.css">
</head>
<body>
<%@ include file="/header/header.jsp" %>

<div class="content-container">
    <h1>Contáctanos</h1>

    <div class="row">
        <!-- Formulario -->
        <div class="col-md-6">
            <div class="contact-card">
                <h5>Formulario de Contacto</h5>
                <form>
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" placeholder="Tu nombre">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" id="email" placeholder="Tu correo">
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" placeholder="Tu teléfono">
                    </div>
                    <div class="mb-3">
                        <label for="asunto" class="form-label">Asunto</label>
                        <input type="text" class="form-control" id="asunto" placeholder="Motivo de tu mensaje">
                    </div>
                    <div class="mb-3">
                        <label for="mensaje" class="form-label">Mensaje</label>
                        <textarea class="form-control" id="mensaje" rows="4" placeholder="Escribe tu mensaje"></textarea>
                    </div>
                    <button type="submit" class="btn btn-custom">Enviar</button>
                </form>
            </div>
        </div>

        <!-- Información de contacto -->
        <div class="col-md-6">
            <div class="contact-card">
                <h5>Información de contacto</h5>
                <p><i class="bi bi-envelope-fill me-2"></i>peruvianstyle@gmail.com</p>
                <p><i class="bi bi-telephone-fill me-2"></i>+51 933 362 455</p>
                <p><i class="bi bi-geo-alt-fill me-2"></i>Lima, Perú</p>

                <h6 class="mt-3 footer-title">Síguenos</h6>
                <a href="https://facebook.com" target="_blank" class="me-2"><i class="bi bi-facebook fs-4"></i></a>
                <a href="https://instagram.com" target="_blank" class="me-2"><i class="bi bi-instagram fs-4"></i></a>
                <a href="https://twitter.com" target="_blank" class="me-2"><i class="bi bi-twitter fs-4"></i></a>
                <a href="https://tiktok.com" target="_blank"><i class="bi bi-tiktok fs-4"></i></a>
            </div>
        </div>
    </div>
</div>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/header.js"></script>

<br></br>
<%@ include file="/footer/footer.jsp" %>    

</body>
</html>
