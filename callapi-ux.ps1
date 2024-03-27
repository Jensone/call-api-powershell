# Ceci est une version plus aboutie du script callapi.ps1 avec une interface utilisateur plus conviviale.

Write-Host "
▄████████    ▄████████  ▄█        ▄█          ▄████████    ▄███████▄  ▄█  
███    ███   ███    ███ ███       ███         ███    ███   ███    ███ ███  
███    █▀    ███    ███ ███       ███         ███    ███   ███    ███ ███▌ 
███          ███    ███ ███       ███         ███    ███   ███    ███ ███▌ 
███        ▀███████████ ███       ███       ▀███████████ ▀█████████▀  ███▌ 
███    █▄    ███    ███ ███       ███         ███    ███   ███        ███  
███    ███   ███    ███ ███▌    ▄ ███▌    ▄   ███    ███   ███        ███  
████████▀    ███    █▀  █████▄▄██ █████▄▄██   ███    █▀   ▄████▀      █▀   
                        ▀         ▀                                        
"

Write-Host "
Bienvenue sur l'application de recherche d'informations sur les pays du monde.

Veuillez suivre les instructions pour obtenir les informations sur un pays.

Comment ça marche ?
1. Saisissez les initiales du pays que vous souhaitez rechercher.
    Les initiales du pays doivent être composées de 2 ou 3 caractères.
    ** Exemple : France -> FR, Allemagne -> DE, Suisse -> CH **
2. L'application va rechercher les informations sur le pays que vous avez demandé.
3. Les informations sur le pays seront enregistrées dans un fichier HTML.

Pour quitter l'application, appuyez sur Ctrl + C
"

function lauchApp {

# ----------------- Saisie des initiales du pays -----------------
$initialesPays = $null
while ($true) {
    $initialesPays = Read-Host "Renseignez les initiales du pays que vous souhaitez"
    if ($initialesPays.Length -eq 2) {
        break
    }
    Write-Host "Les initiales du pays doivent être composées de 2 ou 3 caractères"
}

# ----------------- Récupération des informations sur le pays -----------------
if (-not (Test-Connection -ComputerName "restcountries.com" -Quiet)) {
    Write-Host "Désolé. Vous n'êtes pas connecté à Internet. Veuillez vérifier votre connexion et réessayer."
    exit
}

Write-Host "Recherche des informations sur le pays en cours..."
sleep(3) # Simule un délai de 3 secondes

$endpointApi = "https://restcountries.com/v3.1/alpha/$initialesPays"
$response = Invoke-RestMethod $endpointApi -Method Get

$nomPays = $response.name.common ? $response.name.common : $null
$capitalPays = $response.capital ? $response.capital : $null
$populationPays = $response.population ? [double]::Parse($response.population).ToString("N0") : $null
$continent = $response.region ? $response.region : $null
$flag = $response.flag ? $response.flag : $null
$carte = $response.maps.googleMaps ? $response.maps.googleMaps : $null

if ($nomPays -eq $null -or $capitalPays -eq $null -or $populationPays -eq $null -or $continent -eq $null -or $flag -eq $null -or $carte -eq $null) {
    Write-Host "Désolé. Les informations sur le pays que vous avez demandé ne sont pas disponibles"
    lauchApp
}

Write-Host "
Les informations sur le pays ont été trouvées avec succès !
Création de la fiche pays en cours...
"

# ----------------- Création de la fiche HTML -----------------
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
        <main class="container">
            <dialog open>
                <article>
                    <h2>$nomPays $flag</h2>
                    <ul>
                        <li>Capitale : $capitalPays</li>
                        <li>Population : $populationPays</li>
                        <li>Continent : $continent</li>
                    </ul>
                    <hr>
                    <p>
                        $nomPays est situé en <strong>$continent</strong>, pour en savoir plus, visitez la carte du pays sur <a href="$carte" target="_blank">GoogleMaps</a>.
                    </p>
                </article>
            </dialog>
        </main>
    </body>
</html>
"@

# ----------------- Enregistrement des informations sur le pays -----------------
$sortieRepertoire = "$env:HOME/powershell/fiches"
sleep(3) # Simule un délai de 3 secondes
$nomFichier = "fiche-$initialesPays.html"
$sortieFichier = Join-Path $sortieRepertoire -ChildPath $nomFichier
$contenuHtml | Out-File -Path $sortieFichier -encoding  UTF8

Write-Host "Les informations sur le pays que vous avez demandé ont été ajoutées dans le fichier $sortieFichier"
}

# ----------------- Lancement du programme -----------------
lauchApp
