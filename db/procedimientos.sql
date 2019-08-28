-- -----------------------------------------------------
-- procedure registrar_candidato
-- -----------------------------------------------------
DROP procedure IF EXISTS registrar_candidato;
DELIMITER $$
CREATE PROCEDURE registrar_candidato(

in _id_evento INT,
in _id_persona INT,
in _id_puestos_candidatos INT,
in _id_partidos_politicos INT,
in _cantidad_votos INT
)
begin
 if(select BuscarCandidatoXevento(_id_persona, _id_evento)is null)then
     select ('El candidato no puede pertenecer a un mismo evento 2 veces!!') as notificacion;
    else
     INSERT INTO candidato(idevento,idpersona,idPuestosCandidatos,idPartidosPoliticos,cantidadVotos)
    VALUES(_id_evento,_id_persona,_id_puestos_candidatos,_id_partidos_politicos,_cantidad_votos);
    SELECT 'Candidato registrado correctamente' AS notificacion;
    end if;
end$$
DELIMITER ;



-- -----------------------------------------------------
-- procedure registrar_persona
-- -----------------------------------------------------

DROP procedure IF EXISTS registrar_persona;
DELIMITER $$
CREATE PROCEDURE registrar_persona(
in _cedula varchar(10),
in _nombres varchar(45),
in _apellido_p varchar(45),
in _apellido_m varchar(45),
in _huella_dactilar varchar(10),
in _correo varchar(45),
in _telefono varchar(10),
in _direccion varchar(100)
)
begin 
   INSERT INTO persona(cedula,nombres,apellido_p,apellido_m,huella_dactilar,correo,telefono,direccion) VALUES
    (_cedula,_nombres,_apellido_p,_apellido_m,_huella_dactilar,_correo,_telefono,_direccion);

end$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure registrar_usuario
-- -----------------------------------------------------

DROP procedure IF EXISTS registrar_usuario;
DELIMITER $$
CREATE PROCEDURE registrar_usuario(
in _cedula varchar(10),
in _nombres varchar(45),
in _apellido_p varchar(45),
in _apellido_m varchar(45),
in _huella_dactilar varchar(10),
in _correo varchar(45),
in _telefono varchar(10),
in _direccion varchar(100),
in _tipo_usuario_id INT,
in _estado_usuario_id INT
)
begin
 
  DECLARE aux VARCHAR(30) DEFAULT ' ';
  DECLARE letraPrimeraNombreMayus VARCHAR(1) DEFAULT ' ';
  DECLARE letraPrimeraApeMaterMayus VARCHAR(1) DEFAULT ' ';
  DECLARE apellidoPatMinus VARCHAR(45) DEFAULT ' ';
  DECLARE digitosUsuario VARCHAR(10) DEFAULT ' ';
  DECLARE digitosPass VARCHAR(10) DEFAULT ' ';
  DECLARE _usuario VARBINARY(100);
  DECLARE _contrasena VARBINARY(100);
  DECLARE _idpersona INT;

-- Armamos el usuario de la persona con la primera letra de su Nombre Mayuscula y el 
-- apellido paterno en minuscula mas los ultimos 4 digitos de la cedula
SET letraPrimeraNombreMayus = UPPER(LEFT(_nombres, 1)); -- Primera letra del nombre en mayuscula
SET apellidoPatMinus = LOWER(_apellido_p); -- apellido paterno en misnucula
SET aux = CONCAT('',_cedula);-- concatenamos en ua cadena de caracteres los digitos de la cedula
SET digitosUsuario = RIGHT(aux, 4); -- devuelve los ultimos 4 digitos de la cedula
SET _usuario = CONCAT(letraPrimeraNombreMayus,apellidoPatMinus,digitosUsuario); -- concatenamos todoas las variables y formamos el usuario ejemplo - Jgarcia4377

