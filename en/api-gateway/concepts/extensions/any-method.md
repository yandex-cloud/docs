# x-yc-apigateway-any-method extension

The `x-yc-apigateway-any-method` extension defines operations performed by any HTTP method that is not defined in the specification.

## Supported parameters {#parameters}

The table below lists the parameters specific to API gateways of Yandex API Gateway. You can find the description of other parameters in the [OpenAPI 3.0 specification](https://github.com/OAI/OpenAPI-Specification).

| Parameter | Type | Description |
----|----|----
| `x-yc-apigateway-integration` | [x-yc-apigateway-integration](./index.md#integration) | The entry point for integrating the API gateway with other services. |


## Extension specification {#spec}

Example specification:

```yaml
/example/{ID}:
    x-yc-apigateway-any-method:
      summary: Operating with examples
      operationId: example
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
        type: cloud_functions
        function_id: b095c95icnvb********
        tag: "$latest"
        service_account_id: ajehfe56hhl********
```
