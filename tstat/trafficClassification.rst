Traffic Classification
------------

A widly requested feature is traffic classification. It consists to identify flows to give a better understanding of what kind of traffic is going through the network and therefore which traffic can lead to congestion. An easy way to perform network classification is through the combination of the transport protocol and the port. Typically, HTTPS is performed with TCP on port 443, DNS is performed with UDP on port 53, etc. Luckily, Tstat provide a way to export traffic information based on the transport protocol used and the port. Our *rrd.conf* file would look like this :

.. code-block:: ruby
   :linenos:

    tcp_port_src_in                 idx:22,80,443,other
    udp_port_flow_dst               idx:53,443,other