-- Armamos la contrasena del usuario con la primera letra del apellido materno en Mayuscula mas -
-- y los utimos 6 digitos de la cedula
SET letraPrimeraApeMaterMayus = UPPER(LEFT(_apellido_m, 1)); -- Primera letra del apellido materno en mayuscula
SET aux = CONCAT('',_cedula);-- concatenamos en ua cadena de caracteres los digitos de la cedula
SET digitosPass = RIGHT(aux, 6); -- devuelve los ultimos 6 digitos de la cedula
SET _contrasena = CONCAT(letraPrimeraApeMaterMayus,'-',digitosPass); -- concatenamos todoas las variables y formamos ls contraseañ ejemplo - M-484377

  IF(ValidarCedula(_cedula) = 'CÉDULA CORRECTA') THEN
  IF((SELECT persona.idpersona FROM persona,usuario WHERE persona.idpersona = usuario.persona_idpersona AND cedula = _cedula) IS NULL) THEN
     CALL registrar_persona(_cedula,_nombres,_apellido_p,_apellido_m,_huella_dactilar,_correo,_telefono,_direccion);
     SELECT MAX(idpersona) INTO _idpersona FROM persona;
    
    INSERT INTO usuario(usuario,contrasena,persona_idpersona,tipo_usuario_id,estado_usuario_id)
  --  VALUES(_usuario,_contrasena,1,_idpersona,_tipo_usuario_id,1);
     VALUES(AES_ENCRYPT(_usuario,'iVOTO'),AES_ENCRYPT(_contrasena,'iVOTO'),_idpersona,_tipo_usuario_id,_estado_usuario_id);
    SELECT 'Usuario registrado correctamente' AS notificacion,
     CAST(AES_DECRYPT(usuario,'iVOTO')AS CHAR(50)) AS usuario,
     CAST(AES_DECRYPT(contrasena,'iVOTO')AS CHAR(50)) AS contraseña,
     CONCAT(nombres,' ',apellido_p,' ',apellido_m) AS nombres,
     persona.correo AS correo
      FROM persona,usuario WHERE
    persona.idpersona= usuario.persona_idpersona AND
    usuario = AES_ENCRYPT(_usuario,'iVOTO') AND
    contrasena = AES_ENCRYPT(_contrasena,'iVOTO');
    ELSE
    SELECT 'No puede registrar dos veces este mismo usuario.' AS notificacion;
  END IF;
  ELSE
  SELECT Validarcedula(_cedula) AS notificacion;
  END IF; 
end$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure registrar_estado_usuario
-- -----------------------------------------------------

DROP procedure IF EXISTS registrar_estado_usuario;
DELIMITER $$
CREATE PROCEDURE registrar_estado_usuario(
in _estado varchar(45))
begin
  if(select BuscarEstadoUsuarios(_estado)is null)then
    insert into estado_usuario values(NULL,_estado);
    select ("El estado se registro correctamente") as notificacion;
    else
    select concat('El estado "',_estado,'" ya existe') as notificacion;
    end if;
end$$
DELIMITER ;


-- -----------------------------------------------------
-- procedure modificar_estado_usuario
-- -----------------------------------------------------

DROP procedure IF EXISTS modificar_estado_usuario;
DELIMITER $$
CREATE PROCEDURE modificar_estado_usuario(
in _id_estado int,
in _estado varchar(45)
)
begin
  if((SELECT estado FROM estado_usuario WHERE estado=_estado AND idestado !=_id_estado limit 1) is not null) THEN
    SELECT concat('El Estado "',_estado,'" ya existe') as notificacion;
  ELSE
  UPDATE estado_usuario SET estado=_estado WHERE idestado = _id_estado;
    select 'Estado modificado correctamente'as notificacion;
    end if;
end$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure registrar_tipo_usuario
-- -----------------------------------------------------

