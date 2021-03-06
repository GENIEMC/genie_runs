#!/bin/sh

NUMEVT=1
if [ $# -gt 0 ]; then
  NUMEVT=$1
fi

SPLINEFILE="gxspl-vA-v2.8.0.xml"
echo "NOTE: Using spline file: $XSECSPLINEDIR/$SPLINEFILE"

EXE=gevgen
ARGS=$(echo -e "-n $NUMEVT -p 14 -t 1000060120 -e 3 -r 100 -f x*exp(-x) --seed 2989819 --cross-sections $XSECSPLINEDIR/$SPLINEFILE --event-generator-list CCQE")
DAT=`date -u +%s`
VALLOG="${DAT}_CCQE_grindlog.txt"

valgrind --log-file-exactly=${VALLOG} ${EXE} ${ARGS}

cp $VALLOG leaksum.txt
perl -i -e 'while(<>) { chomp; if (/definitely/) { print $_,"\n"; } }' leaksum.txt
cat leaksum.txt
echo 


