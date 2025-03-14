---
title: How to move a subnet to a different availability zone
description: Follow this guide to move a subnet to a different availability zone.
---

# Moving a subnet to a different availability zone


You can move a [subnet](../concepts/network.md) to a different [availability zone](../../overview/concepts/geo-scope.md). You can only move an empty subnet containing no VMs or other resources.

Make sure the subnet does not include addresses of target load balancer groups either. They prevent migration. Remove unused [target groups](../../network-load-balancer/operations/target-group-delete.md) or individual addresses.

To move a subnet to a different availability zone:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for moving a subnet:

      ```bash
      yc vpc subnet relocate --help
      ```

  1. In the default folder, get the ID of the subnet you need to move:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      |          ID          |   NAME   |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      | e9bcd5mq43cn******** | subnet-a | encb4ubvmief******** |                | {{ region-id }}-a | [10.1.0.0/16]    |
      | e2llon52hhss******** | subnet-b | enc39op1vq9m******** |                | {{ region-id }}-b | [192.168.1.0/24] |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      ```

      {% include [non-empty-subnet-relocate-notice](../../_includes/compute/subnet-relocate-novms-warning.md) %}

  1. Move the subnet:

      ```bash
      yc vpc subnet relocate \
        --id <subnet_ID> \
        --destination-zone-id <availability_zone_ID>
      ```

      Where:
      * `--id`: ID of the subnet you need to move.
      * `--destination-zone-id`: ID of the availability zone to move the subnet to. The possible values are:

          * `{{ region-id }}-a`
          * `{{ region-id }}-b`
          * `{{ region-id }}-d`

      Example:

      ```bash
      yc vpc subnet relocate \
        --id e9bcd5mq43cn******** \
        --destination-zone-id {{ region-id }}-d
      ```

      Result:

      ```bash
      id: e9bcd5mq43cn********
      folder_id: b1gt6g8ht345********
      created_at: "2023-10-06T10:30:06Z"
      name: subnet-a
      network_id: encb4ubvmief********
      zone_id: {{ region-id }}-d
      v4_cidr_blocks:
        - 10.1.0.0/16
      dhcp_options: {}
      ```

      For more information about the `yc vpc subnet relocate` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/relocate.md).

- API {#api}

  Use the [relocate](../api-ref/Subnet/relocate.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Relocate](../api-ref/grpc/Subnet/relocate.md) gRPC API call.

  **Request example**

  To run the example, install [cURL](https://curl.haxx.se).

  1. [Get](../../iam/operations/index.md#iam-tokens) an IAM token for [authentication](../api-ref/authentication.md) with the API.

  1. Save the token to a variable:

      ```bash
      export IAM_TOKEN=<obtained_IAM_token>
      ```

  1. Create the `body.json` file with the request body, specifying the ID of the [availability zone](../../overview/concepts/geo-scope.md) to move the subnet to:

      ```json
      {
        "destinationZoneId": "<availability_zone_ID>"
      }
      ```

  1. Run this request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          --data "@<request_body_file>" \
          https://vpc.{{ api-host }}/vpc/v1/subnets/<subnet_ID>:relocate
      ```

      Where:
      * `<request_body_file>`: Path to the previously created request body file (`body.json`).
      * `<subnet_ID>`: ID of the subnet to move to a new availability zone.

      {% include [non-empty-subnet-relocate-notice](../../_includes/compute/subnet-relocate-novms-warning.md) %}

      Result:

      ```json
      {
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.vpc.v1.RelocateSubnetMetadata",
          "subnetId": "b0cnd1srghnm********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.vpc.v1.Subnet",
          "v4CidrBlocks": [
            "192.168.3.0/24"
          ],
          "dhcpOptions": {},
          "id": "b0cnd1srghnm********",
          "folderId": "b1gt6g8ht345********",
          "createdAt": "2023-10-06T10:30:06Z",
          "name": "subnet-c",
          "networkId": "enpv51f8lple********",
          "zoneId": "{{ region-id }}-d"
        },
        "id": "enpfitqeageu********",
        "description": "Relocate subnet to other zone",
        "createdAt": "2023-11-02T10:40:52.330608134Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2023-11-02T10:40:52.782965099Z"
      }
      ```

{% endlist %}
