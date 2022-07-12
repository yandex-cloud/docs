---
editable: false
---

# Connector
A set of methods for managing Apache Kafka® connectors.
## JSON Representation {#representation}
```json 
{
  "name": "string",
  "tasksMax": "integer",
  "properties": "object",
  "health": "string",
  "status": "string",
  "clusterId": "string",

  //  includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`
  "connectorConfigMirrormaker": {
    "sourceCluster": {
      "alias": "string",

      // `connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`
      "thisCluster": {},
      "externalCluster": {
        "bootstrapServers": "string",
        "saslUsername": "string",
        "saslMechanism": "string",
        "securityProtocol": "string"
      },
      // end of the list of possible fields`connectorConfigMirrormaker.sourceCluster`

    },
    "targetCluster": {
      "alias": "string",

      // `connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`
      "thisCluster": {},
      "externalCluster": {
        "bootstrapServers": "string",
        "saslUsername": "string",
        "saslMechanism": "string",
        "securityProtocol": "string"
      },
      // end of the list of possible fields`connectorConfigMirrormaker.targetCluster`

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
        "endpoint": "string",
        "region": "string"
      }
    }
  },
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the connector.</p> 
tasksMax | **integer** (int64)<br><p>Maximum number of connector tasks. Default value is the number of brokers.</p> 
properties | **object**<br><p>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: ``sync.topics.config.enabled: true``.</p> 
health | **string**<br>Connector health.<br><ul> <li>HEALTH_UNKNOWN: Health of the connector is unknown.</li> <li>ALIVE: Connector is running.</li> <li>DEAD: Connector has failed to start.</li> </ul> 
status | **string**<br>Current status of the connector.<br><ul> <li>STATUS_UNKNOWN: Connector state is unknown.</li> <li>RUNNING: Connector is running normally.</li> <li>ERROR: Connector has encountered a problem and cannot operate.</li> <li>PAUSED: Connector is paused.</li> </ul> 
clusterId | **string**<br><p>ID of the Apache Kafka® cluster that the connector belongs to.</p> 
connectorConfigMirrormaker | **object** <br> includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`<br><br>
connectorConfigMirrormaker.<br>sourceCluster | **object**<br><p>Source cluster connection configuration.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>alias | **string**<br><p>Alias of cluster connection configuration. Examples: ``source``, ``target``.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>thisCluster | **object** <br>`connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br>
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster | **object** <br>`connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br>
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List of bootstrap servers of the cluster, separated by ``,``.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>SASL username to use for connection to the cluster.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>SASL mechanism to use for connection to the cluster.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol to use for connection to the cluster.</p> 
connectorConfigMirrormaker.<br>targetCluster | **object**<br><p>Target cluster connection configuration.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>alias | **string**<br><p>Alias of cluster connection configuration. Examples: ``source``, ``target``.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>thisCluster | **object**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. <br>`connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br>
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster | **object**<br>Configuration of connection to an external cluster with all the necessary credentials. <br>`connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br>
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List of bootstrap servers of the cluster, separated by ``,``.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>SASL username to use for connection to the cluster.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>SASL mechanism to use for connection to the cluster.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol to use for connection to the cluster.</p> 
connectorConfigMirrormaker.<br>topics | **string**<br><p>List of Kafka topics, separated by ``,``.</p> 
connectorConfigMirrormaker.<br>replicationFactor | **integer** (int64)<br><p>Replication factor for automatically created topics.</p> 
connectorConfigS3Sink | **object** <br> includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`<br><br><p>An Apache Kafka® S3-Sink connector resource.</p> 
connectorConfigS3Sink.<br>topics | **string**<br><p>List of Kafka topics, separated by ','</p> 
connectorConfigS3Sink.<br>fileCompressionType | **string**<br><p>The compression type used for files put on GCS. The supported values are: ``gzip``, ``snappy``, ``zstd``, ``none``. Optional, the default is ``none``.</p> 
connectorConfigS3Sink.<br>fileMaxRecords | **integer** (int64)<br><p>Max records per file.</p> 
connectorConfigS3Sink.<br>s3Connection | **object**<br><p>Credentials for connecting to S3 storage</p> <p>Resource for S3Connection - settings of connection to AWS-compatible S3 storage, that are source or target of Kafka S3-connectors. YC Object Storage is AWS-compatible.</p> 
connectorConfigS3Sink.<br>s3Connection.<br>bucketName | **string**<br>
connectorConfigS3Sink.<br>s3Connection.<br>externalS3 | **object**<br>
connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>accessKeyId | **string**<br>
connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>endpoint | **string**<br>
connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>region | **string**<br><p>Default is 'us-east-1'</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new Apache Kafka® connector in a cluster.
[delete](delete.md) | Deletes an Apache Kafka® connector.
[get](get.md) | Returns information about an Apache Kafka® connector.
[list](list.md) | Retrieves the list of Apache Kafka® connectors in a cluster.
[pause](pause.md) | Pauses an Apache Kafka® connector.
[resume](resume.md) | Resumes an Apache Kafka® connector.
[update](update.md) | Updates an Apache Kafka® connector.