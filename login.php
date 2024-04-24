<?php

session_start();

require_once 'db_connection.php';

////////////////////////////////////////////////////////////////////////////////////////////////////CONNEXION
// Vérifier si le formulaire a été soumis
if($_SERVER['REQUEST_METHOD'] == "POST" && isset($_POST['login'])) {
    // Récupérer les données du formulaire
    $pseudo = $_POST['pseudo'];
    $motdepasse = $_POST['motdepasse'];

    // Vérifier si les champs ne sont pas vides
    if(!empty($pseudo) && !empty($motdepasse)) {
        try {
            // Préparation de la requête pour récupérer l'utilisateur de la base de données
            $query = "SELECT * FROM Utilisateurs WHERE pseudo = :pseudo LIMIT 1";
            $statement = $connection->prepare($query);
            $statement->bindParam(':pseudo', $pseudo);
            $statement->execute();
            $user_data = $statement->fetch(PDO::FETCH_ASSOC);

            // Vérifier si un utilisateur a été trouvé
            if($user_data) {
                // Vérifier si le mot de passe correspond
                if(password_verify($motdepasse, $user_data['motdepasse'])) {
                    // Enregistrement de l'ID de l'utilisateur dans la session
                    $_SESSION['user_id'] = $user_data['id'];
                    
                    // Redirection vers la page principale
                    header('Location: Recettesphp.php');
                    exit; // Arrêter l'exécution du script après la redirection
                } else {
                    echo "Nom d'utilisateur ou mot de passe incorrect !";
                }
            } else {
                echo "Nom d'utilisateur ou mot de passe incorrect !";
            }
        } catch (PDOException $e) {
            // Gérer les erreurs de base de données
            echo "Erreur de base de données : " . $e->getMessage();
        }
    } else {
        echo "Nom d'utilisateur ou mot de passe vide !";
    }
}
