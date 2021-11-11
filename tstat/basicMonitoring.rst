Basic monitoring
================
.. sectionauthor:: Clément Delzotti, Vincent Higginson

A first and simple usecase to explore is a simple bitrate monitoring. To do so, we first need to launch a live capture with *tstat* :

.. code-block:: ruby
   :linenos:

    tstat -r RRD -R rrd.conf -N net.conf -l

Tstat can work both with packets traces and live traffic through the libpcap library. Live monitoring is launched with the *-l* flag. To analyse a trace instead, simply replace the *-l* flag with the path to the trace.

Now, let's analyze the remaining of the command to understand what is really going on under the hood :

- **-r flag** : specifies the folder in which Round Robin Databases will be exported
- **-R flag** : specifies the file describing what must be exported in Round Robin Database. This isn't a very well documented part and the best way to properly set RRDs exports is to look at the *rrd.conf* sample file in Tstat source code. For a simple bitrate monitoring, we'll use the following configuration :

.. code-block:: ruby
   :linenos:

    ip_bitrate_loc                  idx:0,1,2
    ip_bitrate_in                   idx:0,1,2
    ip_bitrate_out                  idx:0,1,2


With such a configuration file, Tstat will produce 9 ouput files called *ip_bitrate_direction_idxX.rrd* where **direction** is either *loc* (local traffic), *in* (Download traffic) or *out* (Upload traffic) and **X** is either *0* (TCP), *1* (UDP) or *2* (ICMP). 

- **-N flag** : specifies the file describing the local network. It consists of a simple list of IP masks of your local network. Tstat will then use it to separate ingress traffic from egress and local traffic. In our case, our *net.conf* file contains :

.. code-block:: ruby
   :linenos:

    192.168.42.0/24

Note that you may want to specify the interface to monitor with the *-i* flag.

Once Tstat is launched, it will capture packets and fill Round Robin Databases on its own. We can then use the produced *.rrd* files to see what is happening on the network. In our case, we'll use a script to redraw a graph frequently. We would then obtain a set of graphs similar to figure 1.1.

As illustration is important in passive monitoring, it is possible to use this set of graphs with the *ffmpeg* tool to generate an animated GIF to give a better understanding of how the network bitrate evolved.