---
title: How to get information about trunks in {{ interconnect-name }}
description: In this tutorial, we will get information about trunks in {{ interconnect-name }}.
---

# Getting information about trunk links

{% note info %}

You need the [cic.viewer](../security/index.md#cic-viewer) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. To get information about [trunks](../concepts/trunk.md), see the description of the CLI command:

      ```bash
      yc cic trunk get --help
      ```

  1. Get a list of trunks in the specified folder:

      ```bash
      yc cic trunk list --folder-id b1gqf2hjizv2jw******
      ```

      Result:




  1. Get information about the trunk by specifying its ID obtained in the previous step:

      ```bash
      # yc cic trunk get <trunk_ID>
      yc cic trunk get cf3td**********nufvr
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

