<?php
session_start();

// Inclure le fichier de connexion à la base de données
include 'db_connection.php';

// Vérifier si la connexion à la base de données est établie avec succès
if (!$connection) {
    die("La connexion à la base de données a échoué.");
}

// Gestion de la soumission des formulaires
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['submit_recipe'])) {
        // Récupération des données du formulaire pour ajouter une recette
        $titre_recette = $_POST['titre'];
        $lien_photo_recette = $_POST['lien_photo'];
        $contenu_recette = $_POST['contenu'];

        // Assurez-vous que l'ID de l'utilisateur est correctement défini dans la session
        if (isset($_SESSION['user_id'])) {
            $utilisateur_id = $_SESSION['user_id'];

             // Génération de la date actuelle au format SQL
             $jour_post = date("Y-m-d");

            // Vérifiez si les champs ne sont pas vides
            if (!empty($titre_recette) && !empty($lien_photo_recette) && !empty($contenu_recette)) {
                try {
                    // Préparation de la requête pour insérer une nouvelle recette dans la base de données
                    $requete_insertion_recette = $connection->prepare("INSERT INTO Recettes (titre, `lien-photo`, contenu, `jour-post`, Utilisateurs_id) VALUES (:titre, :lien_photo, :contenu, :jour_post, :utilisateur_id)");
                    $requete_insertion_recette->bindParam(':titre', $titre_recette);
                    $requete_insertion_recette->bindParam(':lien_photo', $lien_photo_recette);
                    $requete_insertion_recette->bindParam(':contenu', $contenu_recette);
                    $requete_insertion_recette->bindParam(':jour_post', $jour_post);
                    $requete_insertion_recette->bindParam(':utilisateur_id', $utilisateur_id);
                    $requete_insertion_recette->execute();

                    echo "Recette ajoutée avec succès !";
                } catch (PDOException $e) {
                    // Gérer les erreurs de base de données
                    echo "Erreur de base de données : " . $e->getMessage();
                }
            } else {
                echo "Veuillez remplir tous les champs du formulaire de recette.";
            }
        } else {
            echo "Impossible de récupérer l'ID de l'utilisateur pour ajouter une recette.";
        }
    } elseif (isset($_POST['submit_comment'])) {
        // Récupération des données du formulaire pour ajouter un commentaire
        $nouveau_commentaire = $_POST['commentaire'];
        $recette_id = $_POST['recette_id'];

        // Assurez-vous que l'ID de l'utilisateur est correctement défini dans la session
        if (isset($_SESSION['user_id'])) {
            $utilisateur_id = $_SESSION['user_id'];

                // Génération de la date actuelle au format SQL
                $jour_comment = date("Y-m-d");

            // Vérifiez si le commentaire n'est pas vide
            if (!empty($nouveau_commentaire)) {
                try {
                   // Préparation de la requête pour insérer un nouveau commentaire dans la base de données
                    $requete_insertion_commentaire = $connection->prepare("INSERT INTO Commentaires (commentaire, Utilisateurs_id, Recettes_id, `jour-comment`) VALUES (:commentaire, :utilisateur_id, :recette_id, :jour_comment)");
                    $requete_insertion_commentaire->bindParam(':commentaire', $nouveau_commentaire);
                    $requete_insertion_commentaire->bindParam(':utilisateur_id', $utilisateur_id);
                    $requete_insertion_commentaire->bindParam(':recette_id', $recette_id);
                    $requete_insertion_commentaire->bindParam(':jour_comment', $jour_comment);
                    $requete_insertion_commentaire->execute();

                    echo "Commentaire ajouté avec succès !";
                } catch (PDOException $e) {
                    // Gérer les erreurs de base de données
                    echo "Erreur de base de données : " . $e->getMessage();
                }
            } else {
                echo "Veuillez saisir un commentaire pour ajouter.";
            }
        } else {
            echo "Impossible de récupérer l'ID de l'utilisateur pour ajouter un commentaire.";
        }
    }
}

// Préparation de la requête SQL pour sélectionner toutes les recettes
$requete_selection_recettes = $connection->prepare("SELECT * FROM Recettes");

// Exécution de la requête SQL pour sélectionner toutes les recettes
$requete_selection_recettes->execute();

// Récupération de toutes les recettes sous forme de tableau associatif
$recettes = $requete_selection_recettes->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="styleRecettesphp.css" rel="stylesheet">
    <title>Recettes Blanche-Neige</title>
