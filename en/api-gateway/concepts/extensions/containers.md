# x-yc-apigateway-integration:serverless_containers extension

The `x-yc-apigateway-integration:serverless_containers` extension invokes the specified [container](../../../serverless-containers/concepts/container.md) and transfers the HTTP request made to the API gateway, to it. In this case, the `Host` header specifies the host on which the user accessed the API gateway rather than the container's host.

{% include [ip](../../../_includes/serverless-containers/ip.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `container_id` | `string` | Container ID. |
| `service_account_id` | `string` | Service account ID used for authorization when accessing a container. If not specified, it defaults to the [top-level](./index.md#top-level) `service_account_id` parameter. |
| `context` | `object` | This is an optional parameter. Operation context is an arbitrary object in `YAML` or `JSON` format. Encoded in `Base64` and passed to the container in the `X-Yc-ApiGateway-Operation-Context` header. `Context` is where parameter substitution takes place. |

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
        container_id: b095c95icnvb********
        service_account_id: ajehfe12hhl********
```

Example of proxying all requests to a container:

```yaml
paths:
  /{proxy+}:
    x-yc-apigateway-any-method:
      x-yc-apigateway-integration:
        type: serverless_containers
        container_id: bba0hocqr8rl********
        service_account_id: ajegj8fnpmkm********
      parameters:
      - explode: false
        in: path
        name: proxy
        required: false
        schema:
          default: '-'
          type: string
        style: simple
```
