---
title: How to delete a resource record in {{ dns-full-name }}
description: In this tutorail, you will learn how to delete a resource record.
---

# Deleting a resource record

To delete a [resource record](../concepts/resource-record.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone with the record you want to delete.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the zone from the list.
  1. Find the record you want to delete and click ![image](../../_assets/console-icons/ellipsis.svg) in its row.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a record:

      ```
      yc dns zone delete-records --help
      ```
  1. Get a list of all zone records:

      ```
      yc dns zone list-records --name <zone_name>
      ```
  1. If the record has a description, clear it before deletion:

      ```
      yc dns zone add-records --name <zone_name> \
      --record "<domain_name> <TTL> <record_type> <value>" \
      --description ""
      ```
  1. Delete the record:

     ```
     yc dns zone delete-records --name <zone_name> \
     --record "<domain_name> <TTL> <record_type> <value>"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a DNS resource record created with {{ TF }}, do the following:

  1. Open the {{ TF }} configuration file and delete the fragment describing the DNS record.
     
     {% cut "{{ TF }} DNS record description example" %}

     ```hcl
     ...
     resource "yandex_dns_recordset" "rs1" {
       zone_id     = yandex_dns_zone.zone1.id
       name        = "srv.example.com."
       type        = "A"
       ttl         = 200
       data        = ["10.1.0.1"]
       description = "Web server"
     }
     ...
     ```

     {% endcut %}


  1. In the command line, navigate to the directory with the {{ TF }} configuration file.

  1. Check the configuration using this command:
     ```
     terraform validate
     ```
     
     If the configuration is valid, you will get this message:
     
     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```
  
     You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```
     
  1. Type `yes` and press **Enter** to confirm changes.

     You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```
     yc dns zone list-records <zone_name>
     ```

- API {#api}
  
  To delete a resource record, use one of the following methods:

  * [upsertRecordSets](../api-ref/DnsZone/upsertRecordSets.md): The move REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpsertRecordSets](../api-ref/grpc/DnsZone/upsertRecordSets.md) gRPC API call. The method does not require an exact match of the `description` field.

  * [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md): The move REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call. The method requires an exact match of all the record's fields, including `description`.

  #### REST API example for the upsertRecordSets method {#rest-api}

  Below is an example of a Bash script for Linux.

  To use it, [get authenticated](../api-ref/authentication.md) with the API and install [cURL](https://curl.haxx.se).

  1. Create a script file:

      ```bash
      sudo touch <file_name>
      ```

  1. Open the file to write the script to:

      ```bash
      sudo nano <file_name>
      ```

  1. Place the script in the file:

      ```bash
      #!/bin/bash

      # Creating variables

      export IAM_TOKEN=$(yc iam create-token)

      dnsZoneId='<DNS_zone_ID>'
      recordName='<domain_name>'
      recordType='<record_type>'
      recordTtl='<TTL>'
      recordData='<value>'

      # Deleting a record via upsertRecordSets

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "Content-Type: application/json" \
        --data '{
          "deletions": [
            {
              "name": "'"${recordName}"'",
              "type": "'"${recordType}"'",
              "ttl": "'"${recordTtl}"'",
              "data": ["'"${recordData}"'"]
            }
          ]
        }' \
        "https://dns.api.cloud.yandex.net/dns/v1/zones/${dnsZoneId}:upsertRecordSets"
      ```

      Where:

      * `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md) for API authentication.
      * `dnsZoneId`: DNS zone ID. To find out the ID, [get a list of DNS zones](zone-list.md).
      * `recordName`: Record domain name, e.g., `srv.example.com.`.
      * `recordType`: Entry type, e.g., `A`.
      * `recordTtl`: Record lifetime (TTL) in seconds, e.g., `600`.
      * `recordData`: Record value, e.g., `10.1.0.1`.

      {% note tip %}

      To use the `updateRecordSets` method, replace `upsertRecordSets` in the URL with `updateRecordSets`. Note that in this case, all the record's fields, including `description`, must match exactly.

      {% endnote %}

  1. Make the file executable:

      ```bash
      chmod +x <file_name>
      ```

  1. Run the script:

      ```bash
      ./<file_name>
      ```

  This will return an operation in JSON format:

  ```json
  {
    "id": "dns1234567890abcdef",
    "description": "",
    "createdAt": "2025-01-15T12:00:00.000000000Z",
    "createdBy": "aje1234567890abcdef",
    "modifiedAt": "2025-01-15T12:00:00.000000000Z",
    "done": true,
    "metadata": {},
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.dns.v1.RecordSetDiff",
      "additions": [],
      "deletions": [
        {
          "name": "srv.example.com.",
          "type": "A",
          "ttl": "600",
          "data": ["10.1.0.1"]
        }
      ]
    }
  }
  ```

  Where:

  * `id`: Unique operation ID.
  * `done`: Operation completion status.
  * `response.deletions`: List of deleted records.

  #### gRPC API example for the upsertRecordSets method {#grpc-api}

  Below is an example Bash script for calling the gRPC API using `grpcurl`.

  1. Install `grpcurl`:

      * Using Bash:

        ```bash
        curl -L https://github.com/fullstorydev/grpcurl/releases/download/v1.9.3/grpcurl_1.9.3_linux_x86_64.tar.gz | tar -xz
        sudo mv grpcurl /usr/local/bin/
        ```

      * Using Golang:

        ```go
        go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
        ```

  1. Create a script file:

      ```bash
      sudo touch <file_name>
      ```

  1. Open the file to write the script to:

      ```bash
      nano <file_name>
      ```

  1. Place the script in the file:

      ```bash
      #!/bin/bash

      # Creating variables

      export IAM_TOKEN=$(yc iam create-token)

      dnsZoneId='<DNS_zone_ID>'
      recordName='<domain_name>'
      recordType='<record_type>'
      recordTtl='<TTL>'
      recordData='<value>'

      # Deleting a record via UpsertRecordSets

      grpcurl \
        -d "{
          \"dns_zone_id\": \"${dnsZoneId}\",
          \"deletions\": [
            {
              \"name\": \"${recordName}\",
              \"type\": \"${recordType}\",
              \"ttl\": \"${recordTtl}\",
              \"data\": [\"${recordData}\"]
            }
          ]
        }" \
        -H "authorization: Bearer ${IAM_TOKEN}" \
        -H "x-client-request-id: $(uuidgen)" \
        dns.api.cloud.yandex.net:443 \
        yandex.cloud.dns.v1.DnsZoneService/UpsertRecordSets
      ```

      Where:

      * `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md) for API authentication.
      * `dnsZoneId`: DNS zone ID. To find out the ID, [get a list of DNS zones](zone-list.md).
      * `recordName`: Record domain name, e.g., `srv.example.com.`.
      * `recordType`: Entry type, e.g., `A`.
      * `recordTtl`: Record lifetime (TTL) in seconds, e.g., `600`.
      * `recordData`: Record value, e.g., `10.1.0.1`.
      * `x-client-request-id`: Unique request ID for tracing.

      {% note tip %}

      To use the `UpdateRecordSets` method, replace `UpsertRecordSets` in the script with `UpdateRecordSets`. Note that in this case, all the record's fields, including `description`, must match exactly.

      {% endnote %}

  1. Make the file executable:

      ```bash
      chmod +x <file_name>
      ```

  1. Run the script:

      ```bash
      ./<file_name>
      ```

  This will return an operation in JSON format:

  ```json
  {
    "id": "dns1234567890abcdef",
    "description": "",
    "createdAt": "2025-01-15T12:00:00.000000000Z",
    "createdBy": "aje1234567890abcdef",
    "modifiedAt": "2025-01-15T12:00:00.000000000Z",
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.dns.v1.UpsertRecordSetsMetadata"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.dns.v1.RecordSetDiff",
      "additions": [],
      "deletions": [
        {
          "name": "srv.example.com.",
          "type": "A",
          "ttl": "600",
          "data": ["10.1.0.1"]
        }
      ]
    }
  }
  ```

  Where:

  * `id`: Unique operation ID.
  * `done`: Operation completion status.
  * `metadata`: Operation metadata.
  * `response.deletions`: List of deleted records.

  For a detailed method description, see the [gRPC API reference](../api-ref/grpc/DnsZone/upsertRecordSets.md).

  {% endlist %}