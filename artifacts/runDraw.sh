#!/bin/bash

GRAPH_WINDOW=2h

counter="`cat counter`"

FLOWPATH="graphs/flow"
mkdir -p $FLOWPATH
TLSDLPATH="graphs/tlsdl"
mkdir -p $TLSDLPATH
TLSDLBITPATH="graphs/tlsdl_bitrate"
mkdir -p $TLSDLBITPATH
TLSUPPATH="graphs/tlsup"
mkdir -p $TLSUPPATH
TLSUPBITPATH="graphs/tlsup_bitrate"
mkdir -p $TLSUPBITPATH
BITRATEDLPATH="graphs/bitratedl"
mkdir -p $BITRATEDLPATH
BITRATEUPPATH="graphs/bitrateup"
mkdir -p $BITRATEUPPATH
TCPANOMALIESPATH="graphs/tcpanomalies"
mkdir -p $TCPANOMALIESPATH
TCPPORTSPATH="graphs/tcpports"
mkdir -p $TCPPORTSPATH
CPUPATH="graphs/cpu"
mkdir -p $CPUPATH


# Show the current number of flows
rrdtool graph \
  $FLOWPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "Transport flows" \
  --vertical-label "Flows" \
  DEF:tcp=RRD/profile_flows.idx3.rrd:profile_flows:AVERAGE \
  DEF:udp=RRD/profile_flows.idx1.rrd:profile_flows:AVERAGE \
  CDEF:total=tcp,udp,+ \
  AREA:total#0000ff:"TCP Flows" \
  GPRINT:tcp:AVERAGE:"Avg\: %3.2lf %s\t" \
  GPRINT:tcp:MAX:"Max\: %3.2lf %s\t" \
  GPRINT:tcp:MIN:"Min\: %3.2lf %s\l"\
  AREA:udp#00ff00:"UDP Flows" \
  GPRINT:udp:AVERAGE:"Avg\: %3.2lf %s\t" \
  GPRINT:udp:MAX:"Max\: %3.2lf %s\t" \
  GPRINT:udp:MIN:"Min\: %3.2lf %s\l"
# Show CPU usage
rrdtool graph \
  $CPUPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "CPU Usage" \
  --vertical-label "% usage" \
  DEF:cpu=RRD/profile_cpu.idx0.rrd:profile_cpu:AVERAGE \
  LINE:cpu#ff0000:"UDP Flows" \
  GPRINT:cpu:AVERAGE:"Avg\: %3.2lf %s\t" \
  GPRINT:cpu:MAX:"Max\: %3.2lf %s\t" \
  GPRINT:cpu:MIN:"Min\: %3.2lf %s\l"
