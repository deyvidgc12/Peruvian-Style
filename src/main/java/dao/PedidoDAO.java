package dao;

import config.Conexion;
import model.Pedido;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class PedidoDAO {

    // Obtiene los pedidos de un usuario específico (para el intranet del cliente)
    public List<Pedido> obtenerPorUsuario(int idUsuario) {
        List<Pedido> pedidos = new ArrayList<>();
        String sql = "SELECT * FROM Pedidos WHERE id_usuario = ? ORDER BY fecha_pedido DESC";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pedido p = new Pedido();
                    p.setId_pedido(rs.getInt("id_pedido"));
                    p.setId_usuario(rs.getInt("id_usuario"));
                    p.setFecha_pedido(rs.getTimestamp("fecha_pedido"));
                    p.setEstado(rs.getString("estado"));
                    p.setTotal(rs.getBigDecimal("total"));
                    pedidos.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pedidos;
    }

    // --- INICIO: MÉTODOS COMPLETOS Y NUEVOS PARA EL PANEL DE ADMIN ---

    // Obtiene todos los pedidos con el nombre del cliente (para la tabla de gestión de ventas)
    public List<Pedido> obtenerTodos() {
        List<Pedido> pedidos = new ArrayList<>();
        // Unimos la tabla Pedidos con Usuarios para obtener el nombre y apellido
        String sql = "SELECT p.*, u.nombre, u.apellido FROM Pedidos p JOIN Usuarios u ON p.id_usuario = u.id_usuario ORDER BY p.fecha_pedido DESC";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Pedido p = new Pedido();
                p.setId_pedido(rs.getInt("id_pedido"));
                p.setId_usuario(rs.getInt("id_usuario"));
                p.setFecha_pedido(rs.getTimestamp("fecha_pedido"));
                p.setEstado(rs.getString("estado"));
                p.setTotal(rs.getBigDecimal("total"));
                // Asignamos el nombre completo del cliente al campo extra del modelo
                p.setNombreCliente(rs.getString("nombre") + " " + rs.getString("apellido"));
                pedidos.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pedidos;
    }

    // Calcula los ingresos totales de todas las ventas no canceladas
    public double calcularIngresosTotales() {
        double total = 0.0;
        String sql = "SELECT SUM(total) as ingresos FROM Pedidos WHERE estado != 'cancelado'";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble("ingresos");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Cuenta el número total de ventas no canceladas
    public int contarVentasTotales() {
        int total = 0;
        String sql = "SELECT COUNT(id_pedido) as total FROM Pedidos WHERE estado != 'cancelado'";
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

    // Cuenta el número de clientes únicos que han realizado al menos un pedido
    public int contarClientesUnicos() {
        int total = 0;
        String sql = "SELECT COUNT(DISTINCT id_usuario) as total FROM Pedidos";
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

    // Obtiene los datos de ingresos de los últimos 7 días para el gráfico
    public List<Double> obtenerVentasUltimos7Dias() {
        // Inicializa una lista con 7 ceros (Domingo a Sábado)
        List<Double> ventasDiarias = new ArrayList<>(Collections.nCopies(7, 0.0));
        String sql = "SELECT DAYOFWEEK(fecha_pedido) as dia_semana, SUM(total) as total_dia " +
                     "FROM Pedidos " +
                     "WHERE fecha_pedido >= CURDATE() - INTERVAL 6 DAY AND estado != 'cancelado' " +
                     "GROUP BY DAYOFWEEK(fecha_pedido)";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int diaDeLaSemana = rs.getInt("dia_semana"); // 1=Domingo, 2=Lunes, ...
                double totalDia = rs.getDouble("total_dia");
                ventasDiarias.set(diaDeLaSemana - 1, totalDia); // Coloca el total en el índice correcto (0-6)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ventasDiarias;
    }

    // (Aquí van los métodos que ya tenías: contarVentasHoy, calcularIngresosHoy)
    public int contarVentasHoy() {
        int total = 0;
        String sql = "SELECT COUNT(id_pedido) as total FROM Pedidos WHERE DATE(fecha_pedido) = CURDATE() AND estado != 'cancelado'";
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

    public double calcularIngresosHoy() {
        double total = 0.0;
        String sql = "SELECT SUM(total) as ingresos FROM Pedidos WHERE DATE(fecha_pedido) = CURDATE() AND estado != 'cancelado'";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble("ingresos");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
}