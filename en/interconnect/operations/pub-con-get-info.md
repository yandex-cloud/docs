---
title: How to get information about {{ interconnect-name }} public connections
description: Follow this guide to get information about {{ interconnect-name }} public connections.
---

# Getting information about public connections

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command to get information on [public connections](../concepts/pub-con.md):

      ```bash
      yc cic public-connection get --help
      ```

  1. Get a list of public connections in the folder:

      ```bash
      yc cic public-connection list --folder-id b1gqf2hjizv2jw******
      ```

      Result:

      ```text
      +----------------------+--------------------+----------------------+---------------+
      |          ID          |        NAME        | TRUNK CONNECTION ID  | SERVICE TYPES |
      +----------------------+--------------------+----------------------+---------------+
      | euuiog88zphgsq****** | customer-name-pub1 | euuqqctbrflq3i****** | APIGW, ML     |
      | euucr7p47329kq****** | customer-name-pub2 | euuvdjl5shd0fv****** | APIGW, ML     |
      +----------------------+--------------------+----------------------+---------------+
      ```

  1. Get information about the public connection by specifying its ID obtained in the previous step:

      ```bash
      # yc cic public-connection get <public_connection_ID>
      yc cic public-connection get euuiog88zphgsq****** 
      ```

      Result:

      ```text
      id: euuiog88zphgsq******
      name: customer-name-pub1
      folder_id: b1gqf2hjizv2jw******
      region_id: ru-central1
      trunk_connection_id: euuqqctbrflq3i******
      vlan_id: "1428"
      ipv4_peering:
        peering_subnet: 178.170.2xx.x2/31
        peer_ip: 178.170.2xx.x2
        cloud_ip: 178.170.2xx.x3
        peer_bgp_asn: "65001"
        cloud_bgp_asn: "200350"
      ipv4_allowed_service_types:
        - CLOUD_SERVICE_APIGW
        - CLOUD_SERVICE_ML
      ipv4_peer_announced_prefixes:
        - 178.170.2xx.x2/31
      ```

      Where:
      * `id`: Public connection ID.
      * `name`: Public connection name.
      * `folder_id`: ID of the cloud folder containing the new public connection.
      * `region_id`: Region of the cloud the new public connection belongs to.
      * `trunk_connection_id`: ID of the trunk the public connection belongs to.
      * `vlan_id`: VLAN ID for the public connection.
      * IP and BGP connectivity parameters for the point-to-point subnet of the public connection:
         * `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/pub-con.md#pub-address) for BGP peering.
         * `peer_ip`: IP address of the point-to-point (peered) subnet on the customer's equipment.
         * `cloud_ip`: IP address of the point-to-point (peered) subnet on the {{ yandex-cloud }} equipment.
         * `peer_bgp_asn`: [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment.
         * `cloud_bgp_asn`: BGP ASN on the {{ yandex-cloud }} equipment.
      * `ipv4_allowed_service_types`: List of IDs for the services whose IP prefixes are announced in the public connection.
      * `ipv4_peer_announced_prefixes`: List of client IP prefixes (if any) the public connection will accept traffic from. 

{% endlist %}
