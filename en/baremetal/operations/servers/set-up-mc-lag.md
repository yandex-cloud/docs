---
title: Configuring network connection reservation in {{ baremetal-full-name }}
description: Follow this guide to set up an aggregation group on a {{ baremetal-full-name }} server with an ability to reserve a network connection using MC-LAG.
---

# Setting up an MC-LAG aggregation group

Servers with [MC-LAG](../../concepts/mc-lag.md) support use two network adapters to simultaneously connect to each of the networks ([public](../../concepts/network.md#public-network) and [private](../../concepts/network.md#private-network)). To ensure fault tolerance, each of the network interface pairs connected to the networks must form an _aggregation group_ on the server side. For more information, see [{#T}](../../concepts/mc-lag.md#additional-setup).

{% note info %}

When setting up aggregation groups, do not connect to the server via the network interface you are going to include in a group: the connection with be lost when you create the group. The [KVM console](./server-kvm.md) is the most reliable way to configure MC-LAG groups.

{% endnote %}

Currently, you can set up MC-LAG groups in Linux Ubuntu 20.04, 22.04, 24.04, and Debian 11. As an example, this guide uses a server with two pairs of network adapters with connection speed of 25 Gbps each.

To set up a link aggregation group:

{% list tabs group=operating_system %}

- Ubuntu/Debian (Netplan) {#ubuntu}

  1. Install the `ethtool` utility:

      ```bash
      apt install ethtool
      ```
  1. Make sure the required network interfaces are installed in the system and active:

      ```bash
      ip link
      ```

      Result:

      ```text
      ...
      2: etx3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      3: etx4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      4: etx1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether 58:a2:e1:ad:38:2a brd ff:ff:ff:ff:ff:ff
      5: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether 58:a2:e1:ad:38:2b brd ff:ff:ff:ff:ff:ff
      ```

      As you can see from the output, the server has four active network interfaces:

      * `etx3`: With the `b8:ce:f6:40:12:d6` MAC address.
      * `etx4`: With the `b8:ce:f6:40:12:d7` MAC address.
      * `etx1`: With the `58:a2:e1:ad:38:2a` MAC address.
      * `etx2`: With the `58:a2:e1:ad:38:2b` MAC address.
  1. Find out which of the interfaces belong to the public network, and which to the private one:

        1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the server belongs to.
        1. In the list of services, go **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** and, in the list of servers that opens, select the one you need.

            On the page that opens, in the `{{ ui-key.yacloud.baremetal.field_mac-address }}` field under **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** and **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**, you can see the MAC addresses of interfaces connected to the public and private networks, respectively.

        1. Use the information obtained in the two previous steps to identify the server interface pairs connected to the public and private networks. In the example above, the pairs are as follows:

            **Public network**:
            * `etx3`: With the `b8:ce:f6:40:12:d6` MAC address.
            * `etx1`: With the `58:a2:e1:ad:38:2a` MAC address.

            **Private network**:
            * `etx4`: With the `b8:ce:f6:40:12:d7` MAC address.
            * `etx2`: With the `58:a2:e1:ad:38:2b` MAC address.
  1. Find out the name of the [Netplan](https://netplan.io/) configuration file:

      ```bash
      ls /etc/netplan/
      ```

      Result:

      ```text
      50-cloud-init.yaml
      ```
  1. Open the Netplan configuration file with a text editor. In this guide, we use [nano](https://en.wikipedia.org/wiki/GNU_nano):

      ```bash
      nano /etc/netplan/50-cloud-init.yaml
      ```
  1. Edit the Netplan configuration by adding aggregation groups (the `bonds` section):

      ```yaml
      network:
          bonds:
              bond1:
                  dhcp4: true
                  interfaces:
                  - <public_interface_1_name>
                  - <public_interface_2_name>
                  macaddress: <public_interface_1_or_2_MAC_address>
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
              bond2:
                  dhcp4: true
                  interfaces:
                  - <private_interface_1_name>
                  - <private_interface_2_name>
                  macaddress: <private_interface_1_or_2_MAC_address>
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
          ethernets:
              etx1:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2a
                  set-name: etx1
              etx2:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2b
                  set-name: etx2
              etx3:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d6
                  set-name: etx3
              etx4:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d7
                  set-name: etx4
          version: 2
      ```

      Where:
      * `<public_interface_1_name>`, `<public_interface_2_name>`: Names of the interfaces which belong to the public network, as you found out earlier.
      * `<public_interface_1_or_2_MAC_address>`: MAC address of an interface which belongs to the public network, as you found out earlier.
      * `<private_interface_1_name>`, `<public_interface_2_name>`: Names of the interfaces which belong to the private network, as you found out earlier.
      * `<private_interface_1_or_2_MAC_address>`: MAC address of an interface which belongs to the private network, as you found out earlier.

      {% note warning %}

      Note that [DHCP](../../concepts/dhcp.md) must be:
      * Enabled (`dhcp4: true`) for aggregation groups (the `bonds` section).
      * Disabled (`dhcp4: false`) for individual interfaces (the `ethernets` section).

      {% endnote %}

      {% cut "Netplan configuration example" %}

      ```yaml
      network:
          bonds:
              bond1:
                  dhcp4: true
                  interfaces:
                  - etx3
                  - etx1
                  macaddress: b8:ce:f6:40:12:d6
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
              bond2:
                  dhcp4: true
                  interfaces:
                  - etx4
                  - etx2
                  macaddress: b8:ce:f6:40:12:d7
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
          ethernets:
              etx1:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2a
                  set-name: etx1
              etx2:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2b
                  set-name: etx2
              etx3:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d6
                  set-name: etx3
              etx4:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d7
                  set-name: etx4
          version: 2
      ```

      {% endcut %}

  1. Apply the new Netplan configuration:

      ```bash
      netplan apply
      ```
  1. Make sure the list of network interfaces displays the aggregation groups:

      ```bash
      ip link
      ```

      Result:

      ```text
      ...
      2: etx3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      3: etx4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond2 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      4: etx1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      5: etx2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond2 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      6: bond1: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      7: bond2: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      ```

      As you can see from the output, the server now has two MC-LAG aggregation groups, `bond1` and `bond2`.

      {% note info %}

      If aggregation groups are inactive (`DOWN`), activate them:

      ```bash
      ifconfig bond1 up
      ifconfig bond2 up
      ```

      {% endnote %}

  1. View the information about the groups you created. As an example, let’s use the aggregation group connected to the public network:

      ```bash
      ethtool bond1
      ```

      Result:

      ```
      Settings for bond1:
        Supported ports: [ ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 50000Mb/s
        Duplex: Full
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Link detected: yes
      ```

      As you can see from the output, the connection speed for the `bond1` group is 50 Gbps.
  1. Simulate an incident where a link in the `bond1` public network aggregation group fails. To do this, disable one of the group’s network interfaces:

      ```bash
      ifconfig etx3 down
      ```
  1. View the group information again:

      ```bash
      ethtool bond1
      ```

      Result:

      ```
      Settings for bond1:
        Supported ports: [ ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 25000Mb/s
        Duplex: Full
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Link detected: yes
      ```

      As you can see from the output, the connection speed for the `bond1` group has been reduced to 25 Gbps, but the network connectivity has been maintained. To check this, [connect](../../../compute/operations/vm-connect/ssh.md) to the server over SSH.
  1. Activate the interface you disabled earlier and make sure the aggregation group is running again at the maximum speed:

      ```bash
      ifconfig etx3 up
      ethtool bond1
      ```

      Result:

      ```text
      Settings for bond1:
        Supported ports: [ ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 50000Mb/s
        Duplex: Full
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Link detected: yes
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/mc-lag.md)
* [{#T}](../../concepts/network.md)
* [{#T}](../../concepts/network-restrictions.md)