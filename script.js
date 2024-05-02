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
// Fonction pour afficher la modal
function showModal() {
    const modal = document.getElementById('myModal');
    const overlay = document.getElementById('overlay');
    modal.style.display = 'block'; // Afficher la modal
    overlay.style.display = 'block'; // Afficher l'overlay

    // Activer la classe hide-buttons sur les boutons
    const buttons = document.querySelectorAll('.hide-buttons');
    buttons.forEach(button => {
        button.style.display = 'none';
    });
}


// Appeler la fonction showModal après le chargement de la page si une inscription ou une connexion réussie est détectée
window.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const inscriptionReussie = urlParams.has('inscription_reussie') && urlParams.get('inscription_reussie') === 'true';
    const connexionReussie = urlParams.has('connexion_reussie') && urlParams.get('connexion_reussie') === 'true';
    
    if (inscriptionReussie || connexionReussie) {
        showModal();
    }
});