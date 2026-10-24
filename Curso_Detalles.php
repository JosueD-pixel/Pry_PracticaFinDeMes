
<?php
// Curso_detalle.php
header("Content-Type: application/json; charset=UTF-8");
require_once "config/conexion.php";

$id_curso = isset($_GET['id_curso']) ? intval($_GET['id_curso']) : 0;

if ($id_curso <= 0) {
    header("HTTP/1.1 400 Bad Request");
    echo json_encode(["error" => "El ID del curso proporcionado no es válido"]);
    exit;
}

try {
    // 1. Consultar únicamente las columnas necesarias del curso para la vista detalle
    $stmtCurso = $pdo->prepare("
        SELECT id_curso, id_carrera, codigo_curso, nombre_curso, descripcion, 
               espacio, total_horas, dias_atencion, horario, cupo, url_imagen_principal 
        FROM cursos 
        WHERE id_curso = ?
    ");
    $stmtCurso->execute([$id_curso]);
    $curso = $stmtCurso->fetch();

    if (!$curso) {
        header("HTTP/1.1 404 Not Found");
        echo json_encode(["error" => "El curso no existe"]);
        exit;
    }

    // 2. Consultar las imágenes secundarias de la galería
    $stmtImgs = $pdo->prepare("SELECT id_imagen, id_curso, url_imagen FROM imagenes_curso WHERE id_curso = ?");
    $stmtImgs->execute([$id_curso]);
    $imagenes = $stmtImgs->fetchAll();

    // Casteo de tipos para las imágenes secundarias
    foreach ($imagenes as &$img) {
        $img['id_imagen'] = (int)$img['id_imagen'];
        $img['id_curso'] = (int)$img['id_curso'];
    }
    unset($img);

    // 3. Casteo de tipos numéricos y nulos del curso principal
    $curso['id_curso'] = (int)$curso['id_curso'];
    $curso['id_carrera'] = (int)$curso['id_carrera'];
    $curso['total_horas'] = $curso['total_horas'] !== null ? (int)$curso['total_horas'] : null;
    $curso['cupo'] = (int)$curso['cupo'];

    // 4. Adjuntar el arreglo de imágenes
    $curso['imagenes_curso'] = $imagenes;

    // 5. Respuesta JSON limpia
    echo json_encode($curso, JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    header("HTTP/1.1 500 Internal Server Error");
    // Mensaje fijo sin exponer detalles internos de la base de datos
    echo json_encode(["error" => "Ocurrió un error al procesar la solicitud"]);
}
?>