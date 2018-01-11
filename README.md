# Programmeerproject

## Problem statement
Wanneer je kookt, gebruik je niet altijd alle producten (helemaal) die je in huis gehaald hebt, of soms komt er iets tussen waardoor je de gekochte producten helemaal niet gebruikt. Vaak hebben deze producten een houdbaarheidsdatum, dus ze zullen binnen aanzienbare tijd alsnog gebruikt moeten worden omdat ze anders bederven. Het is namelijk zonde deze (overige) producten weg te gooien. Het is echter ook niet altijd makkelijk om een gerecht te bedenken waar je deze ingrediënten alsnog voor kan gebruiken. Hier zou wat assistentie handig voor zijn. De doelgroep is hierbij dus mensen die zuinig zijn/het zonde vinden om ongebruikt eten weg te gooien. 

## Solution
### Summary
Een app die op basis van de producten die jij nog hebt op zoek gaat naar recepten waar je de producten voor kan gebruiken. 

### Visual sketch
<img src=https://github.com/gavinschipper/programmeerproject/blob/master/doc/Flow.png>

### Main features
* Recepten zoeken op basis van ingrediënten die je nog hebt. 
* Beperken tot een bepaald soort recepten.
* Sorteren op beoordeling of populairiteit.
* Binnen de app de bereidingswijze tonen op de website/blog waar het recept vandaan komt.
* Account maken/inloggen
* Recepten in favorieten opslaan.
* Reviews schrijven over een recept

### MVP/optional
Een gebruiker zal op zijn minst in staat moeten zijn om op basis van ingrediënten die hij/zij nog in huis heeft recepten te vinden. Verder zal men minstens een link naar de bereidingswijze moeten kunnen vinden die de gebruiker leidt naar de website waar het recept vandaan komt. Het is echter beter als de bereidingswijze binnen de app getoond wordt wanneer hier om gevraagd wordt. Ook het opslaan van recepten als favoriet moet mogelijk zijn, omdat een gebruiker anders steeds opnieuw naar hetzelfde recept moet zoeken. Dit kost veel tijd en moeite. Tot slot zal een gebruiker nog in staat moeten zijn om reviews te schrijven over een recept en de reviews van andere gebruikers te bekijken.

Een functie voor die app die optioneel is, is de mogelijkheid om een boodschappenlijstje te maken voor de producten die je nog wel moet halen voor het maken van een bepaald recept. 

## Prerequisites 
Ik verwacht dat het moeilijkste onderdeel van de app wordt om ervoor te zorgen dat de webpagina's van de websites/blogs waar de recepten staan in de app getoond worden, in plaats van dat de browser apart wordt opgestart. 

### Data source
* Food2Fork Recipe API (http://food2fork.com/about/api)

### External components
* Firebase Database
* Firebase Auth

## Better Code Hub
[![BCH compliance](https://bettercodehub.com/edge/badge/gavinschipper/programmeerproject?branch=master)](https://bettercodehub.com/)
