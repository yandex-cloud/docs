# x-yc-apigateway-integration:cloud_datastreams extension

 The `x-yc-apigateway-integration:cloud_datastreams` extension enables you to access {{ yds-full-name }} for performing operations with [streams](../../../data-streams/concepts/glossary.md#stream-concepts). Currently, the only supported operation is [PutRecord](../../../data-streams/kinesisapi/methods/putrecord.md). 

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `action` | `string` | Operation in progress. Valid values: `PutRecord`. |
| `stream_name` | `string` | {{ yds-name }} stream name. |
| `partition_key` | `string` | This is an optional parameter. [Shard key](../../../data-streams/concepts/glossary#partition-key). If not specified, writing will be performed to a random segment. `Partition_key` is where parameter substitution takes place. |
| `payload_format_type` | `string` | This is an optional parameter. Type of record content. If the value is `body`, only the request body will be written to the stream. If the value is `request`, the entire [request](./cloud-functions.md#request_v1) in JSON format will be written to the stream. The default value is `body`. |
| `service_account_id` | `string` | Service account ID. Used for authorization when performing {{ yds-name }} stream operations. If not specified, it defaults to the [top-level](./index.md#top-level) `service_account_id` parameter. |

## Extension specification {#spec}

Example specification:

```yaml
  /pets-stream/{petId}:
    post:
      x-yc-apigateway-integration:
        type: cloud_datastreams
        action: PutRecord
        stream_name: /{{ region-id }}/b1v1emj927uv********/ett01h3uz7qm********/pets-stream
        partition_key: '{petId}'
        service_account_id: ajeqvh23fi2********
      parameters:
      - description: petId
        explode: false
        in: path
        name: petId
        required: true
        schema:
          type: string
        style: simple
```
