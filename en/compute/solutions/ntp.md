# Configuring clock synchronization using NTP

You can sync virtual machines in Yandex.Cloud with public time servers via [NTPv4](https://tools.ietf.org/html/rfc5905):

* For VMs running Windows Server, give three preferred servers in the time synchronization settings.

* On Linux-based VMs, enable a DHCP client with option 42, `Network Time Protocol Servers`. This lets you automatically apply the list of sync servers sent by the DHCP server. In images provided by Yandex.Cloud, operating systems are already configured properly.

   In the system settings, specify the backup sync servers to use if the DHCP server goes down or is unavailable. To do this, follow the [instructions](#setup).

Recommended sync servers:

- [ntp0.NL.net](http://support.ntp.org/bin/view/Servers/PublicTimeServer000233)
- [clock.isc.org](https://support.ntp.org/bin/view/Servers/PublicTimeServer000262)
- [ntp2.vniiftri.ru](http://support.ntp.org/bin/view/Servers/PublicTimeServer000352)
- [ntps1-1.cs.tu-berlin.de](http://support.ntp.org/bin/view/Servers/PublicTimeServer000213)
- [ntp.ix.ru](http://support.ntp.org/bin/view/Servers/PublicTimeServer000766)

The list of recommended servers may change. Yandex.Cloud notifies you 72 hours before you need to make changes to a VM configuration.

## Setup {#setup}

{% list tabs %}

- Linux (systemd)

  {% note alert %}

  The `systemd-timesyncd` service may conflict with `ntpd` if they are running simultaneously. You can either delete the `ntpd` service or use it to set up time synchronization (in the next tab).

  {% endnote %}

  Specify backup servers in the system settings:
  1. List the backup servers in `/etc/systemd/timesyncd.conf` under `[Time]` in the `FallbackNTP=` parameter, for example:

     ```
     FallbackNTP=ntp0.NL.net clock.isc.org ntp2.vniiftri.ru ntps1-0.eecsit.tu-berlin.de ntp.ix.ru
     ```
  1. Set `UseNTP=true` in the `systemd.network` configuration file. It's usually located in the `/etc/systemd/network` or `/var/lib/systemd/network` directory.
  1. Restart the synchronization service:

     ```
     $ sudo systemctl restart systemd-timesyncd
     ```

- Linux (ntpd)

  Specify the addresses of the servers in the `ntpd` configuration:

  1. Specify the addresses of the recommended servers in `/etc/ntp.conf`. Comment out default server addresses with <q>#</q> at the beginning of the relevant line, for example:

     ```
     # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
     # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
     # more information.
     # server 0.ubuntu.pool.ntp.org
     # server 1.ubuntu.pool.ntp.org
     # server 2.ubuntu.pool.ntp.org
     # server 3.ubuntu.pool.ntp.org
     server ntp0.NL.net
     server clock.isc.org
     server ntp2.vniiftri.ru
     server ntps1-0.eecsit.tu-berlin.de
     server ntp.ix.ru
     ```

  2. Restart the service:

     ```
     $ sudo service ntp restart
     ```

- Windows Server

  Specify the recommended servers in the Windows Time service settings by running the following commands in PowerShell or `cmd`:

  ```
  net stop w32time
  w32tm /config /syncfromflags:manual /manualpeerlist:"ntp0.NL.net clock.isc.org ntp2.vniiftri.ru ntps1-0.eecsit.tu-berlin.de ntp.ix.ru"
  w32tm /config /reliable:yes
  net start w32time
  ```

{% endlist%}

