---
title: How to create a VRF in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to create a virtual routing and forwarding (VRF) segment in {{ baremetal-full-name }}.
---

# Creating a VRF

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [VRF](../concepts/private-network.md#vrf-segment).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, specify your VRF name. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, you can add a VRF **{{ ui-key.yacloud.baremetal.field_description }}**.
  1. Optionally, you can add labels.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-network }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the command to create a [virtual network segment (VRF)](../concepts/private-network.md#vrf-segment):

     ```bash
     yc baremetal vrf create --help
     ```
  
  1. Create a VRF:
     
     ```bash
     yc baremetal vrf create \
       --name <VRF_name> \
       --description "<VRF_description>" \
       --labels <key>=<value>
     ```

     Where:
     * `--name`: VRF name. Follow these naming requirements:
       
       {% include [name-format](../../_includes/name-format.md) %}

     * `--description`: VRF description. This is an optional parameter.
     * `--labels`: VRF labels. This is an optional parameter.

- API {#api}

  To create a VRF, use the [create](../api-ref/Vrf/create.md) REST API method for the [Vrf](../api-ref/Vrf/index.md) resource or the [VrfService/Create](../api-ref/grpc/Vrf/create.md) gRPC API call.
  
{% endlist %}

## Example {#examples}

Create a virtual routing and forwarding segment with a name, description, and label:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal vrf create \
    --name demo-vrf \
    --description "My first VRF" \
    --labels env=test
  ```

  Result:
  
  ```text
  id: ly52l2lzaq5uw********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-vrf
  description: My first VRF
  created_at: "2025-07-01T21:37:08.740581Z"
  labels:
    env: test
  ```

- API {#api}

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{
       "folderId": "b1g07hj5r6i4********",
       "name": "baremetal-vrf",
       "description": "Test baremetal VRF",
       "labels": {
         "key": "vrf"
       }
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/vrfs"
  ```

  Where:

  * `<IAM_token>`: IAM token used for authentication.
  * `folderId`: Folder ID.
  * `name`: Image name. Follow these naming requirements:

    {% include [name-format](../../_includes/name-format.md) %}

  * `description`: VRF description. This is an optional parameter.
  * `labels`: VRF labels. This is an optional parameter.

  Result:

  ```bash
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreateVrfMetadata",
      "vrfId": "ly5uyq2gbxu2********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.Vrf",
      "labels": {
        "key": "vrf"
      },
      "id": "ly5uyq2gbxu2********",
      "cloudId": "b1gia87mbaom********",
      "folderId": "b1g07hj5r6i4********",
      "name": "baremetal-vrf",
      "description": "Test baremetal VRF",
      "createdAt": "2025-12-07T21:22:16.493703Z"
    },
    "id": "ly53ac2rdtrk********",
    "description": "VRF create",
    "createdAt": "2025-12-07T21:22:16.521291Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-07T21:22:16.521291Z"
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}