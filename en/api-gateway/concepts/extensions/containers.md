# x-yc-apigateway-integration:serverless_containers extension

The `x-yc-apigateway-integration:serverless_containers` redirects requests to a specified [container](../../../serverless-containers/concepts/container.md).

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `container_id` | `string` | Container ID. |
| `service_account_id` | `string` | Service account ID used for authorization when accessing a container. If the parameter is omitted, the value of the [top-level](index.md#top-level) `service_account_id` parameter is used. |
| `context` | `object` | Optional parameter. Operation context is an arbitrary object in `YAML` or `JSON` format. Encoded in `Base64` and passed to the container in the `X-Yc-ApiGateway-Operation-Context` header. `context` is where parameter substitution takes place. |

## Extension specification {#spec}

Example specification:

```yaml
/example/{ID}:
    get:
      summary: Get ID
      operationId: getID
      tags:
        - example
      parameters:
        - name: ID
          in: path
          description: Return ID
          required: true
          schema:
            type: string
      x-yc-apigateway-integration:
        type: serverless_containers
        container_id: b095c95icnvbuf4v755l
        service_account_id: ajehfe12hhlas4n56q1
```

