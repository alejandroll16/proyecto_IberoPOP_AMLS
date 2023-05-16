-----------------------------------------------------------------------------
/*Proyecto IBEROPOP Grupo K, por Alejandro Manuel Lluch Sánchez 1º DAW*/ 
-----------------------------------------------------------------------------

/*Creamos las tablas con las sentencias de la base de datos del proyecto IBEROPOP*/

CREATE TABLE PROYECTO_usuario(
    codigo NUMBER(20) PRIMARY KEY,
    email VARCHAR2(50) UNIQUE,
    nombre_Apellidos VARCHAR2(100),
    contr VARCHAR2(30) NOT NULL,
    tel NUMBER(12) NOT NULL,
    fNacimiento DATE NOT NULL,
    ult_conex DATE NOT NULL,
    tipo_Usuario VARCHAR2(10) CHECK (tipo_Usuario IN('Cliente', 'Admin', 'Anonimo'))
    
    
);


CREATE TABLE PROYECTO_categorias(
    codigo NUMBER(20) PRIMARY KEY,
    nombre VARCHAR2(100) 
);

CREATE TABLE PROYECTO_productos(
    codigo NUMBER(20) PRIMARY KEY,
    categoria NUMBER(20),
    usuario_crea NUMBER(20),
    usuario_modifica NUMBER(20),
    f_creac DATE,
    f_ult_modificacion DATE,
    nombre VARCHAR2(100),
    precio NUMBER(6,2),
    IVA NUMBER (4,2),
    descrip_caract VARCHAR2(300),
    tipo_tamano VARCHAR2(10) CHECK (tipo_tamano IN ('Regular', 'Super', 'Jumbo', 'Mega')),
    tipo_producto VARCHAR2(30) CHECK (tipo_producto IN ('funkoConvencion', 'funkoEdicionEspecial', 'funkoNormal')),
    
    CONSTRAINT fk_pertenece FOREIGN KEY (categoria) REFERENCES PROYECTO_categorias,
    CONSTRAINT fk_crea FOREIGN KEY (usuario_crea) REFERENCES PROYECTO_usuario,
    CONSTRAINT fk_modifica FOREIGN KEY (usuario_modifica) REFERENCES PROYECTO_usuario

);

CREATE TABLE PROYECTO_direccion(
    numero NUMBER (20),
    usuario NUMBER (20),
    direccion VARCHAR2 (30),
    poblacion VARCHAR2 (20),
    c_postal NUMBER (6),
    c_autonoma VARCHAR2(50) CHECK (c_autonoma IN ('COMUNIDADVALENCIANA', 'CATALUÑA', 'MADRID', 'ANDALUCIA', 'GALICIA', 'ARAGON', 'MURCIA', 'CASTILLALEON', 'CASTILLALAMANCHA', 
    'PAISVASCO', 'ASTURIAS', 'CANTABRIA', 'NAVARRA', 'LARIOJA', 'EXTREMADURA', 'CEUTA', 'MELILLA')),

    CONSTRAINT pk_dir_usuario PRIMARY KEY (numero, usuario),
    CONSTRAINT fk_dir_usuario FOREIGN KEY (usuario) REFERENCES PROYECTO_usuario
);

CREATE TABLE PROYECTO_pedido(
    codigo NUMBER (20) PRIMARY KEY,
    usuario NUMBER(20) NOT NULL,
    usuario_direc NUMBER (20) NOT NULL,
    numero_direc NUMBER(20) NOT NULL,
    fecha DATE,
    precio_total NUMBER(6,2),
    tipo_pago VARCHAR2(30) CHECK (tipo_pago IN ('TARJETA', 'PAYPAL')),
    
    CONSTRAINT fk_crea_pedido FOREIGN KEY (usuario) REFERENCES PROYECTO_usuario,
    CONSTRAINT fk_dir_pedido FOREIGN KEY (numero_direc, usuario_direc) REFERENCES PROYECTO_direccion
);

CREATE TABLE PROYECTO_linea_pedido(
    producto NUMBER(20),
    pedido NUMBER(20),
    cantidad NUMBER(10),
    precio_producto NUMBER(6,2),
    
    CONSTRAINT pk_añade PRIMARY KEY (producto, pedido),
    CONSTRAINT fk_ped_prod FOREIGN KEY (producto) REFERENCES PROYECTO_productos,
    CONSTRAINT fk_añade FOREIGN KEY (pedido) REFERENCES PROYECTO_pedido
);

