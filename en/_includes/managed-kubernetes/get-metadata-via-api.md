Get all existing metadata for a node group using one of the following methods:

* Use the [get](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/get.md) REST API method for the [NodeGroup](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/index.md) resource.
* Use the [NodeGroupService/Get](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/NodeGroup/get.md) API call.

In your request, provide the node group ID in the `nodeGroupId` parameter. You can get the ID with the [list of node groups in the folder](../../managed-kubernetes/operations/node-group/node-group-list.md#list).

The metadata will be listed as `key=value` pairs in the `nodeTemplate.metadata` field of the response.
