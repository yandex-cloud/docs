---
title: "How to move a subnet to a different availability zone"
description: "Follow this guide to move a subnet to a different availability zone."
---


# Moving a subnet to a different availability zone

[Subnets](../concepts/network.md) can be moved to a different [availability zone](../../overview/concepts/geo-scope.md). You can only migrate empty subnets not hosting any VM instances or other resources.

To move a subnet to a different availability zone:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI subnet move command:

      ```bash
      yc vpc subnet relocate --help
      ```

   1. In the default folder, find the ID of the subnet you need to move:

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
      | b0cscj0f9uq5******** | subnet-c | enc772aa2rgq******** |                | {{ region-id }}-c | [10.0.0.0/16]    |
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
      * `--id`: ID of the subnet to move.
      * `--destination-zone-id`: ID of the availability zone to move the subnet to. The possible values include:

         * `{{ region-id }}-a`
         * `{{ region-id }}-b`
         * `{{ region-id }}-c`
         * `{{ region-id }}-d`

      For example:

      ```
      yc vpc subnet relocate \
        --id e9bcd5mq43cn******** \
        --destination-zone-id {{ region-id }}-d
      ```

      Result:

      ```
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

      For more information about the `yc vpc subnet relocate` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/relocate.md).

- API {#api}

   Use the [relocate](../api-ref/Subnet/relocate.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Relocate](../api-ref/grpc/subnet_service#Relocate) gRPC API call.

   **Sample request**

   To run the sample, install [cURL](https://curl.haxx.se).

   1. [Get](../../iam/operations/index.md#iam-tokens) an IAM token for [authentication](../api-ref/authentication.md) in the API.

   1. Save the token to a variable.

      ```bash
      export IAM_TOKEN=<obtained_IAM_token>
      ```

   1. Prepare a `body.json` file with the request body, specifying the ID of the [availability zone](../../overview/concepts/geo-scope.md) to move the subnet to:

      ```json
      {
        "destinationZoneId": "<availability_zone_ID>"
      }
      ```

   1. Run the following query:

      ```bash
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@<request_body_file>" \
          https://vpc.api.cloud.yandex.net/vpc/v1/subnets/<subnet_ID>:relocate
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