# TLS Download
rrdtool graph \
  $TLSDLPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "TLS download bandwidth repartition" \
  --vertical-label "Proportion" \
  DEF:tls0=RRD/tls_bitrate_in.idx0.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls1=RRD/tls_bitrate_in.idx1.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls2=RRD/tls_bitrate_in.idx2.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls3=RRD/tls_bitrate_in.idx3.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls4=RRD/tls_bitrate_in.idx4.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls5=RRD/tls_bitrate_in.idx5.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls6=RRD/tls_bitrate_in.idx6.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls7=RRD/tls_bitrate_in.idx7.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls8=RRD/tls_bitrate_in.idx8.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls9=RRD/tls_bitrate_in.idx9.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls10=RRD/tls_bitrate_in.idx10.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls11=RRD/tls_bitrate_in.idx11.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls12=RRD/tls_bitrate_in.idx12.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls13=RRD/tls_bitrate_in.idx13.rrd:tls_bitrate_in:AVERAGE \
  CDEF:total=tls0,tls1,tls2,tls3,tls4,tls5,tls6,tls7,tls8,tls9,tls10,tls11,tls12,tls13,+,+,+,+,+,+,+,+,+,+,+,+,+\
  CDEF:tls0perc=tls0,total,/ \
  CDEF:tls1perc=tls1,total,/ \
  CDEF:tls2perc=tls2,total,/ \
  CDEF:tls3perc=tls3,total,/ \
  CDEF:tls4perc=tls4,total,/ \
  CDEF:tls5perc=tls5,total,/ \
  CDEF:tls6perc=tls6,total,/ \
  CDEF:tls7perc=tls7,total,/ \
  CDEF:tls8perc=tls8,total,/ \
  CDEF:tls9perc=tls9,total,/ \
  CDEF:tls10perc=tls10,total,/ \
  CDEF:tls11perc=tls11,total,/ \
  CDEF:tls12perc=tls12,total,/ \
  CDEF:tls13perc=tls13,total,/ \
  CDEF:undef=tls0perc \
  CDEF:google=undef,tls1perc,+ \
  CDEF:youtube=google,tls2perc,+ \
  CDEF:facebook=youtube,tls3perc,+ \
  CDEF:netflix=facebook,tls4perc,+ \
  CDEF:dropbox=netflix,tls5perc,+ \
  CDEF:microsoft=dropbox,tls6perc,+ \
  CDEF:apple=microsoft,tls7perc,+ \
  CDEF:instagram=apple,tls8perc,+ \
  CDEF:uclouvain=instagram,tls9perc,+ \
  CDEF:reddit=uclouvain,tls10perc,+ \
  CDEF:github=reddit,tls11perc,+ \
  CDEF:gitlab=github,tls12perc,+ \
  CDEF:stackoverflow=gitlab,tls13perc,+ \
  AREA:stackoverflow#f5a742:"Stackoverflow" \
  AREA:github#ff008c:"Github" \
  AREA:gitlab#94d4b4:"Gitlab" \
  AREA:reddit#24376e:"Reddit" \
  AREA:uclouvain#ff0000:"UCLouvain" \
  AREA:instagram#00ff00:"Instagram" \
  AREA:apple#0000ff:"Apple" \
  AREA:microsoft#ffff00:"Microsoft" \
  AREA:dropbox#000000:"Dropbox" \
  AREA:netflix#a314a1:"Netflix" \
  AREA:facebook#009dd1:"Facebook" \
  AREA:youtube#d16900:"Youtube" \
  AREA:google#00694b:"Google" \
  AREA:undef#00ffbf:"Undefined"
# TLS Download bitrate
rrdtool graph \
  $TLSDLBITPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "TLS download bandwidth repartition" \
  --vertical-label "bit/sec" \
  DEF:tls0=RRD/tls_bitrate_in.idx0.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls1=RRD/tls_bitrate_in.idx1.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls2=RRD/tls_bitrate_in.idx2.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls3=RRD/tls_bitrate_in.idx3.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls4=RRD/tls_bitrate_in.idx4.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls5=RRD/tls_bitrate_in.idx5.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls6=RRD/tls_bitrate_in.idx6.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls7=RRD/tls_bitrate_in.idx7.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls8=RRD/tls_bitrate_in.idx8.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls9=RRD/tls_bitrate_in.idx9.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls10=RRD/tls_bitrate_in.idx10.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls11=RRD/tls_bitrate_in.idx11.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls12=RRD/tls_bitrate_in.idx12.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls13=RRD/tls_bitrate_in.idx13.rrd:tls_bitrate_in:AVERAGE \
  LINE:tls13#f5a742:"Stackoverflow" \
  LINE:tls12#ff008c:"Github" \
  LINE:tls11#94d4b4:"Gitlab" \
  LINE:tls10#24376e:"Reddit" \
  LINE:tls9#ff0000:"UCLouvain" \
  LINE:tls8#00ff00:"Instagram" \
  LINE:tls7#0000ff:"Apple" \
  LINE:tls6#ffff00:"Microsoft" \
  LINE:tls5#000000:"Dropbox" \
  LINE:tls4#a314a1:"Netflix" \
  LINE:tls3#009dd1:"Facebook" \
  LINE:tls2#d16900:"Youtube" \
  LINE:tls1#00694b:"Google" \
  LINE:tls0#00ffbf:"Undefined"
