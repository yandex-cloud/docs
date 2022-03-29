# x-yc-apigateway-integration:cloud_datasphere extension

The `x-yc-apigateway-integration:cloud_datasphere` extension calls a {{ ml-platform-name }} node deployed as a separate microservice. The {{ api-gw-short-name }} request must contain a JSON object with the input variables specified when creating the node as well as their values. {{ api-gw-short-name }} will return a JSON object containing the output variables specified when creating the node and their values obtained after it executes.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `folder_id` | `string` | ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the created {{ ml-platform-name }} project and the deployed node. |
| `node_id` | `string` | {{ ml-platform-name }} node ID. |
| `service_account_id` | `string` | ID of the service account. Used for authorization when calling a {{ ml-platform-name }} node. If you omit the parameter, the value used is that of the [top-level parameter called](./index.md#top-level) `service_account_id`. |

## Extension specification {#spec}

Example specification:

```yaml
/node/call:
    post:
      summary: Call DataSphere Node
      operationId: callDatasphereNode
      tags:
        - datasphere
      x-yc-apigateway-integration:
        type: cloud_datasphere
        folder_id: b095c95icnvbuf4v755l
        node_id: 244e0c20-74a7-4147-83ad-7fd7b8a1f43f
        service_account_id: ajehfe78asliq4n94q1
```

