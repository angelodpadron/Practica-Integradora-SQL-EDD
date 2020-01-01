-- DML

-- a
UPDATE pelicula
SET calificacion = 10
WHERE nombre_director = 'Steve Guttenberg' OR nombre_director = 'Ian Ziering';

-- b
UPDATE pelicula
SET calificacion = 10
WHERE nombre_director IN (SELECT nombre_director FROM director WHERE nacionalidad = 'Argentino');,

--c
DELETE FROM serie
WHERE temporadas < 3; --necesario que la clave foranea de vio_serie que referencie a esta tabla tenga implementado cascade.

-- QUERYS

--a 
SELECT nombre_actor actor, count (id_pelicula) cantidad peliculas
FROM pelicula
WHERE nombre_actor = 'Rose McGowan'
GROUP BY nombre_actor;

--b
SELECT nacionalidad, count (id_pelicula) cantidad_peliculas, ROUND(AVG (calificacion)) calificacion_promedio
FROM (pelicula NATURAL JOIN director)
GROUP BY nacionalidad
HAVING nacionalidad IS NOT NULL; -- evitar tuplas con valores vacios

--c
SELECT nombre_serie, temporadas
FROM (serie NATURAL JOIN director) 
WHERE nombre_director IN (SELECT nombre_director FROM pelicula);

--d
SELECT DISTINCT nombre nombre_actor
FROM (pelicula NATURAL JOIN actor)
WHERE nombre_actor NOT IN (SELECT nombre_actor FROM serie);

--e
SELECT nombre_pelicula, nombre_director, nombre nombre_actor
FROM (pelicula NATURAL JOIN director)
WHERE nombre_actor IN (SELECT actor_fetiche FROM director);

--f
SELECT nombre_serie serie, genero, nombre_usuario visto_por
FROM (vio_serie NATURAL JOIN serie)
WHERE nombre_serie IN (
        SELECT nombre_serie 
	FROM vio_serie 
	WHERE nombre_usuario = 'RossGeller85' OR nombre_usuario = 'BreakingThrones')
ORDER BY serie;

--g
SELECT DISTINCT nombre_usuario, count (id_pelicula) cantidad_de_peliculas_vistas
FROM (vio_pelicula NATURAL JOIN pelicula)
GROUP BY nombre_usuario
ORDER BY count (id_pelicula) DESC;

--h
DELETE FROM usuario
WHERE nombre_usuario = 'DarthVader'; -- necesario que las claves foraneas de vio_pelicula y vio_serie que referencien a esta tabla tengan implementado cascade.

--i 
-- opcion 1
SELECT nombre_director director_que_no_dirigio_peliculas
FROM director
WHERE nombre_director NOT IN (SELECT nombre_director FROM pelicula);
--opcion 2
SELECT director.nombre_director director_que_no_dirigio_peliculas
FROM (director LEFT JOIN pelicula ON director.nombre_director = pelicula.nombre_director)
WHERE pelicula.nombre_director IS NULL;

--j
SELECT nombre, edad
FROM actor
WHERE edad < (SELECT MAX (edad) FROM actor)
ORDER BY edad DESC 
LIMIT 1;

--k
CREATE VIEW otras_mas_vistas AS
SELECT nacionalidad origen_pelicula, count(id_pelicula) veces_vista
FROM (vio_pelicula NATURAL JOIN pelicula NATURAL JOIN director)
WHERE nombre_pelicula NOT IN (SELECT nombre_pelicula FROM pelicula NATURAL JOIN director WHERE nacionalidad = 'Estadounidense')
GROUP BY nacionalidad
ORDER BY veces_vista DESC
LIMIT 3;