</head>
<body>
    <h1>Les Recettes de Blanche-Neige</h1>

    <!-- Conteneur pour afficher les recettes -->
    <div id="recettes-container">
        <!-- Les recettes seront ajoutées ici -->
        <?php foreach ($recettes as $recette) : ?>
            <div class="recette">
                <h3><?= $recette['titre'] ?></h3>
                <img src="<?= $recette['lien-photo'] ?>" alt="<?= $recette['titre'] ?>" onclick="afficherPopup('popup-<?= $recette['id'] ?>')">
            </div>
        <?php endforeach; ?>
    </div>

    <!-- Popup pour afficher les détails de la recette -->
    <?php foreach ($recettes as $recette) : ?>
        <?php
            // Exécutez une requête pour récupérer le pseudo de l'utilisateur associé à cette recette
            $requete_utilisateur = $connection->prepare("SELECT pseudo FROM Utilisateurs WHERE id = :utilisateur_id");
            $requete_utilisateur->bindParam(':utilisateur_id', $recette['Utilisateurs_id']);
            $requete_utilisateur->execute();
            $utilisateur = $requete_utilisateur->fetch(PDO::FETCH_ASSOC);
        ?>

        <div id="popup-<?= $recette['id'] ?>" class="popup">
            <div class="popup-content">
                <span class="close" onclick="fermerPopup('popup-<?= $recette['id'] ?>')">&times;</span>
                <h2><?= $recette['titre'] ?></h2>
                <p>Auteur: <?= isset($utilisateur['pseudo']) ? $utilisateur['pseudo'] : 'Utilisateur inconnu' ?></p>
                <p>Date: <?= $recette['jour-post'] ?></p>
                <img src="<?= $recette['lien-photo'] ?>" alt="<?= $recette['titre'] ?>">
                <p><?= $recette['contenu'] ?></p>

                <!-- Bouton pour afficher les commentaires -->
                <button onclick="toggleCommentaires('commentaires-<?= $recette['id'] ?>')">Afficher les commentaires</button>

                <!-- Conteneur pour les commentaires -->
                <div id="commentaires-<?= $recette['id'] ?>" style="display: none;">
                    <?php
                    // Requête pour récupérer les commentaires de recette associés à cette recette
                    $requete_commentaires = $connection->prepare("
                        SELECT Commentaires.id AS id_commentaire, Commentaires.commentaire, Utilisateurs.pseudo AS pseudo_commentaire, Commentaires.`jour-comment`,
                        CommentairesReponse.id AS id_reponse, CommentairesReponse.commentaire AS commentaire_reponse, UtilisateursReponse.pseudo AS pseudo_reponse, CommentairesReponse.`jour-comment` AS jour_comment_reponse
                        FROM Commentaires
                        LEFT JOIN Utilisateurs ON Commentaires.Utilisateurs_id = Utilisateurs.id
                        LEFT JOIN Commentaires AS CommentairesReponse ON Commentaires.id = CommentairesReponse.Commentaires_id
                        LEFT JOIN Utilisateurs AS UtilisateursReponse ON CommentairesReponse.Utilisateurs_id = UtilisateursReponse.id
                        WHERE Commentaires.Recettes_id = :recette_id");
                    $requete_commentaires->bindParam(':recette_id', $recette['id']);
                    $requete_commentaires->execute();
                    $commentaires = $requete_commentaires->fetchAll(PDO::FETCH_ASSOC);

                    // Afficher les commentaires avec le pseudo de l'utilisateur
                    if (count($commentaires) > 0) {
                        echo "<h3>Commentaires</h3>";
                        echo "<ul>";
                        foreach ($commentaires as $commentaire) {
                            echo "<li><strong>" . $commentaire['pseudo_commentaire'] . ":</strong> " . $commentaire['commentaire'];
                            if ($commentaire['commentaire_reponse']) {
                                echo "<ul>";
                                echo "<li><strong>" . $commentaire['pseudo_reponse'] . ":</strong>" . $commentaire['commentaire_reponse'] . "</li>";
                                echo "</ul>";
                            }
                            echo "</li>";
                        }
                        echo "</ul>";
                    } else {
                        echo "<p>Aucun commentaire pour le moment.</p>";
                    }
                    ?>

                    <!-- Formulaire pour ajouter un commentaire -->
                    <form method="POST">
                        <input type="hidden" name="recette_id" value="<?= $recette['id'] ?>">
                        <textarea name="commentaire" placeholder="Ajouter un commentaire"></textarea>
                        <input type="submit" name="submit_comment" value="Ajouter">
                    </form>
                </div>
            </div>
        </div>
    <?php endforeach; ?>

    <!-- Formulaire pour ajouter une nouvelle recette -->
    <form id="form-nouvelle-recette" method='POST'>
        <label for="titre">Titre de la recette:</label><br>
        <input type="text" name="titre" required><br>
        <label for="lien_photo">Lien vers la photo de la recette:</label><br>
        <input type="url" name="lien_photo" required><br>
        <label for="contenu">Contenu de la recette:</label><br>
        <textarea name="contenu"></textarea><br>
        <input type="submit" name="submit_recipe" value="Ajouter une recette">
    </form>

    <a href="MyRecettes.php">Mes Recettes</a>

    <script>
        // Fonction pour afficher le popup avec les détails de la recette
        function afficherPopup(popupId) {
            const popup = document.getElementById(popupId);
            popup.style.display = "block";
        }

        // Fonction pour fermer le popup
        function fermerPopup(popupId) {
            const popup = document.getElementById(popupId);
            popup.style.display = "none";
        }

        // Fonction pour afficher ou cacher les commentaires
        function toggleCommentaires(commentairesId) {
            const commentaires = document.getElementById(commentairesId);
            commentaires.style.display === "none" ? commentaires.style.display = "block" : commentaires.style.display = "none";
        }
    </script>
</body>
</html>