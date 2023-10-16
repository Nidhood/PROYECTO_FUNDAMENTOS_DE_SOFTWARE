package com.pontireparte.demo.controller;
import com.pontireparte.demo.entity.Usuario;
import com.pontireparte.demo.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*") // Allow all origins
    @RequestMapping(path = "crear-usuario")
public class UsuarioController {
    private final UsuarioService usuarioService;
    @Autowired
    public UsuarioController(UsuarioService usuarioService) {

        this.usuarioService = usuarioService;
    }

    @GetMapping
    public List<Usuario> getUsuarios(){

        return usuarioService.getUsuarios();
    }
    @PostMapping
    public void registerNewUsuario(@RequestBody Usuario usuario){
        //Nuevo
        System.out.println(usuario);
        usuarioService.addNewUsuario(usuario);
    }
}
