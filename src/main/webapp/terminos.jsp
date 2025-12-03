<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Términos y Condiciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style-footer.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/inicio.css">
</head>
<body>
<%@ include file="/header/header.jsp" %>

<div class="content-container">
    <h1>Términos y Condiciones</h1>

    <div class="section-block">
        <h5>Aceptación de términos</h5>
        <p>
            Al usar el sitio web de Peruvian&Style aceptas los términos establecidos.
        </p>
    </div>

    <div class="section-block">
        <h5>Precios y pagos</h5>
        <p>
            Los precios incluyen impuestos y pueden cambiar sin previo aviso. Los pagos son seguros y validados.
        </p>
    </div>

    <div class="section-block">
        <h5>Envíos y devoluciones</h5>
        <p>
            Los tiempos de entrega dependen de la disponibilidad del producto y ubicación del cliente.
            Las devoluciones se rigen por nuestra <a href="devoluciones.jsp">Política de devoluciones</a>.
        </p>
    </div>

    <div class="section-block">
        <h5>Modificaciones</h5>
        <p>
            Peruvian&Style se reserva el derecho de modificar estos términos en cualquier momento.
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/header.js"></script>

<br></br>
<%@ include file="/footer/footer.jsp" %>   


</body>
</html>
