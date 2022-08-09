---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Connector/create.md
---

# Method create
Creates a new Apache Kafka® connector in a cluster.
 

 
## HTTP request {#https-request}
```
POST https://mdb.{{ api-host }}/managed-kafka/v1/clusters/{clusterId}/connectors
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Apache Kafka® cluster to create the connector in.</p> <p>To get this ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "connectorSpec": {
    "name": "string",
    "tasksMax": "integer",
    "properties": "object",

    // `connectorSpec` includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`
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
          "securityProtocol": "string",
          "sslTruststoreCertificates": "string"
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
          "securityProtocol": "string",
          "sslTruststoreCertificates": "string"
        },
        // end of the list of possible fields`connectorSpec.connectorConfigMirrormaker.targetCluster`

      },
      "topics": "string",
      "replicationFactor": "integer"
    },
    "connectorConfigS3Sink": {
      "topics": "string",
      "fileCompressionType": "string",
      "fileMaxRecords": "integer",
      "s3Connection": {
        "bucketName": "string",
        "externalS3": {
          "accessKeyId": "string",
          "secretAccessKey": "string",
          "endpoint": "string",
          "region": "string"
        }
      }
    },
    // end of the list of possible fields`connectorSpec`

  }
}
```

 
Field | Description
--- | ---
connectorSpec | **object**<br><p>Required. Configuration of the connector to create.</p> <p>An object that represents an Apache Kafka® connector.</p> <p>See <a href="/docs/managed-kafka/concepts/connectors">the documentation</a> for details.</p> 
connectorSpec.<br>name | **string**<br><p>Name of the connector.</p> 
connectorSpec.<br>tasksMax | **integer** (int64)<br><p>Maximum number of connector tasks. Default value is the number of brokers.</p> 
connectorSpec.<br>properties | **object**<br><p>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: ``sync.topics.config.enabled: true``.</p> 
connectorSpec.<br>connectorConfigMirrormaker | **object**<br>Configuration of the MirrorMaker connector. <br>`connectorSpec` includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`<br>
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster | **object**<br><p>Source cluster configuration for the MirrorMaker connector.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>alias | **string**<br><p>Alias of cluster connection configuration. Examples: ``source``, ``target``.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>thisCluster | **object**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. <br>`connectorSpec.connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster | **object**<br>Configuration of connection to an external cluster with all the necessary credentials. <br>`connectorSpec.connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List of bootstrap servers of the cluster, separated by ``,``.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>SASL username to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslPassword | **string**<br><p>SASL password to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>SASL mechanism to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>sslTruststoreCertificates | **string**<br><p>CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster | **object**<br><p>Target cluster configuration for the MirrorMaker connector.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>alias | **string**<br><p>Alias of cluster connection configuration. Examples: ``source``, ``target``.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>thisCluster | **object**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. <br>`connectorSpec.connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster | **object**<br>Configuration of connection to an external cluster with all the necessary credentials. <br>`connectorSpec.connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List of bootstrap servers of the cluster, separated by ``,``.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>SASL username to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslPassword | **string**<br><p>SASL password to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>SASL mechanism to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol to use for connection to the cluster.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>sslTruststoreCertificates | **string**<br><p>CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>topics | **string**<br><p>List of Kafka topics, separated by ``,``.</p> 
connectorSpec.<br>connectorConfigMirrormaker.<br>replicationFactor | **integer** (int64)<br><p>Replication factor for automatically created topics.</p> 
connectorSpec.<br>connectorConfigS3Sink | **object**<br>Configuration of S3-Sink connector. <br>`connectorSpec` includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`<br>
connectorSpec.<br>connectorConfigS3Sink.<br>topics | **string**<br><p>List of Kafka topics, separated by ','.</p> 
connectorSpec.<br>connectorConfigS3Sink.<br>fileCompressionType | **string**<br><p>The compression type used for files put on GCS. The supported values are: ``gzip``, ``snappy``, ``zstd``, ``none``. Optional, the default is ``none``.</p> 
connectorSpec.<br>connectorConfigS3Sink.<br>fileMaxRecords | **integer** (int64)<br><p>Max records per file.</p> 
connectorSpec.<br>connectorConfigS3Sink.<br>s3Connection | **object**<br><p>Credentials for connecting to S3 storage.</p> <p>Specification for S3Connection - settings of connection to AWS-compatible S3 storage, that are source or target of Kafka S3-connectors. YC Object Storage is AWS-compatible.</p> 
connectorSpec.<br>connectorConfigS3Sink.<br>s3Connection.<br>bucketName | **string**
connectorSpec.<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3 | **object**
connectorSpec.<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>accessKeyId | **string**
connectorSpec.<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>secretAccessKey | **string**
connectorSpec.<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>endpoint | **string**
connectorSpec.<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>region | **string**<br><p>Default is 'us-east-1'.</p> 
 
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
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 