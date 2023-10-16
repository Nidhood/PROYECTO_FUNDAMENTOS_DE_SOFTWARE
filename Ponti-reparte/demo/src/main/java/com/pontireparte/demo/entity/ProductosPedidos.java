package com.pontireparte.demo.entity;
import jakarta.persistence.Id;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class ProductosPedidos {

    @Id
    @SequenceGenerator(
            name = "productos_pedido_sequence",
            sequenceName = "productos_pedido_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "productos_pedido_sequence"
    )
    @Column(
            name = "id"
    )
    private Integer productosPedidosId;


    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "pedido_id", // Correct foreign key column name
            referencedColumnName = "id" // Adjust this to the correct column in the Pedido table
    )
    private Pedido pedido;
    // en vez de poner el atributo y la clase, solo pongo la clase y le digo como se debe llamar el atributo que viene de esa clase

    @ManyToOne(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "producto_id",
            referencedColumnName = "id"
    )
    private Producto producto;
}