DROP procedure IF EXISTS registrar_tipo_usuario;
DELIMITER $$
CREATE PROCEDURE registrar_tipo_usuario(
in _tipo varchar(45))
begin
  if(select BuscarTipoUsuarios(_tipo)is null)then
    insert into tipo_usuario values(NULL,_tipo);
    select ("El tipo de usuario se registro correctamente") as notificacion;
    else
    select concat('El tipo de usuario "',_tipo,'" ya existe') as notificacion;
    end if;
end$$
DELIMITER ;


-- -----------------------------------------------------
-- procedure BuscarUsuarioLogin
-- -----------------------------------------------------

DROP procedure IF EXISTS BuscarUsuarioLogin;
DELIMITER $$
CREATE PROCEDURE BuscarUsuarioLogin(
IN _usuario VARCHAR(100),
IN _contrasena VARCHAR(100)
)
BEGIN

if(select BuscarUsuarioLogin(_usuario, _contrasena )is null)then
    select ('El usuario o contraseña son incorrectos!!') as notificacion;
   else
    SELECT ('Iniciando Sesión') as notificacion,usuario.idusuario,
    CAST(AES_DECRYPT(usuario,'iVOTO')AS CHAR(50)) AS usuario,
    CONCAT(apellido_p,' ',apellido_m,' ',nombres) AS nombres,
    persona.cedula AS cedula,
        tipo_usuario.idtipo AS tipo_usuario,
        estado_usuario.idestado AS estado
        FROM persona,usuario,estado_usuario,tipo_usuario WHERE
    persona.idpersona= usuario.persona_idpersona AND
    usuario = AES_ENCRYPT(_usuario,'iVOTO') AND
    contrasena = AES_ENCRYPT(_contrasena,'iVOTO') AND
        usuario.estado_usuario_id = estado_usuario.idestado AND
        usuario.tipo_usuario_id = tipo_usuario.idtipo AND
        estado_usuario.estado = "ACTIVO" AND
        tipo_usuario.tipo = "ESTUDIANTE";
   end if;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure BuscarUsuarioAdminLogin
-- -----------------------------------------------------

DROP procedure IF EXISTS BuscarUsuarioAdminLogin;
DELIMITER $$
CREATE PROCEDURE BuscarUsuarioAdminLogin(
IN _usuario VARCHAR(100),
IN _contrasena VARCHAR(100)
)
BEGIN
 if(select BuscarUsuarioAdmin(_usuario, _contrasena )is null)then
    select ('El usuario o contraseña son incorrectos!!') as notificacion;
   else
   SELECT ('Iniciando Sesión') as notificacion, usuario.idusuario,
   CAST(AES_DECRYPT(usuario,'iVOTO')AS CHAR(50)) AS usuario,
   CONCAT(apellido_p,' ',apellido_m,' ',nombres) AS nombres,        
   tipo_usuario.idtipo AS tipo_usuario,
   estado_usuario.idestado AS estado
    FROM persona,usuario,estado_usuario,tipo_usuario WHERE
    persona.idpersona= usuario.persona_idpersona AND
    usuario = AES_ENCRYPT(_usuario,'iVOTO') AND
    contrasena = AES_ENCRYPT(_contrasena,'iVOTO') AND
        usuario.estado_usuario_id = estado_usuario.idestado AND
        usuario.tipo_usuario_id = tipo_usuario.idtipo AND
        estado_usuario.estado = "ACTIVO" AND
        tipo_usuario.tipo = "ADMIN";
  end if;
END$$
DELIMITER ;


-- -----------------------------------------------------
-- procedure modificar_tipo_usuario
-- -----------------------------------------------------

DROP procedure IF EXISTS modificar_tipo_usuario;
DELIMITER $$
CREATE PROCEDURE modificar_tipo_usuario(
in _id int,
in _tipo varchar(45)
)
begin
IF(SELECT tipo FROM tipo_usuario WHERE tipo = _tipo AND tipo_usuario.idtipo != _id limit 1) THEN
    SELECT 'El tipo de usuario, ya existe..!!' AS notificacion;
  ELSE  
    UPDATE tipo_usuario SET tipo = _tipo WHERE idtipo = _id;
    SELECT 'Tipo de Usuario modificado correctamente' AS notificacion;
  END IF;
