package com.pontireparte.demo.repository;
import com.pontireparte.demo.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository
        extends JpaRepository<Usuario, Integer>{

    // annadir usuario pendiente respecto a si est[a duplicado el correo
    // revisar jpa y capa servicio, etc
    //Nuevo
/*
  @Query("SELECT s FROM Usuario s WHERE s.correo = ?1")
Usuario findUsuarioByCorreo(String correo);*/
}

