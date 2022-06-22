---
editable: false
---

# Method get
Returns information about an Apache Kafka® connector.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-kafka/v1/clusters/{clusterId}/connectors/{connectorName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster the connector belongs to.  To get this ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
connectorName | Required. Name of the Apache Kafka® connector to return information about.  To get this name, make a [list](/docs/managed-kafka/api-ref/Connector/list) request.  The maximum string length in characters is 256. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
tasksMax | **integer** (int64)<br><p>Maximum number of connector tasks. Default value is the number of brokers.</p> 
properties | **object**<br><p>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: ``sync.topics.config.enabled: true``.</p> 
health | **string**<br>Connector health.<br><ul> <li>HEALTH_UNKNOWN: Health of the connector is unknown.</li> <li>ALIVE: Connector is running.</li> <li>DEAD: Connector has failed to start.</li> </ul> 
status | **string**<br>Current status of the connector.<br><ul> <li>STATUS_UNKNOWN: Connector state is unknown.</li> <li>RUNNING: Connector is running normally.</li> <li>ERROR: Connector has encountered a problem and cannot operate.</li> <li>PAUSED: Connector is paused.</li> </ul> 
clusterId | **string**<br><p>ID of the Apache Kafka® cluster that the connector belongs to.</p> 
connectorConfigMirrormaker | **object**<br>Configuration of the MirrorMaker connector.<br>
connectorConfigMirrormaker.<br>sourceCluster | **object**<br><p>Source cluster connection configuration.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>alias | **string**<br><p>Alias of cluster connection configuration. Examples: ``source``, ``target``.</p> 
connectorConfigMirrormaker.<br>sourceCluster.<br>thisCluster | **object**<br>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty. <br>`connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br>
connectorConfigMirrormaker.<br>sourceCluster.<br>externalCluster | **object**<br>Configuration of connection to an external cluster with all the necessary credentials. <br>`connectorConfigMirrormaker.sourceCluster` includes only one of the fields `thisCluster`, `externalCluster`<br><br>
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