end$$
DELIMITER ;


-- -----------------------------------------------------
-- procedure eliminar_tipo_usuario
-- -----------------------------------------------------

DROP procedure IF EXISTS eliminar_tipo_usuario;
DELIMITER $$
CREATE PROCEDURE eliminar_tipo_usuario(
in _id int
)
begin
DELETE FROM tipo_usuario WHERE idtipo = _id;
SELECT 'Tipo de Usuario eliminado correctamente' AS notificacion;
end$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure registrar_estado_votacion
-- -----------------------------------------------------

DROP procedure IF EXISTS registrar_estado_votacion;
DELIMITER $$
CREATE PROCEDURE registrar_estado_votacion(
in _estado varchar(45))
begin
  if(select BuscarEstadoVotacion(_estado)is null)then
    insert into estadoVotacion values(NULL,_estado);
    select concat('El estado "',_estado,'" se registro correctamente') as notificacion;
    else
     select concat('El estado "',_estado,'" ya existe') as notificacion;
    end if;
end$$
DELIMITER ;


-- -----------------------------------------------------
-- procedure RegistrarEvento
-- -----------------------------------------------------

DROP procedure IF EXISTS RegistrarEvento;
DELIMITER $$
CREATE PROCEDURE RegistrarEvento(
IN _descripcion VARCHAR(100),
IN _observaciones VARCHAR(200),
IN _fechahorainicio DATETIME,
IN _fechahorafin DATETIME,
IN _idestadovotacion INT
)
begin 
 
   INSERT INTO evento(descripcion,observaciones,fechaHoraInicio,fechaHoraFin,idestadovotacion) VALUES
    (_descripcion,_observaciones,_fechahorainicio,_fechahorafin,_idestadovotacion);
  select concat('El evento ',_descripcion,' ha sido creado correctamente') as notificacion;

end$$
DELIMITER ;
-- -----------------------------------------------------
-- procedure actualizar_estado_evento
-- -----------------------------------------------------
DROP procedure IF EXISTS actualizar_estado_evento;
DELIMITER $$
CREATE PROCEDURE actualizar_estado_evento(
in _id_evento int,
in _fechaHoraActualSistema datetime
)
BEGIN
IF((SELECT idestadovotacion FROM evento WHERE idevento = _id_evento  limit 1) )THEN
	IF((SELECT fechaHoraInicio FROM evento WHERE idevento = _id_evento ) <= _fechaHoraActualSistema AND (SELECT fechaHoraFin FROM evento WHERE idevento= _id_evento)>= _fechaHoraActualSistema)THEN
		UPDATE evento SET idestadovotacion = 2 WHERE idevento = _id_evento;
        SELECT 'El evento se modifico correctamente al estado de abierto' AS notificacion,
        evento.idestadovotacion AS idestadoVotacion,
        estadovotacion.tipo AS tipo
        FROM evento,estadovotacion WHERE evento.idestadoVotacion = estadovotacion.idestadoVotacion AND evento.idevento = _id_evento;
	ELSEIF((SELECT fechaHoraFin FROM evento WHERE _id_evento = idevento)<= _fechaHoraActualSistema)THEN
		UPDATE evento SET idestadovotacion = 3 WHERE idevento = _id_evento;
        SELECT 'El evento se modifico correctamente al estado es cerrado' AS notificacion,
        evento.descripcion AS nombreEvento,
        evento.fechaHoraInicio AS fechaInicio,
        evento.idestadovotacion AS idestadoVotacion,
        estadovotacion.tipo AS tipo
        FROM evento,estadovotacion WHERE evento.idestadoVotacion = estadovotacion.idestadoVotacion AND evento.idevento = _id_evento;
    end if;
end if;
END$$
DELIMITER ;


-- -----------------------------------------------------
-- procedure registrar_partidos_politicos
-- -----------------------------------------------------

