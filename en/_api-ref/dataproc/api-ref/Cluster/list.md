---
editable: false
---

# Method list
Retrieves a list of Dataproc clusters.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder that the Dataproc cluster belongs to.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListClusters requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListClusters request to get the next page of results.  The maximum string length in characters is 100.
filter | String that describes a display filter.  The maximum string length in characters is 1000.
 
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
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "versionId": "string",
        "hadoop": {
          "services": [
            "string"
          ],
          "properties": "object",
          "sshPublicKeys": [
            "string"
          ]
        }
      },
      "health": "string",
      "status": "string",
      "zoneId": "string",
      "serviceAccountId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>Description of a Dataproc cluster. For more information, see the Yandex Dataproc <a href="/docs/data-proc/concepts/">documentation</a>.</p> 
clusters[].<br>id | **string**<br><p>ID of the Dataproc cluster. This ID is assigned by Dataproc at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Dataproc cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the Dataproc cluster. The name is unique within the folder. 1-64 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the Dataproc cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the Dataproc cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
clusters[].<br>monitoring[] | **object**<br><p>Monitoring system.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the Dataproc cluster.</p> 
clusters[].<br>config.<br>versionId | **string**<br><p>Version of image for cluster provisioning. All available versions are listed in the <a href="/docs/managed-hadoop/concepts/image-versions">documentation</a>.</p> 
clusters[].<br>config.<br>hadoop | **object**<br><p>Dataproc specific options</p> <p>Configuration, that describes application logic of installed services, their properties and settings.</p> 
clusters[].<br>config.<br>hadoop.<br>services[] | **string**<br><p>List of used services in cluster (for default use empty)</p> 
clusters[].<br>config.<br>hadoop.<br>properties | **object**<br><p>Properties passed to all hosts *-site.xml configurations. In key you need to use prefix 'hdfs:dfs.replication' for setting property 'dfs.replication' in /etc/hadoop/conf/hdfs-site.xml</p> 
clusters[].<br>config.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>List of ssh public keys to access to cluster hosts.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown ([Host.health] for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well ([Host.health] for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable ([Host.health] for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity ([Host.health] for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Cluster status.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>zoneId | **string**<br><p>ID of the availability zone.</p> 
clusters[].<br>serviceAccountId | **string**<br><p>ID of service account for Dataproc manager agent.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListClusters requests, if the number of results is larger than <code>page_size</code> specified in the request. To get the next page, specify the value of <code>next_page_token</code> as a value for the <code>page_token</code> parameter in the next ListClusters request. Subsequent ListClusters requests will have their own <code>next_page_token</code> to continue paging through the results.</p> 