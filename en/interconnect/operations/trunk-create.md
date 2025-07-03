---
title: How to create a trunk in {{ interconnect-name }}
description: Follow this guide to create a trunk in {{ interconnect-name }}.
---

# Creating a new trunk

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

## Creating a direct trunk {#direct}

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

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



