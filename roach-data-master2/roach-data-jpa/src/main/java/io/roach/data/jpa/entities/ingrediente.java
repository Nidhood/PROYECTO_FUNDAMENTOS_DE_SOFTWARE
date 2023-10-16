package io.roach.data.jpa.entities;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.UUID;

@Entity
@Table(name ="ingredientes")
public class ingrediente {
    @Id
    @GeneratedValue
    private UUID id;
    private  String nombreingrediente;
}
