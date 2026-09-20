# Losowe drzewo sakura w miejscu gracza
execute store success score #sakura sakura.ok run execute at @s run place feature sakura:sakura_random ~ ~ ~
execute if score #sakura sakura.ok matches 0 run function sakura:internal/fail
