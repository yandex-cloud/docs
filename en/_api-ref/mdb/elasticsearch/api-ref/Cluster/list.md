---
editable: false
---

# Method list
Retrieves the list of ElasticSearch clusters.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list ElasticSearch clusters in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-elasticsearch/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-elasticsearch/api-ref/Cluster/list#query_params) to the [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-elasticsearch/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>Elasticsearch cluster resource</p> 
clusters[].<br>id | **string**<br><p>ID of the ElasticSearch cluster. This ID is assigned by MDB at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the ElasticSearch cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the ElasticSearch cluster. The name is unique within the folder. 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the ElasticSearch cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the ElasticSearch cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the ElasticSearch cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Monitoring system.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the ElasticSearch cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>ElasticSearch version.</p> 
clusters[].<br>config.<br>elasticsearch | **object**<br><p>ElasticSearch configuration.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode | **object**<br>
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources | **object**<br>Resources allocated to data node hosts.<br>
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6 | **object**<br>
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig | **object**<br><p>Required.</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>the percentage of heap space that is allocated to fielddata</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>effectiveConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig | **object**<br>
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>the percentage of heap space that is allocated to fielddata</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>userConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig | **object**<br>
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>fielddataCacheSize | **integer** (int64)<br><p>the percentage of heap space that is allocated to fielddata</p> 
clusters[].<br>config.<br>elasticsearch.<br>dataNode.<br>elasticsearchConfigSet_7_6.<br>defaultConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode | **object**<br>
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources | **object**<br><p>Resources allocated to master node hosts.</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>elasticsearch.<br>masterNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (<code>health</code> for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (<code>health</code> for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (<code>health</code> for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (<code>health</code> for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-elasticsearch/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-elasticsearch/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-elasticsearch/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-elasticsearch/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 