USE BI_tienda_online;
GO

SELECT*FROM dim_clientes;
SELECT*FROM dim_productos;
SELECT*FROM dim_tiempo;
SELECT*FROM hechos_pedidos;

USE pedan_tienda_online;
GO

-- Consulta para poblar la dimensión Clientes
SELECT 
	id AS 'cliente_id',
	numero_documento,
	CONCAT(nombres,' ', apellidos) AS 'nombres',
	direccion_envio
FROM clientes;

-- Consulta para poblar la dimensión productos

SELECT
	p.id AS 'producto_id',
	c.nombre AS 'categoria_producto',
	p.nombre AS 'nombre_producto',
	p.precio AS 'precio_lista',
	p.stock 
FROM productos p
INNER JOIN categorias c ON c.id=p.categoria_id;

-- Consulta para poblar la Dimensión Tiempo

SELECT DISTINCT
	fecha_pedido,
	YEAR(fecha_pedido) AS 'anio',
	MONTH(fecha_pedido) AS 'mes',
	DAY(fecha_pedido) AS 'dia',
	DATENAME(MONTH,fecha_pedido) AS 'nombre_mes',
	DATENAME(DAY,fecha_pedido) AS 'nombre_dia'
FROM pedidos;

-- Consulta para poblar la tabla hechos_pedidos

SELECT
	c.id AS 'cliente_id',
	pr.id AS 'producto_id',
	p.fecha_pedido AS 'dim_tiempo_id',
	SUM(dp.cantidad) AS 'cantidad_producto',
	SUM(dp.precio_venta) AS 'precio_venta'
FROM detalle_pedidos dp
	INNER JOIN pedidos p ON p.id=dp.pedido_id
	INNER JOIN clientes c ON c.id=p.cliente_id
	INNER JOIN productos pr ON pr.id=dp.producto_id
GROUP BY c.id,pr.id,p.fecha_pedido;

