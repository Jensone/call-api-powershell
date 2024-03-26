# Pseudo-code pour CallAPI

## Problème

Un client souhaite avoir accès aux informations de n'importe quel pays, ceci à l'aide d'un programme dans son terminal de commande. Il souhaite également que ces informations soient enregistrées sous n'importe quel format afin d'y accéder de nouveau

## Scénario

Le client lance le programme dans le terminal de commande, il saisit les initiales du pays souhaité, les informations sont récupérées. Un fichier au format .html est créé et les données y sont insérées dans un format lisible et facile d'accès.

## Pseudo-code

Variables :

- initialesPays = string
- endpointApi = "https://restcountries.com/v3.1/alpha"
- response  = Json
- nomPays  = string
- capitalPays  = string
- populationPays  = string
- devisePays  = string

```
DEBUT
    Inviter l'utilisateur à saisir les initiales d'un pays
    Affecter le contenu dans la variable `initialesPays`
    Préparer l'appel à l'API Restcountries
        `endpointApi`/`initialesPays`
    Lancer l'appel à l'API Restcountries
    Récupérer la réponse de l'appel API dans un variable `response`
    Convertir le contenu depuis le Json
    Affecter les valeurs à la liste des variable pour l'affichage
    Créer le document HTML
        "fiche-`initialesPays`.html"
        On insère les données dans le fichier
    Afficher un message de fin
FIN
```