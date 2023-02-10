# x-yc-apigateway-integration:cloud_datastreams extension

{% if audience == "external" %} The `x-yc-apigateway-integration:cloud_datastreams` extension enables you to access {{ yds-full-name }} for performing operations with [streams](../../../data-streams/concepts/glossary.md#stream-concepts). At the moment, the only supported operation is [PutRecord](../../../data-streams/kinesisapi/methods/putrecord.md). This operation writes the contents of the body of an incoming {{ api-gw-short-name }} request to a stream. {% endif %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `action` | `string` | The type of operation to perform. Valid values: `PutRecord`. |
| `stream_name` | `string` | {{ yds-name }} stream name. |
| `partition_key` | `string` | [Shard key](../../../data-streams/concepts/glossary#partition-key). `partition_key` is where parameter substitution takes place. |
| `service_account_id` | `string` | ID of the service account. Used for authorization when performing {{ yds-name }} stream operations. If you omit the parameter, the value used is that of the [top-level parameter called](./index.md#top-level) `service_account_id`. |

## Extension specification {#spec}

Example specification:

```yaml
  /pets-stream/{petId}:
    post:
      x-yc-apigateway-integration:
        type: cloud_datastreams
        action: PutRecord
        stream_name: /{{ region-id }}/b1v1emj927uvf97q62lt/ett01h3uz7qm8rjv0rsh/pets-stream
        partition_key: '{petId}'
        service_account_id: ajeqvh23fi2mfdoq6ba
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