# TLS Upload bitrate
rrdtool graph \
  $TLSUPBITPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "TLS upload bandwidth repartition" \
  --vertical-label "bit/sec" \
  DEF:tls0=RRD/tls_bitrate_out.idx0.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls1=RRD/tls_bitrate_out.idx1.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls2=RRD/tls_bitrate_out.idx2.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls3=RRD/tls_bitrate_out.idx3.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls4=RRD/tls_bitrate_out.idx4.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls5=RRD/tls_bitrate_out.idx5.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls6=RRD/tls_bitrate_out.idx6.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls7=RRD/tls_bitrate_out.idx7.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls8=RRD/tls_bitrate_out.idx8.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls9=RRD/tls_bitrate_out.idx9.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls10=RRD/tls_bitrate_out.idx10.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls11=RRD/tls_bitrate_out.idx11.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls12=RRD/tls_bitrate_out.idx12.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls13=RRD/tls_bitrate_out.idx13.rrd:tls_bitrate_out:AVERAGE \
  LINE:tls13#f5a742:"Stackoverflow" \
  LINE:tls12#ff008c:"Github" \
  LINE:tls11#94d4b4:"Gitlab" \
  LINE:tls10#24376e:"Reddit" \
  LINE:tls9#ff0000:"UCLouvain" \
  LINE:tls8#00ff00:"Instagram" \
  LINE:tls7#0000ff:"Apple" \
  LINE:tls6#ffff00:"Microsoft" \
  LINE:tls5#000000:"Dropbox" \
  LINE:tls4#a314a1:"Netflix" \
  LINE:tls3#009dd1:"Facebook" \
  LINE:tls2#d16900:"Youtube" \
  LINE:tls1#00694b:"Google" \
  LINE:tls0#00ffbf:"Undefined"
# TLS Upload
rrdtool graph \
  $TLSUPPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "TLS upload bandwidth repartition" \
  --vertical-label "Proportion" \
  DEF:tls0=RRD/tls_bitrate_out.idx0.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls1=RRD/tls_bitrate_out.idx1.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls2=RRD/tls_bitrate_out.idx2.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls3=RRD/tls_bitrate_out.idx3.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls4=RRD/tls_bitrate_out.idx4.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls5=RRD/tls_bitrate_out.idx5.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls6=RRD/tls_bitrate_out.idx6.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls7=RRD/tls_bitrate_out.idx7.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls8=RRD/tls_bitrate_out.idx8.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls9=RRD/tls_bitrate_out.idx9.rrd:tls_bitrate_out:AVERAGE \
  DEF:tls10=RRD/tls_bitrate_in.idx10.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls11=RRD/tls_bitrate_in.idx11.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls12=RRD/tls_bitrate_in.idx12.rrd:tls_bitrate_in:AVERAGE \
  DEF:tls13=RRD/tls_bitrate_in.idx13.rrd:tls_bitrate_in:AVERAGE \
  CDEF:total=tls0,tls1,tls2,tls3,tls4,tls5,tls6,tls7,tls8,tls9,tls10,tls11,tls12,tls13,+,+,+,+,+,+,+,+,+,+,+,+,+\
  CDEF:tls0perc=tls0,total,/ \
  CDEF:tls1perc=tls1,total,/ \
  CDEF:tls2perc=tls2,total,/ \
  CDEF:tls3perc=tls3,total,/ \
  CDEF:tls4perc=tls4,total,/ \
  CDEF:tls5perc=tls5,total,/ \
  CDEF:tls6perc=tls6,total,/ \
  CDEF:tls7perc=tls7,total,/ \
  CDEF:tls8perc=tls8,total,/ \
  CDEF:tls9perc=tls9,total,/ \
  CDEF:tls10perc=tls10,total,/ \
  CDEF:tls11perc=tls11,total,/ \
  CDEF:tls12perc=tls12,total,/ \
  CDEF:tls13perc=tls13,total,/ \
  CDEF:undef=tls0perc \
  CDEF:google=undef,tls1perc,+ \
  CDEF:youtube=google,tls2perc,+ \
  CDEF:facebook=youtube,tls3perc,+ \
  CDEF:netflix=facebook,tls4perc,+ \
  CDEF:dropbox=netflix,tls5perc,+ \
  CDEF:microsoft=dropbox,tls6perc,+ \
  CDEF:apple=microsoft,tls7perc,+ \
  CDEF:instagram=apple,tls8perc,+ \
  CDEF:uclouvain=instagram,tls9perc,+ \
  CDEF:reddit=uclouvain,tls10perc,+ \
  CDEF:github=reddit,tls11perc,+ \
  CDEF:gitlab=github,tls12perc,+ \
  CDEF:stackoverflow=gitlab,tls13perc,+ \
  AREA:stackoverflow#f5a742:"Stackoverflow" \
  AREA:github#ff008c:"Github" \
  AREA:gitlab#94d4b4:"Gitlab" \
  AREA:reddit#24376e:"Reddit" \
  AREA:uclouvain#ff0000:"UCLouvain" \
  AREA:instagram#00ff00:"Instagram" \
  AREA:apple#0000ff:"Apple" \
  AREA:microsoft#ffff00:"Microsoft" \
  AREA:dropbox#000000:"Dropbox" \
  AREA:netflix#a314a1:"Netflix" \
  AREA:facebook#009dd1:"Facebook" \
  AREA:youtube#d16900:"Youtube" \
  AREA:google#00694b:"Google" \
  AREA:undef#00ffbf:"Undefined"
