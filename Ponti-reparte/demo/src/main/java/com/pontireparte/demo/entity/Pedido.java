package com.pontireparte.demo.entity;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.*;
import jakarta.persistence.ManyToOne;


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

public class Pedido {


    @Id
    @SequenceGenerator (
            name = "pedido_sequence",
            sequenceName = "pedido_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy =  GenerationType.SEQUENCE,
            generator = "pedido_sequence"
    )
    @Column (
            name = "id"
    )
    private Integer pedidoId;

    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "comprador_id",
            referencedColumnName = "id"
    )
    private Usuario compradorId;
    private String repartidorId;
    private String tiendaId;
    private Integer productoPedidoId;

    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "estado_pedido_id",
            referencedColumnName = "id"
    )
    private EstadosPedidos estadoPedidoId;
    private Integer ubicacionId;
    private String tipoPedido;

    private String valorTotal;







}