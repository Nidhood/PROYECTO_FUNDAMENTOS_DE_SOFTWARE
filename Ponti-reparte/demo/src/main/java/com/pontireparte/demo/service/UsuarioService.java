package com.pontireparte.demo.service;

import com.pontireparte.demo.entity.Usuario;
import com.pontireparte.demo.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;
    @Autowired
    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public List<Usuario> getUsuarios(){
        return usuarioRepository.findAll();
    }

    //Nuevo
    public void addNewUsuario(Usuario usuario) {
        System.out.println(usuario);
      /*  Optional<Usuario> usuarioOptional = usuarioRepository.findUsuarioByCorreo(usuario.getCorreo());
       if(usuarioOptional.isPresent()){
            throw new IllegalStateException("Correo Repetido");
        }*/
        usuarioRepository.save(usuario);
    }

}
