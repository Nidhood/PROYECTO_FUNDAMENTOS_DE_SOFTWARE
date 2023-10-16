package com.pontireparte.demo.entity;
import jakarta.persistence.Entity;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.CascadeType;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor

public class TiendasProductos {


    @Id
    @SequenceGenerator(
            name = "tiendas_productos_sequence",
            sequenceName = "tiendas_productos_sequence"
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "tiendas_productos_sequence"
    )
    @Column(
            name = "id"
    )
    private Integer tiendasProductosId;

    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "tienda_id",
            referencedColumnName = "id"
    )

    private Tienda tiendaId;

    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "producto_id",
            referencedColumnName = "id"
    )
    private Producto producto;
    private Integer cantidadDisponible;


}