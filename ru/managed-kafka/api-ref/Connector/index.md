---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Connector/index.md
---


# Connector
A set of methods for managing Apache Kafka Connectors resources.
## JSON Representation {#representation}
```json 
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
  }
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the connector.</p> 
tasksMax | **integer** (int64)<br><p>Maximum number of tasks. Default is the number of brokers</p> 
properties | **object**<br><p>Properties passed with connector config to Connect service Example: 'sync.topics.config.enabled: true'</p> 
health | **string**<br>Connector health.<br><ul> <li>HEALTH_UNKNOWN: State of the connector is unknown.</li> <li>ALIVE: Connector is running.</li> <li>DEAD: Connector is failed to start.</li> </ul> 
status | **string**<br>Current status of the connector.<br><ul> <li>STATUS_UNKNOWN: Connector state is unknown.</li> <li>RUNNING: Connector is running normally.</li> <li>ERROR: Connector encountered a problem and cannot operate.</li> <li>PAUSED: Connector paused.</li> </ul> 
clusterId | **string**<br><p>ID of the Apache Kafka cluster that the connector belongs to.</p> 
connectorConfigMirrormaker | **object**<br><p>An An Apache Kafka® MirrorMaker connector resource.</p> 
connectorConfigMirrormaker.<br>sourceCluster | **object**<br><p>Source cluster resource settings.</p> <p>Resource ClusterConnection - settings of connection to clusters, that are source or target of MirrorMaker clusters.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>alias | **string**<br><p>Alias of ClusterConnection resource. For example: 'source', 'target', ...</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>thisCluster | **object** <br>`connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of cluster_connection type 'this_cluster'.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster | **object** <br>`connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of connection to external cluster. It contains all settings of connection to external cluster.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List bootstrap servers of cluster, separated by ','</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>Sasl username which we use to connect to cluster.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>Sasl mechanism, which we should use to connect to cluster.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol, which we should use to connect to cluster.</p> 
connectorConfigMirrormaker.<br>targetCluster | **object**<br><p>Target cluster resource settings.</p> <p>Resource ClusterConnection - settings of connection to clusters, that are source or target of MirrorMaker clusters.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>alias | **string**<br><p>Alias of ClusterConnection resource. For example: 'source', 'target', ...</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>thisCluster | **object**<br>If type is 'this_cluster' - we connect to cluster that is handle Kafka Connect Worker, on which we try to register connector. <br>`connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of cluster_connection type 'this_cluster'.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster | **object**<br>If type is 'external_cluster' - we connect to cluster that is not handle Kafka Connect Worker, on which we try to register connector. <br>`connectorConfigMirrormaker.targetCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br><p>Resource of connection to external cluster. It contains all settings of connection to external cluster.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>bootstrapServers | **string**<br><p>List bootstrap servers of cluster, separated by ','</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslUsername | **string**<br><p>Sasl username which we use to connect to cluster.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>saslMechanism | **string**<br><p>Sasl mechanism, which we should use to connect to cluster.</p> 
connectorConfigMirrormaker.<br>targetCluster.<br>externalCluster.<br>securityProtocol | **string**<br><p>Security protocol, which we should use to connect to cluster.</p> 
connectorConfigMirrormaker.<br>topics | **string**<br><p>List of Kafka topics, separated by ','</p> 
connectorConfigMirrormaker.<br>replicationFactor | **integer** (int64)<br><p>Replication factor for automatically created topics.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new Apache Kafka connector in the specified cluster.
[delete](delete.md) | Deletes the specified Apache Kafka connector.
[get](get.md) | Returns the specified Apache Kafka Connector resource.
[list](list.md) | Retrieves the list of Apache Kafka Connector resources in the specified cluster.
[pause](pause.md) | Pause the specified Apache Kafka connector.
[resume](resume.md) | Resume the specified Apache Kafka connector.