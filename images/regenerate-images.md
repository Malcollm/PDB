# Regenerating the images

Everything here is generated from the design files. A `pre-commit` hook rebuilds
it automatically whenever a commit touches `Main_PDB.kicad_pcb` or a
`.kicad_sch`, and stages the results into that commit — enable it once per clone
with `git config core.hooksPath images/hooks`.

To rebuild by hand at any time, run `./images/regenerate.sh` (set `KICAD_CLI=...`
if `kicad-cli` isn't at `C:/Program Files/KiCad/10.0/bin/kicad-cli.exe`, or
`SKIP_IMAGE_REGEN=1` before a `git commit` to skip the hook once).
