<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Obtener el parámetro enviado desde el index.jsp
    String imgParam = request.getParameter("img");

    // Variables para los datos del producto
    String nombre = "";
    String precio = "";
    String stock = "";
    String material = "";
    String descripcion = "";
    String imagen = "";

    if ("1".equals(imgParam)) {
        nombre = "Casaca Andina";
        precio = "S/. 120.00";
        stock = "15 unidades";
        material = "Lana de alpaca";
        descripcion = "Casaca tradicional tejida a mano, ideal para el frío.";
        imagen = "img/1.PNG";
    } else if ("2".equals(imgParam)) {
        nombre = "Poncho Artesanal";
        precio = "S/. 95.00";
        stock = "10 unidades";
        material = "Lana de oveja";
        descripcion = "Poncho peruano multicolor, ligero y cómodo.";
        imagen = "img/2.jpg";
    } else if ("3".equals(imgParam)) {
        nombre = "Chompa Juvenil";
        precio = "S/. 80.00";
        stock = "20 unidades";
        material = "Algodón peruano";
        descripcion = "Chompa moderna con diseños andinos, perfecta para jóvenes.";
        imagen = "img/3.jpg";
    } else {
        nombre = "Producto no encontrado";
        precio = "-";
        stock = "-";
        material = "-";
        descripcion = "No se encontró información del producto.";
        imagen = "img/default.png"; // Puedes poner una imagen genérica
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo - <%= nombre %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #111111;
            font-family: 'Poppins', sans-serif;
        }
        
        .card {
            max-width: 800px;
            margin: 50px auto;
            box-shadow: 0 8px 20px rgba(0,0,0,0.5);
            border-radius: 12px;
            background-color: #212121;
            border: none;
            color: #ffffff; /* ¡Este es el cambio! */
        }
        
        .card img {
            object-fit: cover;
            height: 400px;
            border-top-left-radius: 12px;
            border-bottom-left-radius: 12px;
        }
        
        .card-body h3 {
            color: #ffffff;
            font-weight: 700;
        }
        
        .logo-top-left {
            position: absolute;
            top: 10px;
            left: 10px;
            width: 100px;
            height: auto;
            z-index: 1000;
        }
        
        .card-body p {
            font-weight: 400;
            line-height: 1.6;
        }
    </style>
</head>
<body>

    <img src="img/8.jpeg" alt="Logo Peruvian & Style" class="logo-top-left">

    <div class="container">
        <div class="card">
            <div class="row g-0">
                <div class="col-md-6">
                    <img src="<%= imagen %>" class="img-fluid" alt="<%= nombre %>">
                </div>
                <div class="col-md-6 d-flex flex-column justify-content-center p-4">
                    <h3><%= nombre %></h3>
                    <p><strong>Precio:</strong> <%= precio %></p>
                    <p><strong>Stock disponible:</strong> <%= stock %></p>
                    <p><strong>Material:</strong> <%= material %></p>
                    <p><strong>Descripción:</strong> <%= descripcion %></p>
                    <a href="index.jsp" class="btn btn-dark mt-3">⬅ Volver al Carrusel</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>