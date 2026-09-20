# 🌸 Sakura — data pack z kwitnącymi drzewami wiśniowymi

Data pack do **Minecraft 1.20.6** (Java Edition), który zamienia zwykłe wiśnie w prawdziwe
japońskie **sakury**: pięć wariantów drzew, gęstsze gaje, dywany z różowych płatków
i opadające płatki w powietrzu.

Nie wymaga modów — to czysty data pack (`pack_format 41`).

## Instalacja

**Nowy świat**

1. Zbuduj archiwum: `./build.sh` (powstanie `dist/Sakura-1.20.6.zip`) — albo spakuj ręcznie
   **zawartość** katalogu `Sakura/` (czyli `pack.mcmeta` + `data/` muszą być w korzeniu ZIP-a).
2. Przy tworzeniu świata: **Data Packs → przeciągnij ZIP** (lub kliknij „Otwórz folder paczek”
   i wrzuć go tam), przenieś na listę aktywnych, utwórz świat.

**Istniejący świat**

1. Skopiuj ZIP (lub cały folder `Sakura/`) do `saves/<twój_świat>/datapacks/`.
2. W grze: `/reload`, a następnie `/datapack list` — `Sakura` powinna być na liście aktywnych.

> ⚠️ Zmiany w generacji świata (nowe drzewa w biomach) pojawią się tylko w **nowo generowanych
> chunkach**. Już wczytany teren zostaje bez zmian — wszystko inne (sadzonki, komendy, dropy,
> receptury) działa od razu.

## Nic się nie dzieje po komendzie?

To najczęstszy haczyk data packów: **generacja świata wczytuje się wyłącznie przy ładowaniu świata**.
`/reload` przeładowuje funkcje, receptury, tablice łupów i tagi — ale **nie** rejestry worldgenu
(`configured_feature`, `placed_feature`, `biome`). Jeśli wrzuciłeś paczkę do już otwartego świata
i zrobiłeś `/reload`, to funkcje działają, ale `place feature sakura:...` nie zna jeszcze drzew,
a komendy w funkcjach **nie pokazują błędów w czacie** — stąd wrażenie, że nic się nie dzieje.

**Lekarstwo:** wyjdź do menu głównego (Save and Quit) i wejdź do świata ponownie.

**Szybki test:** wpisz w czacie `/place feature sakura:` i spójrz na podpowiedzi.
* Widzisz `sakura:sakura_tall` i resztę → rejestry są wczytane, a problem to miejsce (patrz niżej).
* Nie widzisz nic → świat nie przeładował paczki, wyjdź i wejdź ponownie.

**Za mało miejsca.** Drzewo stawia się tylko wtedy, gdy ma gdzie rosnąć: potrzebuje wolnego słupa
5×5 kratek na kilkanaście kratek w górę. Pod dachem, w lesie albo w wykopie `place feature` zwróci
„nie udało się" i nie postawi ani jednego bloku. Stań na otwartym terenie — albo zacznij od
`/function sakura:variant/small`, które potrzebuje znacznie mniej przestrzeni.

**Sprawdzanie błędów na piechotę.** Ta sama komenda wpisana ręcznie w czacie *pokaże* powód
niepowodzenia (funkcje go połykają):

```
/place feature sakura:sakura_tall ~ ~ ~
```

Od wersji z tej paczki funkcje same meldują porażkę i podpowiadają, co sprawdzić.

**Serwer nie wstaje / paczka „could not be parsed".** Sprawdź log — Minecraft wypisuje
dokładnie, który plik i które pole odrzucił, np. `Value provider too high: 3 [2-4]` znaczy
„pole przyjmuje najwyżej 3, a dostało zakres 2–4". Zanim wgrasz zmienione pliki, przepuść
paczkę przez dołączony skrypt:

```
python3 validate.py
```

Sprawdza składnię JSON, referencje między plikami i zakresy liczb wymuszane przez kodeki 1.20.6
(to na nich wyłożyła się pierwsza wersja paczki: `branch_count` w `cherry_trunk_placer`
przyjmuje wyłącznie 1–3).

## Co dodaje paczka

### 5 wariantów drzew sakura

