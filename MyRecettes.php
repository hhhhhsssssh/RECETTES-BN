<?php
session_start();

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    // Rediriger l'utilisateur vers la page de connexion s'il n'est pas connecté
    header("Location: index.php");
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

if ($_SERVER["REQUEST_METHOD"] == "POST") {
////////////////////////////////////////////// traiter l'ajout de rrecettes dans la base de données///////////////////////////////////////////////////////

    if (isset($_POST['submit_recipe'])) {
        // Récupération des données du formulaire pour ajouter une recette
        $titre_recette = htmlspecialchars($_POST['titre']);
        $lien_photo_recette = htmlspecialchars($_POST['lien_photo']);
        $ingredients_recette = htmlspecialchars($_POST['ingredients']);
        $preparation_recette = htmlspecialchars($_POST['preparation']);

            // Assurez-vous que l'ID de l'utilisateur est correctement défini dans la session
            if (isset($_SESSION['user_id'])) {
                $utilisateur_id = $_SESSION['user_id'];

                // Génération de la date actuelle au format SQL
                $jour_post = date("Y-m-d");

                // Vérifiez si les champs ne sont pas vides
                if (!empty($titre_recette) && !empty($lien_photo_recette) && !empty($preparation_recette) && !empty($ingredients_recette)) {
                    try {
                        // Préparation de la requête pour insérer une nouvelle recette dans la base de données
                        $requete_insertion_recette = $connection->prepare("INSERT INTO Recettes (titre, `lien-photo`, ingredients, preparation, `jour-post`, Utilisateurs_id) VALUES (:titre, :lien_photo, :ingredients, :preparation, :jour_post, :utilisateur_id)");
                        $requete_insertion_recette->bindParam(':titre', $titre_recette);
                        $requete_insertion_recette->bindParam(':lien_photo', $lien_photo_recette);
                        $requete_insertion_recette->bindParam(':ingredients', $ingredients_recette);
                        $requete_insertion_recette->bindParam(':preparation', $preparation_recette);
                        $requete_insertion_recette->bindParam(':jour_post', $jour_post);
                        $requete_insertion_recette->bindParam(':utilisateur_id', $utilisateur_id);
                        $requete_insertion_recette->execute();

                
                    // Redirection vers la page actuelle pour actualiser les données
                    header("Location: MyRecettes.php");
                    exit;

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
    }

        // Gestion de la soumission du formulaire de modification de recette

        elseif (isset($_POST['modifier_recette'])) {
            // Récupérer les données du formulaire de modification
            $recette_id = $_POST['recette_id'];
            $nouveau_titre = htmlspecialchars($_POST['nouveau_titre']); // échapper les caractères spéciaux
            $nouveau_ingredients = htmlspecialchars($_POST['nouveau_ingredients']); // échapper les caractères spéciaux
            $nouveau_preparation = htmlspecialchars($_POST['nouveau_preparation']); // échapper les caractères spéciaux

            // Préparation de la requête SQL pour mettre à jour la recette
            $requete_modification_recette = $connection->prepare("UPDATE Recettes SET titre = :nouveau_titre, ingredients = :nouveau_ingredients, preparation = :nouveau_preparation WHERE id = :recette_id");

            // Liaison des paramètres avec les valeurs
            $requete_modification_recette->bindParam(':nouveau_titre', $nouveau_titre);
            $requete_modification_recette->bindParam(':nouveau_ingredients', $nouveau_ingredients); // changer le nom de la colonne
            $requete_modification_recette->bindParam(':nouveau_preparation', $nouveau_preparation); // changer le nom de la colonne
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
        <link href="styleRecettes.css" rel="stylesheet">
        <title>Mes Recettes</title>
    </head>
    <body>
        <h1>Mes Recettes</h1>

        <div class="container">
            <!-- Formulaire pour ajouter une nouvelle recette -->
                <form id="form-nouvelle-recette" method="POST">
                    <label for="titre">Titre de la recette:</label><br>
                    <input type="text" name="titre" required><br>
                    <label for="lien_photo">Lien vers la photo de la recette:</label><br>
                    <input type="url" name="lien_photo" required><br>
                    <label for="ingredients">Ingrédients de la recette:</label><br>
                    <textarea name="ingredients"></textarea><br>
                    <label for="preparation">Préparation de la recette:</label><br>
                    <textarea name="preparation"></textarea><br>
                    <input type="submit" name="submit_recipe" value="Ajouter une recette">
                </form>

            <div class="right">
                <!-- Afficher les recettes de l'utilisateur connecté -->
                <ul>
                    <?php foreach ($recettes_utilisateur as $recette) : ?>
                        <li>
                            <h2><?= $recette['titre'] ?></h2>
                            <p><?= nl2br($recette['ingredients']) ?></p>
                            <p><?= nl2br($recette['preparation']) ?></p>
                            <p>Date de publication: <?= $recette['jour-post'] ?></p> <!-- Ajout de la date -->
                            <!-- Bouton pour modifier la recette -->
                            <button onclick="afficherFormulaire('modifier', <?= $recette['id'] ?>)">Modifier</button>
                            <!-- Bouton pour supprimer la recette -->
                            <button onclick="afficherFormulaire('supprimer', <?= $recette['id'] ?>)">Supprimer</button>
                            
                            <!-- Formulaire pour supprimer la recette -->
                            <form id="form-supprimer-<?= $recette['id'] ?>"  method="POST" style="display: none;">
                                <input type="hidden" name="recette_id" value="<?= $recette['id'] ?>">
                                <input type="submit" value="Oui" name="supprimer_recette">
                                <button onclick="annulerSuppression(<?= $recette['id'] ?>)">Non</button>
                            </form>

                           <!-- Formulaire pour modifier la recette -->
                        <form id="form-modifier-<?= $recette['id'] ?>"  method="POST" style="display: none;">
                            <input type="hidden" name="recette_id" value="<?= $recette['id'] ?>">
                            <input type="text" name="nouveau_titre" placeholder="Nouveau titre">
                            <textarea name="nouveau_ingredients" placeholder="Nouveaux ingrédients"></textarea>
                            <textarea name="nouveau_preparation" placeholder="Nouvelle préparation"></textarea>
                            <input type="submit" value="Enregistrer" name="modifier_recette">
                        </form>

                        </li>
                    <?php endforeach; ?>
                </ul>

                <a href="listerecettes.php">Voir toutes les recettes</a>
            </div>   
        </div>

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
    <footer>
            <p>© 2024 Tous droits réservés.</p>
    </footer>
</html>