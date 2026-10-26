-- =====================================================
-- Proyecto: Sistema de Gestión Deportiva
-- Archivo: consultas.sql
-- Motor: MySQL
-- Descripción: Consultas para gestionar jugadores,
-- categorías, entrenamientos y evaluaciones.
-- =====================================================


-- 1. ¿Qué jugadores pertenecen a cada categoría?
-- Se utiliza la categoría registrada en sus evaluaciones.

SELECT DISTINCT
    j.ID_Jugador,
    j.Nombre,
    j.Apellido,
    c.Nombre AS Categoria
FROM Jugadores j
INNER JOIN Prueba p
    ON j.ID_Jugador = p.ID_Jugador
INNER JOIN Evaluacion e
    ON p.ID_Prueba = e.ID_Prueba
INNER JOIN Categorias c
    ON e.ID_Categoria = c.ID_Categoria
ORDER BY c.Nombre, j.Apellido;


-- 2. ¿Qué entrenamientos tiene asignado cada jugador?

SELECT
    j.ID_Jugador,
    j.Nombre,
    j.Apellido,
    en.Fecha,
    en.Tipo,
    en.Intensidad
FROM Jugadores j
INNER JOIN Jugador_Entrenamiento je
    ON j.ID_Jugador = je.ID_Jugador
INNER JOIN Entrenamiento en
    ON je.ID_Entrenamiento = en.ID_Entrenamiento
ORDER BY j.Apellido, en.Fecha;


-- 3. ¿Qué entrenadores están asignados a cada categoría?

SELECT
    c.Nombre AS Categoria,
    en.Nombre,
    en.Apellido
FROM Categorias c
INNER JOIN Categoria_Entrenador ce
    ON c.ID_Categoria = ce.ID_Categoria
INNER JOIN Entrenador en
    ON ce.ID_Entrenador = en.ID_Entrenador
ORDER BY c.Nombre, en.Apellido;


-- 4. ¿Qué evaluación obtuvo un jugador determinado?
-- Reemplazar el 1 por el ID del jugador que se desea consultar.

SELECT
    j.Nombre,
    j.Apellido,
    p.Fecha AS Fecha_Prueba,
    p.Tipo AS Tipo_Prueba,
    e.Puntaje,
    e.Resultado,
    c.Nombre AS Categoria
FROM Jugadores j
INNER JOIN Prueba p
    ON j.ID_Jugador = p.ID_Jugador
INNER JOIN Evaluacion e
    ON p.ID_Prueba = e.ID_Prueba
INNER JOIN Categorias c
    ON e.ID_Categoria = c.ID_Categoria
WHERE j.ID_Jugador = 1
ORDER BY p.Fecha DESC;


-- 5. ¿Cuál es el rendimiento físico de cada jugador?
-- Se consulta la información registrada en el historial.

SELECT
    j.ID_Jugador,
    j.Nombre,
    j.Apellido,
    h.Fecha,
    h.Rendimiento,
    h.Observacion
FROM Jugadores j
INNER JOIN Historial h
    ON j.ID_Jugador = h.ID_Jugador
ORDER BY j.Apellido, h.Fecha DESC;


-- 6. ¿Qué jugadores obtuvieron los mejores resultados
-- en las evaluaciones?

SELECT
    j.Nombre,
    j.Apellido,
    p.Tipo AS Tipo_Prueba,
    e.Puntaje,
    e.Resultado
FROM Jugadores j
INNER JOIN Prueba p
    ON j.ID_Jugador = p.ID_Jugador
INNER JOIN Evaluacion e
    ON p.ID_Prueba = e.ID_Prueba
ORDER BY e.Resultado DESC, e.Puntaje DESC;


-- 7. ¿Qué habilidades se evaluaron en cada prueba?

SELECT
    p.ID_Prueba,
    p.Fecha,
    p.Tipo AS Tipo_Prueba,
    h.Nombre AS Habilidad
FROM Prueba p
INNER JOIN Prueba_Habilidad ph
    ON p.ID_Prueba = ph.ID_Prueba
INNER JOIN Habilidad h
    ON ph.ID_Habilidad = h.ID_Habilidad
ORDER BY p.ID_Prueba, h.Nombre;


-- 8. ¿Qué jugadores tienen los resultados más bajos
-- en pruebas asociadas a una determinada habilidad?
-- Los resultados bajos pueden orientar una revisión
-- del rendimiento; no determinan por sí solos una necesidad.

SELECT
    j.Nombre,
    j.Apellido,
    h.Nombre AS Habilidad,
    e.Resultado,
    p.Fecha
FROM Jugadores j
INNER JOIN Prueba p
    ON j.ID_Jugador = p.ID_Jugador
INNER JOIN Evaluacion e
    ON p.ID_Prueba = e.ID_Prueba
INNER JOIN Prueba_Habilidad ph
    ON p.ID_Prueba = ph.ID_Prueba
INNER JOIN Habilidad h
    ON ph.ID_Habilidad = h.ID_Habilidad
WHERE e.Resultado IS NOT NULL
ORDER BY h.Nombre, e.Resultado ASC;


-- 9. ¿Qué intensidad tiene asignada cada entrenamiento?

SELECT
    ID_Entrenamiento,
    Fecha,
    Tipo,
    Duracion,
    Intensidad
FROM Entrenamiento
ORDER BY Fecha;


-- 10. ¿Cuáles fueron los resultados de un jugador
-- en sus últimas evaluaciones?
-- Reemplazar el 1 por el ID del jugador deseado.

SELECT
    j.Nombre,
    j.Apellido,
    p.Fecha,
    p.Tipo AS Tipo_Prueba,
    e.Puntaje,
    e.Resultado
FROM Jugadores j
INNER JOIN Prueba p
    ON j.ID_Jugador = p.ID_Jugador
INNER JOIN Evaluacion e
    ON p.ID_Prueba = e.ID_Prueba
WHERE j.ID_Jugador = 1
ORDER BY p.Fecha DESC, e.ID_Evaluacion DESC;
