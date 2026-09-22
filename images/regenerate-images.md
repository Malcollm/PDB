# Regenerating the images

Everything in `images/` is generated from the design files with `kicad-cli`.
Close the KiCad editors first, then run:

    ./images/regenerate.sh

That rebuilds the 3D renders, the per-layer copper SVGs and the schematic PDF.

If `kicad-cli` lives somewhere other than
`C:/Program Files/KiCad/10.0/bin/kicad-cli.exe`, point the script at it:

    KICAD_CLI=/path/to/kicad-cli ./images/regenerate.sh
