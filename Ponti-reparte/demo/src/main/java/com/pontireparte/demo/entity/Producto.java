package com.pontireparte.demo.entity;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.CascadeType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.Column;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Producto {


    @Id
    @SequenceGenerator(
            name = "producto_sequence",
            sequenceName = "producto_sequence",
            allocationSize = 1

    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "producto_sequence"
    )
    @Column (
            name = "id"
    )
    private Integer productoId;
    // relacion
    /*
    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "foto_id",
            referencedColumnName = "id"
    )
    private Foto foto;

     */
    private Integer fotoId;


    private String nombreProducto;
    private Float precioDinero;
    private Float descripcion;
    private Float promocion;
    private Boolean disponibleConPuntos;


}