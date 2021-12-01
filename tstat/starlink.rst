Monitoring on a Startlink connection
====================================

.. sectionauthor:: Clément Delzotti, Vincent Higginson

As a practical example, we've performed a passive monitoring on a router connected to the Starlink satelite network. This router was accessible to UCLouvain computer sciences students.

Configuration
-------------

We configured this router with a Tstat instance, allowing us to easely gather information about the network and states of connections. To face the gradual aggregation of RRD database, we defined a cronjob to draw some usual graphs every two hours, allowing us to get a clear image before the aggregation proccess aggeregates data.

Finally, as we don't want the router to gradually get his memory filled with graph pictures, we defined a second cronjob to send an email at 1am every day containing every graph generated during the previous day so that they can be removed.

Observations
------------

One of the first things we have analyzed is the behavior of TCP. We can see that it is actually relatively stable, with a few exceptions :

.. figure:: img/tcp-anomalies.png
   :width: 350
   :align: center

   Anomalies in TCP on a Startlink connection.

Most of the TCP traffic is going well, with the exception of some *Retransmission RTO*, that are probably caused by the fact that the router is located behind a thick wall through Wifi.

Another point of interest in our moniroting is traffic classification. As explained before, TLS traffic possesses a *SNI* field, which is used to identify the destination server. We can thus use this field to identify where a TLS connection is going. Tstat allows us to do so, with a list of 10 predefined services (e.g. Facebook, Google, Instagram, etc). We modified Tstat to also catch traffic that matches our particular case (As our router is located within a UCLouvain building accessed by students in computer sciences, we can foresee some network utiliation) :

# TODO : add a graph of TLS traffic Monitoring

This allows us to see that SNI-based network classification is possible and that we can identify the destination server. Of course, the part of *unknown traffic* is important here as a simple set of 13 services is not enough to identify all the traffic. Once again, it is important to mention that this technique could be threatened by the emergence of ESNI.
