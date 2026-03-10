---
title: How to order a dedicated public subnet in {{ baremetal-full-name }}
description: Follow this guide to order a dedicated public subnet in {{ baremetal-full-name }}.
---

# Ordering a dedicated public subnet

A [dedicated public subnet](../concepts/public-network.md#public-subnet) is a public subnet made up of an IP address range that will be available to your servers in the selected [pools](../concepts/servers.md#server-pools).

You can lease a new dedicated public subnet or convert an existing [ephemeral public subnet](../concepts/public-network.md#ephemeral-public-subnet) to a dedicated one.

### Leasing a new dedicated public subnet {#reserve-new-subnet}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to reserve a [dedicated public subnet](../concepts/public-network.md#public-subnet).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-public-subnet-full }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_zone-id }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) where the subnet will be available.
  1. {% include [reserve-priv-subnet-step-1](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-1.md) %}
  1. Select the size of the subnet you want to order.
  
      In the management console, you can only order subnets of size `/29` (six available IP addresses) and `/28` (14 available IP addresses). If you need a larger public subnet, [contact]({{ link-console-support }}/tickets/create) support to request it.
  1. {% include [reserve-priv-subnet-step-2](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-2.md) %}
  1. Click **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the command for leasing a new [dedicated public subnet](../concepts/public-network.md#public-subnet):

     ```bash
     yc baremetal public-subnet create --help
     ```
  
  1. Lease a subnet:
     
     ```bash
     yc baremetal public-subnet create \
       --hardware-pool-id <pool> \
       --prefix-length 29 \
       --name <public_subnet_name> \
       --description "<public_subnet_description>" \
       --labels <key>=<value>
     ```

     Where:
     * `--hardware-pool-id`: [Pools](../concepts/servers.md#server-pools) where the subnet will be available.

       {% include [link-public-subnet](../../_includes/baremetal/instruction-steps/link-public-subnet.md) %}

     * `--prefix-length`: Size of the subnet you want to order.

       You can only order subnets of size `/29` (six available IP addresses) and `/28` (14 available IP addresses).
     
     * `--name`: Subnet name. Follow these naming requirements:
       
       {% include [name-format](../../_includes/name-format.md) %}
       
     * `--description`: Subnet description. This is an optional setting.
     * `--labels`: Subnet [labels](../../resource-manager/concepts/labels.md). This is an optional setting.

- API {#api}

  To lease a new dedicated public subnet, use the [create](../api-ref/PublicSubnet/create.md) REST API method for the [PublicSubnet](../api-ref/PublicSubnet/index.md) resource or the [PublicSubnetService/Create](../api-ref/grpc/PublicSubnet/create.md) gRPC API call.

{% endlist %}

### Converting an ephemeral public subnet to a dedicated one {#transform-ephemeral-to-dedicated}

{% note info %}

You can only convert an ephemeral public subnet to a dedicated public subnet of size `/31`.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the ephemeral public subnet you want to convert to a dedicated one.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. In the list of public subnets that opens, in the ephemeral subnet row, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.action_dedicate-ephemeral-subnet }}**.
  1. {% include [reserve-priv-subnet-step-1](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-1.md) %}
  1. {% include [reserve-priv-subnet-step-2](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-2.md) %}
  1. Click **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

- CLI {#cli}

  1. View the description of the command for transforming an ephemeral public subnet:

     ```bash
     yc baremetal public-subnet update --help
     ```
  
  1. Transform the subnet:
     
     ```bash
     yc baremetal public-subnet update \
       --id <ephemeral_public_subnet_ID> \
       --type dedicated \
       --hardware-pool-id <pool> \
       --name <public_subnet_name> \
       --description "<public_subnet_description>" \
       --labels <key>=<value>
     ```

     Where:
     * `--id`: ID of the ephemeral public subnet.
     * `--type`: Type to transform the subnet into.
     * `--hardware-pool-id`: [Pools](../concepts/servers.md#server-pools) where the subnet will be available.

       {% include [link-public-subnet](../../_includes/baremetal/instruction-steps/link-public-subnet.md) %}
     
     * `--name`: Subnet name.
     * `--description`: Subnet description. This is an optional setting.
     * `--labels`: Subnet [labels](../../resource-manager/concepts/labels.md). This is an optional setting.

- API {#api}

  To convert an ephemeral public subnet to a dedicated one, use the [update](../api-ref/PublicSubnet/update.md) REST API method for the [PublicSubnet](../api-ref/PublicSubnet/index.md) resource or the [PublicSubnetService/Update](../api-ref/grpc/PublicSubnet/update.md) gRPC API call.

{% endlist %}

## Examples {#examples}

### Leasing a new dedicated public subnet {#reserve-new-subnet-example}

Lease a new dedicated public subnet of the `/29` size:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal public-subnet create \
    --hardware-pool-id ru-central1-m3 \
    --prefix-length 29 \
    --name demo-public-subnet \
    --description "My first public subnet" \
    --labels env=test
  ```

  Result

  ```text
  id: ly5jmqxxrcsu********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-public-subnet
  description: My first public subnet
  zone_id: ru-central1-m
  hardware_pool_ids:
    - ru-central1-m3
  type: DEDICATED
  prefix_length: "29"
  cidr: 94.139.248.184/29
  gateway_ip: 94.139.248.185
  created_at: "2025-06-26T14:11:49.458568Z"
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
      "name": "new-public-subnet",
      "description": "New public subnet",
      "hardwarePoolIds": [
        "ru-central1-m3"
      ],
      "prefixLength": "29",
      "labels": {
        "key": "public-subnet"
      }
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/publicSubnets"
  ```

  Where:

  * `<IAM_token>`: IAM token used for authentication.
  * `folderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
  * `hardwarePoolIds`: [Pool](../concepts/servers.md#server-pools) IDs.
  * `prefixLength`: Size of the subnet you want to order.
  * `name`: Name of the public subnet. Follow these naming requirements:
    
    {% include [name-format](../../_includes/name-format.md) %}
    
  * `description`: Subnet description. This is an optional parameter.
  * `labels`: Subnet labels. This is an optional parameter.

  Result:

  ```bash
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreatePublicSubnetMetadata",
      "publicSubnetId": "ly52xefxa2hi********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PublicSubnet",
      "id": "ly52xefxa2hi********",
      "cloudId": "b1gia87mbaom********",
      "folderId": "b1g07hj5r6i4********",
      "name": "new-public-subnet",
      "description": "New public subnet",
      "zoneId": "ru-central1-m",
      "hardwarePoolId": "ru-central1-m3",
      "type": "EPHEMERAL",
      "prefixLength": "29",
      "cidr": "10.0.*.*/29",
      "dhcpOptions": {
          "startIp": "10.0.*.*",
          "endIp": "10.0.*.*"
        },
      "gatewayIp": "10.0.*.*"
      "createdAt": "2025-12-14T14:42:58.372557Z"
      "labels": {
        "env": "test"
      },
    "id": "ly5hcnsbx3l4********",
    "description": "Public subnet create",
    "createdAt": "2025-12-14T14:42:58.375290Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T14:42:58.375290Z"
  }
  ```
  Follow the status of the operation by the `done` field.

{% endlist %}

### Transforming an ephemeral public subnet into a dedicated one {#transform-ephemeral-to-dedicated-example}

Change the public subnet type from `ephemeral` to `dedicated`:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal public-subnet update \
    --id ly5vr6tugxk7******** \
    --type dedicated \
    --description "Transformed dedicated public subnet"
  ```

  Result

  ```text
  id: ly5vr6tugxk7********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: transformed-public-subnet
  description: Transformed dedicated public subnet
  zone_id: ru-central1-m
  hardware_pool_ids:
    - ru-central1-m3
  type: DEDICATED
  prefix_length: "29"
  cidr: 94.139.248.184/29
  gateway_ip: 94.139.248.185
  created_at: "2025-06-26T14:11:49.458568Z"
  ```
- API {#api}

  ```bash
  curl -X PATCH \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{
      "updateMask": "type,hardwarePoolIds,name,description",
      "type": "DEDICATED",
      "hardwarePoolIds": ["ru-central1-m3"],
      "name": "transformed-public-subnet",
      "description": "Transformed dedicated public subnet"
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/publicSubnets/<subnet_ID>"
  ```

  Where:
  
  * `updateMask`: List of parameters to update, comma-separated.
  * `type`: New subnet type. The `DEDICATED` value for conversion into a dedicated subnet.
  * `name`: Name of the dedicated subnet. Follow these naming requirements:
    
    {% include [name-format](../../_includes/name-format.md) %}
    
  * `description`: Description of the dedicated subnet. This is an optional parameter.
  
  Result:

  ```bash
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreatePublicSubnetMetadata",
      "publicSubnetId": "ly52xefxa2hi********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PublicSubnet",
      "id": "ly52xefxa2hi********",
      "cloudId": "b1gia87mbaom********",
      "folderId": "b1g07hj5r6i4********",
      "name": "new-public-subnet",
      "description": "New public subnet",
      "zoneId": "ru-central1-m",
      "hardwarePoolId": "ru-central1-m3",
      "type": "DEDICATED",
      "prefixLength": "29",
      "cidr": "10.0.*.*/29",
      "dhcpOptions": {
          "startIp": "10.0.*.*",
          "endIp": "10.0.*.*"
        },
      "gatewayIp": "10.0.*.*"
      "createdAt": "2025-12-14T14:42:58.372557Z"
      "labels": {
        "env": "test"
      },
    "id": "ly5hcnsbx3l4********",
    "description": "Public subnet create",
    "createdAt": "2025-12-14T14:42:58.375290Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T14:42:58.375290Z"
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}