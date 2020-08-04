---
editable: false
---

# Method get
Returns the specified ElasticSearch Cluster resource.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the ElasticSearch cluster to return. To get the cluster ID use a [list](/docs/managed-elasticsearch/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
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
    "elasticsearch": {
      "dataNode": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "elasticsearchConfigSet_7_6": {
          "effectiveConfig": {
            "fielddataCacheSize": "integer",
            "maxClauseCount": "integer"
          },
          "userConfig": {
            "fielddataCacheSize": "integer",
            "maxClauseCount": "integer"
          },
          "defaultConfig": {
            "fielddataCacheSize": "integer",
            "maxClauseCount": "integer"
          }
        }
      },
      "masterNode": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    }
  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
Elasticsearch cluster resource
 
Field | Description
--- | ---
id | **string**<br><p>ID of the ElasticSearch cluster. This ID is assigned by MDB at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the ElasticSearch cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the ElasticSearch cluster. The name is unique within the folder. 1-63 characters long.</p> 
description | **string**<br><p>Description of the ElasticSearch cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the ElasticSearch cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
environment | **string**<br><p>Deployment environment of the ElasticSearch cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Monitoring system.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts.</p> 
config | **object**<br><p>Configuration of the ElasticSearch cluster.</p> 
config.<br>version | **string**<br><p>ElasticSearch version.</p> 
config.<br>elasticsearch | **object**<br><p>ElasticSearch configuration.</p> 
config.<br>elasticsearch.<br>dataNode | **object**<br>
config.<br>elasticsearch.<br>dataNode.<br>resources | **object**<br>Resources allocated to data node hosts.<br>
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6 | **object**<br>
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig | **object**<br><p>Required.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>the percentage of heap space that is allocated to fielddata</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig | **object**<br>
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>the percentage of heap space that is allocated to fielddata</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig | **object**<br>
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>the percentage of heap space that is allocated to fielddata</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
config.<br>elasticsearch.<br>masterNode | **object**<br>
config.<br>elasticsearch.<br>masterNode.<br>resources | **object**<br><p>Resources allocated to master node hosts.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (<code>health</code> for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (<code>health</code> for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (<code>health</code> for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (<code>health</code> for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 