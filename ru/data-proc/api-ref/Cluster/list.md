---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method list
Retrieves the list of clusters in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list clusters in.  To get the folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/data-proc/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/data-proc/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/data-proc/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters clusters listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [Cluster.name](/docs/data-proc/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]. Example of a filter: `name=my-cluster`.  The maximum string length in characters is 1000.
 
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
      "serviceAccountId": "string",
      "bucket": "string",
      "uiProxy": true,
      "securityGroupIds": [
        "string"
      ],
      "hostGroupIds": [
        "string"
      ],
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>A Data Proc cluster. For details about the concept, see <a href="/docs/data-proc/concepts/">documentation</a>.</p> 
clusters[].<br>id | **string**<br><p>ID of the cluster. Generated at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the cluster. The name is unique within the folder.</p> <p>The string length in characters must be 1-63.</p> 
clusters[].<br>description | **string**<br><p>Description of the cluster.</p> <p>The string length in characters must be 0-256.</p> 
clusters[].<br>labels | **object**<br><p>Cluster labels as ``key:value`` pairs.</p> <p>No more than 64 per resource.</p> 
clusters[].<br>monitoring[] | **object**<br><p>Metadata of a monitoring system for a Data Proc cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the cluster.</p> 
clusters[].<br>config.<br>versionId | **string**<br><p>Image version for cluster provisioning. All available versions are listed in the <a href="/docs/managed-hadoop/concepts/image-versions">documentation</a>.</p> 
clusters[].<br>config.<br>hadoop | **object**<br><p>Data Proc specific configuration options.</p> <p>Hadoop configuration that describes services installed in a cluster, their properties and settings.</p> 
clusters[].<br>config.<br>hadoop.<br>services[] | **string**<br><p>Set of services used in the cluster (if empty, the default set is used).</p> 
clusters[].<br>config.<br>hadoop.<br>properties | **object**<br><p>Properties set for all hosts in ``*-site.xml`` configurations. The key should indicate the service and the property.</p> <p>For example, use the key 'hdfs:dfs.replication' to set the ``dfs.replication`` property in the file ``/etc/hadoop/conf/hdfs-site.xml``.</p> 
clusters[].<br>config.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>List of public SSH keys to access to cluster hosts.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Cluster status.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>zoneId | **string**<br><p>ID of the availability zone where the cluster resides.</p> 
clusters[].<br>serviceAccountId | **string**<br><p>ID of service account for the Data Proc manager agent.</p> 
clusters[].<br>bucket | **string**<br><p>Object Storage bucket to be used for Data Proc jobs that are run in the cluster.</p> 
clusters[].<br>uiProxy | **boolean** (boolean)<br><p>Whether UI Proxy feature is enabled.</p> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups.</p> 
clusters[].<br>hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/data-proc/api-ref/Cluster/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/data-proc/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 