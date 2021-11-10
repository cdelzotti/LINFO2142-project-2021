Configuration
-----

Hardware
~~~~~

For this project, we had at our disposal a Turris Router. This router allows connections through SSH in order to run software on it. The main advantage of this is the reduced cost of monitoring, as we can observe traffic on router directly instead of monitoring each computer and compile data afterwards. We mainly used this router to run *tstat* and *rrdtool*.

Round Robin Databases
~~~~

RRDs are a central element in this project. They attempt to answer a important problem of networking monitoring : storage. The total amount of data going through a router can be important and routers usually have limited storage. The idea of a Round Robin Database is to keep a constant memory use despite continuous monitoring. To do so, it aggregates older data to make rooms for freshly performed measurements. The further the monitoring goes, the more old data are aggregated. The counter part is of course a lack of precise information for older measures. This can be avoided with automatic plotting using tools such as `crontab` and `rrdtool`.

RRDs are thus usually lightweight and can be transferred easely. However, it is worth saying that RRDs are OS and architecure specific. To use RRDs captured from a router (Typically running Linux on ARM) to a personal computer (Typically running over a x86_64 architecture), some convertion must be performed with the help of `rrdtool dump`.

Tstat
~~~~~

Tstat is a monitoring software developped by the Politecnico di Torino that turned out to be really usefull due to its integrated logic in traffic monitoring. It can, among many other things, read DNS requests and therefore identify where a particular flow is going. It then produces logs in standard text formats that can be parsed to get informations about monitored traffic. Another helpful fonctionality is the ability to export monitored data in Round Robin Databases who can be used for plotting.

The first issue we had was the compilation. As the Turris Router is running a modified version of OpenWRT (A Linux distribution designed for routers) on an armv7l architecture, it was somehow complicated to find dependancies needed by tstat who weren't available in OPKG (OpenWRT package manager). The solution we found was using LXC containers to run a Debian distribution with a much more supplied package manager, enabling an easy compilation of Tstat. But this led to another minor problem : LXC networks. LXC containers embeds by default a networking stack enabling communications between containers. This was an obstacle because we needed to monitor the WAN port of our Router and it was therefore unacessible from inside our container. We worked around it by enabling "host" networking for our container in its configuration file :

.. code-block:: ruby
   :linenos:

    # Network configuration
    lxc.net.0.type = none

Once this was done, we had an up an running instance of Tstat on the Turris.

RRDtool
~~~~~

RRDTool is a tool enabling Round Robin Databases manipulations such as creation, edition and plotting. We mainly used the plotting function as databases creation and editing are handled implicitly by tstat. The use of RRDTool is pretty much straight forward and well-ish documented on https://oss.oetiker.ch/rrdtool/index.en.html. Typically, a rrdtool plotting command will look like this :

.. code-block:: ruby
   :linenos:

    rrdtool graph \
    $destination_dir/graph-name.png \
    --start now-2min --end now \
    --width 850 --height 500 \
    --title "Data download bitrate" \
    --vertical-label "bit/sec" \
    DEF:tcpin=RRD/ip_bitrate_in.idx0.rrd:ip_bitrate_in:LAST \
    DEF:udpin=RRD/ip_bitrate_in.idx1.rrd:ip_bitrate_in:LAST \
    CDEF:total=tcpin,udpin,+ \
    AREA:total#0000ff:"TCP DL" \
    GPRINT:tcpin:AVERAGE:"Avg\: %3.2lf %sbps\t" \
    GPRINT:tcpin:MAX:"Max\: %3.2lf %sbps\t" \
    GPRINT:tcpin:MIN:"Min\: %3.2lf %sbps\l"\
    AREA:udpin#00ff00:"UDP DL" \
    GPRINT:udpin:AVERAGE:"Avg\: %3.2lf %sbps\t" \
    GPRINT:udpin:MAX:"Max\: %3.2lf %sbps\t" \
    GPRINT:udpin:MIN:"Min\: %3.2lf %sbps\l"

We can see that rrdtool let us define the time window we want to see with flags `--start` and `--end`. In the exemple, the command will produce a graph showing data gathered on the last two minutes preceeding the execution of the command. We can also notice the DEF keyword allowing to retreive data from a Round Robin Database and the CDEF keyword allowing on the fly computations of previously retrieved data. The remaining of the command specifies what must be plotted on the graph. For instance, this command as produced the following graph :

.. figure:: img/rrd-exemple.png
  :width: 400
  :align: center
  :alt: Example of a graph drawn with RRDtool

  Example of a graph drawn with RRDtool