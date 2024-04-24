-- -----------------------------------------------------
-- Table `Utilisateurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Utilisateurs` (
`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`pseudo` VARCHAR(45) NOT NULL,
`email` VARCHAR(45) NOT NULL,
`motdepasse` VARCHAR(250) NOT NULL,
 PRIMARY KEY (`id`),
 UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
 UNIQUE INDEX `pseudo_UNIQUE` (`pseudo` ASC) VISIBLE,
 UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);




-- -----------------------------------------------------
-- Table `Recettes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recettes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(45) NOT NULL,
  `contenu` LONGTEXT NOT NULL,
  `lien-photo` VARCHAR(255) NOT NULL,
  `jour-post` DATE NULL,
  `Utilisateurs_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `Utilisateurs_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `titre_UNIQUE` (`titre` ASC) VISIBLE,
  UNIQUE INDEX `lien-photo_UNIQUE` (`lien-photo` ASC) VISIBLE,
  INDEX `fk_Recettes_Utilisateurs_idx` (`Utilisateurs_id` ASC) VISIBLE,
  CONSTRAINT `fk_Recettes_Utilisateurs`
    FOREIGN KEY (`Utilisateurs_id`)
    REFERENCES `Utilisateurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Commentaires`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Commentaires` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `commentaire` MEDIUMTEXT NOT NULL,
  `jour-comment` DATE NOT NULL,
  `Utilisateurs_id` INT UNSIGNED,
 `Recettes_id` INT UNSIGNED NULL, 
  `Commentaires_id` INT UNSIGNED NULL, 
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Commentaires_Utilisateurs1_idx` (`Utilisateurs_id` ASC) VISIBLE,
  INDEX `fk_Commentaires_Recettes1_idx` (`Recettes_id` ASC) VISIBLE,
  INDEX `fk_Commentaires_Commentaires1_idx` (`Commentaires_id` ASC) VISIBLE,
  CONSTRAINT `fk_Commentaires_Utilisateurs1`
    FOREIGN KEY (`Utilisateurs_id`)
    REFERENCES `Utilisateurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commentaires_Recettes1`
    FOREIGN KEY (`Recettes_id`)
    REFERENCES `Recettes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commentaires_Commentaires1`
    FOREIGN KEY (`Commentaires_id`)
    REFERENCES `Commentaires` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

INSERT INTO Utilisateurs (pseudo, email, motdepasse) VALUES
('MickeyMouse', 'mickey@aaa.fr', 'mdp_mickey'),
('MinnieMouse', 'minnie@aaa.fr', 'mdp_minnie'),
('DonaldDuck', 'donald@aaa.fr', 'mdp_donald'),
('DaisyDuck', 'daisy@aaa.fr', 'mdp_daisy'),
('Goofy', 'goofy@aaa.fr', 'mdp_goofy'),
('Pluto', 'pluto@aaa.fr', 'mdp_pluto'),
('ScroogeMcDuck', 'scrooge@aaa.fr', 'mdp_scrooge'),
('Huey', 'huey@aaa.fr', 'mdp_huey'),
('Dewey', 'dewey@aaa.fr', 'mdp_dewey'),
('Louie', 'louie@aaa.fr', 'mdp_louie'),
('Chip', 'chip@aaa.fr', 'mdp_chip'),
('Dale', 'dale@aaa.fr', 'mdp_dale'),
('Pete', 'pete@aaa.fr', 'mdp_pete'),
('Clarice', 'clarice@aaa.fr', 'mdp_clarice'),
('GideonGrey', 'gideon@aaa.fr', 'mdp_gideon'),
('Jaq', 'jaq@aaa.fr', 'mdp_jaq'),
('Gus', 'gus@aaa.fr', 'mdp_gus'),
('Suzy', 'suzy@aaa.fr', 'mdp_suzy'),
('JiminyCricket', 'jiminy@aaa.fr', 'mdp_jiminy'),
('Baloo', 'baloo@aaa.fr', 'mdp_baloo'),
('KingLouie', 'kinglouie@aaa.fr', 'mdp_kinglouie'),
('Mowgli', 'mowgli@aaa.fr', 'mdp_mowgli'),
('Simba', 'simba@aaa.fr', 'mdp_simba'),
('Nala', 'nala@aaa.fr', 'mdp_nala');


User
les adresse mail doivent etre des @aaa.fr
ChatGPT
D'accord, voici la requête SQL mise à jour avec des adresses email se terminant par "@aaa.fr" :

sql
Copy code
INSERT INTO Utilisateurs (pseudo, email, motdepasse) VALUES
('MickeyMouse', 'mickey@aaa.fr', 'motdepasse1'),
('MinnieMouse', 'minnie@aaa.fr', 'motdepasse2'),
('DonaldDuck', 'donald@aaa.fr', 'motdepasse3'),
('DaisyDuck', 'daisy@aaa.fr', 'motdepasse4'),
('Goofy', 'goofy@aaa.fr', 'motdepasse5'),
('Pluto', 'pluto@aaa.fr', 'motdepasse6'),
('ScroogeMcDuck', 'scrooge@aaa.fr', 'motdepasse7'),
('Huey', 'huey@aaa.fr', 'motdepasse8'),
('Dewey', 'dewey@aaa.fr', 'motdepasse9'),
('Louie', 'louie@aaa.fr', 'motdepasse10'),
('Chip', 'chip@aaa.fr', 'motdepasse11'),
('Dale', 'dale@aaa.fr', 'motdepasse12'),
('ClarabelleCow', 'clarabelle@aaa.fr', 'motdepasse13'),
('HoraceHorsecollar', 'horace@aaa.fr', 'motdepasse14'),
('Pete', 'pete@aaa.fr', 'motdepasse15'),
('MaxGoof', 'max@aaa.fr', 'motdepasse16'),
('ScroogeMcDuck', 'scrooge@aaa.fr', 'motdepasse17'),
('FentonCrackshell', 'fenton@aaa.fr', 'motdepasse18'),
('GyroGearloose', 'gyro@aaa.fr', 'motdepasse19'),
('LaunchpadMcQuack', 'launchpad@aaa.fr', 'motdepasse20');



INSERT INTO Recettes (titre, contenu, `lien-photo`, `jour-post`, Utilisateurs_id) VALUES
('Pommes du Prince', 'Ingrédients:
- 6 pommes
- 200g de sucre
- 100ml d\'eau
- Colorant alimentaire rouge

Préparation:
1. Lavez et séchez les pommes, retirez les queues et plantez un bâtonnet en bois à la place.
2. Dans une casserole, faites chauffer le sucre et l\'eau jusqu\'à obtenir un caramel doré.
3. Ajoutez quelques gouttes de colorant alimentaire rouge dans le caramel.
4. Trempez chaque pomme dans le caramel et laissez-les sécher sur du papier sulfurisé.', 'leliendelaphoto1.jpg', '2024-04-18', 1),

('Salade de Pommes dans les Choux', 'Ingrédients:
- 2 pommes vertes, coupées en dés
- 1 petit chou vert, émincé finement
- 1/2 oignon rouge, haché
- 1/4 tasse de raisins secs
- 1/4 tasse de noix hachées (amandes, noix de cajou, ou autres)
- 1/4 tasse de mayonnaise
- 2 cuillères à soupe de vinaigre de cidre de pomme
- 1 cuillère à soupe de miel (facultatif)
- Sel et poivre, au goût

Préparation:
1. Dans un grand saladier, mélangez les dés de pommes, le chou émincé, l\'oignon rouge haché, les raisins secs et les noix hachées.
2. Dans un petit bol, préparez la vinaigrette en mélangeant la mayonnaise, le vinaigre de cidre de pomme, le miel (si utilisé), le sel et le poivre.
3. Versez la vinaigrette sur la salade de pommes et de choux et mélangez délicatement pour bien enrober tous les ingrédients.
4. Réfrigérez la salade pendant au moins 30 minutes avant de servir pour permettre aux saveurs de se mélanger.', 'leliendelaphoto2.jpg', '2024-04-18', 2),

('Beignets de Pommes Magiques', 'Ingrédients:
- 2 pommes
- 150g de farine
- 1 œuf
- 100ml de lait
- 50g de sucre
- 1 sachet de levure chimique
- Sucre glace

Préparation:
1. Epluchez et coupez les pommes en tranches épaisses.
2. Dans un saladier, mélangez la farine, le sucre et la levure.
3. Ajoutez l\'œuf et le lait, mélangez jusqu\'à obtenir une pâte homogène.
4. Trempez les tranches de pommes dans la pâte, puis faites-les frire dans de l\'huile chaude.
5. Egouttez les beignets sur du papier absorbant, saupoudrez de sucre glace.', 'leliendelaphoto3.jpg', '2024-04-19', 3),

('Tarte Enchantée aux Pommes', 'Ingrédients:
- 1 pâte brisée
- 4 pommes
- 50g de sucre
- 1 cuillère à café de cannelle

Préparation:
1. Préchauffez votre four à 180°C.
2. Disposez la pâte brisée dans un moule à tarte.
3. Épluchez et coupez les pommes en tranches fines, disposez-les sur la pâte.
4. Saupoudrez de sucre et de cannelle.
5. Enfournez pendant 30 minutes.', 'leliendelaphoto4.jpg', '2024-04-15', 4),

('Compote Magique de Pommes', 'Ingrédients:
- 4 pommes
- 50g de sucre
- 1 cuillère à café de cannelle

Préparation:
1. Épluchez et coupez les pommes en dés.
2. Dans une casserole, faites cuire les pommes avec le sucre et la cannelle jusqu\'à ce qu\'elles soient tendres.
3. Mixez le tout jusqu\'à obtenir une texture lisse.', 'leliendelaphoto5.jpg', '2024-04-15', 5),

('Jus de Pomme Enchanté', 'Ingrédients:
- 6 pommes
- 1 citron

Préparation:
1. Pressez les pommes pour en extraire le jus.
2. Ajoutez quelques gouttes de jus de citron pour éviter l\'oxydation.
3. Servez frais.', 'leliendelaphoto6.jpg', '2024-04-16', 6),

('Salade de Fruits Magique', 'Ingrédients:
- 2 pommes
- 2 oranges
- 2 bananes
- 100g de fraises
- Jus de citron

Préparation:
1. Coupez tous les fruits en morceaux.
2. Arrosez-les de jus de citron pour éviter l\'oxydation.
3. Mélangez délicatement et servez frais.', 'leliendelaphoto7.jpg', '2024-04-16', 7),

('Pommes Enchantées', 'Ingrédients:
- 6 pommes
- 200g de sucre
- 100ml d\'eau
- Colorant alimentaire rouge

Préparation:
1. Lavez et séchez les pommes, retirez les queues et plantez un bâtonnet en bois à la place.
2. Dans une casserole, faites chauffer le sucre et l\'eau jusqu\'à obtenir un caramel doré.
3. Ajoutez quelques gouttes de colorant alimentaire rouge dans le caramel.
4. Trempez chaque pomme dans le caramel et laissez-les sécher sur du papier sulfurisé.', 'leliendelaphoto8.jpg', '2024-04-17', 8),

('Pommes Magiques', 'Ingrédients:
- 6 pommes
- 200g de sucre
- 100ml d\'eau
- Colorant alimentaire rouge

Préparation:
1. Lavez et séchez les pommes, retirez les queues et plantez un bâtonnet en bois à la place.
2. Dans une casserole, faites chauffer le sucre et l\'eau jusqu\'à obtenir un caramel doré.
3. Ajoutez quelques gouttes de colorant alimentaire rouge dans le caramel.
4. Trempez chaque pomme dans le caramel et laissez-les sécher sur du papier sulfurisé.', 'leliendelaphoto9.jpg', '2024-04-17', 9),

('Gâteau Magique aux Pommes', 'Ingrédients:
- 3 pommes
- 150g de farine
- 100g de sucre
- 100g de beurre
- 3 œufs
- 1 sachet de levure chimique

Préparation:
1. Préchauffez votre four à 180°C.
2. Épluchez et coupez les pommes en dés.
3. Dans un saladier, mélangez la farine, le sucre et la levure.
4. Ajoutez les œufs un à un en mélangeant bien.
5. Incorporez le beurre fondu et les dés de pommes.
6. Versez la préparation dans un moule beurré et enfournez pendant 40 minutes.', 'leliendelaphoto10.jpg', '2024-04-20', 10),

('Smoothie de Pommes Magique', 'Ingrédients:
- 2 pommes
- 1 banane
- 100ml de lait
- 1 cuillère à café de miel

Préparation:
1. Epluchez et coupez les pommes en morceaux.
2. Epluchez la banane et coupez-la en rondelles.
3. Dans un blender, mixez les pommes, la banane, le lait et le miel jusqu\'à obtenir une texture lisse.', 'lien_photo11.jpg', '2024-04-20', 11),

('Tarte Tatin Enchantée', 'Ingrédients:
- 6 pommes
- 150g de sucre
- 100g de beurre
- 1 pâte feuilletée

Préparation:
1. Epluchez et coupez les pommes en quartiers.
2. Dans un moule à tarte, faites fondre le beurre avec le sucre jusqu\'à obtention d\'un caramel doré.
3. Disposez les quartiers de pommes dans le moule, puis recouvrez avec la pâte feuilletée.
4. Enfournez à 180°C pendant 30 minutes.
5. Démoulez la tarte encore chaude et servez-la tiède.', 'lien_photo12.jpg', '2024-04-21', 12),

('Gâteau Magique aux Pommes et à la Cannelle', 'Ingrédients:
- 3 pommes
- 150g de farine
- 100g de sucre
- 100g de beurre
- 3 œufs
- 1 sachet de levure chimique
- 1 cuillère à café de cannelle

Préparation:
1. Préchauffez votre four à 180°C.
2. Epluchez et coupez les pommes en dés.
3. Dans un saladier, mélangez la farine, le sucre, la levure et la cannelle.
4. Ajoutez les œufs un à un en mélangeant bien.
5. Incorporez le beurre fondu et les dés de pommes.
6. Versez la préparation dans un moule beurré et enfournez pendant 40 minutes.', 'lien_photo13.jpg', '2024-04-22', 13),

('Tarte aux Pommes et aux Amandes', 'Ingrédients:
- 1 pâte brisée
- 4 pommes
- 100g de poudre d\'amandes
- 100g de sucre
- 2 œufs
- 100ml de crème fraîche

Préparation:
1. Préchauffez votre four à 180°C.
2. Disposez la pâte brisée dans un moule à tarte.
3. Épluchez et coupez les pommes en quartiers, disposez-les sur la pâte.
4. Dans un saladier, mélangez la poudre d\'amandes, le sucre, les œufs et la crème fraîche.
5. Versez cette préparation sur les pommes.
6. Enfournez pendant 30 minutes.', 'lien_photo14.jpg', '2024-04-23', 14),

('Crumble aux Pommes et aux Noix', 'Ingrédients:
- 4 pommes
- 100g de farine
- 80g de beurre
- 80g de sucre
- 50g de noix concassées

Préparation:
1. Préchauffez votre four à 180°C.
2. Épluchez et coupez les pommes en dés, disposez-les dans un plat à gratin.
3. Dans un saladier, mélangez la farine, le beurre et le sucre jusqu\'à obtenir une texture sableuse.
4. Incorporez les noix concassées à ce mélange, puis répartissez-le sur les pommes.
5. Enfournez pendant 30 minutes.', 'lien_photo15.jpg', '2024-04-24', 15),

('Pommes Caramélisées aux Épices', 'Ingrédients:
- 4 pommes
- 100g de sucre
- 50g de beurre
- 1 cuillère à café de cannelle
- 1 cuillère à café de gingembre en poudre
- 1 cuillère à café de vanille liquide

Préparation:
1. Épluchez et coupez les pommes en quartiers.
2. Dans une poêle, faites fondre le beurre avec le sucre et les épices.
3. Ajoutez les quartiers de pommes et faites-les caraméliser pendant quelques minutes de chaque côté.
4. Servez chaud.', 'lien_photo16.jpg', '2024-04-25', 16),

('Pommes Farcies aux Fruits Secs', 'Ingrédients:
- 4 pommes
- 50g de raisins secs
- 50g de cranberries séchées
- 50g de noisettes concassées
- 50g de sucre
- 50g de beurre
- 1 cuillère à café de cannelle

Préparation:
1. Préchauffez votre four à 180°C.
2. Épluchez les pommes et évidez-les à l\'aide d\'un vide-pomme.
3. Dans un bol, mélangez les raisins secs, les cranberries, les noisettes, le sucre et la cannelle.
4. Farcissez les pommes de ce mélange, puis déposez une noisette de beurre sur le dessus.
5. Enfournez pendant 30 minutes.', 'lien_photo17.jpg', '2024-04-26', 17),

('Pommes au Four Caramélisées', 'Ingrédients:
- 4 pommes
- 100g de sucre
- 50g de beurre
- 1 cuillère à café de cannelle
- 1 cuillère à café de vanille liquide

Préparation:
1. Préchauffez votre four à 180°C.
2. Épluchez les pommes et évidez-les à l\'aide d\'un vide-pomme.
3. Dans un bol, mélangez le sucre, la cannelle et la vanille.
4. Farcissez les pommes de ce mélange, puis déposez une noisette de beurre sur le dessus.
5. Enfournez pendant 30 minutes.', 'lien_photo18.jpg', '2024-04-27', 18),

('Tiramisu aux Pommes Caramélisées', 'Ingrédients:
- 2 pommes
- 200g de mascarpone
- 100g de sucre
- 3 œufs
- 1 paquet de biscuits à la cuillère
- 1 tasse de café noir
- Cacao en poudre

Préparation:
1. Épluchez les pommes et coupez-les en dés, faites-les caraméliser dans une poêle avec un peu de beurre et de sucre.
2. Dans un saladier, mélangez le mascarpone avec le sucre.
3. Séparez les blancs des jaunes d\'œufs, ajoutez les jaunes au mélange de mascarpone.
4. Montez les blancs en neige et incorporez-les délicatement à la préparation.
5. Trempez rapidement les biscuits dans le café, puis disposez-les au fond d\'un plat.
6. Recouvrez d\'une couche de crème au mascarpone, puis d\'une couche de pommes caramélisées.
7. Répétez l\'opération jusqu\'à épuisement des ingrédients, en terminant par une couche de crème.
8. Saupoudrez de cacao en poudre et réservez au réfrigérateur pendant au moins 4 heures avant de déguster.', 'lien_photo19.jpg', '2024-04-28', 19),

('Pommes au Caramel', 'Ingrédients:
- 4 pommes
- 200g de sucre
- 100ml de crème liquide
- 50g de beurre
- 1 cuillère à café de fleur de sel

Préparation:
1. Épluchez les pommes et coupez-les en quartiers.
2. Dans une casserole, faites chauffer le sucre jusqu\'à obtenir un caramel doré.
3. Ajoutez le beurre et la crème liquide en remuant bien.
4. Laissez mijoter quelques minutes jusqu\'à obtenir une sauce lisse.
5. Ajoutez la fleur de sel et mélangez.
6. Plongez les quartiers de pommes dans la sauce au caramel.', 'lien_photo20.jpg', '2024-04-29', 20),

('Crumble aux Pommes et au Caramel Salé', 'Ingrédients:
- 4 pommes
- 100g de farine
- 80g de beurre
- 80g de sucre
- 50g de noix concassées
- 100g de caramel au beurre salé

Préparation:
1. Préchauffez votre four à 180°C.
2. Épluchez et coupez les pommes en dés, disposez-les dans un plat à gratin.
3. Dans un saladier, mélangez la farine, le beurre et le sucre jusqu\'à obtenir une texture sableuse.
4. Incorporez les noix concassées à ce mélange, puis répartissez-le sur les pommes.
5. Versez le caramel au beurre salé sur le crumble.
6. Enfournez pendant 30 minutes.', 'lien_photo21.jpg', '2024-04-28', 21),

('Tarte Fine aux Pommes et au Miel', 'Ingrédients:
- 1 pâte feuilletée
- 4 pommes
- 3 cuillères à soupe de miel
- 50g de beurre

Préparation:
1. Préchauffez votre four à 180°C.
2. Étalez la pâte feuilletée sur une plaque de cuisson.
3. Épluchez et coupez les pommes en fines lamelles, disposez-les sur la pâte en les faisant légèrement chevaucher.
4. Faites fondre le beurre et mélangez-le avec le miel, puis badigeonnez-en les pommes.
5. Enfournez pendant 25 minutes, jusqu\'à ce que la pâte soit dorée.', 'lien_photo22.jpg', '2024-04-29', 22),

('Compote de Pommes Cannelle', 'Ingrédients:
- 6 pommes
- 50g de sucre
- 1 cuillère à café de cannelle
- 50ml d\'eau

Préparation:
1. Épluchez et coupez les pommes en morceaux.
2. Dans une casserole, versez l\'eau, le sucre et la cannelle, puis ajoutez les morceaux de pommes.
3. Faites cuire à feu moyen pendant 15 minutes en remuant régulièrement.
4. Écrasez grossièrement les pommes à l\'aide d\'une fourchette.', 'lien_photo23.jpg', '2024-04-30', 23),

('Pommes au Four à la Cannelle', 'Ingrédients:
- 4 pommes
- 50g de sucre
- 1 cuillère à café de cannelle

Préparation:
1. Préchauffez votre four à 180°C.
2. Épluchez les pommes et retirez le cœur à l\'aide d\'un vide-pomme.
3. Dans un bol, mélangez le sucre et la cannelle.
4. Saupoudrez chaque pomme de ce mélange.
5. Enfournez pendant 30 minutes.', 'lien_photo24.jpg', '2024-05-01', 24),

('Pommes au Chocolat', 'Ingrédients:
- 6 pommes
- 200g de sucre
- 100ml d\'eau
- 100g de chocolat noir

Préparation:
1. Lavez et séchez les pommes, retirez les queues et plantez un bâtonnet en bois à la place.
2. Dans une casserole, faites chauffer le sucre et l\'eau jusqu\'à obtenir un caramel doré.
3. Cassez le chocolat en morceaux et faites-le fondre au bain-marie.
4. Trempez chaque pomme dans le caramel, puis dans le chocolat fondu.
5. Laissez les pommes sécher sur du papier sulfurisé.', 'lien_photo25.jpg', '2024-05-02', 25),

('Muffins aux Pommes et aux Noix', 'Ingrédients:
- 2 pommes
- 200g de farine
- 100g de sucre
- 100g de beurre
- 2 œufs
- 1 sachet de levure chimique
- 50g de noix concassées

Préparation:
1. Préchauffez votre four à 180°C.
2. Dans un saladier, mélangez la farine, le sucre et la levure.
3. Faites fondre le beurre.
4. Incorporez les œufs un à un dans le mélange sec, puis ajoutez le beurre fondu.
5. Épluchez et coupez les pommes en petits dés, ajoutez-les à la pâte ainsi que les noix concassées.
6. Répartissez la pâte dans des moules à muffins et enfournez pendant 20 minutes.', 'lien_photo26.jpg', '2024-05-03', 26),

('Pain Perdu aux Pommes Caramélisées', 'Ingrédients:
- 4 tranches de pain rassis
- 2 pommes
- 2 œufs
- 100ml de lait
- 50g de sucre
- 50g de beurre

Préparation:
1. Épluchez et coupez les pommes en lamelles.
2. Dans une poêle, faites fondre le beurre et saisissez les lamelles de pommes avec le sucre jusqu\'à ce qu\'elles soient dorées.
3. Battez les œufs avec le lait.
4. Trempez les tranches de pain dans le mélange œufs-lait.
5. Faites-les dorer des deux côtés dans une autre poêle avec un peu de beurre.
6. Servez les tranches de pain perdu avec les pommes caramélisées.', 'lien_photo27.jpg', '2024-05-04', 27),

('Galette des Rois aux Pommes', 'Ingrédients:
- 2 pâtes feuilletées
- 2 pommes
- 100g de poudre d\'amandes
- 80g de sucre
- 50g de beurre
- 1 œuf

Préparation:
1. Préchauffez votre four à 180°C.
2. Épluchez et coupez les pommes en lamelles.
3. Dans un saladier, mélangez la poudre d\'amandes, le sucre et le beurre ramolli.
4. Étalez une pâte feuilletée sur une plaque de cuisson, puis étalez la préparation aux amandes par-dessus en laissant un bord libre.
5. Disposez les lamelles de pommes sur la préparation aux amandes.
6. Recouvrez avec la deuxième pâte feuilletée, soudez les bords et faites une petite cheminée au centre.
7. Dorez la galette avec un œuf battu.
8. Enfournez pendant 30 minutes.', 'lien_photo28.jpg', '2024-05-05', 28),

('Salade de Pommes, Noix et Roquefort', 'Ingrédients:
- 2 pommes
- 100g de cerneaux de noix
- 100g de Roquefort
- Mâche
- Vinaigrette (huile d\'olive, vinaigre balsamique, moutarde)

Préparation:
1. Lavez et coupez les pommes en quartiers, puis en fines lamelles.
2. Dans un saladier, mélangez la mâche, les lamelles de pommes, les cerneaux de noix et le Roquefort coupé en dés.
3. Assaisonnez avec la vinaigrette.', 'lien_photo29.jpg', '2024-05-06', 29),

('Rôti de Boeuf aux Pommes et au Miel', 'Ingrédients:
- 1 rôti de boeuf
- 4 pommes
- 2 cuillères à soupe de miel
- 2 cuillères à soupe de moutarde
- Sel et poivre

Préparation:
1. Préchauffez votre four à 180°C.
2. Dans un bol, mélangez le miel, la moutarde, du sel et du poivre.
3. Badigeonnez le rôti de ce mélange.
4. Épluchez et coupez les pommes en quartiers, disposez-les autour du rôti.
5. Enfournez pendant 1h30 en arrosant régulièrement le rôti avec le jus de cuisson.', 'lien_photo30.jpg', '2024-05-07', 30),

('Lieu aux Pommiers', 'Ingrédients:
- 4 filets de lieu jaune
- 2 pommes, pelées, épépinées et coupées en dés
- 1 échalote, émincée
- 1 cuillère à soupe de beurre
- 1 cuillère à soupe de miel
- Jus de citron
- Sel et poivre au goût
- Ciboulette fraîche, hachée (pour la garniture)

Préparation:
1. Préchauffez votre four à 180°C (350°F).
2. Dans une poêle, faites fondre le beurre à feu moyen. Ajoutez les dés de pommes et l\'échalote émincée. Faites cuire pendant quelques minutes jusqu\'à ce que les pommes commencent à ramollir.
3. Ajoutez le miel et un filet de jus de citron aux pommes. Mélangez bien et laissez mijoter pendant encore quelques minutes jusqu\'à ce que les pommes soient tendres. Assaisonnez avec du sel et du poivre selon votre goût.
4. Pendant ce temps, assaisonnez les filets de lieu jaune avec du sel, du poivre et un filet de jus de citron.
5. Disposez les filets de poisson dans un plat allant au four légèrement graissé. Répartissez la compote de pommes sur les filets de poisson.
6. Enfournez le plat au four préchauffé et faites cuire pendant environ 15-20 minutes, ou jusqu\'à ce que le poisson soit cuit à votre goût.
7. Une fois cuit, retirez le plat du four et laissez reposer quelques minutes avant de servir.
8. Garnissez avec de la ciboulette fraîchement hachée et servez chaud avec des légumes de saison ou du riz pour accompagner.', 'lien_photo31.jpg', '2024-05-04', 1),

('Pommes au Sirop Erable Cannelle', 'Ingrédients:
- 4 pommes
- 4 cuillères a soupe de sirop dérable
- 1 cuillère a café de cannelle

Préparation:
1. Préchauffez votre four à 180°C.
2. Epluchez les pommes et retirez le centre avec un vide-pomme.
3. Dans un bol, mélangez le sirop d\'érable et la cannelle.
4. Badigeonnez chaque pomme avec ce mélange.
5. Enfournez pendant 30 minutes.', 'lien_photo32.jpg', '2024-05-09', 2),

('Compote de Pommes à la Vanille', 'Ingrédients:
- 6 pommes
- 50g de sucre
- 1 gousse de vanille
- 50ml d\'eau

Préparation:
1. Epluchez et coupez les pommes en morceaux.
2. Dans une casserole, versez l\'eau, le sucre et les grains de la gousse de vanille, puis ajoutez les morceaux de pommes.
3. Faites cuire à feu moyen pendant 15 minutes en remuant régulièrement.
4. Ecrasez grossièrement les pommes à l\'aide d\'une fourchette.', 'lien_photo33.jpg', '2024-05-10', 3),

('Cheesecake aux Pommes', 'Ingrédients:
- 200g de biscuits Graham
- 100g de beurre fondu
- 500g de fromage à la crème
- 150g de sucre
- 3 œufs
- 1 cuillère à café d’extrait de vanille
- 2 pommes Granny Smith, pelées, épépinées et coupées en dés
- 1 cuillère à soupe de jus de citron
- 1/2 cuillère à café de cannelle
- 2 cuillères à soupe de farine

Préparation:
1. Préchauffez le four à 180°C (350°F). Graissez légèrement un moule à charnière de 23 cm (9 pouces).
2. Réduisez les biscuits Graham en miettes dans un robot culinaire ou en les écrasant dans un sac en plastique. Mélangez-les avec le beurre fondu. Pressez le mélange de biscuits au fond du moule préparé.
3. Dans un grand bol, battez le fromage à la crème avec le sucre jusqu\'à consistance lisse. Ajoutez les oeufs un à un, en battant bien après chaque ajout. Incorporez l\'extrait de vanille.
4. Dans un autre bol, mélangez les dés de pommes avec le jus de citron, la cannelle et la farine.
5. Répartissez les dés de pommes sur la croûte de biscuits Graham.
6. Versez délicatement la préparation au fromage à la crème sur les pommes dans le moule.
7. Faites cuire au four préchauffé pendant environ 45-50 minutes, ou jusqu\'à ce que le centre du cheesecake soit presque pris.
8. Laissez refroidir complètement à température ambiante, puis réfrigérez pendant au moins 4 heures, de préférence toute une nuit, avant de servir.
9. Démoulez délicatement le cheesecake et servez-le avec une garniture de votre choix, comme de la crème fouettée ou une sauce caramel.', 'lien_photo34.jpg', '2024-05-04', 4),

('Pita aux Pommes', 'Ingrédients:
- 4 pommes
- 100g de sucre
- 1 cuillère à café de cannelle
- 1 pate feuilletée

Préparation:
1. Préchauffez votre four à 180°C.
2. Epluchez les pommes, retirez le coeur et coupez-les en tranches fines.
3. Dans un bol, mélangez le sucre et la cannelle.
4. Etalez la pate feuilletée sur une plaque de cuisson.
5. Disposez les tranches de pommes sur la moitié de la pâte en les chevauchant légèrement, en laissant une bordure.
6. Saupoudrez le mélange de sucre et de cannelle sur les pommes.
7. Repliez l\'autre moitié de la pate sur les pommes et soudez les bords.
8. Enfournez pendant 25 minutes, jusqu\'à ce que la pâte soit dorée.', 'lien_photo35.jpg', '2024-05-04', 5),

('Pommes Farcies', 'Ingrédients:
- 4 pommes
- 50g de noix concassées
- 50g de raisins secs
- 2 cuillères à soupe de miel
- 1 cuillère à café de cannelle
- 30g de beurre

Préparation:
1. Préchauffez votre four à 180°C.
2. Lavez les pommes et retirez le trognon à l\'aide d\'un vide-pomme, en veillant à ne pas percer le fond de la pomme.
3. Dans un bol, mélangez les noix concassées, les raisins secs, le miel et la cannelle.
4. Remplissez chaque pomme avec le mélange obtenu.
5. Disposez les pommes dans un plat allant au four.
6. Déposez une noisette de beurre sur le dessus de chaque pomme.
7. Enfournez pendant environ 30 minutes, jusqu\'à ce que les pommes soient tendres.
8. Servez chaud, accompagné éventuellement de crème fouettée ou de glace à la vanille.', 'lien_photo36.jpg', '2024-05-04', 6),

('Poulet aux Pommes', 'Ingrédients:
- 4 filets de poulet
- 2 pommes Granny Smith
- 1 oignon
- 2 cuillères à soupe de miel
- 1 cuillère à soupe de moutarde
- 200ml de bouillon de poulet
- Sel et poivre au goût
- 2 cuillères à soupe d\'huile d\'olive

Préparation:
1. Epluchez et coupez les pommes en tranches épaisses.
2. Emincez l\'oignon.
3. Dans une poêle, chauffez l\'huile d\'olive à feu moyen.
4. Faites dorer les filets de poulet des deux côtés pendant quelques minutes. Retirez-les de la poêle et réservez.
5. Dans la même poêle, ajoutez un peu plus d\'huile si nécessaire, puis faites revenir l\'oignon jusqu\'à ce qu\'il soit translucide.
6. Ajoutez les tranches de pommes dans la poêle et faites-les revenir pendant quelques minutes jusqu\'à ce qu\'elles commencent à ramollir.
7. Remettez les filets de poulet dans la poêle, puis versez le bouillon de poulet, le miel et la moutarde.
8. Assaisonnez avec du sel et du poivre selon votre goût.
9. Laissez mijoter pendant environ 15-20 minutes, jusqu\'à ce que le poulet soit bien cuit et que la sauce épaississe.
10. Servez chaud, accompagné de riz ou de légumes de votre choix.', 'lien_photo37.jpg', '2024-05-04', 7),

('Lapin aux Pommes', 'Ingrédients:
- 1 lapin coupé en morceaux
- 4 pommes
- 2 oignons
- 2 gousses d\'ail
- 200ml de vin blanc
- 200ml de bouillon de poulet
- 2 cuillères à soupe de moutarde
- 2 cuillères à soupe de crème fraîche
- Sel et poivre au goût
- 2 cuillères à soupe d\'huile d\'olive

Préparation:
1. Epluchez et coupez les pommes en quartiers.
2. Emincez les oignons et hachez l\'ail.
3. Dans une grande cocotte, chauffez l\'huile d\'olive à feu moyen.
4. Faites dorer les morceaux de lapin des deux côtés pendant quelques minutes. Retirez-les de la cocotte et réservez.
5. Dans la même cocotte, ajoutez un peu plus d\'huile si nécessaire, puis faites revenir les oignons et l\'ail jusqu\'à ce qu\'ils soient translucides.
6. Ajoutez les morceaux de lapin dans la cocotte, puis versez le vin blanc et le bouillon de poulet.
7. Ajoutez les quartiers de pommes dans la cocotte.
8. Assaisonnez avec du sel et du poivre selon votre goût.
9. Couvrez et laissez mijoter à feu doux pendant environ 45 minutes à 1 heure, jusqu\'à ce que le lapin soit tendre.
10. Juste avant de servir, incorporez la moutarde et la crème fraîche, mélangez bien et laissez mijoter encore quelques minutes.
11. Servez chaud, accompagné de pommes de terre ou de riz.', 'lien_photo38.jpg', '2024-05-04', 8),

('Agneau aux Pommes', 'Ingrédients:
- 800g d\'épaule d\'agneau désossée et coupée en morceaux
- 4 pommes
- 2 oignons
- 2 gousses d\'ail
- 200ml de vin rouge
- 200ml de bouillon de légumes
- 2 cuillères à soupe de miel
- 2 cuillères à soupe de vinaigre balsamique
- Sel et poivre au goût
- 2 cuillères à soupe d\'huile d\'olive

Préparation:
1. Epluchez et coupez les pommes en quartiers.
2. Emincez les oignons et hachez l\'ail.
3. Dans une grande cocotte, chauffez l\'huile d\'olive à feu moyen.
4. Faites dorer les morceaux d\'agneau des deux côtés pendant quelques minutes. Retirez-les de la cocotte et réservez.
5. Dans la même cocotte, ajoutez un peu plus d\'huile si nécessaire, puis faites revenir les oignons et l\'ail jusqu\'à ce qu\'ils soient translucides.
6. Remettez les morceaux d\'agneau dans la cocotte, puis versez le vin rouge et le bouillon de légumes.
7. Ajoutez les quartiers de pommes dans la cocotte.
8. Assaisonnez avec du sel et du poivre selon votre goût.
9. Ajoutez le miel et le vinaigre balsamique.
10. Couvrez et laissez mijoter à feu doux pendant environ 1 heure à 1 heure 30, jusqu\'à ce que l\'agneau soit tendre.
11. Servez chaud, accompagné de légumes de saison ou de riz.', 'lien_photo39.jpg', '2024-05-04', 9),

('Salade de Riz aux Pommes', 'Ingrédients:
- 200g de riz basmati
- 2 pommes
- 1 poignée de raisins secs
- 1 poignée de noix concassées
- 1 poignée de céleri coupé en dés
- 1 poignée de persil frais haché
- Jus d\'un citron
- 3 cuillères à soupe d\'huile d\'olive
- Sel et poivre au gout

Préparation:
1. Faites cuire le riz basmati selon les instructions sur l\'emballage. Une fois cuit, laissez-le refroidir.
2. Pendant ce temps, coupez les pommes en dés et arrosez-les avec le jus de citron pour éviter qu\'elles ne brunissent.
3. Dans un grand saladier, mélangez le riz cuit, les dés de pommes, les raisins secs, les noix concassées, le céleri et le persil haché.
4. Assaisonnez la salade avec l\'huile d\'olive, du sel et du poivre selon votre gout.
5. Réfrigérez la salade pendant au moins 30 minutes avant de servir pour permettre aux saveurs de se mélanger.
6. Servez frais en accompagnement d\'un plat principal ou en entrée légère.', 'lien_photo40.jpg', '2024-05-04', 10);



INSERT INTO Commentaires (commentaire, `jour-comment`, Utilisateurs_id, Recettes_id, Commentaires_id) VALUES
('Délicieux, les pommes du Prince sont un régal.', '2024-04-19', 6, 1, NULL),
('Jadore cette recette, parfaite pour les soirées dautomne!', '2024-04-20', 10, 1, NULL),
('Un smoothie rafraîchissant et délicieux!', '2024-04-18', 2, 11, NULL),
('Mes enfants ont adoré ce smoothie aux pommes!', '2024-04-20', 29, 11, NULL),
('Ce tiramisu est tout simplement magique!', '2024-04-19', 14, 19, NULL),
('Une recette facile et délicieuse, merci!', '2024-04-20', 8, 22, NULL),
('Jai essayé cette recette hier soir et elle était délicieuse!', '2024-04-23', 15, 38, NULL),
('La tarte aux pommes est un grand classique, et cette recette est parfaite!', '2024-04-24', 19, 14, NULL),
('Les pommes sont un fruit si polyvalent, merci pour cette recette!', '2024-04-25', 20, 34, NULL),
('Je suis toujours à la recherche de nouvelles façons de cuisiner les pommes, celle-ci est super!', '2024-04-25', 17, 39, NULL),
('Ces recettes de pommes sont incroyables, merci de les partager!', '2024-04-24', 21, 26, NULL),
('Le roquefort est magique!', '2024-04-19', 26, 29, NULL),
('Une recette facile et rapide, merci!', '2024-04-20', 18, 40, NULL),

('C\est toujours agréable de recevoir des retours positifs!', '2024-04-21', 2, NULL, 2),
('Content que vos enfants aient aimé!', '2024-04-22', 23, NULL, 4),
('Merci pour vos commentaires positifs!', '2024-04-21', 1, NULL, 7),
('Ravi que vous ayez apprécié la recette!', '2024-04-22', 6, NULL, 13),
('Merci pour vos commentaires positifs!', '2024-04-21', 24, NULL, 10),
('Ravi que vous ayez apprécié la recette!', '2024-04-22', 6, NULL, 6),
('Merci!', '2024-04-24', 6, NULL, 11);