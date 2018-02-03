# Homemade - Final report

## Beschrijving
Homemade is een app waarmee je aan de hand van ingrediënten die je nog hebt recepten kan zoeken. Door aan te geven welke ingrediënten je wil gebruiken kan de app geschikte recepten vinden. Gebruikers kunnen nadat ze een account hebben aangemaakt recepten als favoriet opslaan. Verder kunnen gebruikers hun ervaringen met een recept delen met andere gebruikers door 'experiences' te schrijven.

<img src=https://github.com/gavinschipper/programmeerproject/blob/master/doc/1.png width="300">

## Design

### Sketches
De afbeelding hieronder laat een overzicht zien van de app met de verschillende controllers. De app is gemaakt op basis van een tab bar controller en is verdeeld in 3 verschillende tabs, om duidelijk onderscheid te maken tussen de verschillende onderdelen van de app en navigatie tussen deze onderdelen te vergemakkelijken. Hieronder zal rol van de verschillende classes besproken worden.
<img src=https://github.com/gavinschipper/programmeerproject/blob/master/doc/techDesign.png>

### Classes
#### ResultsController
In de ResultsController bevinden zich de functies die gebruikt worden om data van de API op te halen. Dit zijn twee verschillende functies. Één is bedoeld voor het ophalen van zoekresultaten aan de hand van ingrediënten. De ander is bedoeld voor het ophalen van een specifiek recept aan de hand van het recipeID. De functies kunnen in iedere class aangeroepen worden.

#### SearchViewController
De SearchViewController is het scherm dat meteen zichtbaar is wanneer de app geopend wordt. In deze view controller kan de gebruiker invoeren welke ingrediënten hij/zij wil gebruiken. Wanneer de gebruiker een ingrediënt toevoegt komt deze in de ingrediëntlijst te staan. Achter ieder ingrediënt in de lijst staat een verwijderknop waarmee het ingrediënt weer uit de lijst verwijderd kan worden. Wanneer op de 'search' knop gedrukt wordt, wordt gebruiker doorgestuurd naar de ResultsViewController en wordt de query ook doorgestuurd naar deze ViewController.

#### AccountViewController
The AccountViewController is the view where the user can either login, or when the user is already logged in, can log out and see which username he/she is logged in with. The outlets for both cases are in the view, but the right outlets are shown to the right user.

#### CreateAccountViewController
In the CreateAccountViewController the user is able to create an account. This is done by using Firebase. When the account is created, the username and email are also added to the database.

#### ResultsViewController
The resultsViewController collects the recipes that contain the given ingredients, using the fetch function. The results are loaded in the tableView. When a recipe is clicked, the recipeID is sent to the recipeDetailViewController.

#### RecipeDetailViewController
The RecipeDetailViewController shows the details of the recipe chosen in the resultsView. It shows the image of the recipe, the title of the recipe, the ingredients that have to be used for making the recipe and shows buttons that redirect to the instructions of the recipe or the experiences that were written about the recipe.

#### InstructionsViewController
The instructionsViewController shows the website/blog where the recipe originally came from in a webview.

#### FavoritesViewController
The FavoritesViewController shows all the favorites of a user in a tableview. The view contains a searchbar which makes it possible to search for a specific recipe in the favorites list. If the user is not logged in, a popup shows which tells the user he/she is not logged in. There is a button that redirects the user to the login page.

#### ExperiencesViewController
The ExperiencesViewController shows the experiences that user have written about a recipe. The controller collects all of the experiences and shows them in a tableview. For logged in users there is also a possibility to write an experience.

#### WriteExperienceViewController
In the WriteExperienceViewController users are able to write an experience about the chosen recipe. If the user submits the experience, the experience is added to the database.

#### RecipeTableViewCell
The tableview cell class that belongs to the tableviews in the ResultsViewController and the FavoritesViewController.

#### IngredientsTableViewCell
The table view cell class that belongs to the tableview on the RecipeDetailViewController.

#### SearchTableViewCell
The table view cell class that belongs to the tableview in the SearchViewController

#### ExperienceTableViewCell
The table view cell class that belongs to the ExperienceViewController

## Uitdagingen
