#!/usr/bin/env bash
# Regenerates everything in images/ from the design files.
set -euo pipefail

cd "$(dirname "$0")/.."

KICAD_CLI="${KICAD_CLI:-C:/Program Files/KiCad/10.0/bin/kicad-cli.exe}"
PCB=Main_PDB.kicad_pcb
SCH=Main_PDB.kicad_sch
OUT=images

mkdir -p "$OUT"

"$KICAD_CLI" pcb render -o "$OUT/board-iso.png" --quality high --perspective \
  --rotate '-30,0,-35' --zoom 0.7 --width 2000 --height 1500 \
  --background transparent "$PCB"

"$KICAD_CLI" pcb render -o "$OUT/board-top.png" --side top --quality high \
  --width 2000 --height 1500 --background transparent "$PCB"

for pair in "F.Cu,F.SilkS:layer-f-cu" "In1.Cu:layer-in1-cu" \
            "In2.Cu:layer-in2-cu" "B.Cu:layer-b-cu"; do
  L="${pair%%:*}"; N="${pair##*:}"
  "$KICAD_CLI" pcb export svg -o "$OUT/$N.svg" --mode-single \
    --layers "$L,Edge.Cuts" --exclude-drawing-sheet --page-size-mode 2 \
    --check-zones "$PCB"
done

sed -i -e 's/#D0D2CD/#555555/g' -e 's/#F2EDA1/#000000/g' "$OUT"/layer-*.svg

"$KICAD_CLI" sch export pdf -o "$OUT/schematic.pdf" "$SCH"

echo "Regenerated $OUT/"
