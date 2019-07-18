
-- -----------------------------------------------------
-- View vMostrarUsuarios
-- -----------------------------------------------------
DROP VIEW IF EXISTS vMostrarUsuarios ;
CREATE OR REPLACE VIEW vMostrarUsuarios AS 
    SELECT usuario.idusuario AS idusuario,
		   persona.cedula AS cedula,
		   concat(persona.apellido_p,' ',persona.apellido_m,' ',persona.nombres) AS nombres,
           CAST(AES_DECRYPT(usuario.usuario,'iVOTO')AS CHAR(50)) AS usuario,
           -- usuario.usuario AS usuario,
           CAST(AES_DECRYPT(usuario.contrasena,'iVOTO')AS CHAR(50)) AS contraseña,
           -- usuario.contrasena AS contraseña,
           persona.huella_dactilar AS heulla_dactilar,
           persona.direccion AS direccion,
           persona.telefono AS telefono,
           persona.correo AS correo,
           tipo_usuario.tipo AS tipo_usuario,
		   estado_usuario.estado AS estado 
           from (((usuario join persona) join tipo_usuario) join estado_usuario) 
           where ((persona.idpersona = usuario.persona_idpersona) and 
				  (tipo_usuario.idtipo = usuario.tipo_usuario_id) and 
                  (estado_usuario.idestado = usuario.estado_usuario_id));
