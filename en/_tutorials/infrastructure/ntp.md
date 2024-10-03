---
description: Network Time Protocol Servers (NTP) enable you to set up synchronization with public NTP servers on {{ yandex-cloud }} VM instances running Windows Server and Linux. This document describes the process of synchronization setup on the servers.
keywords:
  - ntp
  - ntp server
  - sntp
  - time synchronization
---

# Configuring clock synchronization using NTP

You can set up time synchronization on {{ compute-full-name }} [VMs](../../compute/concepts/vm.md) with public servers via [NTPv4](https://tools.ietf.org/html/rfc5905).

The VM time is synced to correctly work with other servers and applications, process data in real time, store exact time data in system logs, etc.

NTP servers recommended for syncing:
* `0.ru.pool.ntp.org`
* `1.ru.pool.ntp.org`
* `ntp0.NL.net`
* `ntp2.vniiftri.ru`
* `ntp.ix.ru`
* `ntps1-1.cs.tu-berlin.de`

{% note info %}

The list of recommended servers may change. {{ yandex-cloud }} notifies you 72 hours before you need to make changes to a VM configuration.

{% endnote %}

To set up time synchronization:
1. [Prepare your cloud](#before-you-begin).
1. [Prepare your infrastructure](#prepare-infrastructure).
1. [Set up synchronization](#setup-ntp).
1. [Check synchronization](#check-ntp).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of clock synchronization using NTP includes fees for computing resources and VM disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Prepare the infrastructure {#prepare-infrastructure}

1. If you do not have a VM, [create](../../compute/operations/#vm-create) one.
1. [Assign](../../compute/operations/vm-control/vm-attach-public-ip.md) a public IP address to the VM.

## Set up synchronization {#setup-ntp}

{% list tabs group=operating_system %}

- Linux (systemd) {#linux-systemd}

  On Linux-based VMs, make sure to enable a DHCP client with the `42` (`Network Time Protocol Servers`) option. The DHCP client automatically applies the list of time synchronization servers sent by the DHCP server. In {{ compute-name }} images, operating systems are preset properly.

  In the system settings, specify the backup time synchronization servers to use if the DHCP server is unavailable.

  {% note info %}

  `systemd-timesyncd` may conflict with `ntpd` if they are running simultaneously. To see which services are running, use the `ps -eF` command. You can either delete `ntpd` or use it to set up time synchronization (see the **Linux (ntpd)** tab). 

  {% endnote %}

  To set up time synchronization:
  1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
  1. Open the `/etc/systemd/timesyncd.conf` file by running the following command in the terminal:

      ```bash
      sudo nano /etc/systemd/timesyncd.conf
      ```

  1. Specify the addresses of the recommended servers in the `FallbackNTP=` parameter of the `[Time]` section, such as the following:
     

      ```text
      FallbackNTP=0.ru.pool.ntp.org 1.ru.pool.ntp.org ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-1.cs.tu-berlin.de
      ```



  1. In the `systemd.network` configuration file, specify the `UseNTP=true` parameter. The configuration file is usually located in the `/etc/systemd/network/` or `/var/lib/systemd/network/` directory.

      You can also use the `networkd.conf` file in the `/etc/systemd/` directory.
  1. Restart the time synchronization service:

      ```bash
      sudo systemctl restart systemd-timesyncd
      ```

- Linux (ntpd) {#linux-ntpd}

  On Linux-based VMs, make sure to enable a DHCP client with the `42` (`Network Time Protocol Servers`) option. The DHCP client automatically applies the list of time synchronization servers sent by the DHCP server. In {{ compute-name }} images, operating systems are preset properly.

  In the system settings, specify the backup time synchronization servers to use if the DHCP server is unavailable.

  {% note info %}

  `ntpd` may conflict with `systemd-timesyncd` if they are running simultaneously. To see which services are running, use the `ps -eF` command. You can either delete `systemd-timesyncd` or use it to set up time synchronization (see the **Linux (systemd)** tab). 

  {% endnote %}

  To set up time synchronization:
  1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
  1. Install `ntpd` by running the following command in the terminal:

      ```bash
      sudo apt-get install ntp
      ```

  1. Open the `/etc/ntp.conf` file:

      ```bash
      sudo nano /etc/ntp.conf
      ```

  1. Specify the recommended server addresses. Comment out default server addresses with `#` at the beginning of the relevant line. Here is an example:
     

      ```text
      # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
      # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
      # more information.
      # server 0.ubuntu.pool.ntp.org
      # server 1.ubuntu.pool.ntp.org
      # server 2.ubuntu.pool.ntp.org
      # server 3.ubuntu.pool.ntp.org
      server 0.ru.pool.ntp.org
      server 1.ru.pool.ntp.org
      server ntp0.NL.net
      server ntp2.vniiftri.ru
      server ntp.ix.ru
      server ntps1-1.cs.tu-berlin.de
      ```



  1. Restart the time synchronization service:

      ```bash
      sudo service ntp restart
      ```

- Windows Server {#windows}

  To set up time synchronization:
  1. [Connect](../../compute/operations/vm-connect/rdp.md) to the VM via RDP.
  1. Run cmd or PowerShell as an administrator.
  1. Stop the Windows Time service by running the following command:

      ```powershell
      net stop w32time
      ```

      Result:

      ```powershell
      The Windows Time service is stopping.
      The Windows Time service was stopped successfully.
      ```

  1. Specify the recommended server addresses, e.g.:



      ```powershell
      w32tm /config /syncfromflags:manual /manualpeerlist:"0.ru.pool.ntp.org 1.ru.pool.ntp.org ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-1.cs.tu-berlin.de"
      ```



      Result:

      ```powershell
      The command completed successfully.
      ```

  1. Specify that the VM is a reliable time source:

      ```powershell
      w32tm /config /reliable:yes
      ```

      Result:

      ```powershell
      The command completed successfully.
      ```

  1. Start the Windows Time service:

      ```powershell
      net start w32time
      ```

      Result:

      ```powershell
      The Windows Time service is starting.
      The Windows Time service was started successfully.
      ```

{% endlist %}

## Check the synchronization {#check-ntp}

{% list tabs group=operating_system %}

- Linux (systemd) {#linux-systemd}

  Run this command:

  ```bash
  timedatectl
  ```

  Result:

  ```bash
  ...
  System clock synchronized: yes                        
                NTP service: active   
  ...
  ```

- Linux (ntpd) {#linux-ntpd}

  Run this command:

  ```bash
  sudo ntpq -p
  ```

  Result:


  ```bash
      remote           refid      st t when poll reach   delay   offset  jitter
  ==============================================================================
  ntp.ubuntu.com  .POOL.          16 p    -   64    0    0.000   +0.000   0.000
  time.cloudflare 10.87.12.180     3 u    4   64    1    7.870   -0.924   0.000
  195.218.227.230 85.21.78.23      3 u    -   64    1   33.619   +1.099   0.000
  ntp0.nl.uu.net  .GPS.            1 u    4   64    1   46.894   -1.309   0.000
  ntp2.vniiftri.r .MRS.            1 u    2   64    1   10.392   -1.075   0.000
  ntp.ix.ru       .GLN.            1 u    2   64    1    6.511   -0.738   0.000
  ntps1-1.eecsit. .GPS.            1 u    4   64    1   33.026   -0.646   0.000
  alphyn.canonica 132.163.96.1     2 u    3   64    1  124.037   -1.936   0.000
  185.125.190.57  201.68.88.106    2 u    1   64    1   50.676   -0.090   0.000
  185.125.190.58  145.238.203.14   2 u    -   64    1   57.460   -0.464   0.000
  ```



- Windows Server {#windows}

  Run the command below and specify the VM name:

  ```powershell
  w32tm /query /configuration
  ```

  Result:


  ```powershell
  ...
  [TimeProviders]
  ...
  NtpServer: 0.ru.pool.ntp.org 1.ru.pool.ntp.org ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-1.cs.tu-berlin.de (Local)
  ...
  ```



{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) the VM.
