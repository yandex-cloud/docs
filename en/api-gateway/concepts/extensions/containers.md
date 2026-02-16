# x-yc-apigateway-integration:serverless_containers extension

The `x-yc-apigateway-integration:serverless_containers` extension invokes the relevant [container](../../../serverless-containers/concepts/container.md) and provides the HTTP request sent to the API gateway to it. In which case the `Host` header specifies the host used by the user to access the API gateway, not the container's host.

{% include [ip](../../../_includes/serverless-containers/ip.md) %}

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Parameter | Type | Description
----|----|----
`container_id` | `string` | Container ID.
`service_account_id` | `string` | Service account ID used for authorization when accessing a container. [Invoking](../../../serverless-containers/operations/auth.md) a private container requires a service account with the `serverless-containers.containerInvoker` [role](../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) or higher for that container. If you omit the parameter, the `service_account_id` [top-level](./index.md#top-level) parameter value will be used.
`context` | `object` | This is an optional parameter. It provides the operation context, i.e., an object in `YAML` or `JSON` format. It is encoded in `Base64` and provided to the container in the `X-Yc-ApiGateway-Operation-Context` header. The parameters are subsituted into `context`.

## Extension specification {#spec}

Specification example:

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

## Use cases {#examples}

* [{#T}](../../tutorials/deploy-app-container.md)