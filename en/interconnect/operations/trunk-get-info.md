---
title: How to get information about trunks in {{ interconnect-name }}
description: In this tutorial, we will get information about trunks in {{ interconnect-name }}.
---

# Getting information about trunk links

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**. The window that opens will list all trunks in the selected folder.
  1. To view detailed information about a specific trunk, click its row in the list. The window that opens provides the following information:

      * On the ![flag](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** tab: General trunk info, i.e., name, ID, status, capacity, type, point of presence, {{ interconnect-name }} partner, and transceiver type.
      * On the ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}** tab: List of [private connections](../concepts/priv-con.md) within this trunk.
      * On the ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.interconnect.public-connection.public-connections_7xYcV }}** tab: List of [public connections](../concepts/pub-con.md) within this trunk.
      * On the ![display-pulse](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** tab: {{ monitoring-full-name }} [widgets](../../monitoring/concepts/visualization/widget.md) used to track the trunk's status.
      * On the ![list-check](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab: List of [operations](../../api-design-guide/concepts/about-async.md) with the trunk.

- CLI {#cli}

  1. To get information about [trunks](../concepts/trunk.md), see the description of the CLI command:

      ```bash
      yc cic trunk get --help
      ```

  1. Get a list of trunks in the specified folder:

      ```bash
      yc cic trunk list --folder-id b1gt6g8ht345********
      ```

      Result:




  1. Get information about the trunk by specifying its ID obtained in the previous step:

      ```bash
      yc cic trunk get cf3dcodot14p********
      ```

      Result:



      Where:

      * `id`: Trunk ID.
      * `name`: Trunk name.
      * `description`: Trunk description.
      * `cloud_id`: ID of the cloud in whose folder the trunk was created.
      * `folder_id`: ID of the cloud folder containing the trunk.
      * `region_id`: Region of the cloud containing the trunk.
      * Trunk type:
        * `single_port_direct_joint`: Direct trunk:
           * `transceiver_type`: [Transceiver](../concepts/transceivers.md) type in use.
           * `port_name`: Port number(s) allocated for the trunk on the network device.
           * `access_device_name`: Name of the network device with ports allocated for the trunk.
        * `lag_direct_joint`: Aggregated (LAG) direct trunk:
           * `transceiver_type`: [Transceiver](../concepts/transceivers.md) type in use.
           * `lag_id`: Aggregated connection ID.
           * `port_names`: List of physical ports in the LAG.
        * `partner_joint_info`: Partner trunk:
           * `partner_id`: Partner ID.
           * `service_key`: Partner trunk service key.
      * `point_of_presence_id`: [Point of presence](../concepts/pops.md) ID.
      * `capacity`: Trunk [capacity](../concepts/capacity.md). 
      * `status`: Trunk state. Target state: `ACTIVE`.
      * `created_at`: Date and time of trunk creation.

{% endlist %}

