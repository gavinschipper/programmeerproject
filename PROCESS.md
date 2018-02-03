# 15-1-2018
Nog steeds ziek dus helaas niet echt aan de app kunnen werken. Wel een beetje geëxperimenteerd met de API. Via Postman krijg ik gemakkelijk data uit de API. Wanneer ik het in xcode probeer met code die zou moeten werken, krijg ik een foutmelding.

# 16-1-2018
Fout van vorige dag is opgelost en het is gelukt om vanuit de app data op te halen uit de API. Aan de slag met een search interface. 

# 17-1-2018
Login functie en account maken in app gezet. Account maken en inloggen werkt, alleen lukt het nog niet om de username in de database op te slaan. Uitzoeken hoe ik dit het beste kan doen!

# 18-1-2018
Bezig geweest met het tonen van de resultaten in een table view. Wanneer gebruiker op de 'search' button drukt wordt hij doorgestuurd naar de resulatenpagina en de query wordt meegestuurd. Het tonen van de juiste data werkt helaas nog niet precies. 

# 19-1-2018
Het tonen van de resultaten werkt deels. De naam van de recepten wordt aangepast, alleen de afbeelding klopt nog niet. ImageURL staan met 'http' in de API. Xcode heeft moeite met 'http', dus ImageURL's moeten eigenlijk met 'https' zijn. Uitzoeken hoe ik dit het beste kan doen.

# 22-1-2018
Het tonen van de resultaten werkt volledig. Ook de afbeeldingen worden correct ingeladen. DetailView werkt ook en alles wordt goed ingeladen. Het tonen van de instructions website werkt nog niet. Uitzoeken hoe dit precies werkt. Ook problemen bij login pagina. Geprobeerd om bepaalde textfields en labels te verbergen voor users die al ingelogd zijn. Deze worden nog voor het inloggen al gehide. Misschien omdat de log out button nog niet werkt? Morgen uitzoeken..

# 23-1-2018
Instructions website wordt soms correct getoond, en soms niet. Mogelijk een probleem met de URL's in de API. Login pagina, create account pagina en log out werken goed. De juiste textfields en labels worden aan de juiste gebruikers getoond. Bezig geweest met favorieten. Deze kunnen correct opgeslagen in en verwijderd worden uit de database. Het inladen in de app gaat nog niet vlekkeloos. Soms wordt er niks getoond en soms worden recepten dubbel getoond. Probleempje met de variabele waar de favorieten in opgeslagen worden. Deze moet gereset worden als de recepten opnieuw worden opgehaald. Morgen uitzoeken hoe dit moet. Verder besloten de 'reviews'-pagina te veranderen in een 'experiences'-pagina, waar mensen hun ervaring met een bepaald recept kunnen delen. Als er tijd over is alsnog een rating toevoegen, maar niet noodzakelijk. 

# 24-1-2018
Favorieten worden nu correct ingeladen en getoond. Experiences-pagina werkt ook. Gebruikers kunnen experiences toevoegen aan een recept en deze worden correct getoond. Wel nog werken aan de layout van de experiences-pagina. Cell hoogte moet nog afhankelijk gemaakt worden van hoe lang de tekst is. In principe zitten alle functies in de app, maar sommige werken nog buggy. 

# 25-1-2018
Experiences-button wordt correct geupdate met juiste aantal experiences bij een recept. Search bar bij de favorieten lijst toegevoegd en werkt correct. Bij het schrijven van een experience wordt gecheckt of gebruiker daadwerkelijk iets geschreven heeft, anders kan het niet opgeslagen worden. Alle functies werken correct, echter worden sommige schermen nog langzaam ingeladen. Kijken hoe dit verbeterd kan worden. Verder moet er nog veel gedaan worden aan de layout. Nog niet tevreden hiermee. 

# 26-1-2018 t/m 29-1-2018
Wegens overlijden van familielid niks aan project gedaan.

# 30-1-2018
Gewerkt aan het soepeler laten werken van de app door het gebruik van fades. Verder gewerkt aan het design van de app om hem mooier en meer gebruiksvriendelijk te maken. 

# 31-1-2018
Laatste design verbeteringen gedaan. Code opgeschoond en aan de hand van BetterCodeHub code verbeterd (bijv. stukken code minder lang gemaakt). Code beter gestructureerd. Begonnen met het schrijven van comments en beschrijven. Product demo opgenomen en geüpload.

# 1-2-2018
In alle files comments geplaatst en headers geschreven. Final code gecommit. README.me geupdate. LICENSE aangemaakt. Final report geschreven (niet helemaal, uitstel ivm crematie).

# 3-2-2018
Final report helemaal af. Project klaar.
