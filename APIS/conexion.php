<?php
$host = "localhost";
$db   = "cursos_db";
$user = "root"; // Cambia esto si tu MySQL tiene otro usuario
$pass = "";     // Cambia esto si tu MySQL tiene contraseña

try {
    // Conexión con charset utf8 para tildes y ñ
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    // Lanzar excepciones si hay error en los queries
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // Devolver los datos como array asociativo
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    header("Content-Type: application/json", true, 500);
    echo json_encode([
        "error"   => "Error crítico de conexión al servidor",
        "detalle" => $e->getMessage()
    ]);
    exit;
}
?>