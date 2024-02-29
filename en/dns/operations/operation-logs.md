# Viewing operations with zones

All actions with {{ dns-name }} zones are logged as a list of operations. Each operation is assigned a unique ID.

## Get a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder that houses the DNS zone.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Select the zone you need.
   1. Go to the ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab for the selected zone.

      You will see a list of operations for the selected zone and the records made in it.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations for a DNS zone, run this command:

   ```bash
   yc dns zone list-operations <zone_name_or_ID>
   ```

   By default, information about operations is provided as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

   ```bash
   yc dns zone list-operations dns3fh7phb04******** --format yaml
   ```

   Result:

   ```yaml
   - id: dnsi5gv00kas********
     description: Update DNS RecordSets
     created_at: "2024-02-01T08:46:21.554860158Z"
     created_by: ajego134p5h1********
     modified_at: "2024-02-01T08:46:21.554933861Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.dns.v1.UpdateRecordSetsMetadata
   - id: dnssdag1giqk********
     description: Create DNS Zone
     created_at: "2024-02-01T08:45:40.481514713Z"
     created_by: ajego134p5h1********
     modified_at: "2024-02-01T08:45:40.481608241Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.dns.v1.CreateDnsZoneMetadata
       dns_zone_id: dns3fh7phb04********
   ```

- API {#api}

   To get a list of operations for a zone, use the [listOperations](../api-ref/DnsZone/listOperations.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/ListOperations](../api-ref/grpc/dns_zone_service.md#ListOperations) gRPC API call.

{% endlist %}

## Get detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the zone.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc operation get <operation_ID>
      ```

      Result:

      ```yaml
      id: dnsi5gv00kas********
      description: Create DNS Zone
      created_at: "2024-02-01T08:45:40.481Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T08:45:40.481Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.dns.v1.CreateDnsZoneMetadata
        dns_zone_id: dns3fh7phb04********
      response:
        '@type': type.googleapis.com/yandex.cloud.dns.v1.DnsZone
        id: dnssdag1giqk********
        folder_id: b1gmit33ngp3********
        created_at: "2024-02-01T08:45:40.416Z"
        zone: zonedone.com.
        public_visibility: {}
      ```

   - API {#api}

      Use the [get](../../api-design-guide/concepts/operation.md#monitoring) REST API method or the [OperationService/Get](../api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)