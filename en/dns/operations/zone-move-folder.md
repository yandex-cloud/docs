---
title: How to move a DNS zone to a different folder in {{ dns-full-name }}
description: Follow this guide to move a DNS zone to a different folder.
---

# Moving a DNS zone to a different folder

When you create a [DNS zone](../concepts/dns-zone.md), it is placed in the current folder.

In {{ yandex-cloud }}, you can move a DNS zone to a different folder.

Learn more about the {{ yandex-cloud }} resource hierarchy [here](../../resource-manager/concepts/resources-hierarchy.md).

## Limitations {#limits}

Moving a DNS zone does not relocate its [{{ monitoring-full-name }}](../../monitoring/) metrics: existing metrics remain in the source folder, and new metrics will be created in the destination folder.

## Moving a DNS zone {#relocate-zone}

### Updating a DNS zone folder {#change-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get a list of all DNS zones in the default folder:

      ```bash
      yc dns zone list
      ```

      Result:

      ```bash
      +----------------------+---------------------+--------------+----------------------------------------------------+
      |          ID          |        NAME         |     ZONE     |   VISIBILITY   |             DESCRIPTION           |
      +----------------------+---------------------+--------------+----------------+-----------------------------------+
      | aet29qhara5j******** | my-public-zone      | example.com. | PUBLIC         | Automatically created DNS for ... |
      | aet2q4fn8i8i******** | my-private-zone     | internal.    | PRIVATE        | Automatically created DNS for ... |
      +----------------------+---------------------+--------------+----------------+-----------------------------------+
      ```      

  1. Get a list of all folders in the default cloud:

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
      | b1g66mft1vop******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. View the description of the CLI command for moving a DNS zone:

      ```bash
      yc dns zone move --help
      ```

  1. Move the DNS zone to a different folder with the following parameters: 
      
      * Set `id` to the DNS zone ID, e.g., `aet29qhara5j********`.
      * In `destination-folder-id`, specify the destination folder ID, e.g., `b1g66mft1vop********`.

      ```bash
      yc dns zone move \
        --id aet29qhara5j******** \
        --destination-folder-id b1g66mft1vop********
      ```

      For more information about the `yc dns zone move` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/move.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. [Configure](../../resource-manager/operations/folder/set-access-bindings.md) access permissions for the target folder. The account from the source folder you are going to use to perform the operation must have at least the `dns.editor` [role](../security/index.md) for the target folder.

  1. [Get the target folder ID](../../resource-manager/operations/folder/get-id.md).
  1. In the configuration file, update the `folder_id` parameter in the `yandex_dns_zone` resource:

      ```hcl
      resource "yandex_dns_zone" "zone1" {
          name        = "<zone_name>"
          description = "<zone_description>"
          zone        = "<domain_zone>."
          public      = true
          folder_id   = "<target_folder_ID>"
      }
      ```

      Where:

      * `name`: Zone name. Note that the zone name must be unique within a folder.
      * `description`: Zone description. 
      * `zone`: Domain zone name. Note that the zone name must end with a trailing dot. You cannot create top-level domain (TLD) zones. To create a domain name with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
      * `public`: Zone visibility, public or private.
      * `folder_id`: ID of the folder to place the DNS zone in (by default, specified from the [environment variable](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials)).

      For more information about `yandex_dns_zone` properties, see [this provider guide]({{ tf-provider-resources-link }}/dns_zone).

  1. Apply the new configuration:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will move the DNS zone to the specified destination folder without re-creating it. You can check the update using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [move](../api-ref/DnsZone/move.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Move](../api-ref/grpc/DnsZone/move.md) gRPC API call.

  #### REST API example {#rest-api}

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

      export IAM_TOKEN=`yc iam create-token`
      
      dnsZoneId='<DNS_zone_ID>'
      destinationFolderId='<folder_ID>'
      
      # Moving a DNS zone

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "Content-Type: application/json" \
        --data '{ "destinationFolderId": "'"${destinationFolderId}"'" }' \
        "https://dns.{{ api-host }}/dns/v1/zones/${dnsZoneId}:move"
      ```

      Where:

      * `IAM_TOKEN`: IAM token for API authentication.
      * `dnsZoneId`: ID of the DNS zone to move.
      * `destinationFolderId`: ID of the folder to move the DNS zone to.

  1. Make the file executable:

      ```bash
      chmod +x <file_name>
      ```

  1. Run the script:

      ```bash
      ./<file_name>
      ```

  #### gRPC API example {#grpc-api}

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
      destinationFolderId='<folder_ID>'

      # Moving a DNS zone

      grpcurl \
      -d "{
          \"dns_zone_id\": \"${dnsZoneId}\",
          \"destination_folder_id\": \"${destinationFolderId}\"
      }" \
      -H "authorization: Bearer ${IAM_TOKEN}" \
      -H "x-client-request-id: $(uuidgen)" \
      dns.api.cloud.yandex.net:443 \
      yandex.cloud.dns.v1.DnsZoneService/Move
      ```

      Where:

      * `IAM_TOKEN`: IAM token for API authentication.
      * `dnsZoneId`: ID of the DNS zone to move.
      * `destinationFolderId`: ID of the folder to move the DNS zone to.
      * `x-client-request-id`: Unique request ID for tracing.

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
        "id": "dns-zone-move-123456789",
        "description": "Update DNS Zone",
        "createdAt": "2026-02-19T09:52:35.239149422Z",
        "createdBy": "aje6f5h1h2h3********",
        "modifiedAt": "2026-02-19T09:52:35.239218092Z",
        "done": true,
        "metadata": {
            "@type": "type.googleapis.com/yandex.cloud.dns.v1.MoveDnsZoneMetadata",
            "dnsZoneId": "aet29qhara5j********"
        },
        "response": {
            "@type": "type.googleapis.com/yandex.cloud.dns.v1.DnsZone",
            "createdAt": "2026-02-19T07:09:53.853Z",
            "folderId": "b1g66mft1vop********",
            "id": "aet29qhara5j********",
            "name": "my-public-zone",
            "publicVisibility": {},
            "zone": "example.com."
        }
    }
    ```

    Where:

    * `id`: Unique operation ID.
    * `metadata.dnsZoneId`: ID of the DNS zone to move.
    * `response`: Updated DNS zone after migration.
    * `done`: Operation completion status.

    For a detailed method description, see the [gRPC API reference](../api-ref/grpc/DnsZone/move.md).

{% endlist %}
