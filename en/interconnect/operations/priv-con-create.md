---
title: How to create a private connection in an {{ interconnect-name }} trunk
description: Follow this guide to create a private connection in an {{ interconnect-name }} trunk.
---

# Creating a private connection

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}** and click **{{ ui-key.yacloud.interconnect.private-connection.create-private-connection_6K9tP }}**. In the window that opens:

      1. Place your cursor in the **{{ ui-key.yacloud.interconnect.private-connection.TrunkConnectionSuggestOrCreate.title_oPBF7 }}** field and select the trunk where you want to create a private connection.

          Optionally, click **{{ ui-key.yacloud.common.create }}** to create a new trunk.
      1. In the **{{ ui-key.yacloud.interconnect.vlan-id_2wghK }}** field, specify a `VLAN ID` of your choice for the private connection in the 802.1Q trunk, e.g., `123`.
      
          This value must be different from the `VLAN-ID` values of other private connections in this trunk.
      1. In the **{{ ui-key.yacloud.interconnect.peering-subnet_eYRTR }}** field, specify the [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) of the point-to-point subnet for BGP peering, e.g., `192.168.1.0/31`. For more information, see [{#T}](../concepts/priv-con.md#priv-address).
      1. In the **{{ ui-key.yacloud.interconnect.peer-ip_pMdxo }}** field, specify the customer endpoint IP address on the point-to-point peering subnet, e.g., `192.168.1.0`.
      1. In the **{{ ui-key.yacloud.interconnect.cloud-ip_6ESSe }}** field, specify the {{ yandex-cloud }} endpoint IP address on the point-to-point peering subnet, e.g., `192.168.1.1`.
      1. In the **{{ ui-key.yacloud.interconnect.bgp-asn_3dSL7 }}**, specify the customer endpoint BGP ASN in ASPlain format, e.g., `64513`. For more information, see [{#T}](../concepts/priv-con.md#bgp-asn).
      1. Optionally, in the **{{ ui-key.yacloud.interconnect.bgp-key_cn2dU }}** field, specify the encrypted BGP session key value.
      1. In the **IPv4 StaticRoute prefix**, click **{{ ui-key.yacloud.interconnect.private-connection.StaticRoutePrefixRow.add-prefix-button_n11CU }}** for your private connection to include the destination CIDR prefix of the static route that will be announced in the network on the side of the customer's infrastructure.

          You can announce multiple static routes in a single private connection. To do this, click **{{ ui-key.yacloud.interconnect.private-connection.StaticRoutePrefixRow.add-prefix-button_n11CU }}** again, as many times as you need.
      1. Optionally, under **{{ ui-key.yacloud.common.section-base }}**, specify the following for the new connection:

          * **{{ ui-key.yacloud.common.name }}**. The naming requirements are as follows:

              {% include [name-format](../../_includes/name-format.md) %}

              If you do not specify a name, the private connection name will be identical to its [ID](../../api-design-guide/concepts/resources-identification.md).
          * Any **{{ ui-key.yacloud.common.description }}** for the connection
          * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md) to assign to the connection
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. View the description of the CLI command to create a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection create --help
      ```

  1. Create a private connection:

      ```bash
      yc cic private-connection create \
        --name prc-pop1 \
        --description "Private connection #1 via POP-1" \
        --trunk-id cf3dcodot14p******** \
        --vlan-id 125 \
        --ipv4-peering peering-subnet=192.168.10.0/30,peer-ip=192.168.10.1,cloud-ip=192.168.10.2,peer-bgp-asn=65202 \
        --async
      ```

      {% note info %}

      By default, the private connection will be created in the same folder as the trunk. To simplify maintenance, it is best not create trunks and private connections in different folders.

      {% endnote %}

      Expected result:

      ```text
      id: bd6g2l17c8sv********
      name: prc-pop1
      folder_id: b1gt6g8ht345********
      region_id: {{ region-id }}
      trunk_connection_id: cf3dcodot14p********
      vlan_id: "125"
      ipv4_peering:
        peering_subnet: 192.168.10.0/30
        peer_ip: 192.168.10.1
        cloud_ip: 192.168.10.2
        peer_bgp_asn: "20001"
        peer_bgp_md5_key: '*** hidden ***'
      status: ACTIVE
      created_at: "2025-03-20T08:25:33Z"
      ```

      Where:

      * `id`: Private connection ID.
      * `name`: Private connection name.
      * `description`: Private connection description.
      * `folder_id`: ID of the cloud folder the private connection was created in.
      * `region_id`: Cloud region the private connection was created in.
      * `trunk_connection_id`: ID of the trunk the private connection was created in.
      * `vlan_id`: VLAN ID for this private connection in the 802.1Q trunk. This value is selected by the customer. It must be different from the VLAN IDs of the previously set up private connections in this trunk.
      * `ipv4_peering`: Group of IP/BGP connectivity parameters for the private connection:
        * `peering_subnet`: [Point-to-point subnet](../concepts/priv-con.md#priv-address) for BGP peering. This value is selected by the customer.
        * `peer_ip`: Customer endpoint IP address on the point-to-point peering subnet. This value is selected by the customer.
        * `cloud_ip`: {{ yandex-cloud }} endpoint IP address on the point-to-point peering subnet. This value is selected by the customer.
        * `peer_bgp_asn`: Customer endpoint [BGP ASN](../concepts/priv-con.md#bgp-asn) in ASPlain format. This value is selected by the customer.
        * `peer_bgp_md5_key`: Optional parameter. Encrypted BGP session key value.
      * `status`: Resource state. Target state: `ACTIVE`.
      * `created_at`: Date and time of resource creation.
      * `async`: Running the operation in asynchronous mode. This is the recommended mode for all operations that involve changes to resources.

{% endlist %}
