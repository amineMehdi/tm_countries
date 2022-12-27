# TM_countries

Ce projet est une application mobile qui permet de consulter les informations sur les pays du monde.

Cette application est développée en Flutter.

Cette application affiche tous les pays du monde avec leurs informations quand on clique sur un pays.

## Fonctionnalités

Cette application permet de : 

### Favoris 

Ajouter un pays en favoris et le supprimer.

### Localisation

Localiser le pays ou vous vous trouvez et afficher les informations sur ce pays.

### Informations

Afficher les informations sur un pays, sa superficie, son population etc... 

## Architecture

Cette application est developpee en utilisant Bloc architecture, qui permet de gerer et enregistrer les etats de l'application d'une façon globale.

## Difficultés

Durant le developpement de cette application, j'ai rencontré plusieurs difficultés, notamment :

- La gestion des favoris : quand j'ajoute un pays en favoris, et je reviens à la page de favoris, le pays n'existe plus dans la liste des favoris, Pour resoudre ce probleme, j'ai utilisé un Cubit pour gerer les favoris, et qui garde en memoire les pays en favoris durant toute la session de l'application.

- La localisation : quand je veux localiser le pays dans la platteforme Web, `geocoding` ne fonctionne pas (fonctionne que pour iOS et Android), pour cela, je fais un appel API au site `http://ip-api.com/json` qui renvoie les informations concernant ma localisation, et donc le pays dans lequel je me trouve.

- Info sur le pays : quand je veux afficher les informations sur un pays et que je veux afficher les voisins de ce pays, par defaut, je fais un appel d'API pour recuperer les informations de ces pays, mais cela est redondant, puisque je peux les recuperer à partir de la liste des pays precedemment chargée. Le probleme c'est que le Cubit des pays n'est pas accessible dans la page des informations sur le pays selectionné, et quand je veux l'acceder dans la page des informations, il est reinitialisé. Pour resoudre ce probleme, je vais implementer un singleton qui est accessible dans toute l'application en utilisant le package `get_it`. (À implémenter).

## A venir

- Implémenter le singleton pour acceder aux pays dans toute l'application.
- Ajouter une barre de recherche pour rechercher un pays.
- Ajouter un filter pour trier les pays par nom, population, superficie etc...
