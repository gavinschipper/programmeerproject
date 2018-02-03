# Homemade - Final report
###### door Gavin Schipper

## Beschrijving
Homemade is een app waarmee je aan de hand van ingrediënten die je nog hebt recepten kan zoeken. Door aan te geven welke ingrediënten je wil gebruiken kan de app geschikte recepten vinden. Gebruikers kunnen nadat ze een account hebben aangemaakt recepten als favoriet opslaan. Verder kunnen gebruikers hun ervaringen met een recept delen met andere gebruikers door 'experiences' te schrijven.

<img src=https://github.com/gavinschipper/programmeerproject/blob/master/doc/1.png width="300">

## Design

### Storyboard
De afbeelding hieronder laat een overzicht zien van de app met de verschillende controllers. De app is gemaakt op basis van een tab bar controller en is verdeeld in 3 verschillende tabs, om duidelijk onderscheid te maken tussen de verschillende onderdelen van de app en navigatie tussen deze onderdelen te vergemakkelijken. Hieronder zal rol van de verschillende classes besproken worden.
<img src=https://github.com/gavinschipper/programmeerproject/blob/master/doc/techDesign.png>

### Classes
#### ResultsController
In de ResultsController bevinden zich de functies die gebruikt worden om data van de API op te halen. Dit zijn twee verschillende functies. Één is bedoeld voor het ophalen van zoekresultaten aan de hand van ingrediënten. De ander is bedoeld voor het ophalen van een specifiek recept aan de hand van het recipeID. De functies kunnen in iedere class aangeroepen worden.

#### SearchViewController
De SearchViewController is het scherm dat meteen zichtbaar is wanneer de app geopend wordt. In deze view controller kan de gebruiker invoeren welke ingrediënten hij/zij wil gebruiken. Wanneer de gebruiker een ingrediënt toevoegt komt deze in de ingrediëntlijst te staan. Achter ieder ingrediënt in de lijst staat een verwijderknop waarmee het ingrediënt weer uit de lijst verwijderd kan worden. Wanneer op de 'search' knop gedrukt wordt, wordt gebruiker doorgestuurd naar de ResultsViewController en wordt de query ook doorgestuurd naar deze ViewController.

#### AccountViewController
De AccountViewController is het scherm waar de gebruiker kan inloggen, of kan uitloggen wanneer de gebruiker al ingelogd is. Alle outlets voor beide gevallen staan in dezelfde view, maar door middel van het verbergen van outlets worden de juiste outlets aan de juiste gebruiker getoond. Wanneer de login of logout button wordt geklikt, wordt er gebruik gemaakt van de bijbehorende Firebase functies. Wanneer de gebruiker correct is ingelogd wordt hij/zij doorgestuurd naar de SearchViewController. Wanneer de gebruiker de logout button klikt wordt hij opnieuw doorgestuurd naar de AccountViewController wat nu een login scherm is. Wanneer de gebruiker op de Create Account button klikt wordt hij/zij doorgestuurd naar de CreateAccountViewController. 

#### CreateAccountViewController
In de CreateAccountViewController kan een gebruiker een account aanmaken. De gebruiker moet hiervoor een username, email en password opgegeven. Het emailadres en wachtwoord worden gebruikt om in Firebase het account aan te maken. De username van de gebruiker wordt in de database opgeslagen om te gebruiken als weergavenaam in de app. Wanneer een veld niet correct is ingevuld of als er iets fout gegaan is met het creëren van een account krijgt de gebruiker altijd een waarschuwing te zien.

#### ResultsViewController
Wanneer een gebruiker op de zoek-knop heeft geklikt komt hij/zij op de ResultsViewController terecht. Hier wordt de API geraadpleegd voor recepten met de opgeven ingrediënten. Wanneer deze opgehaald zijn worden ze allemaal onder elkaar getoond, met naam en afbeelding, gebruikmakend van de class RecipeTableViewCell. Wanneer er op een recept geklikt wordt, wordt de gebruiker doorgestuurd naar de RecipeDetailViewController en wordt het 'recipeID' meegestuurd.

