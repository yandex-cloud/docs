# x-yc-apigateway-integration:cloud_datasphere extension

The `x-yc-apigateway-integration:cloud_datasphere` extension invokes a {{ ml-platform-name }} node deployed as a separate microservice. The {{ api-gw-short-name }} request must contain a JSON object with the input variables specified when creating the node, as well as their values. {{ api-gw-short-name }} will return a JSON object containing the output variables specified when creating the node and their values obtained after it is run.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `folder_id` | `string` | The ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ ml-platform-name }} project and node were created. |
| `node_id` | `string` | {{ ml-platform-name }} node ID. |
| `service_account_id` | `string` | Service account ID. It is used for authorization when invoking a {{ ml-platform-name }} node. If it is not specified, its value is taken from the [parent](./index.md#top-level) `service_account_id`. |

## Extension specification {#spec}

Specification example:

```yaml
/node/call:
    post:
      summary: Call DataSphere Node
      operationId: callDatasphereNode
      tags:
        - datasphere
      x-yc-apigateway-integration:
        type: cloud_datasphere
        folder_id: b095c95icnvb********
        node_id: 244e0c20-74a7-4147-83ad-7fd7********
        service_account_id: ajehfe78asl********
```
