---
title: How to get information about {{ interconnect-name }} private connections
description: Follow this guide to get information about {{ interconnect-name }} private connections.
---

# Getting information about private connections

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command to get the information about [private connections](../concepts/priv-con.md):

      ```bash
      yc cic private-connection get --help
      ```

  1. Get a list of private connections in the specified folder:

     ```bash
      yc cic private-connection list --folder-id b1gqf2hjizv2jw******
      ```

      Result:

      ```text
      +----------------------+--------------------+----------------------+
      |          ID          |        NAME        | TRUNK CONNECTION ID  |
      +----------------------+--------------------+----------------------+
      | euuiog88zphgsq****** | customer-name-prc1 | euuqqctbrflq3i****** |
      | euucr7p47329kq****** | customer-name-prc2 | euuvdjl5shd0fv****** |
      +----------------------+--------------------+----------------------+      
      ```

  1. Get information about the private connection by specifying its ID obtained in the previous step:

      ```bash
      # yc cic private-connection get <private_connection_ID>
      yc cic private-connection get euuiog88zphgsq******
      ```

      Result:

      ```yml
      id: euuiog88zphgsq******
      name: customer-name-prc1
      folder_id: b1gqf2hjizv2jw******
      region_id: ru-central1
      trunk_connection_id: euuqqctbrflq3i******
      vlan_id: "1531"
      ipv4_peering:
        peering_subnet: 10.211.10.0/30
        peer_ip: 10.211.10.1
        cloud_ip: 10.211.10.2
        peer_bgp_asn: "64515"
        cloud_bgp_asn: "200350"
      ```

      Where:
      * `id`: Private connection ID.
      * `name`: Private connection name.
      * `folder_id`: ID of the cloud folder the private connection was created in.
      * `region_id`: Cloud region the private connection was created in.
      * `trunk_connection_id`: ID of the trunk the private connection belongs to.
      * `vlan_id`: VLAN ID for the private connection
      * IP and BGP connectivity parameters for the private connection’s point-to-point subnet:
         * `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/priv-con.md#priv-address) for BGP peering.
         * `peer_ip`: IP address of the point-to-point (peered) subnet on the customer's equipment.
         * `cloud_ip`: IP address of the point-to-point (peered) subnet on the {{ yandex-cloud }} equipment.
         * `peer_bgp_asn`: [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment.
         * `cloud_bgp_asn`: BGP ASN on the {{ yandex-cloud }} equipment.

{% endlist %}
