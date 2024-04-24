//en cliquant sur connexion ou inscription, affichage du formulaire qui convient
document.getElementById('btn-login').addEventListener('click', function() {
    document.getElementById('login-form').classList.toggle('active');
    document.getElementById('signup-form').classList.remove('active');
});

document.getElementById('btn-signup').addEventListener('click', function() {
    document.getElementById('signup-form').classList.toggle('active');
    document.getElementById('login-form').classList.remove('active');
});

/////////////////////////////////////////////////////////////////////////////////////////