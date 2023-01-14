/*...........................................................................................*/
/*.....................................ANNIE.................................................*/
/*...........................................................................................*/
CREATE PROCEDURE PROC_PERSONAS(
  IN PV_NOM_PERSONA VARCHAR (225)
  ,IN PC_SEX_PERSONA CHAR (1)
  ,IN PI_EDAD_PERSONAL INT (2)
  ,IN PC_TIP_PERSONA CHAR (1)
  ,IN PV_Num_Identidad VARCHAR (15)
  ,IN PC_IND_CIVIL CHAR (1)
  ,IN PC_IND_PERSONA CHAR (1) 
, IN PV_OPERACION  VARCHAR (1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO  personas(
   NOM_PERSONA
  ,SEX_PERSONA
  ,EDAD_PERSONAL
  ,TIP_PERSONA
  ,Num_Identidad
  ,IND_CIVIL
  ,IND_PERSONA
  ,FEC_REGISTRO
) VALUES (
   PV_NOM_PERSONA
  ,PC_SEX_PERSONA
  ,PI_EDAD_PERSONAL
  ,PC_TIP_PERSONA
  ,PV_Num_Identidad
  ,PC_IND_CIVIL
  ,PC_IND_PERSONA
  ,NOW()
);

-- Seleccionar el maximo insertado en la tabla de PERSONAS
Select @COD_PERSONA := MAX(COD_PERSONA) FROM personas;


ELSEIF PV_OPERACION = 2 THEN
UPDATE personas
SET 
   NOM_PERSONA = PV_NOM_PERSONA -- varchar(100)
  ,SEX_PERSONA = PC_SEX_PERSONA -- enum('F','M')
  ,EDAD_PERSONAL = PI_EDAD_PERSONAL -- tinyint(4)
  ,TIP_PERSONA = PC_TIP_PERSONA -- enum('N','J')
  ,Num_Identidad = PV_Num_Identidad -- varchar(15)
  ,IND_CIVIL = PC_IND_CIVIL -- enum('S','C','D','V')
  ,IND_PERSONA = PC_IND_PERSONA -- enum('1','0'
  ,FEC_REGISTRO = now() -- datetime
WHERE COD_PERSONA = PI_FILA; -- bigint(20)


ELSEIF PV_OPERACION = 3 THEN
DELETE FROM PERSONAS
WHERE COD_PERSONA = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_PERSONA, NOM_PERSONA, SEX_PERSONA, EDAD_PERSONAL, TIP_PERSONA, Num_Identidad, IND_CIVIL, IND_PERSONA, FEC_REGISTRO 
FROM personas;
ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM PERSONAS WHERE COD_PERSONA = PI_FILA;
END IF;
COMMIT;
END;

CREATE PROCEDURE PROC_TELEFONOS(
IN PI_COD_PERSONA BIGINT
,IN PI_NUM_TELEFONO INT (15)
  ,IN PC_TIP_TELEFONO CHAR (1)
  , IN PV_OPERACION  VARCHAR (1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO  telefonos(
   COD_PERSONA
  ,NUM_TELEFONO
  ,TIP_TELEFONO
) VALUES (
  PI_COD_PERSONA
  ,PI_NUM_TELEFONO
  ,PC_TIP_TELEFONO
);
-- Seleccionar el maximo insertado en la tabla de TELEFONO
SELECT @COD_TELEFONO := MAX(COD_TELEFONO) from TELEFONOS;
INSERT INTO  pertel(
  COD_TELEFONO
  ,COD_PERSONA
) VALUES (
 @COD_TELEFONO
 ,PI_COD_PERSONA
);
ELSEIF PV_OPERACION = 2 THEN
UPDATE TELEFONOS
SET
   NUM_TELEFONO = PI_NUM_TELEFONO -- int(15)
  ,TIP_TELEFONO = PC_TIP_TELEFONO -- enum('P','C','T')
WHERE COD_TELEFONO = PI_FILA; -- bigint(20)

ELSEIF PV_OPERACION = 3 THEN
DELETE FROM TELEFONOS
WHERE COD_TELEFONO = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_TELEFONO, COD_PERSONA, NUM_TELEFONO, TIP_TELEFONO 
FROM TELEFONOS;
ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM TELEFONOS WHERE COD_TELEFONO = PI_FILA;
END IF;
COMMIT;
END;






CREATE PROCEDURE PROC_DIRECCIONES(
IN PI_COD_PERSONA BIGINT
,IN PV_DIRECCION VARCHAR (30)
  , IN PV_OPERACION  VARCHAR (1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO DIRECCIONES(
  COD_PERSONA
  ,DIRECCION
) VALUES (
 PI_COD_PERSONA 
,PV_DIRECCION 
);

-- Seleccionar el maximo insertado en la tabla de DIRECCION
SELECT @COD_DIR := MAX(COD_DIR) from DIRECCIONES;
INSERT INTO  perdir(
   COD_DIR
  ,COD_PERSONA
) VALUES (
   @COD_DIR
  ,PI_COD_PERSONA
);
ELSEIF PV_OPERACION = 2 THEN
UPDATE DIRECCIONES
SET
  DIRECCION = PV_DIRECCION  -- varchar(100)
WHERE COD_DIR = PI_FILA; -- bigint(20)


ELSEIF PV_OPERACION = 3 THEN
DELETE FROM DIRECCIONES
WHERE COD_DIR = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_DIR, COD_PERSONA, DIRECCION 
FROM DIRECCIONES;
ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM DIRECCIONES WHERE COD_DIR = PI_FILA;
END IF;
COMMIT;
END;


CREATE PROCEDURE PROC_CORREOS(
IN PI_COD_PERSONA BIGINT
,IN PV_CORREO VARCHAR (30)
,IN PV_CONTRA VARCHAR (30)
  , IN PV_OPERACION  VARCHAR (1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN

INSERT INTO  CORREOS(
 
   COD_PERSONA
  ,CORREO
  ,CONTRASEÑA
) VALUES (
  PI_COD_PERSONA
  ,PV_CORREO
  , PV_CONTRA  
);

-- Seleccionar el maximo insertado en la tabla de CORREO
SELECT @COD_COR := MAX(COD_COR) from CORREOS;
INSERT INTO  percor(
   COD_COR
  ,COD_PERSONA
) VALUES (
  @COD_COR
  ,PI_COD_PERSONA
);
ELSEIF PV_OPERACION = 2 THEN
UPDATE CORREOS
SET
COD_PERSONA=PI_COD_PERSONA
  ,CORREO = PV_CORREO -- varchar(50)
   ,CONTRASEÑA =PV_CONTRA 
WHERE COD_COR =PI_FILA; -- bigint(20)


ELSEIF PV_OPERACION = 3 THEN
DELETE FROM CORREOS
WHERE COD_COR = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT * 
FROM CORREOS;
ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM CORREOS WHERE COD_COR = PI_FILA;
END IF;
COMMIT;
END;

CREATE PROCEDURE PROC_VERIFICAR(
IN PV_CORREO VARCHAR(20)
,IN PV_CONTRA VARCHAR(20)
,IN pv_rol varchar(20)
,IN PV_ESTADO INT
,IN PV_OPCION VARCHAR(1)
)BEGIN
START TRANSACTION;
IF PV_OPCION = 1 THEN
Select correo,contraseña FROM correos
where correo = PV_CORREO and  contraseña = PV_CONTRA;
ELSEIF PV_OPCION = 2 THEN
select ROL_PER,ESTADO FROM rol
where ROL_PER =pv_rol and ESTADO = PV_ESTADO;
END IF;
COMMIT;
END;







CREATE PROCEDURE PROC_ROL(
IN PI_COD_PERSONA BIGINT
,IN PV_ROL_PER VARCHAR (30)
,IN PV_DESCR VARCHAR (50)
,IN PI_ESTADO INT 
  , IN PV_OPERACION  VARCHAR (1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO ROL(
   COD_PERSONA
  ,ROL_PER
  ,DESCR
  ,ESTADO
) VALUES (
PI_COD_PERSONA
,PV_ROL_PER
,PV_DESCR
,PI_ESTADO
);

-- Seleccionar el maximo insertado en la tabla de ROL
SELECT @COD_ROL := MAX(COD_ROL) from ROL;
INSERT INTO  rolper(
   COD_ROL
  ,COD_PERSONA
) VALUES (
 @COD_ROL
,PI_COD_PERSONA
);

ELSEIF PV_OPERACION = 2 THEN
UPDATE ROL
SET

  ROL_PER = PV_ROL_PER -- varchar(30)
  ,DESCR = PV_DESCR -- varchar(100)
  ,ESTADO = PI_ESTADO -- bit(1)
WHERE COD_ROL = PI_FILA; -- bigint(20)


ELSEIF PV_OPERACION = 3 THEN
DELETE FROM ROL
WHERE COD_ROL = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_ROL, COD_PERSONA, ROL_PER, DESCR, ESTADO 
FROM ROL;
ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM ROL WHERE COD_ROL = PI_FILA;

END IF;
COMMIT;
END;







CREATE PROCEDURE PROC_USUARIOS(
IN PI_COD_PERSONA BIGINT
,IN PI_COD_ROL BIGINT
,IN PI_COD_COR BIGINT
,IN PI_ESTADO INT 
  , IN PV_OPERACION  VARCHAR (1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO  USUARIOS(
    COD_PERSONA
    ,COD_ROL
  ,COD_COR
  ,ESTADO
) VALUES (
  PI_COD_PERSONA
 ,PI_COD_ROL
 ,PI_COD_COR
 ,PI_ESTADO
);

-- Seleccionar el maximo insertado en la tabla de USUARIO
SELECT @COD_USR := MAX(COD_USR) from USUARIOS;
INSERT INTO  perusr(
   COD_USR
  ,COD_PERSONA
) VALUES (
  @COD_USR
 ,PI_COD_PERSONA
);
ELSEIF PV_OPERACION = 2 THEN
UPDATE USUARIOS 
SET
COD_PERSONA=PI_COD_PERSONA
 ,COD_ROL=PI_COD_ROL
 ,COD_USR = PI_COD_COR
  ,ESTADO = PI_ESTADO -- bit(1)
WHERE COD_USR = PI_FILA; -- bigint(20)


ELSEIF PV_OPERACION = 3 THEN
DELETE FROM USUARIOS
WHERE COD_USR = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_USR, COD_PERSONA, COD_ROL, COD_COR, estado 
FROM USUARIOS;
ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM USUARIOS WHERE COD_USR = PI_FILA;
END IF;
COMMIT;
END;
/*...........................................................................................*/
/*.......................................KEVIN...............................................*/
/*...........................................................................................*/


/*-------------------------------------------------------------------*/
/*--------------------------FABRICANTE-------------------------------*/
/*-------------------------------------------------------------------*/
CREATE PROCEDURE PROC_fabricante(




   IN PV_PROVEEDORES VARCHAR(255)
  ,IN PV_DIR_EMPRESA VARCHAR(255)
  ,IN PV_TEL_EMPRESA VARCHAR(16)
  ,IN PV_COR_EMPRESA VARCHAR(255)
  ,IN PV_NOM_PRODUCTO VARCHAR(255)
  ,IN PI_UNIDADES INT(11)
  ,IN PI_COS_PRODUCTO INT(255)
  , IN PV_OPERACION VARCHAR (255)
  , IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN

      INSERT INTO fabricante(
     
     
      PROVEEDORES
     ,DIR_EMPRESA
     ,TEL_EMPRESA
     ,COR_EMPRESA
     ,NOM_PRODUCTO
     ,UNIDADES
     ,COS_PRODUCTO
     ) VALUES (
     
     
      PV_PROVEEDORES
     ,PV_DIR_EMPRESA
     ,PV_TEL_EMPRESA  
     ,PV_COR_EMPRESA
     ,PV_NOM_PRODUCTO
     ,PI_UNIDADES
     ,PI_COS_PRODUCTO
);

-- Seleccionar el maximo insertado en la tabla de Fabricantes
SELECT @COD_EMPRESA := MAX(COD_EMPRESA) from Fabricante;
INSERT INTO  rel_fabenp(
   COD_ARTICULO
  ,COD_EMPRESA
) VALUES (
  @COD_ARTICULO
 ,@COD_EMPRESA
);

ELSEIF PV_OPERACION = 2 THEN

UPDATE fabricante
SET
 
  PROVEEDORES = PV_PROVEEDORES -- varchar(255)
  ,DIR_EMPRESA = PV_DIR_EMPRESA -- varchar(255)
  ,TEL_EMPRESA = PV_TEL_EMPRESA -- varchar(16)
  ,COR_EMPRESA = PV_COR_EMPRESA -- varchar(255)
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO -- varchar(255)
  ,UNIDADES = PI_UNIDADES -- int(11)
  ,COS_PRODUCTO = PI_COS_PRODUCTO -- varchar(255)
WHERE COD_EMPRESA = PI_FILA;

ELSEIF PV_OPERACION = 3 THEN
DELETE FROM fabricante
WHERE COD_EMPRESA = PI_FILA;


ELSEIF PV_OPERACION = 4 THEN
SELECT COD_EMPRESA, PROVEEDORES, DIR_EMPRESA, TEL_EMPRESA, COR_EMPRESA, NOM_PRODUCTO, UNIDADES, COS_PRODUCTO 
FROM fabricante;

ELSE IF PV_OPERACION = 5 THEN
SELECT * FROM FABRICANTE WHERE COD_EMPRESA = PI_FILA;
END IF;

END IF;
COMMIT;
END;



/*-------------------------------------------------------------------*/
/*--------------------------EMPRODUCCION-------------------------------*/
/*-------------------------------------------------------------------*/
CREATE PROCEDURE PROC_enproduccion(


 IN PI_COD_EMPRESA BIGINT
,IN PV_NOM_PROD_EN VARCHAR(255)
,IN PI_CAN_PRODUCTO VARCHAR(255)
,IN PV_COS_PROD_EN VARCHAR(255)
, IN PV_OPERACION VARCHAR (255)
/*, IN PI_COD_INV BIGINT*/
 , IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN

INSERT INTO enproduccion(
   
   COD_EMPRESA
  ,NOM_PROD_EN
  ,CAN_PRODUCTO
  ,COS_PROD_EN
) VALUES (
  
   PI_COD_EMPRESA
  ,PV_NOM_PROD_EN
  ,PI_CAN_PRODUCTO
  ,PV_COS_PROD_EN
);

-- Seleccionar el maximo insertado en la tabla de Fabricantes
SELECT @COD_ARTICULO := MAX(COD_ARTICULO) from ENPRODUCCION;
INSERT INTO  rel_enpinv(
  COD_INV
  ,COD_ARTICULO
) VALUES (
 @COD_INV
,@COD_ARTICULO
);

ELSEIF PV_OPERACION = 2 THEN

UPDATE enproduccion
SET
   
  COD_EMPRESA= PI_COD_EMPRESA
  /*,COD_INV= PI_COD_INV*/
  ,NOM_PROD_EN = PV_NOM_PROD_EN -- varchar(255)
  ,CAN_PRODUCTO = PI_CAN_PRODUCTO -- varchar(255)
  ,COS_PROD_EN = PV_COS_PROD_EN -- varchar(255)
WHERE COD_ARTICULO = PI_FILA;

ELSEIF PV_OPERACION = 3 THEN

DELETE FROM enproduccion
WHERE COD_ARTICULO = PI_FILA;



ELSEIF PV_OPERACION = 4 THEN
SELECT COD_ARTICULO, COD_EMPRESA, NOM_PROD_EN, CAN_PRODUCTO, COS_PROD_EN 
FROM enproduccion;

ELSE IF PV_OPERACION = 5 THEN
SELECT * FROM enproduccion WHERE COD_ARTICULO = PI_FILA;
END IF;




END IF;
COMMIT;
END;


/*...........................................................................................*/
/*........................................JORGE..............................................*/
/*...........................................................................................*/
CREATE PROCEDURE PROC_PRODUCTO(
   IN PI_COD_EMPRESA BIGINT
  ,IN PV_NOM_PRODUCTO VARCHAR (50)
  ,IN PV_PROVEEDOR VARCHAR (50)
  ,IN PV_MARCA VARCHAR (50)
  ,IN PI_PRECIO INT (5)
  ,IN PI_UNIDADES INT (2)
  ,IN PV_OPERACION  VARCHAR(1)
  ,IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO  PRODUCTO(
   COD_EMPRESA
  ,NOM_PRODUCTO
  ,PROVEEDOR
  ,MARCA
  ,PRECIO
  ,UNIDADES
) VALUES (
   PI_COD_EMPRESA
  ,PV_NOM_PRODUCTO
  ,PV_PROVEEDOR
  ,PV_MARCA
  ,PI_PRECIO
  ,PI_UNIDADES
);
-- Seleccionar el maximo insertado en la tabla de PRODUCTOS
SELECT @COD_producto := MAX(COD_producto) from producto;
ELSEIF PV_OPERACION = 2 THEN
UPDATE Producto
SET
   COD_EMPRESA = PI_COD_EMPRESA
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO
  ,PROVEEDOR = PV_PROVEEDOR
  ,MARCA = PV_MARCA
  ,PRECIO = PI_PRECIO
  ,UNIDADES = PI_UNIDADES
WHERE COD_PRODUCTO = PI_FILA;
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM producto 
WHERE COD_PRODUCTO = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_PRODUCTO, COD_EMPRESA, NOM_PRODUCTO, PROVEEDOR, MARCA, PRECIO, UNIDADES 
FROM producto;

ELSE IF PV_OPERACION = 5 THEN
SELECT * FROM producto WHERE COD_producto = PI_FILA;
END IF;

END IF;
COMMIT;
END;
CREATE PROCEDURE PROC_INVENTARIO(
   IN PI_COD_PRODUCTO BIGINT
  ,IN PI_COD_EMPRESA BIGINT
  ,IN PV_NOM_PRODUCTOS VARCHAR (50)
  ,IN PV_PROVEEDORES VARCHAR (50)
  ,IN PV_MARCA VARCHAR (50)
  ,IN PI_UNIDADES INT (5)
  ,IN PV_CATEGORIAS VARCHAR (50) 
  ,IN PV_OPERACION2 VARCHAR(1)
  ,IN PI_FILA2 INT(1)
 
)
BEGIN
START TRANSACTION;
IF PV_OPERACION2 = 1 THEN
INSERT INTO  INVENTARIO(
   COD_PRODUCTO
  ,COD_EMPRESA
  ,NOM_PRODUCTOS
  ,PROVEEDORES
  ,MARCA
  ,UNIDADES
  ,CATEGORIAS
) VALUES (
   PI_COD_PRODUCTO 
  ,PI_COD_EMPRESA 
  ,PV_NOM_PRODUCTOS 
  ,PV_PROVEEDORES
  ,PV_MARCA 
  ,PI_UNIDADES 
  ,PV_CATEGORIAS  
);
-- Seleccionar el maximo insertado en la tabla de inventario
SELECT @COD_INV := MAX(COD_INV) from inventario;
INSERT INTO  rel_prodinv(
   COD_PRODUCTO
  ,COD_INV
) VALUES (
COD_PRODUCTO
,@COD_INV
);
ELSEIF PV_OPERACION2 = 2 THEN
UPDATE INVENTARIO
SET
   COD_PRODUCTO = PI_COD_PRODUCTO
  ,COD_EMPRESA = PI_COD_EMPRESA
  ,NOM_PRODUCTOS = PV_NOM_PRODUCTOS
  ,PROVEEDORES = PV_PROVEEDORES
  ,MARCA = PV_MARCA
  ,UNIDADES = PI_UNIDADES
  ,CATEGORIAS = PV_CATEGORIAS  
WHERE COD_INV= PI_FILA2;
ELSEIF PV_OPERACION2 = 3 THEN
DELETE FROM inventario 
WHERE COD_inv = PI_FILA2;

ELSEIF PV_OPERACION2 = 4 THEN
SELECT COD_INV, COD_PRODUCTO, COD_EMPRESA, NOM_PRODUCTOS, PROVEEDORES, MARCA, UNIDADES, CATEGORIAS 
FROM  inventario;

ELSE IF PV_OPERACION2 = 5 THEN
SELECT * FROM inventario WHERE COD_INV = PI_FILA2;
END IF;

END IF;
COMMIT;
END;

/*...........................................................................................*/
/*........................................EMERSON..............................................*/
/*...........................................................................................*/
/*
Nombre:PROC_VENTA
Descripcion:procedimiento que almacena  para realizar funciones basicas
Autor:Emerson Exequiel Ramos Velasquez
Version 2.0
*/
CREATE PROCEDURE `PROC_VENTA`(
  IN PI_COD_INV BIGINT
, IN PI_COD_PERSONA BIGINT
, IN PI_COD_PRODUCTO BIGINT
, IN PV_NOM_PRODUCTO VARCHAR(20)
, IN PI_CANT_PRODUCTO INT(3)
, IN PI_PREC_UNITARIO INT(3)
, IN PI_TOTAL_BRUTO  INT(3)
, IN PV_DESTINO_VENTA VARCHAR(20)
, IN PI_IMPUE_TOTAL   INT(2)
, IN PI_TOTAL_VENTA INT(3)
, IN PV_OPERACION  VARCHAR(1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO  ventas(
   COD_INV
  ,COD_PERSONA
  ,COD_PRODUCTO
  ,NOM_PRODUCTO
  ,CANT_PRODUCTO
  ,PREC_UNITARIO
  ,TOTAL_BRUTO
  ,DESTINO_VENTA
  ,FEC_VENTA
  ,IMPUE_TOTAL
  ,TOTAL_VENTA
) VALUES (
   PI_COD_INV   
  ,PI_COD_PERSONA  
  ,PI_COD_PRODUCTO 
  ,PV_NOM_PRODUCTO
  ,PI_CANT_PRODUCTO
  ,PI_PREC_UNITARIO
  ,PI_TOTAL_BRUTO
  ,PV_DESTINO_VENTA
  ,NOW()
  ,PI_IMPUE_TOTAL
  ,PI_TOTAL_VENTA
);
-- Seleccionar el maximo insertado en la tabla de Ventas
SELECT @COD_VENTA := MAX(COD_VENTA) from VENTAS;
INSERT INTO  relveninv(
  COD_VENTA
  ,COD_INV
) VALUES (
  @COD_VENTA
 ,PI_COD_INV
);
INSERT INTO  relvenper(
  COD_VENTA
 ,COD_PERSONA
) VALUES (
  @COD_VENTA
 ,PI_COD_PERSONA
);
INSERT INTO  relvenprod(
   COD_VENTA
  ,COD_PRODUCTO
) VALUES (
  @COD_VENTA
 ,PI_COD_PRODUCTO
);
ELSEIF PV_OPERACION = 2 THEN
UPDATE ventas
SET
   COD_INV = PI_COD_INV   
  ,COD_PERSONA=PI_COD_PERSONA  
  ,COD_PRODUCTO = PI_COD_PRODUCTO 
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO -- varchar(255)
  ,CANT_PRODUCTO = PI_CANT_PRODUCTO -- tinyint(4)
  ,PREC_UNITARIO = PI_PREC_UNITARIO -- tinyint(4)
  ,TOTAL_BRUTO = PI_TOTAL_BRUTO -- tinyint(4)
  ,DESTINO_VENTA = PV_DESTINO_VENTA -- varchar(255)
  ,FEC_VENTA = now() -- datetime
  ,IMPUE_TOTAL = PI_IMPUE_TOTAL  -- decimal(4,2)
  ,TOTAL_VENTA =  PI_TOTAL_VENTA   -- decimal(11,2)
WHERE COD_VENTA = PI_FILA;-- bigint(20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM ventas 
WHERE COD_VENTA = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_VENTA, COD_INV, COD_PERSONA, COD_PRODUCTO, NOM_PRODUCTO, CANT_PRODUCTO, PREC_UNITARIO, TOTAL_BRUTO, DESTINO_VENTA, FEC_VENTA, IMPUE_TOTAL, TOTAL_VENTA 
FROM ventas;
ELSEIF PV_OPERACION = 5 THEN
SELECT * FROM VENTAS WHERE COD_VENTA= PI_FILA;
END IF;
COMMIT;
END;
/*
Nombre:PROC_COMPRA
Descripcion:procedimiento que almacena  para realizar funciones basicas
Autor:Emerson Exequiel Ramos Velasquez
Version 2.0
*/

CREATE PROCEDURE `PROC_COMPRA`(
  
  IN PI_COD_EMPRESA BIGINT
 ,IN PI_COD_PERSONA BIGINT
 ,IN PV_NOM_PRODUCTO VARCHAR(10)
 ,IN PV_DEST_PROD VARCHAR(20)
 ,IN PV_DEST_CATEG VARCHAR(20)
 ,IN PI_CANT_PROD INT
 ,IN PI_PREC_COMP INT
 ,IN PI_IMPU_COMP INT
 ,IN PI_TOL_COMP  INT
, IN PV_OPERACION  VARCHAR(1)
, IN PI_FILA INT(1)
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO COMPRAS(
   
   COD_EMPRESA
  ,COD_PERSONA
  ,NOM_PROD
  ,DEST_PROD
  ,FEC_COMP
  ,DEST_CATEG
  ,CANT_PROD
  ,PREC_COMP
  ,IMPU_COMP
  ,TOL_COMP
) VALUES (
  PI_COD_EMPRESA  
 ,PI_COD_PERSONA
 ,PV_NOM_PRODUCTO
 ,PV_DEST_PROD
 ,NOW()
 ,PV_DEST_CATEG
 ,PI_CANT_PROD
 ,PI_PREC_COMP
 ,PI_IMPU_COMP
 ,PI_TOL_COMP   
);
-- Seleccionar el maximo insertado en la tabla de Ventas
SELECT @COD_COMPRA := MAX(COD_COMPRA) from COMPRAS;

INSERT INTO  RELCOMFAB(
   COD_COMPRA
  ,COD_EMPRESA
) VALUES (
  @COD_COMPRA
 ,PI_COD_EMPRESA
);
INSERT INTO  RELCOMPERS(
   COD_COMPRA
  ,COD_PERSONA
) VALUES (
  @COD_COMPRA
 ,PI_COD_PERSONA
);


ELSEIF PV_OPERACION = 2 THEN
UPDATE COMPRAS
SET
   NOM_PROD = PV_NOM_PRODUCTO -- varchar(55)
  ,DEST_PROD = PV_DEST_PROD -- varchar(7)
  ,FEC_COMP = now() -- datetime
  ,DEST_CATEG = PV_DEST_CATEG-- varchar(7)
  ,CANT_PROD = PI_CANT_PROD -- tinyint(4)
  ,PREC_COMP = PI_PREC_COMP -- tinyint(4)
  ,IMPU_COMP = PI_IMPU_COMP -- decimal(4,2)
  ,TOL_COMP = PI_TOL_COMP  -- decimal(11,2)
WHERE COD_COMPRA = PI_FILA; -- bigint(20)

ELSEIF PV_OPERACION = 3 THEN
DELETE FROM COMPRAS
WHERE COD_COMPRA = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_COMPRA, COD_EMPRESA, COD_PERSONA, NOM_PROD, DEST_PROD, FEC_COMP, DEST_CATEG, CANT_PROD, PREC_COMP, IMPU_COMP, TOL_COMP 
FROM COMPRAS;
ELSEIF PV_OPERACION = 5 THEN
SELECT * FROM COMPRAS WHERE COD_COMPRA= PI_FILA;
END IF;
COMMIT;
END;

CREATE PROCEDURE PROC_UPDATEINVENTARIO(
PV_CODINV INT(10),
PV_UNIDADES INT,
PV_OPCION VARCHAR(1)
)BEGIN
START TRANSACTION;
IF PV_OPCION = 1 THEN
UPDATE inventario
SET
  UNIDADES = PV_UNIDADES -- int(11)
  
WHERE COD_INV = PV_CODINV; -- bigint(20)
ELSEIF PV_OPCION = 2 THEN
SELECT UNIDADES FROM INVENTARIO
WHERE COD_INV = PV_CODINV;
END IF;
COMMIT;
END;

/*...........................................................................................*/
/*.............................................ANA.........................................*/
/*...........................................................................................*/
/*...........................................................................................*/
/*.............................................ANA.........................................*/
/*...........................................................................................*/
CREATE PROCEDURE PROC_DISTRIBPRODUCT(
/*
Nombre:INS_DISTRIBPRODUCT
Descripcion:procedimiento que almacena  para realizar funciones basicas
Autor:Ana Esther Vallejo Alvarenga
Version 1.0
*/
-- PV = Paramatro Varchar, PC = Parametro char, PI = Parametro entero
-- parametros:
   IN PI_COD_PERSONA  BIGINT,
   IN PI_COD_PRODUCTO BIGINT,
   IN PI_COD_VENTA BIGINT,
 
   
  IN PV_nombreDepart VARCHAR (50),
  IN PV_lugar_entrega VARCHAR (50),
   IN PV_nombre VARCHAR (100),

  IN PV_OPERACION  VARCHAR(1),
  IN PI_FILA INT(1)
  

  
)
BEGIN
START TRANSACTION;
IF PV_OPERACION = 1 THEN
        
      INSERT INTO  distribproduct(
         COD_PERSONA,
        COD_PRODUCTO,
        COD_VENTA
     
         ,nombreDepart
        ,lugar_entrega
        ,nombre
      )VALUES (
          PI_COD_PERSONA,
          PI_COD_PRODUCTO,
          PI_COD_VENTA,
          
         PV_nombreDepart
        ,PV_lugar_entrega
        ,PV_nombre
);


-- Seleccionar el maximo insertado en la tabla de distribproduct

 SELECT @cod_departamento := MAX(cod_departamento) from DistribProduct;
INSERT INTO  rel_distribpr(
   cod_departamento
   ,COD_PERSONA
) VALUES (
  @cod_departamento,
  PI_COD_PERSONA
);

INSERT INTO  rel_distven(
   cod_departamento
  ,COD_VENTA
  
) VALUES (
  @cod_departamento
 ,PI_COD_VENTA
 );
 
 INSERT INTO  rel_distprod(
   cod_departamento
  ,COD_PRODUCTO
  
) VALUES (
  @cod_departamento
 ,PI_COD_PRODUCTO
 
 
 
);
ELSEIF PV_OPERACION = 2 THEN

      UPDATE distribproduct
      SET
         nombreDepart = PV_nombreDepart -- varchar(30)
         ,lugar_entrega = PV_lugar_entrega -- varchar(60)
         ,nombre = PV_nombre -- varchar(100)
      WHERE cod_departamento = PI_FILA;
      
ELSEIF PV_OPERACION = 3 THEN
      DELETE FROM distribproduct 
      WHERE cod_departamento = PI_FILA;
      
ELSEIF PV_OPERACION = 4 THEN
      SELECT cod_departamento,COD_PERSONA, COD_PRODUCTO ,COD_VENTA, nombreDepart, lugar_entrega, nombre
      FROM distribproduct;
      
      
      ELSE IF PV_OPERACION = 5 THEN
SELECT * FROM distribproduct WHERE cod_departamento = PI_FILA;
END IF;


END IF;
COMMIT;
END;


CREATE PROCEDURE PROC_DESCPRODUCT(
/*
Nombre:PROC_DESCPRODUCT
Descripcion:procedimiento que almacena  para realizar funciones basicas de la
tabla descripcion de producto
Autor:Ana Esther Vallejo Alvarenga
Version 1.0
*/
-- PV = Paramatro Varchar, PC = Parametro char, PI = Parametro entero
-- parametros:

    -- IN PI_COD_descproducto BIGINT  -- eliminar la llave foranea guiarme al de emrson todo el procedimiento
    IN PI_COD_PRODUCTO BIGINT
   ,IN PV_nombreproduct  VARCHAR(30)
   ,IN PI_precioproduct INT(7)
   ,IN PI_cantidadproduct INT(7)
   ,IN PV_color  VARCHAR(25)
   ,IN PV_tamano VARCHAR(30)
   ,IN pc_opcion CHAR(1)
   ,IN pi_fila int(1) 
   
  
)
BEGIN
START TRANSACTION;
IF pc_opcion = 1 THEN
 
      INSERT INTO  descproducto(
          COD_PRODUCTO,
          nombreproduct
          ,precioproduct
          ,cantidadproduct
          ,color
          ,tamano
      ) VALUES (
            PI_COD_PRODUCTO,
            PV_nombreproduct
           ,PI_precioproduct
           ,PI_cantidadproduct
           ,PV_color 
           ,PV_tamano 
      );
      SELECT @cod_descproducto := MAX(cod_descproducto) from Descproducto;  

INSERT INTO  rel_despro(
   cod_descproducto,
   COD_PRODUCTO
) VALUES (
  @cod_descproducto,
  PI_COD_PRODUCTO
);


ELSEIF pc_opcion = 2 THEN

      UPDATE descproducto
      SET
         nombreproduct = PV_nombreproduct-- varchar(30)
         ,precioproduct = PI_precioproduct -- int(10)
         ,cantidadproduct = PI_cantidadproduct -- int(10)
         ,color =  PV_color -- varchar(20)
         ,tamano =  PV_tamano-- varchar(30)
      WHERE cod_descproducto = pi_fila ; -- bigint(20)

      
ELSEIF pc_opcion = 3 THEN

        DELETE FROM descproducto 
        WHERE cod_descproducto = pi_fila;
      
ELSEIF pc_opcion = 4 THEN

      SELECT cod_descproducto,  COD_PRODUCTO,   nombreproduct, precioproduct, cantidadproduct, color, tamano 
      FROM descproducto;
ELSEIF pc_opcion = 5 then
select * from descproducto where COD_descproducto=pi_fila;
END IF;
COMMIT;
END;



/*----------------------------------JAIRO--------------------------------------------------------*/
/*----------------------------------JAIRO--------------------------------------------------------*/

CREATE PROCEDURE PROC_REPORTPERSONAS(
   IN PI_COD_ROL BIGINT
  ,IN PV_ROL_PER VARCHAR (255)
  ,IN PI_COD_PERSONA BIGINT
  ,IN PV_NOM_PERSONA VARCHAR (25)
  ,IN PI_COD_TELEFONO BIGINT 
  ,IN PI_COD_DIR BIGINT
  ,IN PI_COD_COR BIGINT
  ,IN PI_COD_USR BIGINT
  ,IN PV_OPERACION VARCHAR (1)
  ,IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO reportpersonas(
   COD_ROL
  ,ROL_PER
  ,COD_PERSONA
  ,NOM_PERSONA
  ,COD_TELEFONO
  ,COD_DIR
  ,COD_COR
  ,COD_USR
)VALUES(
   PI_COD_ROL
  ,PV_ROL_PER 
  ,PI_COD_PERSONA 
  ,PV_NOM_PERSONA
  ,PI_COD_TELEFONO 
  ,PI_COD_DIR
  ,PI_COD_COR
  ,PI_COD_USR 
);

SELECT @COD_REPORTPERSONAS:= MAX(COD_REPORTPERSONAS) from REPORTPERSONAS;
ELSEIF PV_OPERACION = 2 THEN
UPDATE reportpersonas
SET
   COD_ROL = PI_COD_ROL
  ,ROL_PER = PV_ROL_PER -- VARCHAR (255)
  ,COD_PERSONA = PI_COD_PERSONA
  ,NOM_PERSONA = PV_NOM_PERSONA -- VARCHAR (255)
  ,COD_TELEFONO = PI_COD_TELEFONO
  ,COD_DIR = PI_COD_DIR
  ,COD_COR = PI_COD_COR
  ,COD_USR = PI_COD_USR

WHERE COD_REPORTPERSONAS = PI_FILA; -- BIGINT (20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM REPORTPERSONAS
WHERE COD_REPORTPERSONAS = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT *
FROM REPORTPERSONAS;       

ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM REPORTPERSONAS WHERE COD_ROL = PI_FILA;

END IF;
COMMIT;
END;


/*******************************************************************************************************************************/


CREATE PROCEDURE PROC_REPORTPRODUCCION(
   IN PI_COD_ARTICULO BIGINT
  ,IN PV_NOM_PRODUCTO VARCHAR (255)
  ,IN PI_COD_EMPRESA BIGINT
  ,IN PV_PROVEEDORES VARCHAR (255)
  ,IN PI_COD_INV BIGINT
  ,IN PV_CATEGORIAS VARCHAR (255)
  ,IN PV_OPERACION VARCHAR (1)
  ,IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO reportproduccion(
   
   COD_ARTICULO
  ,NOM_PRODUCTO
  ,COD_EMPRESA
  ,PROVEEDORES
  ,COD_INV
  ,CATEGORIAS
  
)VALUES(
   PI_COD_ARTICULO
  ,PV_NOM_PRODUCTO
  ,PI_COD_EMPRESA 
  ,PV_PROVEEDORES
  ,PI_COD_INV 
  ,PV_CATEGORIAS 
);

SELECT @COD_REPORTPRODUCCION:= MAX(COD_REPORTPRODUCCION) from REPORTPRODUCCION;
ELSEIF PV_OPERACION =2 THEN
UPDATE reportproduccion
SET
   COD_ARTICULO = PI_COD_ARTICULO
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO -- VARCHAR (255)
  ,COD_EMPRESA = PI_COD_EMPRESA 
  ,PROVEEDORES = PV_PROVEEDORES -- VARCHAR (255)
  ,COD_INV = PI_COD_INV 
  ,CATEGORIAS = PV_CATEGORIAS -- VARCHAR (255)

WHERE COD_REPORTPRODUCCION = PI_FILA; -- BIGINT (20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM REPORTPRODUCCION
WHERE COD_REPORTPRODUCCION = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT *
FROM REPORTPRODUCCION;       

ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM REPORTPRODUCCION WHERE COD_ARTICULO = PI_FILA;

END IF;
COMMIT;
END;



/*******************************************************************************************************************************/


CREATE PROCEDURE PROC_REPORTINVENTARIO (
   IN PI_COD_PRODUCTO BIGINT
  ,IN PV_NOM_PRODUCTO VARCHAR (255)
  ,IN PI_COD_INV BIGINT
  ,IN PV_CATEGORIAS VARCHAR (255)
  ,IN PV_OPERACION VARCHAR (1)
  ,IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO reportinventario(
   
   COD_PRODUCTO
  ,NOM_PRODUCTO
  ,COD_INV
  ,CATEGORIAS
  
)VALUES(
   PI_COD_PRODUCTO
  ,PV_NOM_PRODUCTO 
  ,PI_COD_INV 
  ,PV_CATEGORIAS 
);

SELECT @COD_REPORTINVENTARIO:= MAX(COD_REPORTINVENTARIO) from REPORTINVENTARIO;
ELSEIF PV_OPERACION =2 THEN
UPDATE reportinventario
SET
   COD_PRODUCTO = PI_COD_PRODUCTO
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO -- VARCHAR (255)
  ,COD_INV = PI_COD_INV
  ,CATEGORIAS = PV_CATEGORIAS -- VARCHAR (255)

WHERE COD_REPORTINVENTARIO = PI_FILA; -- BIGINT (20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM REPORTINVENTARIO
WHERE COD_REPORTINVENTARIO = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_PRODUCTO, NOM_PRODUCTO, COD_INV, CATEGORIAS
FROM REPORTINVENTARIO;       

ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM REPORTINVENTARIO WHERE COD_PRODUCTO = PI_FILA;

END IF;
COMMIT;
END;

/*******************************************************************************************************************************/


CREATE PROCEDURE PROC_REPORTCOMPRA(
   IN PI_COD_COMPRA BIGINT
  ,IN PI_COD_INV BIGINT
  ,IN PV_CATEGORIAS VARCHAR (255)
  ,IN PI_COD_PERSONA BIGINT
  ,IN PV_NOM_PERSONA VARCHAR (255)
  ,IN PI_COD_VENTA BIGINT
  ,IN PI_COD_PRODUCTO BIGINT
  ,IN PV_NOM_PRODUCTO VARCHAR (255)
  ,IN PV_OPERACION VARCHAR (1)
  ,IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO reportcompra(
   
   COD_COMPRA
  ,COD_INV
  ,CATEGORIAS
  ,COD_PERSONA
  ,NOM_PERSONA
  ,COD_VENTA
  ,COD_PRODUCTO
  ,NOM_PRODUCTO
  
)VALUES(
   PI_COD_COMPRA
  ,PI_COD_INV
  ,PV_CATEGORIAS
  ,PI_COD_PERSONA
  ,PV_NOM_PERSONA
  ,PI_COD_VENTA
  ,PI_COD_PRODUCTO
  ,PV_NOM_PRODUCTO 
);

SELECT @COD_REPORTCOMPRA:= MAX(COD_REPORTCOMPRA) from REPORTCOMPRA;
ELSEIF PV_OPERACION =2 THEN
UPDATE reportcompra
SET
   COD_COMPRA = PI_COD_COMPRA
  ,COD_INV = PI_COD_INV
  ,CATEGORIAS = PV_CATEGORIAS -- VARCHAR (255)
  ,COD_PERSONA = PI_COD_PERSONA
  ,NOM_PERSONA = PV_NOM_PERSONA -- VARCHAR (255)
  ,COD_VENTA = PI_COD_VENTA
  ,COD_PRODUCTO = PI_COD_PRODUCTO
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO -- VARCHAR (255)

WHERE COD_REPORTCOMPRA = PI_FILA; -- BIGINT (20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM REPORTCOMPRA
WHERE COD_REPORTCOMPRA = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT *
FROM REPORTCOMPRA;       

ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM REPORTCOMPRA WHERE COD_COMPRA = PI_FILA;

END IF;
COMMIT;
END;


/*******************************************************************************************************************************/


CREATE PROCEDURE PROC_REPORTVENTA(
   IN PI_COD_VENTA BIGINT
  ,IN PI_COD_INV BIGINT 
  ,IN PV_CATEGORIAS VARCHAR (255)
  ,IN PI_COD_PERSONA BIGINT 
  ,IN PV_NOM_PERSONA VARCHAR (255)
  ,IN PI_COD_PRODUCTO BIGINT 
  ,IN PV_NOM_PRODUCTO VARCHAR (255)
  ,IN PV_OPERACION VARCHAR (1)
  ,IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO reportventa(
   COD_VENTA
  ,COD_INV
  ,CATEGORIAS
  ,COD_PERSONA
  ,NOM_PERSONA
  ,COD_PRODUCTO
  ,NOM_PRODUCTO
  
)VALUES(
   PI_COD_VENTA
  ,PI_COD_INV
  ,PV_CATEGORIAS
  ,PI_COD_PERSONA
  ,PV_NOM_PERSONA
  ,PI_COD_PRODUCTO
  ,PV_NOM_PRODUCTO 
);

SELECT @COD_REPORTVENTA:= MAX(COD_REPORTVENTA) from REPORTVENTA;
ELSEIF PV_OPERACION =2 THEN
UPDATE reportventa
SET
   COD_VENTA = PI_COD_VENTA
  ,COD_INV = PI_COD_INV
  ,CATEGORIAS = PV_CATEGORIAS -- VARCHAR (255)
  ,COD_PERSONA = PI_COD_PERSONA
  ,NOM_PERSONA = PV_NOM_PERSONA -- VARCHAR (255)
  ,COD_PRODUCTO = PI_COD_PRODUCTO
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO -- VARCHAR (255)

WHERE COD_REPORTVENTA = PI_FILA; -- BIGINT (20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM REPORTVENTA
WHERE COD_REPORTVENTA = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT *
FROM REPORTVENTA;       

ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM REPORTINVENTARIO WHERE COD_PRODUCTO = PI_FILA;

END IF;
COMMIT;
END;



/*******************************************************************************************************************************/


CREATE PROCEDURE PROC_REPORTDISTRIBUCION (
   IN PI_COD_PERSONA BIGINT
  ,IN PV_NOM_PERSONA VARCHAR (255)
  ,IN PI_COD_VENTA BIGINT
  ,IN PI_COD_PRODUCTO BIGINT
  ,IN PV_NOM_PRODUCTO VARCHAR (255)
  ,IN PI_COD_INV BIGINT
  ,IN PV_CATEGORIAS VARCHAR (255)
  ,IN PI_COD_ARTICULO BIGINT
  ,IN PI_cod_descproducto BIGINT
  ,IN PV_OPERACION VARCHAR (1)
  ,IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO reportdistribucion(
   COD_PERSONA
  ,NOM_PERSONA
  ,COD_VENTA
  ,COD_PRODUCTO
  ,NOM_PRODUCTO
  ,COD_INV
  ,CATEGORIAS
  ,COD_ARTICULO
  ,cod_descproducto
  
)VALUES(
   PI_COD_PERSONA
  ,PV_NOM_PERSONA
  ,PI_COD_VENTA
  ,PI_COD_PRODUCTO
  ,PV_NOM_PRODUCTO
  ,PI_COD_INV
  ,PV_CATEGORIAS
  ,PI_COD_ARTICULO
  ,PI_cod_descproducto
);

SELECT @COD_REPORTDISTRIBUCION:= MAX(COD_REPORTDISTRIBUCION) from REPORTDISTRIBUCION;
ELSEIF PV_OPERACION =2 THEN
UPDATE reportdistribucion
SET
   COD_PERSONA = PI_COD_PERSONA
  ,NOM_PERSONA = PV_NOM_PERSONA -- VARCHAR (255)
  ,COD_VENTA = PI_COD_VENTA
  ,COD_PRODUCTO = PI_COD_PRODUCTO
  ,NOM_PRODUCTO = PV_NOM_PRODUCTO -- VARCHAR (255)
  ,COD_INV =  PI_COD_INV
  ,CATEGORIAS = PV_CATEGORIAS -- VARCHAR (255)
  ,COD_ARTICULO = PI_COD_ARTICULO
  ,cod_descproducto = PI_cod_descproducto

WHERE COD_REPORTDISTRIBUCION = PI_FILA; -- BIGINT (20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM REPORTDISTRIBUCION
WHERE COD_REPORTDISTRIBUCION = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_PERSONA, NOM_PERSONA, COD_VENTA, COD_PRODUCTO, NOM_PRODUCTO, COD_INV, CATEGORIAS, COD_ARTICULO, cod_descproducto
FROM REPORTDISTRIBUCION;       

ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM REPORTDISTRIBUCION WHERE COD_PERSONA = PI_FILA;

END IF;
COMMIT;
END;


/*******************************************************************************************************************************/


CREATE PROCEDURE PROC_REPORTGENERAL (
   IN PI_COD_REPORTPERSONAS BIGINT
  ,IN PV_NOM_PERSONA VARCHAR (255)
  ,IN PI_COD_REPORTPRODUCCION BIGINT
  ,IN PV_PROVEEDORES VARCHAR (255)
  ,IN PI_COD_REPORTINVENTARIO BIGINT
  ,IN PV_CATEGORIAS VARCHAR (255)
  ,IN PI_COD_REPORTVENTA BIGINT
  ,IN PI_COD_REPORTCOMPRA BIGINT
  ,IN PI_COD_REPORTDISTRIBUCION BIGINT
  ,IN PV_OPERACION VARCHAR (1)
  ,IN PI_FILA INT (1)
)
BEGIN 
START TRANSACTION;
IF PV_OPERACION = 1 THEN
INSERT INTO reportgeneral(
   COD_REPORTPERSONAS
  ,NOM_PERSONA
  ,COD_REPORTPRODUCCION
  ,PROVEEDORES
  ,COD_REPORTINVENTARIO
  ,CATEGORIAS
  ,COD_REPORTVENTA
  ,COD_REPORTCOMPRA
  ,COD_REPORTDISTRIBUCION
  
)VALUES(
   PI_COD_REPORTPERSONAS
  ,PV_NOM_PERSONA
  ,PI_COD_REPORTPRODUCCION
  ,PV_PROVEEDORES
  ,PI_COD_REPORTINVENTARIO
  ,PV_CATEGORIAS
  ,PI_COD_REPORTVENTA
  ,PI_COD_REPORTCOMPRA
  ,PI_COD_REPORTDISTRIBUCION
);

SELECT @COD_REPORTGENERAL:= MAX(COD_REPORTGENERAL) from REPORTGENERAL;
ELSEIF PV_OPERACION =2 THEN
UPDATE reportgeneral
SET
   COD_REPORTPERSONAS = PI_COD_REPORTPERSONAS
  ,NOM_PERSONA = PV_NOM_PERSONA -- VARCHAR (255)
  ,COD_REPORTPRODUCCION = PI_COD_REPORTPRODUCCION
  ,PROVEEDORES = PV_PROVEEDORES -- VARCHAR (255)
  ,COD_REPORTINVENTARIO = PI_COD_REPORTINVENTARIO
  ,CATEGORIAS = PV_CATEGORIAS -- VARCHAR (255)
  ,COD_REPORTVENTA = PI_COD_REPORTVENTA
  ,COD_REPORTCOMPRA = PI_COD_REPORTCOMPRA
  ,COD_REPORTDISTRIBUCION = PI_COD_REPORTDISTRIBUCION

WHERE COD_REPORTGENERAL = PI_FILA; -- BIGINT (20)
ELSEIF PV_OPERACION = 3 THEN
DELETE FROM REPORTGENERAL
WHERE COD_REPORTGENERAL = PI_FILA;

ELSEIF PV_OPERACION = 4 THEN
SELECT COD_REPORTPERSONAS, NOM_PERSONA, COD_REPORTPRODUCCION, PROVEEDORES, COD_REPORTINVENTARIO, CATEGORIAS, COD_REPORTVENTA, COD_REPORTCOMPRA, COD_REPORTDISTRIBUCION
FROM REPORTGENERAL;       

ELSEIF PV_OPERACION = 5 THEN
SELECT*FROM REPORTGENERAL WHERE COD_REPORTPERSONAS = PI_FILA;

END IF;
COMMIT;
END;


