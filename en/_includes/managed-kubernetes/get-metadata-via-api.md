Get all the existing metadata for the node group using the [get](../../managed-kubernetes/api-ref/NodeGroup/get.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) resource, and provide the node group ID in the `nodeGroupId` request parameter.

You can request the name of a node group with a [list of node groups in the folder](../../managed-kubernetes/operations/node-group/node-group-list.md#list).

The metadata will be listed as `key=value` pairs in the `nodeTemplate.metadata` field of the response.
