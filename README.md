# Call API avec PowerShell

Dans cette exercice, nous allons communiquer avec une API en utilisant PowerShell. Pour ce faire, nous allons utiliser l'API de [Restcountries](https://restcountries.com/). Cette API permet de récupérer des informations sur les pays du monde.

## Objectifs

Créer un programme en PowerShell qui permet de récupérer les informations suivantes sur un pays donné.

-   Nom du pays
-   Capitale
-   Population
-   Continent

Ces informations devront être insérée dans un fichier .html qui contiendra le code HTML suivant :

```html
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Informations sur le pays : $nomPays</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css"/>
    </head>
    <body>
        <h1>Informations sur le pays $nomPays</h1>
        <ul>
            <li>Nom: $nomPays</li>
            <li>Capitale: $capitalPays</li>
            <li>Population: $populationPays</li>
            <li>Continent: $continent</li>
        </ul>
    </body>
</html>
```
---

## Étapes

1. Créer un algorigramme pour le programme
2. Rédiger le pseudo-code du programme
3. Implémenter le programme en PowerShell
4. Tester le programme avec un pays de votre choix
