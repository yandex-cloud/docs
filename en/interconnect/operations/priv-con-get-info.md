---
title: Getting information about a {{ interconnect-name }} private connection
description: Follow this guide to get information about a {{ interconnect-name }} private connection.
---

# Getting information about a private connection

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**. The window that opens will list all private connections in the selected folder.
  1. To view detailed information about a specific private connection, click its row in the list.

- CLI {#cli}

  1. View the description of the CLI command to get information about a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection get --help
      ```

  1. Get a list of private connections in the specified folder:

      ```bash
      yc cic private-connection list --folder-id b1gt6g8ht345********
      ```

      Result:

      ```text
      +----------------------+--------------------+----------------------+
      |          ID          |        NAME        | TRUNK CONNECTION ID  |
      +----------------------+--------------------+----------------------+
      | euuiog88zphg******** | customer-name-prc1 | euuqqctbrflq******** |
      | euucr7p47329******** | customer-name-prc2 | euuvdjl5shd0******** |
      +----------------------+--------------------+----------------------+      
      ```

  1. Get information about the private connection by specifying its ID obtained in the previous step:

      ```bash
      yc cic private-connection get euuiog88zphg********
      ```

      Result:

      ```yml
      id: euuiog88zphg********
      name: customer-name-prc1
      folder_id: b1gt6g8ht345********
      region_id: {{ region-id }}
      trunk_connection_id: euuqqctbrflq********
      vlan_id: "1531"
      ipv4_peering:
        peering_subnet: 10.211.10.0/30
        peer_ip: 10.211.10.1
        cloud_ip: 10.211.10.2
        peer_bgp_asn: "64515"
        cloud_bgp_asn: "{{ cic-bgp-asn }}"
      ```

      Where:

      * `id`: Private connection ID.
      * `name`: Private connection name.
      * `folder_id`: ID of the cloud folder where you created the private connection.
      * `region_id`: Region of the cloud where you created the private connection.
      * `trunk_connection_id`: ID of the trunk link containing the private connection.
      * `vlan_id`: Private connection VLAN ID.
      * IP and BGP connectivity settings for the private connection point-to-point subnet:
         * `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/priv-con.md#priv-address) for BGP peering.
         * `peer_ip`: Customer endpoint IP address on the point-to-point peering subnet.
         * `cloud_ip`: {{ yandex-cloud }} endpoint IP address on the point-to-point peering subnet.
         * `peer_bgp_asn`: [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment.
         * `cloud_bgp_asn`: BGP ASN on the {{ yandex-cloud }} equipment.

{% endlist %}
