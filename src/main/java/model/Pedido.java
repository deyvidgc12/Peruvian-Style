package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Pedido {
    private int id_pedido;
    private int id_usuario;
    private int id_direccion;
    private Timestamp fecha_pedido;
    private String estado;
    private BigDecimal total;
    private String nombreCliente;

    // Getters y Setters
    public int getId_pedido() { return id_pedido; }
    public void setId_pedido(int id_pedido) { this.id_pedido = id_pedido; }
    
    public int getId_usuario() { return id_usuario; }
    public void setId_usuario(int id_usuario) { this.id_usuario = id_usuario; }
    
    public int getId_direccion() { return id_direccion; }
    public void setId_direccion(int id_direccion) { this.id_direccion = id_direccion; }
    
    public Timestamp getFecha_pedido() { return fecha_pedido; }
    public void setFecha_pedido(Timestamp fecha_pedido) { this.fecha_pedido = fecha_pedido; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }
    
    public String getNombreCliente() {
        return nombreCliente;
    }
    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }
}