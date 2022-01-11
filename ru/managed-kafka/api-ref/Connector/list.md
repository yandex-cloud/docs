---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Connector/list.md
---


# Method list
Retrieves the list of Apache Kafka Connector resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/connectors
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka cluster to list connectors in. To get the cluster ID use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | Page token. To get the next page of results, Set [pageToken](/docs/managed-kafka/api-ref/Connector/list#query_params) to the [nextPageToken](/docs/managed-kafka/api-ref/Connector/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
connectors[] | **object**<br><p>An Apache Kafka® connector resource.</p> 
connectors[].<br>name | **string**<br><p>Name of the connector.</p> 
connectors[].<br>tasksMax | **integer** (int64)<br><p>Maximum number of tasks. Default is the number of brokers</p> 
connectors[].<br>properties | **object**<br><p>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true'</p> 
connectors[].<br>health | **string**<br>Connector health.<br><ul> <li>HEALTH_UNKNOWN: State of the connector is unknown.</li> <li>ALIVE: Connector is running.</li> <li>DEAD: Connector is failed to start.</li> </ul> 
connectors[].<br>status | **string**<br>Current status of the connector.<br><ul> <li>STATUS_UNKNOWN: Connector state is unknown.</li> <li>RUNNING: Connector is running normally.</li> <li>ERROR: Connector encountered a problem and cannot operate.</li> <li>PAUSED: Connector paused.</li> </ul> 
connectors[].<br>clusterId | **string**<br><p>ID of the Apache Kafka cluster that the connector belongs to.</p> 
connectors[].<br>connectorConfigMirrormaker | **object**<br><p>An An Apache Kafka® MirrorMaker connector resource.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster | **object**<br><p>Source cluster resource settings.</p> <p>Resource ClusterConnection - settings of connection to clusters, that are source or target of MirrorMaker clusters.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>alias | **string**<br><p>Alias of ClusterConnection resource. For example: 'source', 'target', ...</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>thisCluster | **object**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. <br>`connectors[].connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of cluster_connection type 'this_cluster'.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster | **object**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. <br>`connectors[].connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of connection to external cluster. It contains all settings of connection to external cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List bootstrap servers of cluster, separated by ','</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>Sasl username which we use to connect to cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>Sasl mechanism, which we should use to connect to cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol, which we should use to connect to cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster | **object**<br><p>Target cluster resource settings.</p> <p>Resource ClusterConnection - settings of connection to clusters, that are source or target of MirrorMaker clusters.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>alias | **string**<br><p>Alias of ClusterConnection resource. For example: 'source', 'target', ...</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>thisCluster | **object**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. <br>`connectors[].connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of cluster_connection type 'this_cluster'.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster | **object**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. <br>`connectors[].connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of connection to external cluster. It contains all settings of connection to external cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List bootstrap servers of cluster, separated by ','</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>Sasl username which we use to connect to cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>Sasl mechanism, which we should use to connect to cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol, which we should use to connect to cluster.</p> 
connectors[].<br>connectorConfigMirrormaker.<br>topics | **string**<br><p>List of Kafka topics, separated by ','</p> 
connectors[].<br>connectorConfigMirrormaker.<br>replicationFactor | **integer** (int64)<br><p>Replication factor for automatically created topics.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Connector/list#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/Connector/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/Connector/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/Connector/list#responses">nextPageToken</a> to continue paging through the results.</p> 