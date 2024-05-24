---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/list.md
---

# Managed Service for OpenSearch API, REST: Cluster.list
Retrieves the list of OpenSearch clusters that belong to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list OpenSearch clusters in.</p> <p>To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageToken</a> to the <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li> <p>The field name. Currently you can only use filtering with the <a href="/docs/managed-opensearch/api-ref/Cluster#representation">Cluster.name</a> field.</p> </li> <li> <p>An ``=`` operator.</p> </li> <li> <p>The value in double quotes (``"``). Must be 1-63 characters long and match the regular expression ``[a-zA-Z0-9_-]+``.</p> </li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
          ],
          "keystoreSettings": [
            "string"
          ],
          "opensearchConfigSet_2": {
            "effectiveConfig": {
              "maxClauseCount": "integer",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            },
            "userConfig": {
              "maxClauseCount": "integer",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            },
            "defaultConfig": {
              "maxClauseCount": "integer",
              "fielddataCacheSize": "string",
              "reindexRemoteWhitelist": "string"
            }
          }
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
clusters[].<br>id | **string**<br><p>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the OpenSearch cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Time when the cluster was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
clusters[].<br>name | **string**<br><p>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the OpenSearch cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the OpenSearch cluster as ``key:value`` pairs. Maximum 64 labels per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the OpenSearch cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the OpenSearch cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the OpenSearch cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the OpenSearch cluster.</p> <p>The OpenSearch cluster configuration.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of the OpenSearch server software.</p> 
clusters[].<br>config.<br>opensearch | **object**<br><p>OpenSearch configuration.</p> <p>The OpenSearch host group type configuration.</p> 
clusters[].<br>config.<br>opensearch.<br>plugins[] | **string**<br><p>Names of the cluster plugins.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[] | **object**<br><p>Host groups of the OpenSearch type.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>name | **string**<br><p>Name of the group. Must be 1-63 characters long.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to the hosts.</p> <p>A list of computational resources allocated to a host.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of hosts in the group.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zones the hosts belong to.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnets that the hosts belong to.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)<br><p>Determines whether a public IP is assigned to the hosts in the group.</p> 
clusters[].<br>config.<br>opensearch.<br>nodeGroups[].<br>roles[] | **string**<br><p>Roles of the host group.</p> 
clusters[].<br>config.<br>opensearch.<br>keystoreSettings[] | **string**<br><p>Keystore entries names.</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2 | **object**
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig | **object**<br><p>Required.</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig.<br>fielddataCacheSize | **string**<br><p>the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>effectiveConfig.<br>reindexRemoteWhitelist | **string**
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig | **object**
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig.<br>fielddataCacheSize | **string**<br><p>the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>userConfig.<br>reindexRemoteWhitelist | **string**
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig | **object**
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig.<br>maxClauseCount | **integer** (int64)<br><p>the maximum number of allowed boolean clauses in a query</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig.<br>fielddataCacheSize | **string**<br><p>the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata</p> 
clusters[].<br>config.<br>opensearch.<br>opensearchConfigSet_2.<br>defaultConfig.<br>reindexRemoteWhitelist | **string**
clusters[].<br>config.<br>dashboards | **object**<br><p>Dashboards configuration.</p> <p>The Dashboards host group type configuration.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[] | **object**<br><p>Host groups of the Dashboards type.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>name | **string**<br><p>Name of the group. 1-63 characters long.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to the hosts.</p> <p>A list of computational resources allocated to a host.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of hosts in the group.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zones the hosts belong to.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnets that the hosts belong to.</p> 
clusters[].<br>config.<br>dashboards.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)<br><p>Determines whether a public IP is assigned to the hosts in the group.</p> 
clusters[].<br>config.<br>access | **object**<br><p>Access policy for external services.</p> <p>Access policy for external services.</p> 
clusters[].<br>config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Determines whether the access to Data Transfer is allowed.</p> 
clusters[].<br>config.<br>access.<br>serverless | **boolean** (boolean)<br><p>Determines whether the access to Serverless is allowed.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the cloud network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: Health of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is working normally (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster has encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster has stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups.</p> 
clusters[].<br>serviceAccountId | **string**<br><p>ID of the service account used to access Object Storage.</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Determines whether the cluster is protected from being deleted.</p> 
clusters[].<br>maintenanceWindow | **object**<br><p>Cluster maintenance window. Should be defined by either one of the two options.</p> <p>An OpenSearch cluster maintenance window. Should be defined by either one of the two options.</p> 
clusters[].<br>maintenanceWindow.<br>anytime | **object**<br>An any-time maintenance window. <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>A weekly maintenance window. <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week.</p> <ul> <li>MON: Monday</li> <li>TUE: Tuesday</li> <li>WED: Wednesday</li> <li>THU: Thursday</li> <li>FRI: Friday</li> <li>SAT: Saturday</li> <li>SUN: Sunday</li> </ul> 
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in the UTC timezone.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
clusters[].<br>plannedOperation | **object**<br><p>Maintenance operation planned at nearest <a href="/docs/managed-opensearch/api-ref/Cluster#representation">maintenanceWindow</a>.</p> 
clusters[].<br>plannedOperation.<br>info | **string**<br><p>The description of the operation.</p> <p>The maximum string length in characters is 256.</p> 
clusters[].<br>plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Delay time for the maintenance operation.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
clusters[].<br>plannedOperation.<br>latestMaintenanceTime | **string** (date-time)<br><p>Time of the last maintenance window.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
clusters[].<br>plannedOperation.<br>nextMaintenanceWindowTime | **string** (date-time)<br><p>Time of the next maintenance window.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-opensearch/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent list request has its own <a href="/docs/managed-opensearch/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 