---
editable: false
---

# Cluster
A set of methods for managing Dataproc clusters.
## JSON Representation {#representation}
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
  "bucket": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Dataproc cluster. This ID is assigned by Dataproc at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Dataproc cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Dataproc cluster. The name is unique within the folder. 1-64 characters long.</p> 
description | **string**<br><p>Description of the Dataproc cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Dataproc cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
monitoring[] | **object**<br><p>Monitoring system.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system.</p> 
config | **object**<br><p>Configuration of the Dataproc cluster.</p> 
config.<br>versionId | **string**<br><p>Version of image for cluster provisioning. All available versions are listed in the <a href="/docs/managed-hadoop/concepts/image-versions">documentation</a>.</p> 
config.<br>hadoop | **object**<br><p>Dataproc specific options</p> <p>Configuration, that describes application logic of installed services, their properties and settings.</p> 
config.<br>hadoop.<br>services[] | **string**<br><p>List of used services in cluster (for default use empty)</p> 
config.<br>hadoop.<br>properties | **object**<br><p>Properties passed to all hosts *-site.xml configurations. In key you need to use prefix 'hdfs:dfs.replication' for setting property 'dfs.replication' in /etc/hadoop/conf/hdfs-site.xml</p> 
config.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>List of ssh public keys to access to cluster hosts.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown ([Host.health] for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well ([Host.health] for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable ([Host.health] for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity ([Host.health] for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Cluster status.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
zoneId | **string**<br><p>ID of the availability zone.</p> 
serviceAccountId | **string**<br><p>ID of service account for Dataproc manager agent.</p> 
bucket | **string**<br><p>Object storage bucket name for Dataproc jobs.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a Dataproc cluster.
[delete](delete.md) | Deletes the specified Dataproc cluster.
[get](get.md) | Returns the specified Dataproc cluster.
[list](list.md) | Retrieves a list of Dataproc clusters.
[listHosts](listHosts.md) | Retrieves a list of hosts.
[listOperations](listOperations.md) | 
[start](start.md) | Start the specified Dataproc cluster.
[stop](stop.md) | Stop the specified Dataproc cluster.
[update](update.md) | Updates configuration of the specified Dataproc cluster.