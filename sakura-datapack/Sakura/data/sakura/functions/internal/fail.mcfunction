# Wywolywane, gdy place feature nie postawilo ani jednego drzewa
tellraw @s [{"text":"[","color":"gray"},{"text":"\u2740 Sakura","color":"light_purple","bold":true},{"text":"] ","color":"gray"},{"text":"Nie udalo sie postawic drzewa.","color":"red"}]
tellraw @s [{"text":"1. Brak miejsca","color":"white"},{"text":" - drzewo potrzebuje wolnego slupa 5x5 kratek na kilkanascie kratek w gore. Stan na otwartej przestrzeni.","color":"gray"}]
tellraw @s [{"text":"2. Swiat nie zna featurow z paczki","color":"white"},{"text":" - generacja swiata wczytuje sie tylko przy ladowaniu swiata. Wyjdz do menu i wejdz ponownie; samo /reload nie wystarczy.","color":"gray"}]
tellraw @s [{"text":"Test: ","color":"gray"},{"text":"/place feature sakura:","color":"aqua","clickEvent":{"action":"suggest_command","value":"/place feature sakura:"}},{"text":" - jesli podpowiedzi nie pokazuja sakura:sakura_tall, to przypadek 2.","color":"gray"}]