# Download traffic
rrdtool graph \
  $BITRATEDLPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "Data download bitrate" \
  --vertical-label "bit/sec" \
  DEF:tcpin=RRD/ip_bitrate_in.idx0.rrd:ip_bitrate_in:AVERAGE \
  DEF:udpin=RRD/ip_bitrate_in.idx1.rrd:ip_bitrate_in:AVERAGE \
  CDEF:total=tcpin,udpin,+ \
  AREA:total#0000ff:"TCP DL" \
  GPRINT:tcpin:AVERAGE:"Avg\: %3.2lf %sbps\t" \
  GPRINT:tcpin:MAX:"Max\: %3.2lf %sbps\t" \
  GPRINT:tcpin:MIN:"Min\: %3.2lf %sbps\l"\
  AREA:udpin#00ff00:"UDP DL" \
  GPRINT:udpin:AVERAGE:"Avg\: %3.2lf %sbps\t" \
  GPRINT:udpin:MAX:"Max\: %3.2lf %sbps\t" \
  GPRINT:udpin:MIN:"Min\: %3.2lf %sbps\l"
# Upload traffic
rrdtool graph \
  $BITRATEUPPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "Data upload bitrate" \
  --vertical-label "bit/sec" \
  DEF:udpout=RRD/ip_bitrate_out.idx1.rrd:ip_bitrate_out:AVERAGE \
  DEF:tcpout=RRD/ip_bitrate_out.idx0.rrd:ip_bitrate_out:AVERAGE \
  CDEF:total=tcpout,udpout,+ \
  AREA:total#0000ff:"TCP UP" \
  GPRINT:tcpout:AVERAGE:"Avg\: %3.2lf %sbps\t" \
  GPRINT:tcpout:MAX:"Max\: %3.2lf %sbps\t" \
  GPRINT:tcpout:MIN:"Min\: %3.2lf %sbps\l" \
  AREA:udpout#00ff00:"UDP UP" \
  GPRINT:udpout:AVERAGE:"Avg\: %3.2lf %sbps\t" \
  GPRINT:udpout:MAX:"Max\: %3.2lf %sbps\t" \
  GPRINT:udpout:MIN:"Min\: %3.2lf %sbps\l"
