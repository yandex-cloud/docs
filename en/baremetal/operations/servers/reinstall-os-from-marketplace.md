---
title: How to reinstall an OS on a {{ baremetal-name }} server using a {{ marketplace-short-name }} image
description: Follow this guide to reinstall a {{ baremetal-full-name }} server OS from a {{ marketplace-short-name }} image.
---

# Reinstalling an OS from a {{ marketplace-short-name }} image

{{ marketplace-short-name }} is a catalog of preconfigured images of operating systems available for installation on {{ baremetal-name }} servers.

In {{ baremetal-full-name }}, you can reinstall a server OS from a public [{{ marketplace-short-name }} image](../../concepts/images.md#marketplace-images). During reinstallation, you can select any {{ baremetal-name }} server OS available in {{ marketplace-short-name }}, redistribute disk space, rebuild RAID arrays, and reconfigure root user access settings.

{% note warning %}

After reinstalling the OS, data on the disks will be deleted. The server configuration will remain intact.

{% endnote %}

To reinstall a {{ baremetal-name }} server OS:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in its row, and select ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **{{ ui-key.yacloud.baremetal.action_reinstall-server-os-menu }}**.
  1. In the window that opens:

      1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select one of the available OS images.
      1. {% include [server-lease-step8](../../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}

          If you do not modify the disk partitioning, the server will maintain its existing RAID configuration and disk allocation settings.
      1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Click **{{ ui-key.yacloud.baremetal.action_reinstall-server-os }}** and wait for the server OS reinstallation to complete.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the command for reinstalling the OS:

      ```bash
      yc baremetal server reinstall --help
      ```

   1. Reinstall the OS:

      ```bash
      yc baremetal server reinstall \
        --name <server_name> \
        --os-settings "image-id=<image_ID>,image-name=<image_name>,ssh-key-public=<public_SSH_key_contents>,ssh-key-user-id=<SSH_key_user_ID>,password-plain-text=<user_password>,password-lockbox-secret={secret-id=<secret_ID>,version-id=<secret_version>,key=<secret_key>}" \
        --storage "partition={type=<file_system>,size-gib=<partition_size>,mount-point=<mount_point>},raid-type=<RAID array level>,disk={id=<disk_number>,size-gib=<disk_size>,type=<disk_type>}"
      ```

      Where:
      * `--name`: Server name.
      * {% include [server-lease-cli-os](../../../_includes/baremetal/instruction-steps/server-lease-cli-os.md) %}
      * {% include [server-lease-cli-storage](../../../_includes/baremetal/instruction-steps/server-lease-cli-storage.md) %}

- API {#api}

  To reinstall a server OS, use the [reinstall](../../api-ref/Server/reinstall.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/Reinstall](../../api-ref/grpc/Server/reinstall.md) gRPC API call.

{% endlist %}

## Example {#example}

Reinstall the OS:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal server reinstall \
    --name demo-baremetal-server \
    --os-settings "image-id=ly5vtno2mjr3k4iuecur,password-plain-text=FDrxicR********,ssh-key-public=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQ********"
  ```

  Result:

  ```text
  done (22m47s)
  id: ly5u2442ulmz********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-baremetal-server
  description: My first BareMetal server
  zone_id: ru-central1-m
  hardware_pool_id: ru-central1-m4
  status: RUNNING
  os_settings:
    image_id: ly5vtno2mjr3k4iuecur
    ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
    storages:
      - partitions:
          - type: EXT3
            size_gib: "9"
            mount_point: /boot
          - type: SWAP
            size_gib: "4"
          - type: EXT4
            mount_point: /
        raid:
          type: RAID10
          disks:
            - id: ly54aes2ecmb********
              type: HDD
              size_gib: "1862"
            - id: ly5nrgud6zrt********
              type: HDD
              size_gib: "1862"
            - id: ly5yf2ylmchh********
              type: HDD
              size_gib: "1862"
            - id: ly5loug77ciu********
              type: HDD
              size_gib: "1862"
  configuration_id: ly5lymxdltk3xitpkrmi
  created_at: "2025-07-09T07:23:39.323794Z"
  labels:
    env: test
  ```

- API {#api}

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{
    "osSettingsSpec": {
    "imageId": "ly5vyzcggvci********",
    "storages": [
      {
        "partitions": [
          {
            "type": "EXT3",
            "sizeGib": "9",
            "mountPoint": "/boot"
          },
          {
            "type": "SWAP",
            "sizeGib": "4"
          },
          {
            "type": "EXT4",
            "mountPoint": "/"
          }
        ],
        "raid": {
          "disks": [
            {
              "id": "ly536lgz5cdo********",
              "type": "HDD",
              "sizeGib": "1862"
            },
            {
              "id": "ly55nr77qcgq********",
              "type": "HDD",
              "sizeGib": "1862"
            },
            {
              "id": "ly57e5ouat4r********",
              "type": "HDD",
              "sizeGib": "1862"
            },
            {
              "id": "ly5g77vbnavh********",
              "type": "HDD",
              "sizeGib": "1862"
            }
          ],
          "type": "RAID10"
        }
       }
      ],
      "sshPublicKey": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYMj0PbB7ObhwL0z3y+vN0BfNK********",
      "passwordLockboxSecret": {
        "secretId": "e6q44i0gmlrh********",
        "versionId": "e6q3ba84ur0a********",
        "key": "password"
      }
     }
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>:reinstall"
  ```

  Where:

  * `<server_ID>`: ID of the server you want to update. To find out the ID, follow [this guide](get-info.md).

  {% include [ossettingsspec-api-legend](../../../_includes/baremetal/ossettingsspec-api-legend.md) %}

  Result:

  ```bash
  {
    "done": false,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.ReinstallServerMetadata",
      "serverId": "ly56xpblirh4********"
    },
    "id": "ly5ryflh7v5p********",
    "description": "Server reinstall",
    "createdAt": "2025-12-07T20:47:23.928014Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-07T20:47:23.928014Z"
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}