---
title: How to update a server in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to update your {{ baremetal-full-name }} server’s name and description.
---

# Updating a server

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the server belongs to.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Push your changes to the server configuration:

      * Optionally, change the server's name in the **{{ ui-key.yacloud.baremetal.field_name_dFuVW }}** field. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

      * Optionally, add or update the server's description in the **{{ ui-key.yacloud.baremetal.field_description_f2tds }}** field.
      * Optionally, add or update the server's [labels](../../../resource-manager/concepts/labels.md) in the **{{ ui-key.yacloud.component.label-set.label_labels }}** field.
      * Optionally, update server lease duration under **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**.

          {% note info %}

          The lease duration setting changes will apply only after the current server lease period expires.

          {% endnote %}
      
      * Optionally, change the server's [network settings](../../concepts/network.md) in the **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}** and **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** sections.

          To attach an [additional private subnet](../../concepts/private-network.md#tagged-vlan-subnet) to the server, click **{{ ui-key.yacloud.baremetal.addAdditionalSubnet }}** in the **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}** section and, in the field that appears, select an existing additional subnet or create a new one.

          {% include [additional-private-subnet-dhcp-notice](../../../_includes/baremetal/additional-private-subnet-dhcp-notice.md) %}

          To detach an additional subnet from the server, click ![trash-bin](../../../_assets/console-icons/trash-bin.svg) next to this subnet in the **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}** section.

          {% note warning %}

          If you have changed the number or composition of additional private subnets attached to the server, [configure](./set-up-tagged-vlan.md) the network interface in its operating system.

          {% endnote %}

      * Optionally, in the **{{ ui-key.yacloud.baremetal.servers.BandwidthRow.bandwidthTitle_wvZra }}** field, change the [server's bandwidth](../../concepts/network-restrictions.md#bandwidth-for-pubic-network) package. Available bandwidth packages:

          * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan10Tb_2BFQU }}`
          * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan100Tb_4AB2b }}`

          {% note info %}

          You can select a bandwidth package only for configurations with a public IP address and network cards of 10 Gbps or higher.

          After you increase bandwidth, it can be reduced only after 24 hours.

          {% endnote %}

  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the server update command:

      ```bash
      yc baremetal server update --help
      ```

   1. Update server:

      ```bash
      yc baremetal server update \
        --name <server_name> \
        --new-name <new_server_name> \
        --description <new_server_description> \
        --network-interfaces private-subnet-id=<new_private_subnet_ID> \
        --network-interfaces public-subnet-id=<new_public_subnet_ID> \
        --labels <label_key>=<label_value>
      ```

      Where:
      * `--name`: Server name.
      * `--new-name`: New server name. This is an optional setting.
      * `--description`: New server description. This is an optional setting.
      * `--network-interfaces`: New network settings. This is an optional setting. The possible values are:
        
        * `private-subnet-id`: ID of the new [private subnet](../../concepts/private-network.md#private-subnet).
        * `public-subnet-id`: ID of the new [dedicated public subnet](../../concepts/public-network.md#public-subnet).

      * `--labels`: New server labels. This is an optional setting.

- API {#api}

  To update a server, use the [update](../../api-ref/Server/update.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/Update](../../api-ref/grpc/Server/update.md) gRPC API call.

{% endlist %}

## Example {#example}

Update server name, description, and network settings:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
     yc baremetal server update \
       --name demo-baremetal-server  \
       --new-name new-demo-baremetal-server  \
       --description "Updated BareMetal server" \
       --network-interfaces private-subnet-id=ly5rljahs3re******** \
       --network-interfaces public-subnet-id=ly5vr6tugxk7********
   ```

   Result:

   ```bash
   id: ly52dtzdi55r********
   cloud_id: b1gia87mbaom********
   folder_id: b1g0ijbfaqsn********
   name: new-demo-baremetal-server
   description: Updated BareMetal server
   zone_id: ru-central1-m
   hardware_pool_id: ru-central1-m4
   status: PROVISIONING
   os_settings:
     image_id: ly5vhn4lapev********
     ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
     storages:
       - partitions:
           - type: EXT3
             size_gib: "999"
             mount_point: /
           - type: EXT4
             size_gib: "499"
             mount_point: /root
         raid:
           type: RAID0
           disks:
             - id: ly5ual3jbnhr********
               type: HDD
               size_gib: "1862"
             - id: ly54qfjw55d4********
               type: HDD
               size_gib: "1862"
       - partitions:
           - type: EXT3
             size_gib: "999"
             mount_point: /boot
           - type: SWAP
             size_gib: "9"
         disk:
           id: ly5ojffpngul********
           type: HDD
           size_gib: "1862"
   network_interfaces:
     - id: ly5wbsiklrtd********
       mac_address: 00:25:90:92:fa:48
       private_subnet:
         private_subnet_id: ly5ztavbezrf********
     - id: ly5ygl4loyy6********
       mac_address: 00:25:90:92:fa:49
       public_subnet:
         public_subnet_id: ly5o6l7pxmk2********
   configuration_id: ly5lymxdltk3********
   created_at: "2025-07-06T21:53:46.186130Z"
   labels:
     env: test
   ```

- API {#api}

  ```bash
  curl -X PATCH \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{
      "updateMask": "name,description,networkInterfaces",
      "name": "new-bm-server-test",
      "description": "Updated BareMetal server",
      "networkInterfaces": [
        {
          "privateSubnet": {
            "privateSubnetId": "ly55shvlzvy4********"
          },
          "id": "ly5j33j44gtc********",
          "macAddress": "00:25:90:e9:49:98"
        },
        {
          "publicSubnet": {
            "publicSubnetId": "ly52yjugkj57********"
          },
          "id": "ly5rmqqchyep********",
          "macAddress": "00:25:90:e9:49:99"
        }
      ]
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>"
  ```

  Where:
  * `<IAM_token>`: IAM token used for authentication.
  * `<server_ID>`: ID of the server you want to update. To find out the ID, follow [this guide](get-info.md).
  * `updateMask`: List of fields to update, comma-separated. Only the specified fields will be updated. If you specify a field in `updateMask` but provide no value in the query, the field will be reset to its default value.
  * `name`: New server name. The name must be unique within the folder.

    {% include [name-format](../../../_includes/name-format.md) %}

  * `description`: New server description.
  * `networkInterfaces[]`: New network settings. This is an optional parameter. The possible values are:
    * `privateSubnetId`: ID of the new [private subnet](../../concepts/private-network.md#private-subnet).
    * `publicSubnetId`: ID of the new [dedicated public subnet](../../concepts/public-network.md#public-subnet).
  
  Result:

  ```bash
  {
    "done": false,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.UpdateServerMetadata",
      "serverId": "ly56xpblirh4********"
    },
    "id": "ly5k7jdyevbh********",
    "description": "Server update",
    "createdAt": "2025-12-07T20:03:43.637004Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-07T20:03:43.637004Z"
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}