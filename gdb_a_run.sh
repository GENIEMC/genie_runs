#!/bin/sh

NUMEVT=10
if [ $# -gt 0 ]; then
  NUMEVT=$1
fi

# http://pdg.lbl.gov/2007/reviews/montecarlorpp.pdf
# http://pdg.lbl.gov/2011/mcdata/mc_particle_id_contents.html
# http://genie.hepforge.org/doxygen/html/PDGCodes_8h_source.html
CARBON="1000060120"
OXYGEN="1000080160"

TARGET=$OXYGEN

gdb -tui --args gevgen -n $NUMEVT -p -14,14 -t $TARGET -e 2,10 -r 101 \
  --message-thresholds Messenger_laconic.xml \
  --seed 2989819 --cross-sections $XSECSPLINEDIR/gxspl-vA-v2.8.0.xml