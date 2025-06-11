---
title: How to get information about {{ interconnect-name }} public connections
description: In this tutorial, we will get information about {{ interconnect-name }} public connections.
---

# Getting information about public connections

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. To get information about [public connections](../concepts/pub-con.md), see the description of the CLI command:

      ```bash
      yc cic public-connection get --help
      ```

  1. Get a list of public connections in the specified folder:

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
      * `region_id`: Region of the cloud containing the new public connection.
      * `trunk_connection_id`: ID of the trunk link containing the new public connection.
      * `vlan_id`: public connection VLAN ID.
      * IP and BGP connectivity settings for the public connection point-to-point subnet:
         * `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/pub-con.md#pub-address) for BGP peering.
         * `peer_ip`: Customer endpoint IP address on the point-to-point peering subnet.
         * `cloud_ip`: {{ yandex-cloud }} endpoint IP address on the point-to-point peering subnet.
         * `peer_bgp_asn`: [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment.
         * `cloud_bgp_asn`: BGP ASN on the {{ yandex-cloud }} equipment.
      * `ipv4_allowed_service_types`: IDs of the services with their IP prefixes announced in the public connection.
      * `ipv4_peer_announced_prefixes`: List of client IP prefixes (if any) allowed to send traffic to the public connection. 

{% endlist %}
