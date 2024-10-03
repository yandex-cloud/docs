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
1. [Attach](../../compute/operations/vm-control/vm-attach-public-ip.md) a public IP address to the VM.

## Set up synchronization {#setup-ntp}

{% list tabs %}

- Linux (systemd)

   On Linux-based VMs, enable a DHCP client with the `42` (`Network Time Protocol Servers`) option. The DHCP client automatically applies the list of time synchronization servers sent by the DHCP server. In {{ compute-name }} images, operating systems are preset properly.

   In the system settings, specify the backup time synchronization servers to use if the DHCP server is unavailable.

   {% note info %}

   The `systemd-timesyncd` service may conflict with `ntpd` if they are running simultaneously. To see what services are running, use the `ps -eF` command. You can either delete the `ntpd` service or use it to set up time synchronization (see the **Linux (ntpd)** tab).

   {% endnote %}

   To set up time synchronization:
   1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
   1. Open the `/etc/systemd/timesyncd.conf` file by running the following command in the terminal:

      ```bash
      sudo nano /etc/systemd/timesyncd.conf
      ```

   1. Specify the addresses of the recommended servers in the `FallbackNTP=` parameter of the `[Time]` section, e.g.:


      ```text
      FallbackNTP=ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-0.eecsit.tu-berlin.de
      ```



   1. Set `UseNTP=true` in the `systemd.network` configuration file. It is usually located in the `/etc/systemd/network/` or `/var/lib/systemd/network/` directory.

      You can also use the `networkd.conf` file in the `/etc/systemd/` directory.
   1. Restart the time synchronization service:

      ```bash
      sudo systemctl restart systemd-timesyncd
      ```

- Linux (ntpd)

   On Linux-based VMs, enable a DHCP client with the `42` (`Network Time Protocol Servers`) option. The DHCP client automatically applies the list of time synchronization servers sent by the DHCP server. In {{ compute-name }} images, operating systems are preset properly.

   In the system settings, specify the backup time synchronization servers to use if the DHCP server is unavailable.

   {% note info %}

   The `ntpd` service may conflict with `systemd-timesyncd` if they are running simultaneously. To see what services are running, use the `ps -eF` command. You can either delete the `systemd-timesyncd` service or use it to set up time synchronization (see the **Linux (systemd)** tab).

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

   1. Specify the recommended server addresses. Comment out default server addresses with <q>#</q> at the beginning of the relevant line, for example:


      ```text
      # Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
      # on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
      # more information.
      # server 0.ubuntu.pool.ntp.org
      # server 1.ubuntu.pool.ntp.org
      # server 2.ubuntu.pool.ntp.org
      # server 3.ubuntu.pool.ntp.org
      server ntp0.NL.net
      server ntp2.vniiftri.ru
      server ntp.ix.ru
      server ntps1-0.eecsit.tu-berlin.de
      ```



   1. Restart the time synchronization service:

      ```bash
      sudo service ntp restart
      ```

- Windows Server

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
      w32tm /config /syncfromflags:manual /manualpeerlist:"ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-0.eecsit.tu-berlin.de"
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

{% list tabs %}

- Linux (systemd)

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

- Linux (ntpd)

   Run this command:

   ```bash
   sudo ntpq -p
   ```

   Result:


   ```bash
        remote           refid      st t when poll reach   delay   offset  jitter
   ==============================================================================
   +ntp0.nl.uu.net  .GPS.            1 u  111  128  377   41.220    1.662   0.214
   +ntp2.vniiftri.r .MRS.            1 u   99  128  377    7.540    1.697   0.417
   *ntp.ix.ru       .GPS.            1 u   45  128  377    4.343    1.456   0.296
   +ntps1-0.eecsit. .PPS.            1 u   36  128  377   30.128    1.258   0.265
   ```



- Windows Server

   Run the command below and specify the VM name:

   ```powershell
   w32tm /query /computer:<VM_name> /configuration
   ```

   Result:


   ```powershell
   ...
   [TimeProviders]
   ...
   NtpServer: ntp0.NL.net ntp2.vniiftri.ru ntp.ix.ru ntps1-0.eecsit.tu-berlin.de (Local)
   ...
   ```



{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) the VM.
