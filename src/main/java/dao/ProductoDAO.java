package dao;

import config.Conexion;
import model.Producto;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // Obtiene todos los productos (para la tabla de gestión)
    public List<Producto> obtenerTodos() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM Productos ORDER BY nombre";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getBigDecimal("precio"));
                p.setStock(rs.getInt("stock"));
                p.setId_categoria(rs.getInt("id_categoria"));
                p.setImagen(rs.getString("imagen"));
                p.setEstado(rs.getString("estado"));
                p.setFecha_creacion(rs.getTimestamp("fecha_creacion"));
                productos.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productos;
    }

    // Obtiene un producto específico por su ID (para la página de edición)
    public Producto obtenerPorId(int id) {
        Producto producto = null;
        String sql = "SELECT * FROM Productos WHERE id_producto = ?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    producto = new Producto();
                    // *** INICIO: CORRECCIÓN CRÍTICA ***
                    // Se han añadido todos los setters que faltaban para poblar el objeto.
                    producto.setId_producto(rs.getInt("id_producto"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getBigDecimal("precio"));
                    producto.setStock(rs.getInt("stock"));
                    producto.setId_categoria(rs.getInt("id_categoria"));
                    producto.setImagen(rs.getString("imagen"));
                    producto.setEstado(rs.getString("estado"));
                    // *** FIN: CORRECCIÓN CRÍTICA ***
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return producto;
    }

    // Crea un nuevo producto
    public boolean crearProducto(Producto producto) {
        String sql = "INSERT INTO Productos (nombre, descripcion, precio, stock, id_categoria, imagen, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getDescripcion());
            ps.setBigDecimal(3, producto.getPrecio());
            ps.setInt(4, producto.getStock());
            ps.setInt(5, producto.getId_categoria());
            ps.setString(6, producto.getImagen());
            ps.setString(7, "activo");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Actualiza un producto existente
    public boolean actualizarProducto(Producto producto) {
        String sql = "UPDATE Productos SET nombre=?, descripcion=?, precio=?, stock=?, id_categoria=?, imagen=?, estado=? WHERE id_producto=?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getDescripcion());
            ps.setBigDecimal(3, producto.getPrecio());
            ps.setInt(4, producto.getStock());
            ps.setInt(5, producto.getId_categoria());
            ps.setString(6, producto.getImagen());
            ps.setString(7, producto.getEstado());
            ps.setInt(8, producto.getId_producto());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Desactiva un producto (borrado lógico - Ocultar)
    public boolean desactivarProducto(int idProducto) {
        String sql = "UPDATE Productos SET estado = 'inactivo' WHERE id_producto = ?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idProducto);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Elimina un producto de la BD (solo si está inactivo)
    public boolean eliminarProductoFisico(int idProducto) {
        String sql = "DELETE FROM Productos WHERE id_producto = ? AND estado = 'inactivo'";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idProducto);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cuenta los productos activos (para el KPI del dashboard)
    public int contarActivos() {
        int total = 0;
        String sql = "SELECT COUNT(id_producto) as total FROM Productos WHERE estado = 'activo'";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
    
    public boolean activarProducto(int idProducto) {
    String sql = "UPDATE Productos SET estado = 'activo' WHERE id_producto = ?";
    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, idProducto);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
}