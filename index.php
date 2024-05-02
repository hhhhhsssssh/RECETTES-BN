<?php

include 'db_connection.php';

session_start(); // Démarrer la session

$new_username = "";
$new_email = "";

// Vérifier si l'inscription a réussi
if (isset($_GET['inscription_reussie']) && $_GET['inscription_reussie'] === 'true') {
    // Marquer l'inscription comme réussie pour afficher la modal de bienvenue
    $inscription_reussie = true;
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page d'accueil</title>
    <link rel="stylesheet" href="styleindex.css">
   
</head>
<body  class="accueil-body">
    <header>
        <h1>Les Recettes de Blanche-Neige</h1>
    </header>
    <main>

    <button id="btn-login" class="hide-buttons">Connexion</button>
    <button id="btn-signup" class="hide-buttons">Inscription</button>

        <div class="form-container" id="login-form">
            <form method='POST' action="login.php">
                <label for="pseudo">Nom d'utilisateur:</label>
                <input type="text" id="pseudo" name="pseudo">
                <label for="motdepasse">Mot de passe:</label>
                <input type="password" id="motdepasse" name="motdepasse">
                <button type="submit" name="login">Se connecter</button>
            </form>
        </div>

        <div class="form-container" id="signup-form">
            <form method='POST' action="signup.php">
                <label for="new-username">Nom d'utilisateur:</label>
                <input type="text" id="new-username" name="new-username" value="<?php echo $new_username; ?>" required>
                <label for="new-email">Adresse e-mail:</label>
                <input type="email" id="new-email" name="new-email" value="<?php echo $new_email; ?>" required>
                <label for="new-password">Mot de passe:</label>
                <input type="password" id="new-password" name="new-password" required>
                <button type="submit">S'inscrire</button>
            </form>
        </div>

                    <!-- Modal de bienvenue -->
                    <?php 
            if (isset($_GET['inscription_reussie']) && $_GET['inscription_reussie'] === 'true') {
                $new_username = isset($_SESSION['username']) ? $_SESSION['username'] : '';
            ?>
                    <div id="myModal" class="modal">
                        <div class="modal-content">
                            <h2>Bienvenue <?= $new_username ?> !</h2>
                            <button onclick="window.location.href='index.php'">Découvrir les recettes</button>  
                        </div>
                    </div>
            <?php 
            } elseif (isset($_GET['connexion_reussie']) && $_GET['connexion_reussie'] === 'true') {
                $username = isset($_SESSION['username']) ? $_SESSION['username'] : '';
            ?>
                    <div id="myModal" class="modal">
                        <div class="modal-content">
                            <h2>Bienvenue <?= $username ?> !</h2>
                            <button onclick="window.location.href='listerecettes.php'">Découvrir les recettes</button>  
                        </div>
                    </div>
            <?php 
            }
            ?>
    </main>
    <footer>
        <p>© 2024 Tous droits réservés.</p>
    </footer>
    <script src="script.js" defer></script>
</body>
</html>