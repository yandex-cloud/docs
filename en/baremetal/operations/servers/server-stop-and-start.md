---
title: How to start, stop, and restart a server in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to start, stop, and restart a leased {{ baremetal-full-name }} server.
---

# How to start, stop, and restart a server

## Stopping {#stop}

To stop a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.common.stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the command to stop the server:

      ```bash
      yc baremetal server power-off --help
      ```

   1. Run this command:

      ```bash
      yc baremetal server power-off <server_name_or_ID>
      ```

- API {#api}

  To stop a server, use the [powerOff](../../api-ref/Server/powerOff.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/PowerOff](../../api-ref/grpc/Server/powerOff.md) gRPC API call.

{% endlist %}

## Starting {#start}

To start a stopped server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the stopped server belongs to.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

   1. View the description of the command to start the server:

      ```bash
      yc baremetal server power-on --help
      ```

   1. Run this command:

      ```bash
      yc baremetal server power-on <server_name_or_ID>
      ```

- API {#api}

  To start a server, use the [powerOn](../../api-ref/Server/powerOn.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/PowerOn](../../api-ref/grpc/Server/powerOn.md) gRPC API call.

{% endlist %}

## Restarting {#restart}

To restart a server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Find the server you need in the list, click ![image](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. The server status will change to `Restarting`.

- CLI {#cli}

   1. View the description of the command to restart the server:

      ```bash
      yc baremetal server reboot --help
      ```

   1. Run this command:

      ```bash
      yc baremetal server reboot <server_name_or_ID>
      ```

- API {#api}

  To restart a server, use the [reboot](../../api-ref/Server/reboot.md) REST API method for the [Server](../../api-ref/Server/index.md) resource or the [ServerService/Reboot](../../api-ref/grpc/Server/reboot.md) gRPC API call.

{% endlist %}

### Query examples {#request-examples}

To stop a server, run this command:

```bash
curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <IAM_token>" \
-d '{}' \
"https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>:powerOff"
```

Where:

* `<IAM_token>`: IAM token used for authentication.
* `<server_ID>`: ID of the server you want to update. To find out the ID, follow [this guide](get-info.md).

Result:

```bash
{
  "done": false,
  "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PowerOffServerMetadata",
    "serverId": "ly56xpblirh4********"
  },
  "id": "ly5rqxit432m********",
  "description": "Server power off",
  "createdAt": "2025-12-07T19:55:40.399275Z",
  "createdBy": "ajeb9l33h6mu********",
  "modifiedAt": "2025-12-07T19:55:40.399275Z"
}
```

To start a server, run this command:

```bash
curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <IAM_token>" \
-d '{}' \
"https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>:powerOn"
```
Result:

```bash
{
  "done": false,
  "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PowerOnServerMetadata",
    "serverId": "ly56xpblirh4********"
  },
  "id": "ly5rqxit432m********",
  "description": "Server power on",
  "createdAt": "2025-12-07T19:55:40.399275Z",
  "createdBy": "ajeb9l33h6mu********",
  "modifiedAt": "2025-12-07T19:55:40.399275Z"
}
```
To restart a server, run this command:

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM_token>" \
  -d '{}' \
  "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<server_ID>:reboot"
```

Result:

```bash
{
"done": false,
"metadata": {
  "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.RebootServerMetadata",
  "serverId": "ly56xpblirh4********"
},
"id": "ly54ebp4hozz********",
"description": "Server reboot",
"createdAt": "2025-12-07T19:39:42.667128Z",
"createdBy": "ajeb9l33h6mu********",
"modifiedAt": "2025-12-07T19:39:42.667128Z"
}
```

  Monitor your operation status in the `done` field.
