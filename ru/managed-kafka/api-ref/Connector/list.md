---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Connector/list.md
---

# Managed Service for Apache Kafka® API, REST: Connector.list
Retrieves the list of Apache Kafka® connectors in a cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/connectors
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Apache Kafka® cluster to list connectors in.</p> <p>To get this ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-kafka/api-ref/Connector/list#query_params">pageSize</a>, the API returns a <a href="/docs/managed-kafka/api-ref/Connector/list#responses">nextPageToken</a> that can be used to get the next page of results in the subsequent <a href="/docs/managed-kafka/api-ref/Connector/list">list</a> requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-kafka/api-ref/Connector/list#query_params">pageToken</a> to the <a href="/docs/managed-kafka/api-ref/Connector/list#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-kafka/api-ref/Connector/list">list</a> request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "connectors": [
    {
      "name": "string",
      "tasksMax": "integer",
      "properties": "object",
      "health": "string",
      "status": "string",
      "clusterId": "string",

      // `connectors[]` includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`
      "connectorConfigMirrormaker": {
        "sourceCluster": {
          "alias": "string",

          // `connectors[].connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`
          "thisCluster": {},
          "externalCluster": {
            "bootstrapServers": "string",
            "saslUsername": "string",
            "saslMechanism": "string",
            "securityProtocol": "string"
          },
          // end of the list of possible fields`connectors[].connectorConfigMirrormaker.sourceCluster`

        },
        "targetCluster": {
          "alias": "string",

          // `connectors[].connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`
          "thisCluster": {},
          "externalCluster": {
            "bootstrapServers": "string",
            "saslUsername": "string",
            "saslMechanism": "string",
            "securityProtocol": "string"
          },
          // end of the list of possible fields`connectors[].connectorConfigMirrormaker.targetCluster`

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
      // end of the list of possible fields`connectors[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
connectors[] | **object**<br><p>List of Apache Kafka® Connectors.</p> 
connectors[].<br>name | **string**<br><p>Name of the connector.</p> 
connectors[].<br>tasksMax | **integer** (int64)<br><p>Maximum number of connector tasks. Default value is the number of brokers.</p> 
connectors[].<br>properties | **object**<br><p>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: ``sync.topics.config.enabled: true``.</p> 
connectors[].<br>health | **string**<br>Connector health.<br><ul> <li>HEALTH_UNKNOWN: Health of the connector is unknown.</li> <li>ALIVE: Connector is running.</li> <li>DEAD: Connector has failed to start.</li> </ul> 
connectors[].<br>status | **string**<br>Current status of the connector.<br><ul> <li>STATUS_UNKNOWN: Connector state is unknown.</li> <li>RUNNING: Connector is running normally.</li> <li>ERROR: Connector has encountered a problem and cannot operate.</li> <li>PAUSED: Connector is paused.</li> </ul> 
connectors[].<br>clusterId | **string**<br><p>ID of the Apache Kafka® cluster that the connector belongs to.</p> 
connectors[].<br>connectorConfigMirrormaker | **object**<br>Configuration of the MirrorMaker connector. <br>`connectors[]` includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`<br>
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster | **object**<br><p>Source cluster connection configuration.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>alias | **string**<br><p>Alias of cluster connection configuration. Examples: ``source``, ``target``.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>thisCluster | **object**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. <br>`connectors[].connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster | **object**<br>Configuration of connection to an external cluster with all the necessary credentials. <br>`connectors[].connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List of bootstrap servers of the cluster, separated by ``,``.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>SASL username to use for connection to the cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>SASL mechanism to use for connection to the cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol to use for connection to the cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster | **object**<br><p>Target cluster connection configuration.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>alias | **string**<br><p>Alias of cluster connection configuration. Examples: ``source``, ``target``.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>thisCluster | **object**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. <br>`connectors[].connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster | **object**<br>Configuration of connection to an external cluster with all the necessary credentials. <br>`connectors[].connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br>
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List of bootstrap servers of the cluster, separated by ``,``.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>SASL username to use for connection to the cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>SASL mechanism to use for connection to the cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol to use for connection to the cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>topics | **string**<br><p>List of Kafka topics, separated by ``,``.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>replicationFactor | **integer** (int64)<br><p>Replication factor for automatically created topics.</p> 
connectors[].<br>connectorConfigS3Sink | **object**<br>Configuration of S3-Sink connector. <br>`connectors[]` includes only one of the fields `connectorConfigMirrormaker`, `connectorConfigS3Sink`<br>
connectors[].<br>connectorConfigS3Sink.<br>topics | **string**<br><p>List of Kafka topics, separated by ','.</p> 
connectors[].<br>connectorConfigS3Sink.<br>fileCompressionType | **string**<br><p>The compression type used for files put on GCS. The supported values are: ``gzip``, ``snappy``, ``zstd``, ``none``. Optional, the default is ``none``.</p> 
connectors[].<br>connectorConfigS3Sink.<br>fileMaxRecords | **integer** (int64)<br><p>Max records per file.</p> 
connectors[].<br>connectorConfigS3Sink.<br>s3Connection | **object**<br><p>Credentials for connecting to S3 storage.</p> <p>Resource for S3Connection - settings of connection to AWS-compatible S3 storage, that are source or target of Kafka S3-connectors. YC Object Storage is AWS-compatible.</p> 
connectors[].<br>connectorConfigS3Sink.<br>s3Connection.<br>bucketName | **string**
connectors[].<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3 | **object**
connectors[].<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>accessKeyId | **string**
connectors[].<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>endpoint | **string**
connectors[].<br>connectorConfigS3Sink.<br>s3Connection.<br>externalS3.<br>region | **string**<br><p>Default is 'us-east-1'</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Connector/list#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/Connector/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/Connector/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-kafka/api-ref/Connector/list">list</a> request to iterate through multiple pages of results.</p> 