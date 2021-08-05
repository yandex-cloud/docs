---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method get
Returns the specified cluster.
 
To get the list of all available clusters, make a [list](/docs/data-proc/api-ref/Cluster/list) request.
 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Data Proc cluster.  To get a cluster ID make a [list](/docs/data-proc/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
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
```
A Data Proc cluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the cluster. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the cluster. The name is unique within the folder.</p> <p>The string length in characters must be 1-63.</p> 
description | **string**<br><p>Description of the cluster.</p> <p>The string length in characters must be 0-256.</p> 
labels | **object**<br><p>Cluster labels as ``key:value`` pairs.</p> <p>No more than 64 per resource.</p> 
monitoring[] | **object**<br><p>Metadata of a monitoring system for a Data Proc cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system.</p> 
config | **object**<br><p>Configuration of the cluster.</p> 
config.<br>versionId | **string**<br><p>Image version for cluster provisioning. All available versions are listed in the <a href="/docs/managed-hadoop/concepts/image-versions">documentation</a>.</p> 
config.<br>hadoop | **object**<br><p>Data Proc specific configuration options.</p> <p>Hadoop configuration that describes services installed in a cluster, their properties and settings.</p> 
config.<br>hadoop.<br>services[] | **string**<br><p>Set of services used in the cluster (if empty, the default set is used).</p> 
config.<br>hadoop.<br>properties | **object**<br><p>Properties set for all hosts in ``*-site.xml`` configurations. The key should indicate the service and the property.</p> <p>For example, use the key 'hdfs:dfs.replication' to set the ``dfs.replication`` property in the file ``/etc/hadoop/conf/hdfs-site.xml``.</p> 
config.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>List of public SSH keys to access to cluster hosts.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Cluster status.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
zoneId | **string**<br><p>ID of the availability zone where the cluster resides.</p> 
serviceAccountId | **string**<br><p>ID of service account for the Data Proc manager agent.</p> 
bucket | **string**<br><p>Object Storage bucket to be used for Data Proc jobs that are run in the cluster.</p> 
uiProxy | **boolean** (boolean)<br><p>Whether UI Proxy feature is enabled.</p> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 