## Advanced sketches
<img src=https://github.com/gavinschipper/programmeerproject/blob/master/doc/newFlow.png>

## Classes & functions
<img src=https://github.com/gavinschipper/programmeerproject/blob/master/doc/diagram.png>

## API
Food2Fork Recipe API
(https://food2fork.com/about/api)

## Data source
De data source die bij deze app gebruikt wordt is de hierboven beschreven API. De API heeft twee verschillende soorten query's, namelijk:
* **Search**: Bij de search functie kun je een zoekopdracht meegeven. In het geval van deze app zijn dat de ingrediënten die de gebruiker opgeeft. Verder kan je meegeven hoe de resultaten gesorteerd moeten worden en welke pagina van resultaten je wil zien (max 30 resultaten per pagina). Van alle recepten krijg je onder andere een ID, een foto, en de bron terug. De variabelen zijn in de vorm "image_url". Dit zal getransformeerd worden naar "imageURL".
* **GET Recipe**: Bij de GET Recipe functie kun je een een recipe ID meegeven. Je krijgt dan alle informatie over het recept terug,     waaronder de ingrediënten, de naam van het recept en op welke website de bereidingswijze van het recept te vinden is. De variabelen zijn in de vorm "image_url". Dit zal getransformeerd worden naar "imageURL".

## Database
* User
  * username
  * email
  * favorites
    * recipeID
* Recipes
  * recipeID
    * reviews