#### RecipeDetailViewController
De RecipeDetailViewController is het scherm waar de details van het gekozen recept getoond worden. Nogmaals worden de afbeelding en de naam van het recept getoond. Echter wordt nu ook een lijst getoond van de ingrediënten die nodig zijn om het recept te maken en knoppen die leiden naar de bereidswijze van het recept (InstructionsViewController) of de ervaringen die gebruikers over het recept geschreven hebben (ExperiencesViewController). Verder is er op de pagina nog een favorite-knop. Deze wordt alleen getoond wanneer de gebruiker ingelogd is. Wanneer de gebruiker ingelogd is, wordt bij het openen van de pagina ook gecheckt of het recept al in de favorieten van de gebruiker staat. De knop wordt aan de hand daarvan uiteraard naar de juiste staat gezet.

#### InstructionsViewController
Op de InstructionsViewController kan de gebruiker lezen hoe het gekozen recept gemaakt moet worden. De bereidswijze is niet opgenomen in de API, maar de link naar de website/blog van het recept wel. Daarom wordt in deze view de website geopend in een WebView. Wanneer linksboven op 'done' geklikt wordt, sluit de view weer.

#### FavoritesViewController
De FavoritesViewController laat een lijst zien van alle recepten die een gebruiker in zijn favorieten gezet heeft. Dit gebeurt op dezelfde manier als bij de ResultsViewController, namelijk door gebruik te maken van de class RecipeTableViewCell. De ViewController heeft ook een zoekbalk, waarmee makkelijk gezocht kan worden naar een specifiek recept. De FavoritesViewController is alleen bereikbaar als een gebruiker ingelogd is. Wanneer een gebruiker namelijk de tab opent wanneer deze gebruiker niet ingelogd is, krijgt hij/zij gelijk een popup te zien met deze melding. Vanuit de popup kan de gebruiker gemakkelijk naar de loginpagina gaan. Wanneer de gebruiker in de ViewController op een recept klikt wordt hij doorverwezen naar de RecipeDetailViewController, net als bij de ResultsViewController.

#### ExperiencesViewController
Op de ExperiencesViewController verschijnen ervaringen die gebruikers gedeeld hebben over het gekozen recept. Deze worden geladen uit de Firebase database. Zo kunnen gebruikers bijvoorbeeld tips geven om het recept makkelijker te maken of extra lekker te maken. Rechtsboven bevindt zich een knop die leidt naar het scherm waar een gebruiker zelf een experience kan schrijven (WriteExperienceViewController). Deze is alleen beschikbaar voor gebruikers die ingelogd zijn. 

#### WriteExperienceViewController
In the WriteExperienceViewController kunnen ingelogde gebruikers een experience schrijven. Als ze klaar zijn met schrijven kunnen ze de experience opslaan en deze wordt dan opgeslagen in de Firebase database. Voordat dit gebeurd wordt er eerst gecheckt of het textvak niet leeg is. Als dit wel het geval is krijgt de gebruiker een melding. Na het opslaan van de experience wordt de gebruiker teruggestuurd naar de ExperiencesViewController.

#### RecipeTableViewCell
De RecipeTableViewCell is de class die gebruikt wordt om de cellen in de tableviews van de ResultsViewController en de FavoritesViewController in te vullen. 

#### IngredientsTableViewCell
De RecipeTableViewCell is de class die gebruikt wordt om de cellen in de tableview van de RecipeDetailViewController in te vullen. 

#### SearchTableViewCell
De SearchTableViewCell is de class die gebruikt wordt om de cellen in de tableview van de SearchViewController in te vullen. Hierbij is ook een delegate gemaakt die ervoor zorgt dat iedere regel een verwijder knop heeft die het bijbehorende ingrediënt verwijdert uit de ingrediëntenlijst.

#### ExperienceTableViewCell
De ExperienceTableViewCell is de class die gebruikt wordt om de cellen in de tableview van de ExperiencesViewController in te vullen. 

## Uitdagingen

## Future work
