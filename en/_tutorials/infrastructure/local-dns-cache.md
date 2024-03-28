# Configuring a local caching DNS resolver

**Do not** use {{ dns-full-name }} directly for requesting external domain names.

Instead, install and configure a local caching DNS resolver, such as `systemd-resolved`, `dnsmasq`, or `unbound`. This will speed up the execution of public DNS queries, reduce their number, and [save you money](../../dns/pricing.md#public-dns-requests).

If Ubuntu 18.04 LTS or higher is installed on your VM, it already has the `systemd-resolved` service by default and no additional installation and setup is required. For more information, see [Test systemd-resolved performance](#test-resolver).

If you are using an older version of Ubuntu, such as [16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts), you need to install a caching DNS resolver yourself. We recommend `dnsmasq` or `unbound`. For more information, see [Install an alternative resolver](#alternate-resolvers).

To configure a local caching DNS resolver:

1. [Prepare your cloud](#before-you-begin).
1. [Prepare your infrastructure](#prepare-infrastructure).
1. [Test `systemd-resolved` performance](#test-resolver).
1. [Install an alternative resolver](#alternate-resolvers).
1. [Replace the resolver](#change-resolver).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or a static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Prepare the infrastructure {#prepare-infrastructure}

1. [Create](../../compute/operations/#vm-create) a VM with an Ubuntu OS, e.g., [Ubuntu 18.04 LTS](/marketplace/products/yc/ubuntu-18-04-lts).
1. [Assign](../../compute/operations/vm-control/vm-attach-public-ip.md) a public IP address to the VM.

## Test systemd-resolved performance {#test-resolver}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.

1. Get the state of the `systemd-resolved` caching DNS resolver. To do this in Ubuntu version 18.04 or above, run this command:

   ```bash
   systemd-resolve --status
   ```

   As the `systemd-resolved` utility was renamed to `resolvectl`, for Ubuntu 22.04+, the command will be different:

   ```bash
   resolvectl status
   ```

   Result:

   ```bash
   <...>
   Link 2 (eth0)
   <...>
   Current DNS Server: 192.168.6.2
            DNS Servers: 192.168.6.2
            DNS Domain: {{ region-id }}.internal
                        auto.internal
   ```

   If the configuration is correct, the `Current DNS Server:` line in the command output will show the {{ dns-full-name }} server address, the second one in the virtual network. For example, `192.168.6.2` for a VM in the `192.168.6.0/24` subnet.

1. Make sure that external DNS names are resolved by the `127.0.0.53#53` DNS server. To do this, use the `dig` utility:

   ```bash
   dig example.com
   ```

   Result:

   ```bash
   <...>
   ;; Query time: 69 msec
   ;; SERVER: 127.0.0.53#53(127.0.0.53)
   <...>
   ```

   All resolutions of an external DNS name, except for the very first one, are executed almost instantly.

## Install an alternative resolver {#alternate-resolvers}

{% note warning %}

Configuration parameters are given as an example. For information about how to set up a caching resolver based on the VM's workload and your needs, see the documentation for the selected resolver.

{% endnote %}

{% list tabs %}

- dnsmasq

   [dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html) is a lightweight caching DNS resolver that has a small footprint.

   1. Install the `dnsmasq` and `dnsutils` packages:

      ```bash
      sudo apt-get update -y
      sudo apt-get install dnsmasq dnsutils -y
      ```

   1. Edit the `/etc/dnsmasq.conf` configuration file by increasing the cache size to 1,000 and setting the caching resolver to only listen to local VM addresses.

      1. Open the file:

         ```bash
         sudo nano /etc/dnsmasq.conf
         ```

      1. Paste this text to the file:

         ```bash
         cache-size=1000
         listen-address=127.0.0.1
         interface=lo
         bind-interfaces
         ```

   1. Restart `dnsmasq` to apply the new settings. Check that the `dnsmasq` service status changed to `active (running)` and there is a line saying `Started dnsmasq.service` at the end of the service log:

      ```bash
      sudo systemctl restart dnsmasq.service
      sudo systemctl status dnsmasq.service
      ```

      Result:

      ```bash
      ● dnsmasq.service - dnsmasq - A lightweight DHCP and caching DNS server
      Loaded: loaded (/lib/systemd/system/dnsmasq.service; enabled; vendor preset: enabled)
      Active: active (running) <...>
      <...>
      Oct 28 22:39:57 <...> systemd[1]: Starting dnsmasq - A lightweight DHCP and caching DNS server...
      Oct 28 22:39:57 <...> dnsmasq[<...>]: dnsmasq: syntax check OK.
      Oct 28 22:39:57 <...> dnsmasq[<...>]: started, version 2.75 cachesize 150
      <...>
      Oct 28 22:39:58 <...> dnsmasq[<...>]: using nameserver 192.168.6.2#53
      Oct 28 22:39:58 <...> systemd[1]: Started dnsmasq - A lightweight DHCP and caching DNS server.
      ```

      Also pay attention to the address in the `using nameserver <...>` line. The line should contain the {{ dns-full-name }} server address, the second one in the virtual network. For example, `192.168.6.2` for a VM in the `192.168.6.0/24` subnet.

   1. Use `dig` to check that external DNS names are resolved successfully:

      ```bash
      dig example.com @127.0.0.1 | grep -B3 Query
      ```

      Result:

      ```bash
      ;; ANSWER SECTION:
      example.com.    65420   IN  A  93.184.216.34
      ;; Query time: 3 msec
      ```

- unbound

   [unbound](https://unbound.docs.nlnetlabs.nl/en/latest/) is a validating, recursive, and caching DNS resolver. It focuses on fast performance, efficient resource consumption, and compliance with modern open standards.

   1. Install the `unbound` and `dnsutils` packages:

      ```bash
      sudo apt-get update -y
      sudo apt-get install unbound dnsutils -y
      ```

   1. Specify the server settings at the end of the `/etc/unbound/unbound.conf` global configuration file or in a separate configuration file named `/etc/unbound/unbound.conf.d/<file_name>.conf`.

      1. Open the file:

         ```bash
         sudo nano /etc/unbound/unbound.conf
         ```

      1. Paste this text at the end of the file:

         ```bash
         server:
               port: 53
               interface: 127.0.0.1
               access-control: 127.0.0.0/8 allow
               do-ip4: yes
               do-ip6: no
               do-udp: yes
               do-tcp: yes
               num-threads: 2
               num-queries-per-thread: 1024
               hide-identity: yes
               hide-version: yes
               prefetch: yes
               verbosity: 1
         ```

   1. Start `unbound` to apply the new settings. Check that the `unbound` service status changed to `active (running)` and there is the `Started unbound.service` line at the end of the service log:

      ```bash
      sudo systemctl start unbound.service
      sudo systemctl status unbound.service
      ```

      Result:

      ```bash
      ● unbound.service - Unbound DNS server
      Loaded: loaded (/lib/systemd/system/unbound.service; enabled; vendor preset: enabled)
      Active: active (running) <...>
      <...>
      Oct 29 00:21:06 <...> unbound[<...>]: * Starting DNS server unbound
      Oct 29 00:21:06 <...> unbound[<...>]: [<...>:0] info: start of service (unbound 1.5.8).
      Oct 29 00:21:06 <...> unbound[<...>]: ...done.
      Oct 29 00:23:21 <...> systemd[1]: Started unbound.service.
      ```

   1. Use `dig` to check that external DNS names are resolved successfully:

      ```bash
      dig example.com @127.0.0.1 | grep -B3 Query
      ```

      Result:

      ```bash
      ;; ANSWER SECTION:
      example.com.    86400  IN  A  93.184.216.34
      ;; Query time: 611 msec
      ```

{% endlist %}

## Replace the resolver {#change-resolver}

If you need to replace `systemd-resolved` with a different local caching DNS resolver:

1. Follow the guide in [Alternative resolvers](#alternate-resolvers) to install an alternative resolver.

1. Edit the `/etc/systemd/resolved.conf` file to disable a stub resolver and set `127.0.0.1` as the DNS server address:

   1. Open the file:

      ```bash
      sudo nano /etc/unbound/unbound.conf
      ```

   1. Paste this text to the file after the `[Resolve]` line:

      ```bash
      DNS=127.0.0.1
      DNSStubListener=no
      ```

1. Create a symlink:

   ```bash
   sudo ln -svi /run/systemd/resolve/resolv.conf /etc/resolv.conf
   ```

1. Restart `systemd-resolved`:

   ```bash
   systemctl restart systemd-resolved
   ```

1. Check that `dig` now uses the `127.0.0.1#53` server instead of `127.0.0.53#53`:

   ```bash
   dig example.com
   ```

   Result:

   ```bash
   <...>
   ;; Query time: 0 msec
   ;; SERVER: 127.0.0.1#53(127.0.0.1)
   <...>
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) the VM.