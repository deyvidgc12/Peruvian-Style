<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario}"><c:redirect url="/index.jsp"/></c:if>

<c:set var="user" value="${sessionScope.usuario}"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Cuenta - Peruvian&Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/c_style.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block sidebar">
                <div class="position-sticky pt-3">
                    <img src="img/logo_sin_fondo.png" alt="Logo" class="sidebar-logo mb-3">
                    <h5 class="px-3 text-warning">Hola, ${user.nombre}!</h5>
                    <hr class="text-secondary">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link active" href="mi-cuenta"><i class="bi bi-person-circle me-2"></i> Mis Datos</a></li>
                        <li class="nav-item"><a class="nav-link" href="mis-pedidos"><i class="bi bi-bag-check me-2"></i> Mis Pedidos</a></li>
                        <li class="nav-item"><a class="nav-link" href="mis-favoritos"><i class="bi bi-heart me-2"></i> Favoritos</a></li>
                        <li class="nav-item"><a class="nav-link" href="mis-tarjetas"><i class="bi bi-credit-card me-2"></i> Mis Tarjetas</a></li>
                    </ul>
                    <hr class="text-secondary">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión</a></li>
                        <li class="nav-item"><a class="nav-link text-danger" href="eliminar-cuenta"><i class="bi bi-trash me-2"></i> Eliminar Cuenta</a></li>
                    </ul>
                </div>
            </nav>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 content-area">
                <h2 class="mb-4">Editar Información Personal</h2>
                
                <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
                <c:if test="${not empty mensaje}"><div class="alert alert-success">${mensaje}</div></c:if>

                <div class="card p-4">
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/editar-info">
                            
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" value="${user.nombre}" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" value="${user.apellido}" required>
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" value="${user.telefono}">
                            </div>
                            <div class="mb-3">
                                <label for="direccion" class="form-label">Dirección Principal</label>
                                <input type="text" class="form-control" id="direccion" name="direccion" value="${user.direccion}">
                            </div>
                            
                            <div class="mb-3">
                                <label for="contrasena" class="form-label">Nueva Contraseña (Opcional)</label>
                                <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Deja vacío para mantener la actual">
                            </div>

                            <button type="submit" class="btn btn-warning mt-3">Guardar Cambios</button>
                            <a href="mi-cuenta" class="btn btn-secondary mt-3">Cancelar</a>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>