package com.pontireparte.demo.controller;

import com.pontireparte.demo.entity.Foto;
import com.pontireparte.demo.entity.Usuario;
import com.pontireparte.demo.repository.UsuarioRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class UsuarioConfig {

    @Bean
    CommandLineRunner commandLineRunner(UsuarioRepository repository){
        return args -> {
            Foto laFoto = new Foto(43,"porDefecto", "esta es la foto por defecto", "c:/Program Files");
            Usuario Juan = Usuario.builder()
                    .usuarioId(1)
                    .foto(laFoto)  // You'll need to create a Foto instance and provide it here
                    .tipoUsuario("Usuario")
                    .nombreUsuario("juan01")
                    .nombre("Juan")
                    .contrasena("Password123")
                    .javerianaid(123)
                    .correoInstitucional("juan@javeriana.edu.co")
                    .apellido("López")
                    .edad(28)
                    .telefono(123)
                    .correo("juan@example.com")
                    .estadoSesion("true")  // Assuming estadoSesion is a String
                    .puntos(0)
                    .calificacion(0.0f)
                    .disponibilidad("true")  // Assuming disponibilidad is a String
                    .build();

            Usuario Maria = Usuario.builder()
                    .usuarioId(2)
                    .foto(laFoto)  // You'll need to create a Foto instance and provide it here
                    .tipoUsuario("Usuario")
                    .nombreUsuario("Maria123")
                    .nombre("Maria")
                    .contrasena("SecurePass567")
                    .javerianaid(456)
                    .correoInstitucional("maria@javeriana.edu.co")
                    .apellido("González")
                    .edad(32)
                    .telefono(59876543)
                    .correo("maria@example.com")
                    .estadoSesion("true")  // Assuming estadoSesion is a String
                    .puntos(0)
                    .calificacion(0.0f)
                    .disponibilidad("true")  // Assuming disponibilidad is a String
                    .build();


            repository.saveAll(
                    List.of(Juan, Maria)
            );
        };

    }

}
