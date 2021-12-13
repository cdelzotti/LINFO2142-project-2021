#!/bin/bash
# Run capture
tstat/tstat/tstat -r RRD -R rrd.conf -N net.conf -i eth2 -l
