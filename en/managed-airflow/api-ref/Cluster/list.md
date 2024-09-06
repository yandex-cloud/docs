---
editable: false
sourcePath: en/_api-ref/airflow/v1/api-ref/Cluster/list.md
---

# Managed Service for Apache Airflow™ API, REST: Cluster.list
Retrieves a list of Apache Airflow Cluster resources.
 

 
## HTTP request {#https-request}
```
GET https://airflow.{{ api-host }}/managed-airflow/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list Apache Airflow clusters in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-airflow/api-ref/Cluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-airflow/api-ref/Cluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-airflow/api-ref/Cluster/list#query_params">pageToken</a> to the <a href="/docs/managed-airflow/api-ref/Cluster/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can only use filtering with the <a href="/docs/managed-airflow/api-ref/Cluster#representation">Cluster.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 1-63 characters long and match the regular expression ``[a-zA-Z0-9_-]+``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
        "airflow": {
          "config": "object"
        },
        "webserver": {
          "count": "string",
          "resources": {
            "resourcePresetId": "string"
          }
        },
        "scheduler": {
          "count": "string",
          "resources": {
            "resourcePresetId": "string"
          }
        },
        "triggerer": {
          "count": "string",
          "resources": {
            "resourcePresetId": "string"
          }
        },
        "worker": {
          "minCount": "string",
          "maxCount": "string",
          "resources": {
            "resourcePresetId": "string"
          }
        },
        "dependencies": {
          "pipPackages": [
            "string"
          ],
          "debPackages": [
            "string"
          ]
        },
        "lockbox": {
          "enabled": true
        }
      },
      "health": "string",
      "status": "string",
      "network": {
        "subnetIds": [
          "string"
        ],
        "securityGroupIds": [
          "string"
        ]
      },
      "codeSync": {
        "s3": {
          "bucket": "string"
        }
      },
      "deletionProtection": true,
      "webserverUrl": "string",
      "serviceAccountId": "string",
      "logging": {
        "enabled": true,
        "minLevel": "string",

        // `clusters[].logging` includes only one of the fields `folderId`, `logGroupId`
        "folderId": "string",
        "logGroupId": "string",
        // end of the list of possible fields`clusters[].logging`

      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>List of Apache Airflow Cluster resources.</p> 
clusters[].<br>id | **string**<br><p>Unique ID of the Apache Airflow cluster. This ID is assigned by Cloud during cluster creation.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Apache Airflow cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>The time when the Apache Airflow cluster was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
clusters[].<br>name | **string**<br><p>Name of the Apache Airflow cluster. The name is unique within the folder. 1-64 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the Apache Airflow cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
clusters[].<br>monitoring[] | **object**<br><p>Monitoring systems relevant to the Apache Airflow cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system.</p> 
clusters[].<br>config | **object**<br><p>Configuration of Apache Airflow components.</p> 
clusters[].<br>config.<br>versionId | **string**<br><p>Version of Apache that runs on the cluster.</p> 
clusters[].<br>config.<br>airflow | **object**<br><p>Configuration of the Apache Airflow application itself.</p> 
clusters[].<br>config.<br>airflow.<br>config | **object**<br><p>Properties to be passed to Apache Airflow configuration file.</p> 
clusters[].<br>config.<br>webserver | **object**<br><p>Required. Configuration of webserver instances.</p> 
clusters[].<br>config.<br>webserver.<br>count | **string** (int64)<br><p>The number of webserver instances in the cluster.</p> <p>Acceptable values are 1 to 512, inclusive.</p> 
clusters[].<br>config.<br>webserver.<br>resources | **object**<br><p>Resources allocated to webserver instances.</p> 
clusters[].<br>config.<br>webserver.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
clusters[].<br>config.<br>scheduler | **object**<br><p>Required. Configuration of scheduler instances.</p> 
clusters[].<br>config.<br>scheduler.<br>count | **string** (int64)<br><p>The number of scheduler instances in the cluster.</p> <p>Acceptable values are 1 to 512, inclusive.</p> 
clusters[].<br>config.<br>scheduler.<br>resources | **object**<br><p>Resources allocated to scheduler instances.</p> 
clusters[].<br>config.<br>scheduler.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
clusters[].<br>config.<br>triggerer | **object**<br><p>Configuration of triggerer instances.</p> 
clusters[].<br>config.<br>triggerer.<br>count | **string** (int64)<br><p>The number of triggerer instances in the cluster.</p> <p>Acceptable values are 0 to 512, inclusive.</p> 
clusters[].<br>config.<br>triggerer.<br>resources | **object**<br><p>Resources allocated to triggerer instances.</p> 
clusters[].<br>config.<br>triggerer.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
clusters[].<br>config.<br>worker | **object**<br><p>Required. Configuration of worker instances.</p> 
clusters[].<br>config.<br>worker.<br>minCount | **string** (int64)<br><p>The minimum number of worker instances in the cluster.</p> <p>Acceptable values are 0 to 512, inclusive.</p> 
clusters[].<br>config.<br>worker.<br>maxCount | **string** (int64)<br><p>The maximum number of worker instances in the cluster.</p> <p>Acceptable values are 1 to 512, inclusive.</p> 
clusters[].<br>config.<br>worker.<br>resources | **object**<br><p>Resources allocated to worker instances.</p> 
clusters[].<br>config.<br>worker.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
clusters[].<br>config.<br>dependencies | **object**<br><p>The list of additional packages installed in the cluster.</p> 
clusters[].<br>config.<br>dependencies.<br>pipPackages[] | **string**<br><p>Python packages that are installed in the cluster.</p> 
clusters[].<br>config.<br>dependencies.<br>debPackages[] | **string**<br><p>System packages that are installed in the cluster.</p> 
clusters[].<br>config.<br>lockbox | **object**<br><p>Configuration of Lockbox Secret Backend.</p> 
clusters[].<br>config.<br>lockbox.<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable Lockbox Secret Backend.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: Cluster is in unknown state (we have no data).</li> <li>ALIVE: Cluster is alive and well.</li> <li>DEAD: Cluster is inoperable (it cannot perform any of its essential functions).</li> <li>DEGRADED: Cluster is partially alive (it can perform some of its essential functions).</li> </ul> 
clusters[].<br>status | **string**<br><p>Cluster status.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster is stopped.</li> <li>STARTING: Cluster is starting.</li> <li>UPDATING: Cluster is being updated.</li> </ul> 
clusters[].<br>network | **object**<br><p>Network related configuration options.</p> 
clusters[].<br>network.<br>subnetIds[] | **string**<br><p>IDs of VPC network subnets where instances of the cluster are attached.</p> 
clusters[].<br>network.<br>securityGroupIds[] | **string**<br><p>User security groups.</p> 
clusters[].<br>codeSync | **object**<br><p>Parameters of the location and access to the code that will be executed in the cluster.</p> 
clusters[].<br>codeSync.<br>s3 | **object**
clusters[].<br>codeSync.<br>s3.<br>bucket | **string**<br><p>The name of the Object Storage bucket that stores DAG files used in the cluster.</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster.</p> 
clusters[].<br>webserverUrl | **string**<br><p>Address of Apache Airflow web UI.</p> 
clusters[].<br>serviceAccountId | **string**<br><p>Service account used to access Cloud resources. For more information, see <a href="/docs/managed-airflow/concepts/impersonation">documentation</a>.</p> <p>The maximum string length in characters is 50.</p> 
clusters[].<br>logging | **object**<br><p>Cloud Logging configuration.</p> 
clusters[].<br>logging.<br>enabled | **boolean** (boolean)<br><p>Logs generated by the Airflow components are delivered to Cloud Logging.</p> 
clusters[].<br>logging.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
clusters[].<br>logging.<br>folderId | **string** <br>`clusters[].logging` includes only one of the fields `folderId`, `logGroupId`<br><br><p>Logs should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
clusters[].<br>logging.<br>logGroupId | **string** <br>`clusters[].logging` includes only one of the fields `folderId`, `logGroupId`<br><br><p>Logs should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-airflow/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-airflow/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-airflow/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-airflow/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 