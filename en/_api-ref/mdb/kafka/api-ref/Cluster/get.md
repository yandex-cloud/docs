---
editable: false
---

# Method get
Returns the specified Apache Kafka Cluster resource.
 
To get the list of available Apache Kafka Cluster resources, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka Cluster resource to return. To get the cluster ID use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
  "config": {
    "version": "string",
    "kafka": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "kafkaConfig_2_1": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer"
      }
    },
    "zookeeper": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "zoneId": [
      "string"
    ],
    "brokersCount": "integer",
    "assignPublicIp": true
  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
A Apache Kafka Cluster resource. For more information, see
the [Concepts](/docs/mdb/kafka/concepts) section of the documentation.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Apache Kafka cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Apache Kafka cluster. The name is unique within the folder. 1-63 characters long.</p> 
description | **string**<br><p>Description of the Apache Kafka cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
environment | **string**<br><p>Deployment environment of the Apache Kafka cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Monitoring system.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Apache Kafka cluster.</p> 
config | **object**<br><p>Configuration of the Apache Kafka cluster.</p> 
config.<br>version | **string**<br><p>Version of Apache Kafka used in the cluster.</p> 
config.<br>kafka | **object**<br>
config.<br>kafka.<br>resources | **object**<br>Resources allocated to Apache Kafka brokers.<br>
config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>kafka.<br>kafkaConfig_2_1 | **object**<br>
config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Specify the final compression type for a cluster topics.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time in ms that a message in any topic is kept in memory before flushed to disk.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency in ms that the log flusher checks whether any log needs to be flushed to disk.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>The maximum size of the log before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log file before deleting it.</p> 
config.<br>zookeeper | **object**<br>
config.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to Zookeeper hosts.</p> 
config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>zoneId[] | **string**<br><p>IDs of availability zones to place brokers.</p> 
config.<br>brokersCount | **integer** (int64)<br><p>Number of Apache Kafka brokers deployed in each availability zone.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br>
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (<code>health</code> for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (<code>health</code> for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (<code>health</code> for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (<code>health</code> for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 