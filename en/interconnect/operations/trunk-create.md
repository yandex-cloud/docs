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

      ```bash
      yc cic trunk-connection create --name trunk-m9 \
        --description "Trunk M9" \ 
        --pop ru-msk-m9-0 \
        --capacity 1-gbps \
        --trunk-options type=direct,transceiver=10GBASE-LR \ 
        --deletion-protection \
        --folder-id b1gqf**********jiz2w \
        --async
      ```

      Expected result:

      ```text
      id: cf3td**********nufvr
      name: trunk-m9
      description: Trunk M9
      cloud_id: b1g7a**********kd23p
      folder_id: b1gqf**********jiz2w
      region_id: ru-central1
      created_at: "2025-03-25T10:54:46Z"
      single_port_direct_joint:
        transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
        port_name: 25GE1/0/12
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_1_GBPS
      status: ACTIVE
      ```

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
      * `async`: Running the operation in asynchronous mode. We recommend you to perform all resource state change operations in this mode.

{% endlist %}

## Creating a trunk via a partner {#partner}

{% list tabs group=instructions %}

- CLI {#cli}

  1. See the description of the CLI command for creating a [trunk](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection create --help
      ```

  1. Get the required partner connection `ID`:

      ```bash
      yc cic partner list
      ``` 

  1. Create a partner trunk in the specified folder:

      ```bash
      yc cic trunk-connection create --name trunk-m9 \
        --description "Trunk M9" \
        --pop ru-msk-m9-0 \
        --capacity 500-mbps \
        --trunk-options type=partner,partner-id=partnerID \
        --folder-id b1gqf**********jiz2w \
        --async
      ```

      {% note info %}

      When creating it, specify partner ID and do not specify transceiver type.

      {% endnote %}

      Expected result:

      ```text
      id: cf3td**********nufvr
      name: trunk-m9
      description: Trunk M9
      cloud_id: b1g7a**********kd23p
      folder_id: b1gqf**********jiz2w
      region_id: ru-central1
      created_at: "2025-03-25T10:54:46Z"
      partner_joint_info:
        partner_id: partnerID
        service_key: euucl**********bdga6
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_500_MBPS
      status: ACTIVE
      ```

  1. Create a [new support ticket]({{ link-console-support }}) to inform your partner about the trunk you created.

      Follow this request format:

      ```text
      Subject: [CIC] Notification to _partnerID_ about the Cloud Interconnect trunk that has been created.
      

      Request text: Please notify the partner about the parameters of the new trunk trunk_id: euus5dfgchu2********
      
      ```

      {% note info %}

      The support engineer will process the ticket and notify the partner about the new trunk. 

      The following data will be sent to the partner: `partner_joint_id`, `partner_vlan_id`, `capacity`, and `service_key`.

      {% endnote %}

{% endlist %}