| Wariant | ID | Opis |
|---|---|---|
| Mała sakura | `sakura:sakura_small` | niska, 4–6 kratek, do ogródków |
| Klasyczna | `sakura:sakura_classic` | odpowiednik wiśni z vanilli + ule |
| Wysoka | `sakura:sakura_tall` | 10–13 kratek, szeroka korona (promień 5) |
| Płacząca | `sakura:sakura_weeping` | długie, zwisające kaskady liści |
| Prastara | `sakura:sakura_ancient` | ogromna, 13–16 kratek, 3 konary po 5–7 kratek, korona o promieniu 6 |
| Krzew | `sakura:sakura_bush` | niski krzaczek wiśniowy do poszycia |

### Generacja świata

* **Cherry Grove** — dodatkowe 3–5 sakur na chunk (w tym rzadko *prastara*), więcej płatków
  na ziemi oraz delikatnie opadające płatki w powietrzu (cząsteczki biomu).
* **Flower Forest** i **Meadow** — pojedyncze sakury (średnio co 4. chunk) + płatki w kwiecistym lesie.
* **Forest** i **Plains** — rzadkie, pojedyncze sakury (średnio co 16. chunk).

### Rozgrywka

* **Sadzonka wiśni** wyrasta teraz w losowy wariant sakury (mała / klasyczna / wysoka / płacząca),
  a nie zawsze w to samo drzewo.
* **Liście wiśni** przy zbieraniu bez nożyc mają 12% szans na 1–2 **różowe płatki**.
* **Receptury:**
  * 9 × różowe płatki → 1 × sadzonka wiśni,
  * 2 × liście wiśni → 2 × różowe płatki.
* **3 osiągnięcia:** *Sakura*, *Hanami*, *Prastara Sakura*.

### Komendy

| Komenda | Efekt |
|---|---|
| `/function sakura:help` | lista komend |
| `/function sakura:tree` | losowa sakura w miejscu, w którym stoisz |
| `/function sakura:grove` | cały gaj (do 15 drzew + płatki) wokół gracza |
| `/function sakura:petals` | dywan z różowych płatków |
| `/function sakura:variant/small` … `/ancient`, `/bush`, `/classic`, `/tall`, `/weeping` | konkretny wariant |

Komendy stawiają drzewo dokładnie na wysokości twoich stóp, więc najlepiej działają na
płaskim terenie. `sakura:grove` sadzi drzewo tylko tam, gdzie pod spodem jest ziemia/trawa
(tag `#sakura:sakura_soil`), więc na nierównym terenie postawi ich mniej.
Drzew możesz użyć też bezpośrednio: `/place feature sakura:sakura_ancient ~ ~ ~`.

## Zgodność

Paczka **nadpisuje** kilka plików vanilli — może się to gryźć z innymi data packami,
które ruszają te same pliki:

* `minecraft:worldgen/biome/{cherry_grove, meadow, flower_forest, forest, plains}` — dopisane
  nowe drzewa (reszta biomu bit w bit jak w vanilli 1.20.6),
* `minecraft:worldgen/configured_feature/cherry` — losowanie wariantu przy wzroście sadzonki,
* `minecraft:loot_tables/blocks/cherry_leaves` — drop płatków.

Nie chcesz którejś z tych zmian? Po prostu usuń dany plik z paczki — reszta działa dalej.
Np. usunięcie `data/minecraft/` zostawia same nowe drzewa dostępne komendami.

## Struktura

```
Sakura/
├── pack.mcmeta
├── pack.png
└── data/
    ├── sakura/
    │   ├── advancements/          # 3 osiągnięcia
    │   ├── functions/             # komendy (+ variant/)
    │   ├── recipes/               # 2 receptury
    │   ├── tags/blocks/           # sakura_soil
    │   └── worldgen/
    │       ├── configured_feature/  # 6 drzew, 2 losowania, płatki
    │       └── placed_feature/      # warianty "_checked" + generacja w biomach
    └── minecraft/
        ├── loot_tables/blocks/    # cherry_leaves
        ├── tags/functions/        # load
        └── worldgen/
            ├── biome/             # 5 nadpisanych biomów
            └── configured_feature/# cherry (wzrost sadzonki)
```

## Wersja

Zrobione pod **1.20.6** (`pack_format 41`, `supported_formats 41`). Pod 1.21+ trzeba zmienić
format paczki i nazwy katalogów (`functions` → `function`, `recipes` → `recipe`,
`loot_tables` → `loot_table`, `advancements` → `advancement`, `tags/blocks` → `tags/block`).
