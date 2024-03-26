# Inviter l'utilisateur à saisir les initiales d'un pays
# Affecter le contenu dans la variable `initialesPays`
$initialesPays = Read-Host "Renseignez les initiales du pays que vous souhaitez"

# Préparer l'appel à l'API Restcountries
#     `endpointApi`/`initialesPays`
$endpointApi = "https://restcountries.com/v3.1/alpha/$initialesPays"

# Lancer l'appel à l'API Restcountries
# Récupérer la réponse de l'appel API dans un variable `response`
$response = Invoke-RestMethod $endpointApi

# Affecter les valeurs à la liste des variable pour l'affichage
$nomPays = $response.name.common
$capitalPays = $response.capital
$populationPays = $response.population
$continent = $response.region

# Créer le document HTML
#     "fiche-`initialesPays`.html"
#     On insère le contenu avec les données dans le fichier
$contenuHtml = @"
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
            <li>Nom : $nomPays</li>
            <li>Capitale : $capitalPays</li>
            <li>Population : $populationPays</li>
            <li>Continent : $continent</li>
        </ul>
    </body>
</html>
"@

$sortieRepertoire = "$env:HOME/powershell" # Chemin pour Mac & Linux
# $sortieRepertoie = "C:\users\powershell" # Chemin pour Windows
$nomFichier = "fiche-$initialesPays.html"
$sortieFichier = Join-Path $sortieRepertoire -ChildPath $nomFichier

$contenuHtml | Out-File -Path $sortieFichier -encoding  UTF8

# Afficher un message de fin
Write-Host "Les informations sur le pays que vous avez demandé ont été ajoutées dans le fichier $nomFichier"
