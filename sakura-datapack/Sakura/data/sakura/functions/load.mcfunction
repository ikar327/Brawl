# Sakura - Kwitnace Drzewa Wisniowe  (Minecraft 1.20.6)
scoreboard objectives add sakura.ok dummy
tellraw @a [{"text":"[","color":"gray"},{"text":"\u2740 Sakura","color":"light_purple","bold":true},{"text":"] ","color":"gray"},{"text":"data pack zaladowany. Wpisz ","color":"white"},{"text":"/function sakura:help","color":"aqua","clickEvent":{"action":"suggest_command","value":"/function sakura:help"}},{"text":" po liste komend.","color":"white"}]
