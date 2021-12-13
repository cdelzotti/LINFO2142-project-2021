Conclusion
============

We can see this project as a proof of concept of some basic network monitoring functionalities. Naively, we initially thought that using encryption would make the whole network completely opaque from an external point of view. We discovered that it wasn't the case, and that it is possible to deduce the nature of the network activity by looking for patterns in the connection, by inspecting ports or by inspecting non-encrypted fields such as SNI. Even if there are already some techniques to enforce SNI [f]_ [g]_ , this last method could be difficult to use in the next few years with the rise of *ECH* [1]_ . This last method allows encryption of sensitive TLS fields, obfuscating communications and making them harder to classify.

We also noticed that it is simpler to perform monitoring on protocols that are less subject to application level interpretations. For example, we couldn't efficiently monitor RTP streams easily as many applications encode and interpret RTP header differently [a]_ [b]_ .

.. [1] https://blog.cloudflare.com/encrypted-client-hello/
.. [a] Nisticò, Antonio, et al. "2020 IEEE International Symposium on Multimedia (ISM)." A comparative study of RTC applications. IEEE, pp. 2-4, doi:10.1109/ISM.2020.00007.
.. [b] "hjp: doc: RFC 3550: RTP: A Transport Protocol for Real-Time Applications." 6 Oct. 2021, www.hjp.at/doc/rfc/rfc3550.html.
.. [f] Shbair, Wazen M., et al. "2016 IEEE 36th International Conference on Distributed Computing Systems Workshops (ICDCSW)." Improving SNI-Based HTTPS Security Monitoring. IEEE, 27 June 2016, pp. 72-77, doi:10.1109/ICDCSW.2016.21.
.. [g] Chai, Zimo, et al. "On the Importance of Encrypted-SNI to Censorship Circumvention." 2019, www.usenix.org/conference/foci19/presentation/chai.