# TCP anomalies
rrdtool graph \
  $TCPANOMALIESPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "TCP anomalies" \
  --vertical-label "count" \
  DEF:inseq=RRD/tcp_anomalies_in.idx0.rrd:tcp_anomalies_in:AVERAGE \
  DEF:retrto=RRD/tcp_anomalies_in.idx1.rrd:tcp_anomalies_in:AVERAGE \
  DEF:retfr=RRD/tcp_anomalies_in.idx2.rrd:tcp_anomalies_in:AVERAGE \
  DEF:reorder=RRD/tcp_anomalies_in.idx3.rrd:tcp_anomalies_in:AVERAGE \
  DEF:dup=RRD/tcp_anomalies_in.idx4.rrd:tcp_anomalies_in:AVERAGE \
  DEF:flowctrl=RRD/tcp_anomalies_in.idx5.rrd:tcp_anomalies_in:AVERAGE \
  DEF:uselessRTO=RRD/tcp_anomalies_in.idx6.rrd:tcp_anomalies_in:AVERAGE \
  DEF:uselessFR=RRD/tcp_anomalies_in.idx7.rrd:tcp_anomalies_in:AVERAGE \
  DEF:unknown=RRD/tcp_anomalies_in.idx63.rrd:tcp_anomalies_in:AVERAGE \
  CDEF:inseqshow=inseq\
  CDEF:retrtoshow=inseqshow,retrto,+ \
  CDEF:retfrshow=retrtoshow,retfr,+ \
  CDEF:reordershow=retfrshow,reorder,+ \
  CDEF:dupshow=reordershow,dup,+ \
  CDEF:flowctrlshow=dupshow,flowctrl,+ \
  CDEF:uselessRTOshow=flowctrlshow,uselessRTO,+ \
  CDEF:uselessFRshow=uselessRTOshow,uselessFR,+ \
  CDEF:unknownshow=uselessFRshow,unknown,+ \
  AREA:unknownshow#ff0000:"Unknown" \
  AREA:uselessFRshow#00ff00:"Unnecessary Retransmit FR" \
  AREA:uselessRTOshow#0000ff:"Unnecessary Retransmit RTO" \
  AREA:flowctrlshow#ffff00:"Flow control" \
  AREA:dupshow#000000:"Duplicates" \
  AREA:reordershow#a314a1:"Reordering" \
  AREA:retfrshow#009dd1:"Retransmission FR" \
  AREA:retrtoshow#d16900:"Retransmission RTO" \
  AREA:inseqshow#00694b:"In sequence"
# Port classification
rrdtool graph \
  $TCPPORTSPATH/graph-$counter.png \
  --start now-$GRAPH_WINDOW --end now \
  --width 850 --height 500 \
  --title "Download Traffic Classification" \
  --vertical-label "Traffic proportion" \
  DEF:ssh=RRD/tcp_port_src_in.idx22.rrd:tcp_port_src_in:AVERAGE \
  DEF:dns=RRD/udp_port_flow_dst.idx53.rrd:udp_port_flow_dst:AVERAGE \
  DEF:http=RRD/tcp_port_src_in.idx80.rrd:tcp_port_src_in:AVERAGE \
  DEF:https=RRD/tcp_port_src_in.idx443.rrd:tcp_port_src_in:AVERAGE \
  DEF:udphttps=RRD/udp_port_flow_dst.idx443.rrd:udp_port_flow_dst:AVERAGE \
  CDEF:total=ssh,dns,http,https,udphttps,+,+,+,+ \
  CDEF:sshperc=ssh,total,/ \
  CDEF:dnsperc=dns,total,/ \
  CDEF:httpperc=http,total,/ \
  CDEF:httpsperc=https,total,/ \
  CDEF:udphttpsperc=udphttps,total,/ \
  CDEF:dnsshow=sshperc,dnsperc,+ \
  CDEF:httpshow=dnsshow,httpperc,+ \
  CDEF:httpsshow=httpshow,httpsperc,+ \
  CDEF:udphshow=httpsshow,udphttpsperc,+ \
  AREA:udphshow#f00000:"UDP HTTPS traffic" \
  AREA:httpsshow#a232a8:"TCP HTTPS traffic" \
  AREA:httpshow#00f000:"TCP HTTP traffic" \
  AREA:dnsshow#00fff0:"DNS traffic" \
  AREA:sshperc#000fff:"SSH traffic"

let "counter = counter + 1"
echo $counter > counter
