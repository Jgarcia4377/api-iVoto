SET GLOBAL log_bin_trust_function_creators = 1;
-- -----------------------------------------------------
-- function ValidarCedula
-- -----------------------------------------------------
DROP function IF EXISTS ValidarCedula;
DELIMITER $$
CREATE FUNCTION ValidarCedula(ced VARCHAR(11)) RETURNS varchar(100) CHARSET latin1
BEGIN
  DECLARE digito,digitov,doble,decena INT;
    DECLARE pos,bandera INT DEFAULT 1;
    DECLARE acomulado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(100);
  
    IF(LENGTH(ced)="") THEN
    SET mensaje = 'Cédula vacía';
    ELSEIF(LENGTH(ced)<10) THEN
    SET mensaje = 'Cédula incompleta';
  ELSEIF(LENGTH(ced)>10) THEN
    SET mensaje = 'La cédula debe tener exactamente 10 dígitos';
  ELSEIF (SUBSTRING(ced,pos,2) > 24 AND SUBSTRING(ced,pos,2) <30) OR SUBSTRING(ced,pos,2) > 30 THEN
    #rELSEIF SUBSTRING(ced,pos,2) > 23 THEN
        SET mensaje = 'Esta cédula no pertenece a ninguna provincia';
    ELSEIF SUBSTRING(ced,3,1) > 5 THEN    
    SET mensaje = 'El tercer dígito no puede ser mayor a 5';
    ELSEIF ced = '0000000000' OR ced = '0202020202' OR ced = '0404040404' OR ced = '0606060606' OR ced = '0808080808' OR ced = '1010101010'
     OR ced = '1212121212' OR ced = '1414141414' OR ced = '1616161616' OR ced = '1818181818' OR ced = '2020202020' OR ced = '2222222222' OR ced = '2424242424' THEN
        SET mensaje = 'Cédula incorrecta'; 
    ELSEIF ced REGEXP ('^[0-9]+$') = ''  THEN
    SET mensaje = 'La cédula no puede tener letras';
    ELSE
    REPEAT
      IF bandera = 1 THEN
        SET doble =  SUBSTRING(ced,pos,1) * 2;
          IF doble > 9 THEN
            SET doble = doble - 9;
          END IF;
        SET acomulado = acomulado + doble;
        SET bandera = 2;
            ELSE
        SET acomulado = acomulado + SUBSTRING(ced,pos,1);
        SET bandera = 1;
            END IF;
          SET pos = pos + 1;
         UNTIL pos > 9  
       END REPEAT;   
  IF(SUBSTRING(acomulado,2,1)) = 0 AND (SUBSTRING(ced,10,1)) = 0 THEN
    SET mensaje = 'Cédula Correcta';
    ELSEIF(((SUBSTRING(acomulado,1,1)+1)*10)-acomulado) = SUBSTRING(ced,10,1) THEN
    SET mensaje = 'Cédula Correcta';
    ELSE
    SET mensaje = 'Cédula incorrecta';
    END IF;
   END IF;
RETURN mensaje; 
END$$
DELIMITER ;

-- -----------------------------------------------------
-- function BuscarEstadoUsuarios
-- -----------------------------------------------------

DROP function IF EXISTS BuscarEstadoUsuarios;
DELIMITER $$
CREATE FUNCTION BuscarEstadoUsuarios(InEstado VARCHAR(45)) RETURNS varchar(90) CHARSET utf8
BEGIN 
    RETURN (SELECT estado FROM estado_usuario WHERE estado = InEstado LIMIT 1);                   
END$$
DELIMITER ;

-- -----------------------------------------------------
-- function BuscarTipoUsuarios
-- -----------------------------------------------------

DROP function IF EXISTS BuscarTipoUsuarios;
DELIMITER $$
CREATE FUNCTION BuscarTipoUsuarios(InTipo VARCHAR(45)) RETURNS varchar(90) CHARSET utf8
BEGIN 
    RETURN (SELECT tipo FROM tipo_usuario WHERE tipo = InTipo LIMIT 1);                   
END$$
DELIMITER ;


-- -----------------------------------------------------
-- function BuscarTipoPuestos
-- -----------------------------------------------------

DROP function IF EXISTS BuscarTipoPuestos;
DELIMITER $$
CREATE FUNCTION BuscarTipoPuestos(InTipo VARCHAR(45)) RETURNS varchar(90) CHARSET utf8
BEGIN 
    RETURN (SELECT tipo FROM tipo_puestos WHERE tipo = InTipo LIMIT 1);                   
END$$
DELIMITER ;

-- -----------------------------------------------------
-- function BuscarUsuarioAdmin
-- -----------------------------------------------------

DROP function IF EXISTS BuscarUsuarioAdmin;
DELIMITER $$
CREATE FUNCTION BuscarUsuarioAdmin(_usuario VARCHAR(100), _contrasena VARCHAR(100)) RETURNS varchar(45) CHARSET latin1
BEGIN
    
    RETURN (SELECT usuario.idusuario FROM usuario WHERE usuario = AES_ENCRYPT(_usuario,'iVOTO') AND
    contrasena = AES_ENCRYPT(_contrasena,'iVOTO') AND usuario.tipo_usuario_id =1 LIMIT 1);
END$$
DELIMITER ;

-- -----------------------------------------------------
-- function BuscarUsuarioLogin
-- -----------------------------------------------------

DROP function IF EXISTS BuscarUsuarioLogin;
DELIMITER $$
CREATE FUNCTION BuscarUsuarioLogin(_usuario VARCHAR(100), _contrasena VARCHAR(100)) RETURNS varchar(45) CHARSET latin1
BEGIN
    
    RETURN (SELECT usuario.idusuario FROM usuario WHERE usuario = AES_ENCRYPT(_usuario,'iVOTO') AND
    contrasena = AES_ENCRYPT(_contrasena,'iVOTO') AND usuario.tipo_usuario_id = 2 LIMIT 1);
END$$
DELIMITER ;


-- -----------------------------------------------------
-- function BuscarEstadoVotacion
-- -----------------------------------------------------

DROP function IF EXISTS BuscarEstadoVotacion;
DELIMITER $$
CREATE FUNCTION BuscarEstadoVotacion(InTipo VARCHAR(45)) RETURNS varchar(90) CHARSET utf8
BEGIN 
    RETURN (SELECT tipo FROM estadoVotacion WHERE tipo = InTipo LIMIT 1);                   
END$$
DELIMITER ;

-- -----------------------------------------------------
-- function BuscarCandidatoXevento
-- -----------------------------------------------------

DROP function IF EXISTS BuscarCandidatoXevento;
DELIMITER $$
CREATE FUNCTION BuscarCandidatoXevento(InNombres VARCHAR(100), InId INT) RETURNS varchar(100) CHARSET utf8
BEGIN 
     RETURN (SELECT candidato.idcandidato FROM candidato, votacion WHERE candidato.idvotacion = InId AND candidato.nombres = InNombres LIMIT 1);                
END$$
DELIMITER ;

-- -----------------------------------------------------
-- function BuscarEventoById
-- -----------------------------------------------------

DROP function IF EXISTS BuscarEventoById;
DELIMITER $$
CREATE FUNCTION BuscarEventoById(InId INT) RETURNS varchar(100) CHARSET latin1
BEGIN 
    RETURN (SELECT idvotacion FROM votacion WHERE idvotacion = InId LIMIT 1);                   
END$$
DELIMITER ;



