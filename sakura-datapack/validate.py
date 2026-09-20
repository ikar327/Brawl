#!/usr/bin/env python3
"""Sprawdza paczkę Sakura bez uruchamiania Minecrafta.

1. składnia JSON,
2. czy referencje sakura:* wskazują na istniejące pliki,
3. czy liczby mieszczą się w zakresach, które wymusza kodek 1.20.6 —
   to właśnie na tym wyłożyła się pierwsza wersja paczki
   (branch_count przyjmuje wyłącznie 1–3).

Użycie: python3 validate.py
"""
import json
import os
import sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Sakura")

# (pole, min, max) — zakresy z kodeków 1.20.6
TRUNK_COMMON = [("base_height", 0, 32), ("height_rand_a", 0, 24), ("height_rand_b", 0, 24)]
CHERRY_TRUNK = [("branch_count", 1, 3), ("branch_horizontal_length", 2, 16),
                ("branch_start_offset_from_top", -16, 0), ("branch_end_offset_from_top", -16, 0)]
FOLIAGE_COMMON = [("radius", 0, 16), ("offset", 0, 16)]
CHERRY_FOLIAGE = [("height", 4, 16)]
BLOB_FOLIAGE = [("height", 0, 16)]
CHERRY_CHANCES = ["wide_bottom_layer_hole_chance", "corner_hole_chance",
                  "hanging_leaves_chance", "hanging_leaves_extension_chance"]
FEATURE_SIZE = [("limit", 0, 81), ("lower_size", 0, 16), ("upper_size", 0, 16)]

errors = []


def provider_range(value):
    """Najmniejsza i największa wartość, jaką może zwrócić IntProvider w JSON-ie."""
    if isinstance(value, int):
        return value, value
    if "type" not in value:  # gołe UniformInt, jak branch_start_offset_from_top
        return value["min_inclusive"], value["max_inclusive"]
    kind = value["type"]
    if kind.endswith("constant"):
        return value["value"], value["value"]
    if kind.endswith("uniform") or kind.endswith("biased_to_bottom"):
        return value["min_inclusive"], value["max_inclusive"]
    if kind.endswith("clamped_normal"):
        return value["min_inclusive"], value["max_inclusive"]
    if kind.endswith("weighted_list"):
        lows, highs = zip(*(provider_range(e["data"]) for e in value["distribution"]))
        return min(lows), max(highs)
    raise ValueError("nieznany IntProvider: %s" % kind)


def check_ranges(where, obj, spec):
    for field, lo, hi in spec:
        if field not in obj:
            continue
        low, high = provider_range(obj[field])
        if low < lo:
            errors.append("%s: %s = [%s..%s], kodek wymaga min %s" % (where, field, low, high, lo))
        if high > hi:
            errors.append("%s: %s = [%s..%s], kodek wymaga max %s" % (where, field, low, high, hi))


def check_chances(where, obj, fields):
    for field in fields:
        if field in obj and not 0.0 <= obj[field] <= 1.0:
            errors.append("%s: %s = %s, dozwolone 0.0–1.0" % (where, field, obj[field]))


files = {}
for dirpath, _, names in os.walk(ROOT):
    for name in names:
        if not (name.endswith(".json") or name == "pack.mcmeta"):
            continue
        path = os.path.join(dirpath, name)
        rel = os.path.relpath(path, ROOT).replace(os.sep, "/")
        try:
            files[rel] = json.load(open(path, encoding="utf-8"))
        except Exception as exc:
            errors.append("BŁĄD JSON %s: %s" % (rel, exc))


def owned(kind, rid):
    ns, path = rid.split(":")
    return "data/%s/%s/%s.json" % (ns, kind, path) in files


for rel, doc in sorted(files.items()):
    # --- referencje wewnątrz paczki ---
    if "/worldgen/placed_feature/" in rel and isinstance(doc.get("feature"), str):
        ref = doc["feature"]
        if ref.startswith("sakura:") and not owned("worldgen/configured_feature", ref):
            errors.append("%s -> brak configured feature %s" % (rel, ref))
    if "/worldgen/configured_feature/" in rel and doc.get("type") == "minecraft:random_selector":
        refs = [doc["config"]["default"]] + [f["feature"] for f in doc["config"]["features"]]
        for ref in refs:
            if isinstance(ref, str) and ref.startswith("sakura:") and not owned("worldgen/placed_feature", ref):
                errors.append("%s -> brak placed feature %s" % (rel, ref))
    if "/worldgen/biome/" in rel:
        if len(doc.get("features", [])) != 11:
            errors.append("%s: %d kroków generacji zamiast 11" % (rel, len(doc.get("features", []))))
        for step in doc["features"]:
            for ref in step:
                if ref.startswith("sakura:") and not owned("worldgen/placed_feature", ref):
                    errors.append("%s -> brak placed feature %s" % (rel, ref))

    # --- zakresy liczb w drzewach ---
    if "/worldgen/configured_feature/" in rel and doc.get("type") == "minecraft:tree":
        cfg = doc["config"]
        trunk, foliage = cfg["trunk_placer"], cfg["foliage_placer"]
        check_ranges(rel, trunk, TRUNK_COMMON)
        check_ranges(rel, foliage, FOLIAGE_COMMON)
        check_ranges(rel, cfg["minimum_size"], FEATURE_SIZE)

        if trunk["type"] == "minecraft:cherry_trunk_placer":
            check_ranges(rel, trunk, CHERRY_TRUNK)
            start = trunk["branch_start_offset_from_top"]
            low, high = provider_range(start)
            if high - low < 1:
                errors.append("%s: branch_start_offset_from_top musi mieć rozpiętość >= 1 "
                              "(dwa konary nie zmieszczą się na jednej wysokości)" % rel)
        if foliage["type"] == "minecraft:cherry_foliage_placer":
            check_ranges(rel, foliage, CHERRY_FOLIAGE)
            check_chances(rel, foliage, CHERRY_CHANCES)
        elif foliage["type"] in ("minecraft:bush_foliage_placer", "minecraft:blob_foliage_placer"):
            check_ranges(rel, foliage, BLOB_FOLIAGE)

        for dec in cfg.get("decorators", []):
            check_chances(rel + " [" + dec["type"] + "]", dec, ["probability"])

print("sprawdzonych plików: %d" % len(files))
if errors:
    print("\n".join(errors))
    sys.exit(1)
print("OK — referencje i zakresy liczb zgodne z 1.20.6")
