package com.pontireparte.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.ManyToOne;


import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor

public class EstadosPedidos {

    @Id
    @SequenceGenerator(
            name = "estados_pedido_sequence",
            sequenceName = "estados_pedido_sequece",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "estados_pedido_sequence"
    )
    @Column(
            name = "id"
    )
    private Integer estadosPedidosId;

    private String estadoPago;
    private String estadoEnvio;
    private String estadoPedido;


}