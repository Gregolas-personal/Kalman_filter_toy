#!/usr/bin/env bash
set -euo pipefail

mkdir -p /outputs

CARD="/opt/delphes/cards/delphes_card_ATLAS.tcl"
CMD="/workspace/zmm.cmnd"
OUT="/outputs/zmm_delphes.root"

echo "Running Z -> mu mu with Delphes"
echo "Card:    $CARD"
echo "Command: $CMD"
echo "Output:  $OUT"

cd /opt/delphes
./DelphesPythia8 "$CARD" "$CMD" "$OUT"

echo "Done."
ls -lh "$OUT"