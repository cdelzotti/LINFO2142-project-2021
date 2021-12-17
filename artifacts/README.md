# Enabling monitoring on a Network device

1. Build `tstat` by following instructions in `tstat/README`
    - Once built, the executables are located in `tstat/tstat`, **don't move them**
2. We provide some scripts to use tstat, use them at your convenance
    - **startTstat.sh** : Starts a Tstat monitoring. If you're using Tstat on a device using multiple network interfaces, you can specify which interface to monitor after the *-i* flag in `startTstat.sh`
    - **runDraw.sh** : Draw some predefined graphs from the monitoring outputs (Round Robin Databases)
    - **runReport.sh** : Compress every graph in the `graphs/` folder and send them by email along with a copy of every RRD. To use this script, you must specify a Gmail address to use (Be aware that using a Gmail address from a script requires you to enable specific settings on your Google account: https://support.google.com/accounts/answer/6010255?hl=en. It is advised to use a specific email for security.)

If you want to perform advance monitoring using Tstat and Round Robin Databases, see RRDTool documentation : https://oss.oetiker.ch/rrdtool/doc/rrdgraph.en.html

As a troubleshooting script when you feel something is odd, you can also use `listConnectedDevices.sh` to list every connected device (Useful when you're monitoring a wireless router)