CREATE TABLE PROYECTO_factura(
    codigo NUMBER(20) PRIMARY KEY,
    usuario NUMBER(20),
    pedido NUMBER(20),
    numero_direc NUMBER (20),
    fecha DATE,
    
    CONSTRAINT fk_dir_factura FOREIGN KEY (numero_direc, usuario) REFERENCES PROYECTO_direccion,
    CONSTRAINT fk_genera FOREIGN KEY (pedido) REFERENCES PROYECTO_pedido
);

ALTER TABLE PROYECTO_usuario MODIFY (nombre_Apellidos VARCHAR2(120));
ALTER TABLE PROYECTO_productos ADD (CONSTRAINT limite_IVA CHECK(IVA BETWEEN 0 AND 100));



/* a) Inserta los datos de todas las tablas. Para empezar, puedes insertar 3-4 datos en cada una de las tablas y ya más adelante insertaremos más datos.
Igual que hicimos en listas, insertamos todos los valores de los atributos de las tablas, llevando cuidado del orden y las limitaciones expecificadas en las tablas de arriba.
*/

INSERT INTO PROYECTO_usuario(codigo, email, nombre_Apellidos, contr, tel, fNacimiento,ult_conex, tipo_Usuario) VALUES 
(1, 'usuario1@gmail.com','Alejandro Manuel Lluch','Alejandro123',622123622,to_date('16-02-1995','dd-mm-yyyy'), SYSDATE, 'Admin');
INSERT INTO PROYECTO_usuario(codigo, email, nombre_Apellidos, contr, tel, fNacimiento,ult_conex, tipo_Usuario) VALUES 
(2, 'usuario2@gmail.com','Marta Gonzalez','Marta123',612153682,to_date('12-02-1985','dd-mm-yyyy'), SYSDATE, 'Cliente');
INSERT INTO PROYECTO_usuario(codigo, email, nombre_Apellidos, contr, tel, fNacimiento,ult_conex, tipo_Usuario) VALUES 
(3, 'usuario3@gmail.com','Jose Luis Martinez ','Jose123',623322528,to_date('31-01-2001','dd-mm-yyyy'), SYSDATE, 'Cliente');
INSERT INTO PROYECTO_usuario(codigo, email, nombre_Apellidos, contr, tel, fNacimiento,ult_conex, tipo_Usuario) VALUES 
(4, 'usuario4@gmail.com','Pedro Javier Medina ','Pedro123',623442523,to_date('22-11-1993','dd-mm-yyyy'), SYSDATE, 'Admin');

INSERT INTO PROYECTO_categorias(codigo, nombre) VALUES (1,'Marvel');
INSERT INTO PROYECTO_categorias(codigo, nombre) VALUES (2,'Anime');
INSERT INTO PROYECTO_categorias(codigo, nombre) VALUES (3,'Series y Películas');
INSERT INTO PROYECTO_categorias(codigo, nombre) VALUES (4,'Deportes');
INSERT INTO PROYECTO_categorias(codigo, nombre) VALUES (5,'Disney');


INSERT INTO PROYECTO_productos(codigo, categoria, usuario_crea, usuario_modifica, f_creac, f_ult_modificacion, nombre, precio, IVA,  descrip_caract, tipo_producto, tipo_tamano) VALUES
(1, 2, 1, 1, to_date('21-01-2022','dd-mm-yyyy'), to_date('11-11-2022','dd-mm-yyyy'), 'Funko Luffy One Piece ', 14.95, 21, 'De la famosa serie One Piece','funkoNormal', 'Super');
INSERT INTO PROYECTO_productos(codigo, categoria, usuario_crea, usuario_modifica, f_creac, f_ult_modificacion, nombre, precio, IVA,  descrip_caract, tipo_producto, tipo_tamano) VALUES 
(2, 1, 1, 1, to_date('02-06-2022','dd-mm-yyyy'), to_date('08-01-2023','dd-mm-yyyy'), 'Funko Spider-Man Marvel', 14.95, 21, 'De comics y películas Marvel','funkoNormal', 'Jumbo');
INSERT INTO PROYECTO_productos(codigo, categoria, usuario_crea, usuario_modifica, f_creac, f_ult_modificacion, nombre, precio, IVA,   descrip_caract, tipo_producto, tipo_tamano) VALUES 
(3, 3, 1, 1, to_date('16-01-2022','dd-mm-yyyy'), to_date('10-02-2023','dd-mm-yyyy'), 'Funko Harry Potter Harry Potter', 19.95, 21, 'De la saga de libros de Harry Potter', 'funkoConvencion','Regular');
INSERT INTO PROYECTO_productos(codigo, categoria, usuario_crea, usuario_modifica, f_creac, f_ult_modificacion, nombre, precio, IVA,  descrip_caract, tipo_producto, tipo_tamano) VALUES
(4, 1, 1, 1, to_date('22-02-2023','dd-mm-yyyy'), to_date('22-01-2023','dd-mm-yyyy'), 'Funko Capitán América', 14.95, 21, 'El comandate de los Avengers ha llegado', 'funkoNormal', 'Regular');
INSERT INTO PROYECTO_productos(codigo, categoria, usuario_crea, usuario_modifica, f_creac, f_ult_modificacion, nombre, precio, IVA,  descrip_caract, tipo_producto, tipo_tamano) VALUES
(5, 4, 1, 1, to_date('22-02-2023','dd-mm-yyyy'), to_date('22-01-2023','dd-mm-yyyy'), 'Funko Michael Jordan', 19.95, 21, 'El histórico 23 de los Bulls viene haciendo mates', 'funkoEdicionEspecial', 'Regular');
INSERT INTO PROYECTO_productos(codigo, categoria, usuario_crea, usuario_modifica, f_creac, f_ult_modificacion, nombre, precio, IVA,  descrip_caract, tipo_producto, tipo_tamano) VALUES
(6, 2, 4, 4, to_date('25-03-2023','dd-mm-yyyy'), to_date('25-03-2023','dd-mm-yyyy'), 'Funko Son Goku', 14.95, 21, 'El Saiyan mas poderoso', 'funkoNormal', 'Mega');
INSERT INTO PROYECTO_productos(codigo, categoria, usuario_crea, usuario_modifica, f_creac, f_ult_modificacion, nombre, precio, IVA,  descrip_caract, tipo_producto, tipo_tamano) VALUES
(7, 1, 4, 4, to_date('17-04-2023','dd-mm-yyyy'), to_date('17-04-2023','dd-mm-yyyy'), 'Funko Loki', 19.95, 21, 'El villado más querido', 'funkoEdicionEspecial', 'Regular');



