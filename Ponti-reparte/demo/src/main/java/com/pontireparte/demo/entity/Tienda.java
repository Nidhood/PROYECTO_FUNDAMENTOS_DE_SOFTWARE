package com.pontireparte.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Column;
import jakarta.persistence.GenerationType;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor

public class Tienda {

    @Id
    @SequenceGenerator(
            name = "tienda_sequence",
            sequenceName = "tienda_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "tienda_sequence"
    )
    @Column(
            name = "id"
    )

    private Integer tiendaId;
    private Integer personalTiendaId;
    private Integer ubicacionId;
    private String estadoTienda;
    private String nombreTienda;

}