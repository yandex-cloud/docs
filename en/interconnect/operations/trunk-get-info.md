---
title: How to get information about trunks in {{ interconnect-name }}
description: Follow this guide to get information about trunks in {{ interconnect-name }}.
---

# Getting information about trunks

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command to get information about [trunks](../concepts/trunk.md):

      ```bash
      yc cic trunk get --help
      ```

  1. Get a list of trunks in the specified folder:

      ```bash
      yc cic trunk list --folder-id b1gqf2hjizv2jw******
      ```

      Result:

      ```text
      +----------------------+--------------------+----------------------------+------------------+----------+
      |          ID          |        NAME        | POINT OF PRESENCE ID (POP) | TRANSCEIVER TYPE | CAPACITY |
      +----------------------+--------------------+----------------------------+------------------+----------+
      | euuqqctbrflq3i****** | customer-name-m9   | ru-msk-m9-0                | 10GBASE-LR       | 5 GBPS   |
      | euuvdjl5shd0fv****** | customer-name-ost  | ru-msk-ost-0               | 10GBASE-LR       | 5 GBPS   |
      +----------------------+--------------------+----------------------------+------------------+----------+
      ```

  1. Get information about the trunk by specifying its ID obtained in the previous step:

      ```bash
      # yc cic trunk get <trunk_ID>
      yc cic trunk get euuqqctbrflq3i******
      ```

      Result:

      ```yml
      id: euuqqctbrflq3i******
      name: customer-name-m9
      folder_id: b1gqf2hjizv2jw******
      region_id: ru-central1
      single_port_direct_joint:
        transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
        port_name: 25GE1/0/2
        access_device_name: m9-cicext1
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_5_GBPS
      ```

      Where:
      * `id`: Trunk ID.
      * `name`: Trunk name.
      * `folder_id`: ID of the cloud folder the trunk was created in.
      * `region_id`: Region of the cloud the trunk belongs to.
      * Trunk type:
        * `single_port_direct_joint`: Direct trunk:
           * `transceiver_type`: [Transceiver](../concepts/transceivers.md) type.
           * `port_name`: Port(s) allocated for the trunk on the network device.
           * `access_device_name`: Name of the network device with ports allocated for the trunk.
        * `lag_direct_joint`: Aggregated (LAG) direct trunk:
           * `transceiver_type`: [Transceiver](../concepts/transceivers.md) type.
           * `lag_id`: Aggregated connection ID.
           * `port_names`: List of physical ports in LAG.
        * `partner_joint_info`: Partner trunk:
           * `partner_id`: Partner ID.
           * `service_key`: Service key for the partner trunk.
      * `point_of_presence_id`: [Point of presence](../concepts/pops.md) ID.
      * `capacity`: Trunk [traffic packet](../concepts/capacity.md) size. 

{% endlist %}