INSERT INTO PROYECTO_direccion(numero, usuario, direccion, poblacion, c_postal, c_autonoma) VALUES
(1, 2, 'C/Velazquez Nº2', 'Alicante', '03005', 'CATALUÑA');
INSERT INTO PROYECTO_direccion(numero, usuario, direccion, poblacion, c_postal, c_autonoma) VALUES
(2, 3, 'C/Aragon Nº70', 'Elda', '03600', 'MADRID');

INSERT INTO PROYECTO_pedido(codigo, usuario, usuario_direc, numero_direc, fecha, precio_total, tipo_pago) VALUES
(1, 2, 2, 1 , to_date('12-01-2023','dd-mm-yyyy') , 19.95, 'TARJETA');
INSERT INTO PROYECTO_pedido(codigo, usuario, usuario_direc, numero_direc, fecha, precio_total, tipo_pago) VALUES
(2, 3, 3, 2 , to_date('05-08-2022','dd-mm-yyyy') , 14.95, 'PAYPAL');


INSERT INTO PROYECTO_linea_pedido(producto, pedido, cantidad, precio_producto) VALUES
(1, 2, 1, 14.95);
INSERT INTO PROYECTO_linea_pedido(producto, pedido, cantidad, precio_producto) VALUES
(3, 1, 1, 19.95);


INSERT INTO PROYECTO_factura(codigo,usuario, pedido, numero_direc, fecha) VALUES
(1, 2, 1,1, to_date('12-01-2023','dd-mm-yyyy'));
INSERT INTO PROYECTO_factura(codigo,usuario, pedido, numero_direc ,fecha) VALUES
(2, 3, 2,2, to_date('05-08-2022','dd-mm-yyyy'));


/* b)Realiza 3 actualizaciones al menos.
Actualizo mediante UPDATE 3 atributos que podrían tener que cambiarse de verdad por errores, como son nommbres, direcciones..etc.
*/


UPDATE PROYECTO_categorias SET nombre = 'Super Heroes' WHERE codigo = '1';
UPDATE PROYECTO_usuario SET nombre_Apellidos = 'Irene Rodriguez' WHERE codigo = '2';
UPDATE PROYECTO_direccion SET c_postal = '03002' WHERE usuario = '2' AND numero = 1;

/* c)Realiza 2 borrados al menos. 
Al realizar el borrado hay que tener en cuenta que no nos van a dejar si este hace referencia a otro, por ello podemos borrar igual que haríamos con drop table, en orden.
*/

DELETE FROM PROYECTO_factura WHERE pedido = '1';


/* Creamos el borrado de tablas mediante DROP TABLE en el orden correcto*/

DROP TABLE proyecto_factura;
DROP TABLE PROYECTO_linea_pedido;
DROP TABLE proyecto_pedido;
DROP TABLE proyecto_direccion;
DROP TABLE proyecto_productos;
DROP TABLE proyecto_categorias;
DROP TABLE proyecto_usuario;