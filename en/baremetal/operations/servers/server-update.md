---
title: How to update a server in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to update your {{ baremetal-full-name }} server’s name and description.
---

# Updating a server

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the server belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.common.edit }}**.
  1. If required, change the server’s name, description, labels, lease duration, and network settings.

      {% note info %}

      The lease duration setting changes will apply only after the current server lease period expires.

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
      * `--new-name`: New server name. This is an optional parameter.
      * `--description`: New server description. This is an optional parameter.
      * `--network-interfaces`: New network settings. This is an optional parameter. The possible values are:
        
        * `private-subnet-id`: ID of the new [private subnet](../../concepts/network.md#private-subnet).
        * `public-subnet-id`: ID of the new [dedicated public subnet](../../concepts/network.md#public-subnet).

      * `--labels`: New server labels. This is an optional parameter.

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
        --network-interfaces private-subnet-id=ly5rljahs3re4gw7bf6l \
        --network-interfaces public-subnet-id=ly5vr6tugxk75fynutzt
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
    configuration_id: ly5lymxdltk3xitpkrmi
    created_at: "2025-07-06T21:53:46.186130Z"
    labels:
      env: test
    ```

 {% endlist %}