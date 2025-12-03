<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario}"><c:redirect url="/index.jsp"/></c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Favoritos - Peruvian&Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/c_style.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/favoritos_style.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            
            <nav class="col-md-3 col-lg-2 d-md-block sidebar">
                <div class="position-sticky pt-3">
                    <a href="${pageContext.request.contextPath}/inicio.jsp"><img src="${pageContext.request.contextPath}/img/logo_sin_fondo.png" alt="Logo" class="sidebar-logo mb-3"></a>
                    <h5 class="px-3 text-warning">Hola, ${sessionScope.usuario.nombre}!</h5>
                    <hr class="text-secondary">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mi-cuenta"><i class="bi bi-person-circle me-2"></i> Mis Datos</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mis-pedidos"><i class="bi bi-bag-check me-2"></i> Mis Pedidos</a></li>
                        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/mis-favoritos"><i class="bi bi-heart me-2"></i> Favoritos</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mis-tarjetas"><i class="bi bi-credit-card me-2"></i> Mis Tarjetas</a></li>
                    </ul>
                    <hr class="text-secondary">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/inicio.jsp" style="color: #6c757d !important;"><i class="bi bi-arrow-left-circle me-2"></i> Regresar a Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión</a></li>
                        <li class="nav-item"><a class="nav-link text-danger" href="#" data-bs-toggle="modal" data-bs-target="#confirmarEliminarModal" data-delete-url="${pageContext.request.contextPath}/eliminar-cuenta"><i class="bi bi-trash me-2"></i> Eliminar Cuenta</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 content-area">
                <h2 class="mb-4">Mis Favoritos</h2>
                <div class="card p-5 text-center empty-favorites-card">
                    <i class="bi bi-heart display-1 mb-3 text-secondary"></i>
                    <h3 class="card-title">Tu lista de favoritos está vacía.</h3>
                    <p class="text-secondary">Haz clic en el corazón de los productos que te encanten para guardarlos aquí.</p>
                    <a href="${pageContext.request.contextPath}/catalogo.jsp" class="btn btn-warning mt-3 w-50 mx-auto">Explorar productos</a>
                </div>
            </main>
        </div>
    </div>
    
    <div class="modal fade" id="confirmarEliminarModal" tabindex="-1"> ... </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const confirmarModal = document.getElementById('confirmarEliminarModal');
            if (confirmarModal) {
                const btnConfirmar = document.getElementById('btnConfirmarEliminar');
                confirmarModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    const deleteUrl = button.getAttribute('data-delete-url');
                    if (btnConfirmar && deleteUrl) { btnConfirmar.href = deleteUrl; }
                });
            }
        });
    </script>
</body>
</html>