DROP procedure IF EXISTS registrar_partidos_politicos;
DELIMITER $$
CREATE PROCEDURE registrar_partidos_politicos(
in _nombre_Partido varchar(100),
in _numero_Partido varchar(45))
begin
  if(select BuscarPartidosPoliticos(_nombre_Partido)is null)then
    insert into partidospoliticos values(NULL,_nombre_Partido,_numero_Partido);
    select ("El Partido Politico se registro correctamente") as notificacion;
    else
    select concat('El Partido Politico "',_nombre_Partido,'" ya existe') as notificacion;
    end if;
end$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure registrar_puestos_candidatos
-- -----------------------------------------------------

DROP procedure IF EXISTS registrar_puestos_candidatos;
DELIMITER $$
CREATE PROCEDURE registrar_puestos_candidatos(
in _tipo varchar(45))
begin
  if(select BuscarPuestosCandidatos(_tipo)is null)then
    insert into puestoscandidatos values(NULL,_tipo);
    select concat('El puesto "',_tipo,'" se registro correctamente') as notificacion;
    else
     select concat('El puesto "',_tipo,'" ya existe') as notificacion;
    end if;
end$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure RegistrarVotoDetalle
-- -----------------------------------------------------

DROP procedure IF EXISTS RegistrarVotoDetalle;
DELIMITER $$
CREATE PROCEDURE RegistrarVotoDetalle(
IN _fechaHoraVoto DATETIME,
IN _idEvento INT,
IN _idUsuario INT,
IN _idCandidato INT,
IN _idPuestoCandidato INT
)
BEGIN

if((SELECT idusuario FROM votodetalle WHERE idusuario = _idUsuario AND idPuestoCandidato = _idPuestoCandidato LIMIT 1))then
		select ('No puede votar 2 veces por el mismo puesto!!') as notificacion;
	else
         INSERT INTO votodetalle(fechaHoraVoto,idevento,idusuario,idcandidato,idPuestoCandidato)
		VALUES(_fechaHoraVoto, _idEvento,_idUsuario,_idCandidato, _idPuestoCandidato);
        -- VALUES(_fechaHoraVoto, AES_ENCRYPT(_idEvento,'iVOTO'),AES_ENCRYPT(_idUsuario,'iVOTO'),AES_ENCRYPT(_idCandidato,'iVOTO'),AES_ENCRYPT( _idPuestoCandidato,'iVOTO'));
        
        SELECT candidato.idcandidato AS idcandidato,
        cantidadVotos as cantidadVotos
		FROM candidato, votodetalle WHERE votodetalle.idcandidato = candidato.idcandidato;
        UPDATE candidato SET cantidadVotos = cantidadVotos+1 WHERE idcandidato=_idCandidato;
		SELECT 'Voto registrado correctamente' AS notificacion;
	end if;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure BuscarEventoGrafico
-- -----------------------------------------------------

DROP procedure IF EXISTS BuscarEventoGrafico;
DELIMITER $$
CREATE PROCEDURE BuscarEventoGrafico(
IN _idEvento int
)
BEGIN
 if((SELECT idcandidato FROM candidato WHERE idevento = _idEvento LIMIT 1))then
	select CONCAT(apellido_p,' ',apellido_m,' ',nombres) AS nombres,        
   puestoscandidatos.tipo AS puesto,
   candidato.cantidadVotos as cantidadVotos,
   evento.descripcion as descripcion,
   partidospoliticos.nombrePartido AS partidoPolitico
    FROM persona,candidato,puestoscandidatos,evento,partidospoliticos WHERE
    candidato.idevento = evento.idevento AND 
    candidato.idevento = _idEvento AND
   candidato.idpersona = persona.idpersona AND
   candidato.idPartidosPoliticos = partidospoliticos.idPartidosPoliticos AND
   candidato.idPuestosCandidatos = puestoscandidatos.idPuestosCandidatos;
   end if;
END$$
DELIMITER ;


