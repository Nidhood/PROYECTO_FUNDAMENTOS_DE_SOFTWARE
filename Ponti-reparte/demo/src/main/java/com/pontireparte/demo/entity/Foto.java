package com.pontireparte.demo.entity;

import jakarta.persistence.*;
import jakarta.persistence.Entity;
import lombok.Data;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Foto {



    // SIEMPRE TOCA INCLUIR EL ID PARA QUE CREE LA TABLA
    @Id
    @SequenceGenerator(
            name = "foto_sequence",
            sequenceName = "foto_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "foto_sequence"
    )
    @Column(
            name = "id"
    )
    private Integer fotoId;
    private String nombre;
    private String description;
    private String path;


/*    @OneToMany(
            cascade = CascadeType.ALL
    )
    @JoinColumn(
            name = "id", // para poner la foreing key toca nombreclase_id, sino, paila, nodetecta
            referencedColumnName = "id"
    )
    private List<Usuario> fotosUsuarios;

 */

// para dropear una tabla es DROP TABLE nombre_tabla; o en cascade es DROP TABLE nombre_table CASCADE;
    // para dropear sequencia toca DROP SEQUENCE tabla_sequence


}