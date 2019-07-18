
-- --------------------------------------------------------------------------------
-- Guardar estado_usuario
-- --------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS GuardarEstadosUsuarios;
delimiter //
Create trigger GuardarEstadosUsuarios Before insert On estado_usuario For Each Row
begin
	If LENGTH(TRIM(NEW.estado))>0 THEN
		SET NEW.estado=UPPER(NEW.estado);
	END IF;
	END //
delimiter ;

-- --------------------------------------------------------------------------------
-- Modificar estado_usuario
-- --------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS ModificarEstadosUsuarios;
delimiter //
Create trigger ModificarEstadosUsuarios Before update On estado_usuario For Each Row
begin
	If LENGTH(TRIM(NEW.estado))>0 THEN
		SET NEW.estado=UPPER(NEW.estado);
	END IF;
	END //
delimiter ;

-- --------------------------------------------------------------------------------
-- Guardar tipo_usuario
-- --------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS GuardarTipoUsuario;
delimiter //
Create trigger GuardarTipoUsuario Before insert On tipo_usuario For Each Row
begin
	If LENGTH(TRIM(NEW.tipo))>0 THEN
		SET NEW.tipo=UPPER(NEW.tipo);
	END IF;
	END //
delimiter ;


-- --------------------------------------------------------------------------------
-- Modificar tipo_usuario
-- --------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS ModificarTipoUsuario;
delimiter //
Create trigger ModificarTipoUsuario Before update On tipo_usuario For Each Row
begin
	If LENGTH(TRIM(NEW.tipo))>0 THEN
		SET NEW.tipo=UPPER(NEW.tipo);
	END IF;
	END //
delimiter ;
-- --------------------------------------------------------------------------------
-- Guardar Personas
-- --------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS GuardarPersonas;
delimiter //
Create trigger GuardarPersonas Before Insert On persona For Each Row
begin
	If LENGTH(TRIM(NEW.nombres))>0 THEN
	SET NEW.nombres=UPPER(NEW.nombres);
	END IF;
	If LENGTH(TRIM(NEW.apellido_p))>0 THEN
		SET NEW.apellido_p=UPPER(NEW.apellido_p);
	END IF;
	If LENGTH(TRIM(NEW.apellido_m))>0 THEN
		SET NEW.apellido_m=UPPER(NEW.apellido_m);
	END IF;
	If LENGTH(TRIM(NEW.direccion))>0 THEN
		SET NEW.direccion=UPPER(NEW.direccion);
		else
		SET NEW.direccion="No registrado";
	END IF;
	
END //
delimiter ;


-- --------------------------------------------------------------------------------
-- Guardar estado_votacion
-- --------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS estado_votacion;
delimiter //
Create trigger estado_votacion Before insert On estadoVotacion For Each Row
begin
	If LENGTH(TRIM(NEW.tipo))>0 THEN
		SET NEW.tipo=UPPER(NEW.tipo);
	END IF;
	END //
delimiter ;