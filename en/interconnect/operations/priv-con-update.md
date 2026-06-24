---
title: How to update a private connection in {{ interconnect-full-name }}
description: Follow this guide to update private connection parameters in {{ interconnect-full-name }}.
---

# Updating private connection parameters

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

To update a [private connection](../concepts/priv-con.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**.
  1. In the row with the private connection, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens:

      1. Optionally, update the trunk the private connection belongs to. Do it by putting the cursor in the **{{ ui-key.yacloud.interconnect.private-connection.TrunkConnectionSuggestOrCreate.title_oPBF7 }}** field and selecting the trunk.

          Optionally, click **{{ ui-key.yacloud.common.create }}** to create a new trunk.
      1. Optionally, in the **{{ ui-key.yacloud.interconnect.vlan-id_2wghK }}** field, change `VLAN ID` of the private connection in the 802.1Q trunk, e.g., `123`.
      
          This value must be different from the `VLAN-ID` values of other private connections in this trunk.
      1. Optionally, in the **{{ ui-key.yacloud.interconnect.peering-subnet_eYRTR }}** field, change the [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) of the point-to-point subnet for BGP peering, e.g., `192.168.1.0/31`. For more information, see [{#T}](../concepts/priv-con.md#priv-address).
      1. Optionally, in the **{{ ui-key.yacloud.interconnect.peer-ip_pMdxo }}** field, change the IP address from the point-to-point (peering) subnet on the customer’s hardware, e.g., `192.168.1.0`.
      1. Optionally, in the **{{ ui-key.yacloud.interconnect.cloud-ip_6ESSe }}** field, change the IP address from the point-to-point (peering) subnet on the {{ yandex-cloud }} hardware, e.g., `192.168.1.1`.
      1. Optionally, in the **{{ ui-key.yacloud.interconnect.bgp-asn_3dSL7 }}** field, change the BGP ASN on the customer’s hardware in ASPlain format, e.g., `64513`. For more information, see [{#T}](../concepts/priv-con.md#bgp-asn).
      1. Optionally, in the **{{ ui-key.yacloud.interconnect.bgp-key_cn2dU }}** field, change the encrypted BGP session key value.
      1. Optionally, in the **IPv4 StaticRoute prefix** field, change destination CIDR prefixes of static routes announced in the network on the customer’s infrastructure side. You can announce multiple static routes in a single private connection:

          * To add a new static route, click **{{ ui-key.yacloud.interconnect.private-connection.StaticRoutePrefixRow.add-prefix-button_n11CU }}** and specify the prefix you need.
          * To delete an existing static route, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) next to the route.
      1. Optionally, under **{{ ui-key.yacloud.common.section-base }}**, change the following:

          * Private connection **{{ ui-key.yacloud.common.name }}**. The naming requirements are as follows:

              {% include [name-format](../../_includes/name-format.md) %}

              If you do not specify a name, the private connection name will be identical to its [ID](../../api-design-guide/concepts/resources-identification.md).
          * Private connection **{{ ui-key.yacloud.common.description }}**.
          * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md) assigned to the private connection.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  You can update a private connection using these commands:
  * [yc cic private-connection update](../../cli/cli-ref/cic/cli-ref/private-connection/update.md): Allows changing all private connection parameters, which includes full replacement of its static route list with a new one.
  * [yc cic private-connection upsert-static-routes](../../cli/cli-ref/cic/cli-ref/private-connection/upsert-static-routes.md): Allows adding new static routes to a private connection in addition to existing ones.
  * [yc cic private-connection remove-static-routes](../../cli/cli-ref/cic/cli-ref/private-connection/remove-static-routes.md): Allows deleting some static routes from a private connection while preserving others.

  **yc cic private-connection update**

  1. See the description of the CLI command for updating a private connection:

      ```bash
      yc cic private-connection update --help
      ```

  1. Update the `vlan-id` value and the static route list of the private connection:

      ```bash
      yc cic private-connection update cf3r5ke20fo0******** \
        --vlan-id 201 \
        --ipv4-static-routes "192.168.12.0/24,192.168.13.0/28" \
        --async
      ```

      Expected result:

      ```text
      id: bd60h5qtn90s********
      description: private connection update
      created_at: "2025-04-08T21:21:33.106772882Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-04-08T21:21:33.106772882Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdatePrivateConnectionMetadata
        private_connection_id: cf3r5ke20fo0********
      ```

  1. Check the updated parameter value after the operation is complete:

      ```bash
      yc cic private-connection get cf3r5ke20fo0********
      ```

  **yc cic private-connection upsert-static-routes**

  1. See the description of the CLI command for adding new static routes to a private connection:

      ```bash
      yc cic private-connection upsert-static-routes --help
      ```

  1. Add static routes to a private connection:

      ```bash
      yc cic private-connection upsert-static-routes cf3dcodot14p******** \
        --ipv4-static-routes "10.0.0.0/8,192.168.100.0/24" \
        --async
      ```

  **yc cic private-connection remove-static-routes**

  1. See the description of the CLI command for removing static routes from a private connection:

      ```bash
      yc cic private-connection remove-static-routes --help
      ```
      
  1. Remove static routes from your private connection:

      ```bash
      yc cic private-connection remove-static-routes cf3dcodot14p******** \
        --ipv4-static-routes "10.0.0.0/8,192.168.100.0/24" \
        --async
      ```

{% endlist %}