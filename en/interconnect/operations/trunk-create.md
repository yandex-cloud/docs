---
title: How to create a trunk in {{ interconnect-name }}
description: Follow this guide to create a trunk in {{ interconnect-name }}.
---

# Creating a new trunk

## Creating a direct trunk {#direct}

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) or ![chevron-down](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}** and click **{{ ui-key.yacloud.interconnect.trunk-connection.TrunkConnectionListScreen.create-trunk-connection_oUuYo }}**. In the window that opens:

      1. In the **{{ ui-key.yacloud.interconnect.trunk-connection.connection-capacity_tkrnE }}** field, specify the [traffic packet](../concepts/capacity.md) size for the new trunk.
      1. In the **{{ ui-key.yacloud.interconnect.trunk-connection.point-of-presence_265QN }}** field, select the required [point of presence](../concepts/pops.md).
      1. In the **{{ ui-key.yacloud.interconnect.trunk-connection.connection-type_23Twp }}** field, select `{{ ui-key.yacloud.interconnect.trunk-connection.connection-type-single-port-direct_1QHVe }}`.
      1. In the **{{ ui-key.yacloud.interconnect.trunk-connection.transceiver-type_2WtM8 }}** field, select the tranciever type to use on the {{ interconnect-name }} side. Your hardware must have a compatible tranciever.
      1. Optionally, under **{{ ui-key.yacloud.common.section-base }}**, specify:

          * **{{ ui-key.yacloud.common.name }}**. The naming requirements are as follows:

              {% include [name-format](../../_includes/name-format.md) %}

              If you do not specify a name, the trunk name will be identical to the trunk [ID](../../api-design-guide/concepts/resources-identification.md).
          * Ad hoc trunk **{{ ui-key.yacloud.common.description }}**.
          * Trunk [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md).
      1. To protect the new trunk from accidental deletion, enable **{{ ui-key.yacloud.common.deletion-protection }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. See the description of the CLI command for creating a [trunk](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection create --help
      ```

  1. Create a direct trunk in the specified folder:



      Where:

      * `id`: Trunk ID.
      * `name`: Trunk name.
      * `description`: Trunk description.
      * `cloud_id`: ID of the cloud in whose folder the trunk was created.
      * `folder_id`: ID of the cloud folder the trunk was created in.
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
      * `point_of_presence_id`: [Point of presence](../concepts/pops.md) ID. When creating a trunk, you must select the required value from the _Label_ column of the [table](../concepts/pops.md).
      * `capacity`: Trunk [capacity](../concepts/capacity.md). When creating a trunk, you must select the required value from the _Label_ column of the [table](../concepts/capacity.md).
      * `status`: Resource state. Target state: `ACTIVE`.
      * `created_at`: Date and time of resource creation.
      * `deletion-protection`: Resource protection against accidental deletion. You will not be able to delete the resource unless this flag is removed first.
      * `async`: Running a command in asynchronous mode. We recommend you to perform all resource state change operations in this mode.

{% endlist %}




