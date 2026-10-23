<?php
// cursos.php
header("Content-Type: application/json; charset=UTF-8");
require_once "config/conexion.php";

$id_carrera = isset($_GET['id_carrera']) ? intval($_GET['id_carrera']) : 0;

try {
    if ($id_carrera > 0) {
        $stmt = $pdo->prepare("SELECT id_curso, id_carrera, codigo_curso, nombre_curso, espacio, url_imagen_principal FROM cursos WHERE id_carrera = ?");
        $stmt->execute([$id_carrera]);
    } else {
        $stmt = $pdo->query("SELECT id_curso, id_carrera, codigo_curso, nombre_curso, espacio, url_imagen_principal FROM cursos");
    }

    $cursos = $stmt->fetchAll();

    // Casteo de tipos para que coincidan con la data class de Kotlin
    foreach ($cursos as &$c) {
        $c['id_curso'] = (int)$c['id_curso'];
        $c['id_carrera'] = (int)$c['id_carrera'];
    }

    echo json_encode($cursos);
} catch (Exception $e) {
    header("HTTP/1.1 500 Internal Server Error");
    echo json_encode(["error" => "Error al obtener los cursos: " . $e->getMessage()]);
}
?>
