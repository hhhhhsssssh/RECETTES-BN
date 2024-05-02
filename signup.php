<?php
session_start(); // Démarrer la session

require_once 'db_connection.php';

/////////////////////////////////////////////////////////////////////////////////////////////////INSCRIPTION
// Vérifier si le formulaire d'inscription a été soumis
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Vérifier si tous les champs sont renseignés
    if (isset($_POST['new-username']) && isset($_POST['new-email']) && isset($_POST['new-password'])) {
        // Récupérer les données du formulaire
        $new_username = $_POST['new-username'];
        $new_email = $_POST['new-email'];
        $new_password = $_POST['new-password'];

         // Hacher le mot de passe
         $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

 
         try {
            // Préparation de la requête d'insertion
            $query = "INSERT INTO utilisateurs (pseudo, email, motdepasse) VALUES (:username, :email, :password)";
            $statement = $connection->prepare($query);

            // Liaison des valeurs aux paramètres de la requête
            $statement->bindParam(':username', $new_username);
            $statement->bindParam(':email', $new_email);
            $statement->bindParam(':password', $hashed_password);

           // Exécution de la requête
           if ($statement->execute()) {
            // Enregistrement de l'ID de l'utilisateur dans la session
            $_SESSION['user_id'] = $connection->lastInsertId();

            // Stocker le pseudo dans une variable de session
            $_SESSION['new_username'] = $new_username;

            // Rediriger vers la page d'accueil avec un paramètre pour indiquer une inscription réussie
            header('Location: index.php?inscription_reussie=true');
            exit; // Arrêter l'exécution du script après la redirection
        } else {
            echo "Erreur lors de l'inscription.";
        }
    } catch (PDOException $e) {
        echo "Erreur lors de l'inscription: " . $e->getMessage();
    }
} else {
    echo "Tous les champs doivent être remplis.";
}
}
?>