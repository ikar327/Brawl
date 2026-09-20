# Gaj sakury wokol gracza (najlepiej na plaskim terenie)
tellraw @s [{"text":"\u2740 Sadze gaj sakury...","color":"light_purple"}]
scoreboard players set #sakura.count sakura.ok 0
execute store success score #sakura sakura.ok run execute at @s positioned ~0 ~ ~0 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~6 ~ ~2 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~-5 ~ ~4 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~3 ~ ~-6 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~-7 ~ ~-3 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~9 ~ ~-7 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~-9 ~ ~7 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~11 ~ ~4 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~-3 ~ ~10 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~5 ~ ~9 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~-11 ~ ~-6 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~12 ~ ~-2 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~-2 ~ ~-11 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~8 ~ ~12 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute store success score #sakura sakura.ok run execute at @s positioned ~-12 ~ ~9 if block ~ ~-1 ~ #sakura:sakura_soil run place feature sakura:sakura_grove_random ~ ~ ~
scoreboard players operation #sakura.count sakura.ok += #sakura sakura.ok
execute at @s positioned ~0 ~ ~0 run place feature sakura:flower_sakura_petals ~ ~ ~
execute at @s positioned ~8 ~ ~6 run place feature sakura:flower_sakura_petals ~ ~ ~
execute at @s positioned ~-8 ~ ~-6 run place feature sakura:flower_sakura_petals ~ ~ ~
execute at @s positioned ~7 ~ ~-8 run place feature sakura:flower_sakura_petals ~ ~ ~
execute at @s positioned ~-7 ~ ~8 run place feature sakura:flower_sakura_petals ~ ~ ~
execute if score #sakura.count sakura.ok matches 1.. run tellraw @s [{"text":"\u2740 Posadzono drzew: ","color":"light_purple"},{"score":{"name":"#sakura.count","objective":"sakura.ok"},"color":"white"}]
execute if score #sakura.count sakura.ok matches 0 run function sakura:internal/fail
