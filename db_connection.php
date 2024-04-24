<?php
// Inclusion de la classe Dotenv pour charger les variables d'environnement depuis le fichier .env
require_once __DIR__.'/vendor/autoload.php';

use Symfony\Component\Dotenv\Dotenv;

// Initialisation de Dotenv pour charger les variables d'environnement
$dotenv = new Dotenv();
$dotenv->load(__DIR__.'/.env');

// Récupération des informations de la base de données depuis les variables d'environnement
$servername = $_ENV['DATABASE_HOSTNAME'];
$username = $_ENV['DATABASE_USERNAME'];
$password = $_ENV['DATABASE_PASSWORD'];
$database = $_ENV['DATABASE_NAME'];

try {
    // Connexion à la base de données MySQL en utilisant PDO
    $connection = new PDO("mysql:host=$servername;dbname=$database", $username, $password);
    // Configuration de PDO pour afficher les erreurs en mode exception
    $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    
} catch (PDOException $error) {
    // Gestion des erreurs PDO
    echo "Il y a une erreur : " . $error->getMessage();
}
?>