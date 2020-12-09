---
editable: false
---

# Cluster
A set of methods for managing Elasticsearch clusters.
## JSON Representation {#representation}
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
        "elasticsearchConfigSet_7": {
          "effectiveConfig": {
            "maxClauseCount": "integer",
            "fielddataCacheSize": "string"
          },
          "userConfig": {
            "maxClauseCount": "integer",
            "fielddataCacheSize": "string"
          },
          "defaultConfig": {
            "maxClauseCount": "integer",
            "fielddataCacheSize": "string"
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
  "status": "string",
  "securityGroupIds": [
    "string"
  ]
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Elasticsearch cluster. This ID is assigned at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Elasticsearch cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long.</p> 
description | **string**<br><p>Description of the Elasticsearch cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed.</p> 
environment | **string**<br><p>Deployment environment of the Elasticsearch cluster.</p> <ul> <li>PRODUCTION: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Metadata of monitoring system.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Elasticsearch cluster.</p> 
config | **object**<br><p>Configuration of the Elasticsearch cluster.</p> 
config.<br>version | **string**<br><p>Elasticsearch version.</p> 
config.<br>elasticsearch | **object**<br><p>Configuration and resource allocation for Elasticsearch nodes.</p> 
config.<br>elasticsearch.<br>dataNode | **object**<br><p>Configuration and resource allocation for Elasticsearch data nodes.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources | **object**<br><p>Computational resources.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-elasticsearch/concepts/instance-types">documentation</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. All available types are listed in the <a href="/docs/managed-elasticsearch/concepts/storage">documentation</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7 | **object**<br><p>Elasticsearch 7.x data node configuration.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>effectiveConfig | **object**<br><p>Required. Effective settings for an Elasticsearch cluster (a combination of settings defined in `userConfig` and `defaultConfig`).</p> <p>Elasticsearch 7.x supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">Elasticsearch documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>effectiveConfig.<br>maxClauseCount | **integer** (int64)<br><p>The maximum number of clauses a boolean query can contain.</p> <p>The limit is in place to prevent searches from becoming too large and taking up too much CPU and memory. It affects not only Elasticsearch's `bool` query, but many other queries that are implicitly converted to `bool` query by Elastcsearch.</p> <p>Default value: `1024`.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">Elasticsearch documentation</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>effectiveConfig.<br>fielddataCacheSize | **string**<br><p>The maximum percentage or absolute value (10%, 512mb) of heap space that is allocated to field data cache.</p> <p>All the field values that are placed in this cache, get loaded to memory in order to provide fast document based access to those values. Building the field data cache for a field can be an expensive operations, so its recommended to have enough memory for this cache, and to keep it loaded.</p> <p>Default value: unbounded.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">Elasticsearch documentation</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>userConfig | **object**<br><p>User-defined settings for an Elasticsearch cluster.</p> <p>Elasticsearch 7.x supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">Elasticsearch documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>userConfig.<br>maxClauseCount | **integer** (int64)<br><p>The maximum number of clauses a boolean query can contain.</p> <p>The limit is in place to prevent searches from becoming too large and taking up too much CPU and memory. It affects not only Elasticsearch's `bool` query, but many other queries that are implicitly converted to `bool` query by Elastcsearch.</p> <p>Default value: `1024`.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">Elasticsearch documentation</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>userConfig.<br>fielddataCacheSize | **string**<br><p>The maximum percentage or absolute value (10%, 512mb) of heap space that is allocated to field data cache.</p> <p>All the field values that are placed in this cache, get loaded to memory in order to provide fast document based access to those values. Building the field data cache for a field can be an expensive operations, so its recommended to have enough memory for this cache, and to keep it loaded.</p> <p>Default value: unbounded.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">Elasticsearch documentation</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>defaultConfig | **object**<br><p>Default settings for an Elasticsearch cluster.</p> <p>Elasticsearch 7.x supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">Elasticsearch documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>defaultConfig.<br>maxClauseCount | **integer** (int64)<br><p>The maximum number of clauses a boolean query can contain.</p> <p>The limit is in place to prevent searches from becoming too large and taking up too much CPU and memory. It affects not only Elasticsearch's `bool` query, but many other queries that are implicitly converted to `bool` query by Elastcsearch.</p> <p>Default value: `1024`.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">Elasticsearch documentation</a>.</p> 
config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7.<br>defaultConfig.<br>fielddataCacheSize | **string**<br><p>The maximum percentage or absolute value (10%, 512mb) of heap space that is allocated to field data cache.</p> <p>All the field values that are placed in this cache, get loaded to memory in order to provide fast document based access to those values. Building the field data cache for a field can be an expensive operations, so its recommended to have enough memory for this cache, and to keep it loaded.</p> <p>Default value: unbounded.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">Elasticsearch documentation</a>.</p> 
config.<br>elasticsearch.<br>masterNode | **object**<br><p>Configuration and resource allocation for Elasticsearch master nodes.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources | **object**<br><p>Resources allocated to Elasticsearch master nodes.</p> <p>Computational resources.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-elasticsearch/concepts/instance-types">documentation</a>.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. All available types are listed in the <a href="/docs/managed-elasticsearch/concepts/storage">documentation</a>.</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: state of the cluster is unknown (`health` of all hosts in the cluster is `UNKNOWN`).</li> <li>ALIVE: cluster is alive and well (`health` of all hosts in the cluster is `ALIVE`).</li> <li>DEAD: cluster is inoperable (`health` of all hosts in the cluster is `DEAD`).</li> <li>DEGRADED: cluster is in degraded state (`health` of at least one of the hosts in the cluster is not `ALIVE`).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: cluster state is unknown.</li> <li>CREATING: cluster is being created.</li> <li>RUNNING: cluster is running normally.</li> <li>ERROR: cluster encountered a problem and cannot operate.</li> <li>UPDATING: cluster is being updated.</li> <li>STOPPING: cluster is stopping.</li> <li>STOPPED: cluster stopped.</li> <li>STARTING: cluster is starting.</li> </ul> 
securityGroupIds[] | **string**<br><p>User security groups</p> 

## Methods {#methods}
Method | Description
--- | ---
[addHosts](addHosts.md) | Adds new hosts to the specified Elasticsearch cluster.
[create](create.md) | Creates a new Elasticsearch cluster in the specified folder.
[delete](delete.md) | Deletes the specified Elasticsearch cluster.
[deleteHosts](deleteHosts.md) | Deletes specified hosts from the specified Elasticsearch cluster.
[get](get.md) | Returns the specified Elasticsearch cluster.
[list](list.md) | Retrieves the list of Elasticsearch clusters that belong to the specified folder.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified Elasticsearch cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified Elasticsearch cluster.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified Elasticsearch cluster.
[move](move.md) | Moves the specified Elasticsearch cluster to the specified folder.
[start](start.md) | Starts the specified Elasticsearch cluster.
[stop](stop.md) | Stops the specified Elasticsearch cluster.
[streamLogs](streamLogs.md) | Same as [listLogs](/docs/managed-elasticsearch/api-ref/Cluster/listLogs) but using server-side streaming. Also supports `tail -f` semantics.
[update](update.md) | Updates the specified Elasticsearch cluster.