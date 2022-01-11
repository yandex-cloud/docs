---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Connector/update.md
---


# Method update
Updates an Apache Kafka connector in the specified cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/connectors/{connectorName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the Apache Kafka cluster to update a connector in. To get the cluster ID use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
connectorName | Required. Required. Name of the connector to update. To get the name of the connector, use a [list](/docs/managed-kafka/api-ref/Connector/list) request.  The maximum string length in characters is 256. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "connectorSpec": {
    "tasksMax": "integer",
    "properties": "object",
    "connectorConfigMirrormaker": {
      "sourceCluster": {
        "alias": "string",

        // `connectorSpec.connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`
        "thisCluster": {},
        "externalCluster": {
          "bootstrapServers": "string",
          "saslUsername": "string",
          "saslPassword": "string",
          "saslMechanism": "string",
          "securityProtocol": "string"
        },
        // end of the list of possible fields`connectorSpec.connectorConfigMirrormaker.sourceCluster`

      },
      "targetCluster": {
        "alias": "string",

        // `connectorSpec.connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`
        "thisCluster": {},
        "externalCluster": {
          "bootstrapServers": "string",
          "saslUsername": "string",
          "saslPassword": "string",
          "saslMechanism": "string",
          "securityProtocol": "string"
        },
        // end of the list of possible fields`connectorSpec.connectorConfigMirrormaker.targetCluster`

      },
      "topics": "string",
      "replicationFactor": "integer"
    }
  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Connector resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
connectorSpec | **object**<br><p>Required. Required. Configuration of the connector to update.</p> <p>An Apache Kafka® connector's update specification.</p> 
connectorSpec.<br>tasksMax | **integer** (int64)<br><p>Maximum number of tasks to update.</p> 
connectorSpec.<br>properties | **object**<br><p>Properties passed with connector config to Connect service, that we should change or add in existing Properties-set of connector. Example: 'sync.topics.config.enabled: false'</p> 
connectorSpec.<br>connectorConfigMirrormaker | **object**<br>Update specification for MirrorMaker.<br><p>An An Apache Kafka® MirrorMaker connector specification.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster | **object**<br><p>Source cluster configuration.</p> <p>Specification of ClusterConnection - connection to clusters, that are source or target of MirrorMaker clusters.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>alias | **string**<br><p>Alias of ClusterConnection. For example: 'source', 'target', ...</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>thisCluster | **object**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. <br>`connectorSpec.connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Specification of cluster_connection type 'this_cluster'. This means that we already have all credentials, so this spec is empty.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster | **object**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. <br>`connectorSpec.connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Specification of connection to external cluster. It contains all necessary credentials to connect to external cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List bootstrap servers of cluster, separated by ','.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>Sasl username which we use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslPassword | **string**<br><p>Sasl password which we use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>Sasl mechanism, which we should use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol, which we should use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster | **object**<br><p>Target cluster configuration.</p> <p>Specification of ClusterConnection - connection to clusters, that are source or target of MirrorMaker clusters.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>alias | **string**<br><p>Alias of ClusterConnection. For example: 'source', 'target', ...</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>thisCluster | **object**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. <br>`connectorSpec.connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Specification of cluster_connection type 'this_cluster'. This means that we already have all credentials, so this spec is empty.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster | **object**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. <br>`connectorSpec.connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Specification of connection to external cluster. It contains all necessary credentials to connect to external cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List bootstrap servers of cluster, separated by ','.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>Sasl username which we use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslPassword | **string**<br><p>Sasl password which we use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>Sasl mechanism, which we should use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol, which we should use to connect to cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>topics | **string**<br><p>List of Kafka topics, separated by ','</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>replicationFactor | **integer** (int64)<br><p>Replication factor for automatically created topics.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 