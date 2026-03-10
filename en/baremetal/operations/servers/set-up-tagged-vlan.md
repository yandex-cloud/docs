---
title: Setting up a secondary private subnet on a {{ baremetal-full-name }} server
description: Follow this guide to add to a {{ baremetal-full-name }} server and configure a secondary private subnet with a tagged VLAN.
---

# Setting up a secondary private subnet with a tagged VLAN on a server

In addition to the [main private subnet](../../concepts/private-network.md#native-vlan-subnet), you can attach several [additional](../../concepts/private-network.md#tagged-vlan-subnet) private subnets to the server's [network interface](../../concepts/servers.md#network-interfaces) (or the [MC-LAG](../../concepts/mc-lag.md) aggregation group) connected to a [private network](../../concepts/private-network.md).

For information on how to attach or detach a secondary private subnet to a server, see [this section](./server-update.md).

Once you have changed the number or composition of secondary private subnets attached to the server, you need to configure the network interface in its operating system. Here is an example of how to configure a network interface in Linux Ubuntu 24.04 with [Netplan](https://netplan.io/):

1. Connect to the server over SSH:

    ```bash
    ssh root@<server_public_IP_address>
    ```

    You can also access the server via the [KVM console](./server-kvm.md) using your username and password.
1. Find out the name of the Netplan configuration file:

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
1. To configure secondary private subnets with tagged VLANs on a server, add the `vlans` section to the Netplan configuration that contains information about secondary private subnets attached to the server. The settings for servers without reserved network connections and servers with MC-LAG are different. Here is an example:

    {% list tabs %}

    - Server without network reservation

      ```yaml
      network:
          version: 2
          ethernets:
              etx1:
                  dhcp4: true
                  match:
                      macaddress: b4:2e:99:58:5b:cc
                  set-name: etx1
              etx2:
                  dhcp4: true
                  match:
                      macaddress: b4:2e:99:58:5b:ce
                  set-name: etx2
          vlans:
              myvlan:
                  id: <VLAN_ID>
                  link: <network_interface_name>
                  addresses:
                      - <IP_address_of_server_in_secondary_subnet>
                  routes:
                      - to: <secondary_subnet_CIDR>
                        via: <default_gateway_of_secondary_subnet>
      ```

      Where:

      * {% include [set-up-tagged-vlan-legend-1](../../../_includes/baremetal/set-up-tagged-vlan-legend-1.md) %}
      * {% include [set-up-tagged-vlan-legend-2](../../../_includes/baremetal/set-up-tagged-vlan-legend-2.md) %}
      * `<network_interface_name>`: Name assigned in the Netplan configuration (the `ethernets` section) to the network interface connected to a private network, e.g., `etx1`.

          To find out which of the server's network interfaces is connected to a private network, use its [MAC address](https://en.wikipedia.org/wiki/MAC_address): the MAC address is [indicated](./get-info.md) in the [management console]({{ link-console-main }}) on the server information page under **{{ ui-key.yacloud.baremetal.title_section-server-private-network_xrEye }}**.
      * {% include [set-up-tagged-vlan-legend-3](../../../_includes/baremetal/set-up-tagged-vlan-legend-3.md) %}
      * {% include [set-up-tagged-vlan-legend-4](../../../_includes/baremetal/set-up-tagged-vlan-legend-4.md) %}
      * {% include [set-up-tagged-vlan-legend-5](../../../_includes/baremetal/set-up-tagged-vlan-legend-5.md) %}

    - Server with MC-LAG

      ```yaml
      network:
          version: 2
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
          vlans:
              myvlan:
                  id: <VLAN_ID>
                  link: <network_interface_name>
                  addresses:
                      - <IP_address_of_server_in_secondary_subnet>
                  routes:
                      - to: <secondary_subnet_CIDR>
                        via: <default_gateway_of_secondary_subnet>
      ```

      Where:

      * {% include [set-up-tagged-vlan-legend-1](../../../_includes/baremetal/set-up-tagged-vlan-legend-1.md) %}
      * {% include [set-up-tagged-vlan-legend-2](../../../_includes/baremetal/set-up-tagged-vlan-legend-2.md) %}
      * `<network_interface_name>`: Name assigned in the Netplan configuration (the `bonds` section) to the aggregation group connected to a private network, e.g., `bond1`.

          Learn how to find out which aggregation group is connected to a private network in [this section](./set-up-mc-lag.md).
      * {% include [set-up-tagged-vlan-legend-3](../../../_includes/baremetal/set-up-tagged-vlan-legend-3.md) %}
      * {% include [set-up-tagged-vlan-legend-4](../../../_includes/baremetal/set-up-tagged-vlan-legend-4.md) %}
      * {% include [set-up-tagged-vlan-legend-5](../../../_includes/baremetal/set-up-tagged-vlan-legend-5.md) %}

    {% endlist %}

    If you have detached all secondary private subnets from the server, delete the `vlans` section from the settings file.
1. Apply updated Netplan settings:

    ```bash
    netplan apply
    ```

{% note tip %}

If you made a mistake and created a VLAN for the wrong network interface (aggregation group):

1. Adjust the settings in the Netplan configuration file.
1. Delete the wrong VLAN interface. To do this, run this command, specifying its ID:

    ```bash
    ip link del myvlan
    ```
1. Apply updated Netplan settings:

    ```bash
    netplan apply
    ```

{% endnote %}

#### See also {#see-also}

* [{#T}](../../concepts/mc-lag.md)
* [{#T}](../../concepts/network.md)