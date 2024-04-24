<?php
session_start();

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    // Rediriger l'utilisateur vers la page de connexion s'il n'est pas connecté
    header("Location: login.php");
    exit; // Arrêter l'exécution du script après la redirection
}

// Inclure le fichier de connexion à la base de données
include 'db_connection.php';

// Vérifier si la connexion à la base de données est établie avec succès
if (!$connection) {
    die("La connexion à la base de données a échoué.");
}

// Récupérer l'identifiant de l'utilisateur connecté à partir de la session
$user_id = $_SESSION['user_id'];

// Préparation de la requête SQL pour sélectionner les recettes de l'utilisateur connecté
$requete_selection_recettes_utilisateur = $connection->prepare("SELECT * FROM Recettes WHERE Utilisateurs_id = :user_id");

// Liaison des paramètres avec les valeurs
$requete_selection_recettes_utilisateur->bindParam(':user_id', $user_id);

// Exécution de la requête SQL pour sélectionner les recettes de l'utilisateur connecté
$requete_selection_recettes_utilisateur->execute();

// Récupération de toutes les recettes de l'utilisateur connecté sous forme de tableau associatif
$recettes_utilisateur = $requete_selection_recettes_utilisateur->fetchAll(PDO::FETCH_ASSOC);

// Gestion de la soumission du formulaire de modification de recette
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['modifier_recette'])) {
        // Récupérer les données du formulaire de modification
        $recette_id = $_POST['recette_id'];
        $nouveau_titre = $_POST['nouveau_titre'];
        $nouveau_contenu = $_POST['nouveau_contenu'];

        // Préparation de la requête SQL pour mettre à jour la recette
        $requete_modification_recette = $connection->prepare("UPDATE Recettes SET titre = :nouveau_titre, contenu = :nouveau_contenu WHERE id = :recette_id");

        // Liaison des paramètres avec les valeurs
        $requete_modification_recette->bindParam(':nouveau_titre', $nouveau_titre);
        $requete_modification_recette->bindParam(':nouveau_contenu', $nouveau_contenu);
        $requete_modification_recette->bindParam(':recette_id', $recette_id);

        // Exécution de la requête SQL pour mettre à jour la recette
        $requete_modification_recette->execute();

        // Redirection vers la page actuelle pour actualiser les données
        header("Location: MyRecettes.php");
        exit;
        
    } elseif (isset($_POST['supprimer_recette'])) {
        // Récupérer l'identifiant de la recette à supprimer
        $recette_id = $_POST['recette_id'];

        // Préparation de la requête SQL pour supprimer la recette
        $requete_suppression_recette = $connection->prepare("DELETE FROM Recettes WHERE id = :recette_id");

        // Liaison des paramètres avec les valeurs
        $requete_suppression_recette->bindParam(':recette_id', $recette_id);

        // Exécution de la requête SQL pour supprimer la recette
        $requete_suppression_recette->execute();

        // Redirection vers la page actuelle pour actualiser les données
        header("Location: MyRecettes.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="stylemyrecettes.css" rel="stylesheet">
    <title>Mes Recettes</title>
</head>
<body>
    <h1>Mes Recettes</h1>

    <!-- Afficher les recettes de l'utilisateur connecté -->
    <ul>
        <?php foreach ($recettes_utilisateur as $recette) : ?>
            <li>
                <h2><?= $recette['titre'] ?></h2>
                <p><?= $recette['contenu'] ?></p>
                <!-- Bouton pour modifier la recette -->
                <button onclick="afficherFormulaire('modifier', <?= $recette['id'] ?>)">Modifier</button>
                <!-- Bouton pour supprimer la recette -->
                <button onclick="afficherFormulaire('supprimer', <?= $recette['id'] ?>)">Supprimer</button>
                
                <!-- Formulaire pour modifier la recette -->
                <form id="form-modifier-<?= $recette['id'] ?>"  method="POST" style="display: none;">
                    <input type="hidden" name="recette_id" value="<?= $recette['id'] ?>">
                    <input type="text" name="nouveau_titre" placeholder="Nouveau titre">
                    <textarea name="nouveau_contenu" placeholder="Nouveau contenu"></textarea>
                    <input type="submit" value="Enregistrer" name="modifier_recette">
                </form>
                <!-- Formulaire pour supprimer la recette -->
                <form id="form-supprimer-<?= $recette['id'] ?>"  method="POST" style="display: none;">
                    <input type="hidden" name="recette_id" value="<?= $recette['id'] ?>">
                    <input type="submit" name="confirmation" value="Oui" name="supprimer_recette">
                    <button onclick="annulerSuppression(<?= $recette['id'] ?>)">Non</button>
                </form>
            </li>
        <?php endforeach; ?>
    </ul>

    <!-- Lien pour ajouter une nouvelle recette -->
    <a href="Recettesphp.php">Ajouter une nouvelle recette</a>

    <!-- Script pour afficher les formulaires correspondants -->
    <script>
        function afficherFormulaire(type, recetteId) {
            var formModifier = document.getElementById("form-modifier-" + recetteId);
            var formSupprimer = document.getElementById("form-supprimer-" + recetteId);
            
            if (type === 'modifier') {
                // Afficher le formulaire de modification et cacher le formulaire de suppression
                formModifier.style.display = "block";
                formSupprimer.style.display = "none";
            } else if (type === 'supprimer') {
                // Afficher le formulaire de suppression et cacher le formulaire de modification
                formSupprimer.style.display = "block";
                formModifier.style.display = "none";
            }
        }

        function annulerSuppression(recetteId) {
            var formSupprimer = document.getElementById("form-supprimer-" + recetteId);
            formSupprimer.style.display = "none";
            // Rafraîchir la page pour annuler l'action de suppression
            location.reload();
        }
    </script>

</body>
</html>