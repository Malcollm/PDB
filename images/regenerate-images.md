# Regenerating the images

Everything here is generated from the design files. A `pre-commit` hook rebuilds
it automatically and stages the results into that commit — enable it once per
clone with `git config core.hooksPath images/hooks`.

The hook only rebuilds what the commit actually affects:

| Staged change      | Rebuilt                                            |
| ------------------ | -------------------------------------------------- |
| `Main_PDB.kicad_pcb` | `board-iso.png`, `board-top.png`, `layer-*.svg`   |
| `*.kicad_sch`        | `schematic.pdf`                                   |

To rebuild by hand, run `./images/regenerate.sh` for everything, or narrow it
with `./images/regenerate.sh pcb` / `./images/regenerate.sh sch`. Set
`KICAD_CLI=...` if `kicad-cli` isn't at
`C:/Program Files/KiCad/10.0/bin/kicad-cli.exe`, or `SKIP_IMAGE_REGEN=1` before
a `git commit` to skip the hook once.
