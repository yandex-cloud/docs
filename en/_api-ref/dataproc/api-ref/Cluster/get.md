---
editable: false
---

# Data Proc API, REST: Cluster.get
Returns the specified cluster.
 
To get the list of all available clusters, make a [list](/docs/data-proc/api-ref/Cluster/list) request.
 
## HTTP request {#https-request}
```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Data Proc cluster.</p> <p>To get a cluster ID make a <a href="/docs/data-proc/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
      ],
      "initializationActions": [
        {
          "uri": "string",
          "args": [
            "string"
          ],
          "timeout": "string"
        }
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
  "deletionProtection": true,
  "logGroupId": "string"
}
```
A Data Proc cluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the cluster. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the cluster. The name is unique within the folder.</p> <p>The string length in characters must be 1-63.</p> 
description | **string**<br><p>Description of the cluster.</p> <p>The string length in characters must be 0-256.</p> 
labels | **object**<br><p>Cluster labels as ``key:value`` pairs.</p> <p>No more than 64 per resource.</p> 
monitoring[] | **object**<br><p>Monitoring systems relevant to the cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system.</p> 
config | **object**<br><p>Configuration of the cluster.</p> 
config.<br>versionId | **string**<br><p>Image version for cluster provisioning. All available versions are listed in the <a href="/docs/data-proc/concepts/environment">documentation</a>.</p> 
config.<br>hadoop | **object**<br><p>Data Proc specific configuration options.</p> <p>Hadoop configuration that describes services installed in a cluster, their properties and settings.</p> 
config.<br>hadoop.<br>services[] | **string**<br><p>Set of services used in the cluster (if empty, the default set is used).</p> 
config.<br>hadoop.<br>properties | **object**<br><p>Properties set for all hosts in ``*-site.xml`` configurations. The key should indicate the service and the property.</p> <p>For example, use the key 'hdfs:dfs.replication' to set the ``dfs.replication`` property in the file ``/etc/hadoop/conf/hdfs-site.xml``.</p> 
config.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>List of public SSH keys to access to cluster hosts.</p> 
config.<br>hadoop.<br>initializationActions[] | **object**<br><p>Set of init-actions</p> 
config.<br>hadoop.<br>initializationActions[].<br>uri | **string**<br><p>URI of the executable file</p> 
config.<br>hadoop.<br>initializationActions[].<br>args[] | **string**<br><p>Arguments to the initialization action</p> 
config.<br>hadoop.<br>initializationActions[].<br>timeout | **string** (int64)<br><p>Execution timeout</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: Object is in unknown state (we have no data).</li> <li>ALIVE: Object is alive and well (for example, all hosts of the cluster are alive).</li> <li>DEAD: Object is inoperable (it cannot perform any of its essential functions).</li> <li>DEGRADED: Object is partially alive (it can perform some of its essential functions).</li> </ul> 
status | **string**<br><p>Cluster status.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
zoneId | **string**<br><p>ID of the availability zone where the cluster resides.</p> 
serviceAccountId | **string**<br><p>ID of service account for the Data Proc manager agent.</p> 
bucket | **string**<br><p>Object Storage bucket to be used for Data Proc jobs that are run in the cluster.</p> 
uiProxy | **boolean** (boolean)<br><p>Whether UI Proxy feature is enabled.</p> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
logGroupId | **string**<br><p>ID of the cloud logging log group to write logs. If not set, default log group for the folder will be used. To prevent logs from being sent to the cloud set cluster property dataproc:disable_cloud_logging = true</p> 