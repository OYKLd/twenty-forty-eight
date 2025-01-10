# 2048 Game Clone

## Description
Ce projet est une implémentation du célèbre jeu **2048**, développé avant sa sortie officielle en avril 2014.  
Le but du jeu est de combiner des tuiles numérotées sur une grille pour atteindre une tuile de valeur **2048**.  

Les joueurs peuvent glisser les tuiles dans quatre directions (haut, bas, gauche, droite), et de nouvelles tuiles apparaissent aléatoirement après chaque mouvement. Le jeu se termine lorsqu'il n'y a plus de mouvements possibles. Ce projet inclut une interface utilisateur réactive et des fonctionnalités comme un suivi des scores, ainsi qu'une option pour recommencer une partie.

---

## Fonctionnalités principales

- **Grille 4x4** :  
  Le jeu commence avec une grille contenant 3 à 4 tuiles placées aléatoirement, avec des valeurs de 2 ou 4.

- **Mouvements des tuiles** :  
  Les tuiles peuvent être déplacées dans l'une des quatre directions (haut, bas, gauche, droite).  
  Les tuiles se déplacent aussi loin que possible dans la direction choisie.

- **Fusion des tuiles** :  
  Si deux tuiles de même valeur entrent en collision, elles fusionnent pour former une nouvelle tuile ayant une valeur double.  
  Le score est mis à jour en conséquence.

- **Génération de nouvelles tuiles** :  
  Après chaque mouvement, une nouvelle tuile (valeur de 2 ou 4) apparaît aléatoirement dans un emplacement vide.

- **Conditions de fin** :  
  Le jeu se termine lorsque la grille est pleine et qu'aucun mouvement légal n'est possible.

- **Suivi des scores** :  
  - Affichage en temps réel du score actuel.  
  - Suivi du meilleur score (mis à jour automatiquement).

- **Bouton Restart** :  
  Permet de recommencer une nouvelle partie.

---

## Instructions d'installation et d'exécution

### Étape 1 : Cloner le projet
```bash
git clone https://github.com/OYKLd/twenty-forty-eight.git
cd twenty-forty-eight
