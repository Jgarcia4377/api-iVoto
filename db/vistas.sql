-- ---------------------------------
-- View vMostrarPersonas
-- -----------------------------------------------------
DROP VIEW IF EXISTS vMostrarPersonas ;
CREATE OR REPLACE VIEW vMostrarPersonas AS 
    SELECT idpersona AS idpersona,
		   concat(persona.nombres,' ',persona.apellido_p,' ',persona.apellido_m) AS nombres
           from persona ORDER BY nombres ASC;

-- -----------------------------------------------------
-- vMostrarCandidatos
-- -----------------------------------------------------
DROP VIEW IF EXISTS vMostrarCandidatos ;
CREATE OR REPLACE VIEW vMostrarCandidatos AS 
    SELECT idcandidato AS idcandidato,
           evento.idevento AS idEvento,
		   concat(evento.descripcion,' ',DATE_FORMAT(fechaHoraInicio, "%d-%m-%Y")) AS nombreEvento,
           evento.observaciones AS observacionesEvento,
           estadoVotacion.tipo AS estadoEvento,
          
           usuario.idusuario AS idUsuario,
             CAST(AES_DECRYPT(usuario.usuario,'iVOTO')AS CHAR(50)) AS usuario,
              persona.idpersona AS idpersona,
		   concat(persona.nombres,' ',persona.apellido_p,' ',persona.apellido_m) AS nombres,
           PartidosPoliticos.nombrePartido AS partidoPolitico,
           PartidosPoliticos.numeroPartido AS numeroPartidoPolitico,
           PuestosCandidatos.idPuestosCandidatos AS idPuestoCandidato,
           PuestosCandidatos.tipo AS puestoCandidato
           from ((((((candidato join persona) join evento) join PuestosCandidatos) join PartidosPoliticos) join estadoVotacion ) join usuario)
           where ((persona.idpersona = candidato.idpersona) and 
					(persona.idpersona = usuario.persona_idpersona)and
				  (candidato.idevento = evento.idevento) and 
                  (evento.idestadoVotacion = estadoVotacion.idestadoVotacion) and
                  (candidato.idPartidosPoliticos = PartidosPoliticos.idPartidosPoliticos) and
                   (candidato.idPuestosCandidatos = PuestosCandidatos.idPuestosCandidatos)) ORDER BY idevento;


-- -----------------------------------------------------
-- vMostrarEventos
-- -----------------------------------------------------
DROP VIEW IF EXISTS vMostrarEventos ;
CREATE OR REPLACE VIEW vMostrarEventos AS 
    SELECT idevento AS idEvento,
		   descripcion AS descripcion,
           observaciones AS observaciones,
           DATE_FORMAT(fechaHoraInicio, "%d-%m-%Y") AS FHinicio,
            DATE_FORMAT(fechaHoraFin, "%d-%m-%Y") AS FHfin,
           estadoVotacion.tipo AS estado
		  from evento join estadoVotacion
           where evento.idestadoVotacion = estadoVotacion.idestadoVotacion;


-- -----------------------------------------------------
-- vMostrarTiposUsuarios
-- -----------------------------------------------------
DROP VIEW IF EXISTS vMostrarTiposUsuarios ;
CREATE OR REPLACE VIEW vMostrarTiposUsuarios AS 
    SELECT idtipo AS idtipousuario,
		   tipo AS tipo
           from tipo_usuario;

-- ---------------------------------
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
                  (estado_usuario.idestado = usuario.estado_usuario_id) and
                  (tipo_usuario.tipo = "ESTUDIANTE"));

-- -----------------------------------------------------
-- vMostrarPartidosPoliticos
-- -----------------------------------------------------
DROP VIEW IF EXISTS vMostrarPartidosPoliticos ;
CREATE OR REPLACE VIEW vMostrarPartidosPoliticos AS 
    SELECT idPartidosPoliticos AS idPartidosPoliticos,
		   nombrePartido AS nombrePartido,
           numeroPartido AS numeroPartido
           from PartidosPoliticos order by nombrePartido ASC;

-- -----------------------------------------------------
-- vMostrarPuestosCandidatos
-- -----------------------------------------------------
DROP VIEW IF EXISTS vMostrarPuestosCandidatos ;
CREATE OR REPLACE VIEW vMostrarPuestosCandidatos AS 
    SELECT idPuestosCandidatos AS idPuestosCandidatos,
		   tipo AS tipo
           from PuestosCandidatos order by tipo ASC;

