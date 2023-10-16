package com.pontireparte.demo.entity;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.*;
import jakarta.persistence.Embedded;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder // este lo voy a usar en el test

public class Usuario {

    @Id
    @SequenceGenerator (
            name = "usuario_squence",
            sequenceName = "usuario_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy =  GenerationType.SEQUENCE,
            generator = "usuario_sequence"
    )
    @Column(
            name = "id"
    )
    private Integer usuarioId;
    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name ="foto_id",
            referencedColumnName = "id"
    )
    private Foto foto;
    private String tipoUsuario;
    private String nombreUsuario;
    private String nombre;
    private String contrasena;
    private Integer javerianaid;
    private String correoInstitucional;

    private String apellido;
    private Integer edad;
    private Integer telefono;
    private String correo;
    private String estadoSesion;

    private Integer puntos;

    private Float calificacion;

    private String disponibilidad;
/*
    @OneToMany (
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "id",
            referencedColumnName = "id"
    )
    private List<Pedido> pedidos;


 */






    @Override
    public String toString() {
        return "Usuario{" +
                "ID=" + usuarioId +
                ", TipoUsuario='" + tipoUsuario + '\'' +
                ", NombreUsuario='" + nombreUsuario + '\'' +
                ", Contrasena='" + contrasena + '\'' +
                ", Nombre='" + nombre + '\'' +
                ", Apellido='" + apellido + '\'' +
                ", Telefono='" + telefono + '\'' +
                ", Edad=" + edad +
                ", Correo='" + correo + '\'' +
                ", Foto='" + foto + '\'' +
                '}';
    }




}

