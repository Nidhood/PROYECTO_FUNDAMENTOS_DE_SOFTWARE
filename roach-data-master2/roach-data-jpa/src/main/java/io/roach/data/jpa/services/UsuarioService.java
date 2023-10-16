package io.roach.data.jpa.services;

import io.roach.data.jpa.dao.UsuarioRepository;
import io.roach.data.jpa.entities.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {
    private UsuarioRepository usuarioRepository;

    @Autowired
    public UsuarioService(UsuarioRepository usuarioRepository){
        this.usuarioRepository = usuarioRepository;
    }

    public Usuario encontrarUsuariosPorNombre(String nombre){
        return usuarioRepository.findByNombreusuario(nombre);
    }
}
