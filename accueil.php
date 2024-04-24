<?php

include 'db_connection.php';


$new_username = "";
$new_email = "";

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page d'accueil</title>
    <link rel="stylesheet" href="styleaccueil.css">
   
</head>
<body  class="accueil-body">>
    <header>
        <h1>Les Recettes de Blanche-Neige</h1>
    </header>
    <main>

        <button id="btn-login">Connexion</button>
        <button id="btn-signup">Inscription</button>

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

    </main>
    <footer>
        <p>© 2024 Tous droits réservés.</p>
    </footer>
    <script src="script.js" defer></script>
</body>
</html>