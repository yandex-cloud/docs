---
editable: false
---

# Method list
Retrieves the list of OpenSearch clusters.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list OpenSearch clusters in. To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageToken</a> to the <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can only use filtering with the <a href="/docs/managed-opensearch/api-ref/Cluster#representation">Cluster.name</a> field.</li> <li>An operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>The value. Must be 1-63 characters long and match the regular expression ``^[a-zA-Z0-9_-]+$``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
        "opensearch": {
          "plugins": [
            "string"
          ],
          "nodeGroups": [
            {
              "name": "string",
              "resources": {
                "resourcePresetId": "string",
                "diskSize": "string",
                "diskTypeId": "string"
              },
              "hostsCount": "string",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": true,
              "roles": [
                "string"
              ]
            }
          ]
        },
        "dashboards": {
          "nodeGroups": [
            {
              "name": "string",
              "resources": {
                "resourcePresetId": "string",
                "diskSize": "string",
                "diskTypeId": "string"
              },
              "hostsCount": "string",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": true
            }
          ]
        },
        "access": {
          "dataTransfer": true,
          "serverless": true
        }
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "securityGroupIds": [
        "string"
      ],
      "serviceAccountId": "string",
      "deletionProtection": true,
      "maintenanceWindow": {

        // `clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": {},
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        },
        // end of the list of possible fields`clusters[].maintenanceWindow`

      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string",
        "latestMaintenanceTime": "string",
        "nextMaintenanceWindowTime": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>List of OpenSearch clusters.</p> 
clusters[].<br>id | **string**<br><p>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the OpenSearch cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the OpenSearch cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the OpenSearch cluster as ``key:value`` pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the OpenSearch cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the OpenSearch cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the OpenSearch cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>OpenSearch version.</p> 
clusters[].<br>config.<br>opensearch | **object**<br><p>OpenSearch configuration.</p> <p>OpenSearch configuration</p> 
clusters[].<br>config.<br>opensearch.<br>plugins[] | **string**<br><p>Cluster plugins</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[] | **object**
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>name | **string**<br><p>Name of the group.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to data node hosts.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of nodes in the group</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zones for hosts</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnets for hosts</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>roles[] | **string**
clusters[].<br>config.<br>dashboards | **object**<br><p>Dashboards configuration.</p> <p>Dashboards configuration</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[] | **object**
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>name | **string**<br><p>Name of the group.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to data node hosts.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of nodes in the group</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zone for hosts</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnets for hosts</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)
clusters[].<br>config.<br>access | **object**<br><p>Services access</p> 
clusters[].<br>config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required.</p> 
clusters[].<br>config.<br>access.<br>serverless | **boolean** (boolean)<br><p>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups</p> 
clusters[].<br>serviceAccountId | **string**<br><p>ID of the service account used for access to Yandex Object Storage.</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
clusters[].<br>maintenanceWindow | **object**<br><p>Window of maintenance operations</p> 
clusters[].<br>maintenanceWindow.<br>anytime | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
clusters[].<br>plannedOperation | **object**<br><p>Maintenance operation planned at nearest maintenance_window</p> 
clusters[].<br>plannedOperation.<br>info | **string**<br><p>The maximum string length in characters is 256.</p> 
clusters[].<br>plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>plannedOperation.<br>latestMaintenanceTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>plannedOperation.<br>nextMaintenanceWindowTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 