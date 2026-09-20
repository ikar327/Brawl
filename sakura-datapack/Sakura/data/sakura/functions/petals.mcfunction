# Dywan z rozowych platkow wokol gracza
execute store success score #sakura sakura.ok run execute at @s run place feature sakura:flower_sakura_petals ~ ~ ~
execute if score #sakura sakura.ok matches 0 run function sakura:internal/fail
