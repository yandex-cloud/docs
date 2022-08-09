---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/Cluster/update.md
---

# Method update
Updates the specified Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.{{ api-host }}/managed-elasticsearch/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Elasticsearch cluster to update.</p> <p>To get the Elasticsearch cluster ID, make a <a href="/docs/managed-elasticsearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "elasticsearchSpec": {
      "dataNode": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "elasticsearchConfig_7": {
          "maxClauseCount": "integer",
          "fielddataCacheSize": "string",
          "reindexRemoteWhitelist": "string",
          "reindexSslCaPath": "string"
        }
      },
      "masterNode": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "plugins": [
        "string"
      ]
    },
    "edition": "string",
    "adminPassword": "string"
  },
  "name": "string",
  "securityGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "deletionProtection": true,
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the Elasticsearch cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Elasticsearch cluster as ``key:value`` pairs.</p> <p>For example, "project": "mvp" or "source": "dictionary".</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-elasticsearch/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-elasticsearch/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the Elasticsearch cluster.</p> <p>Use <a href="/docs/managed-elasticsearch/api-ref/Cluster/update#body_params">updateMask</a> to prevent reverting all cluster settings that are not listed in ``config_spec`` to their default values.</p> 
configSpec.<br>version | **string**<br><p>Elasticsearch version.</p> 
configSpec.<br>elasticsearchSpec | **object**<br><p>Configuration and resource allocation for Elasticsearch nodes.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode | **object**<br><p>Configuration and resource allocation for Elasticsearch data nodes.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>resources | **object**<br>Resources allocated to Elasticsearch data nodes.
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-elasticsearch/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. All available types are listed in the <a href="/docs/managed-elasticsearch/concepts/storage">documentation</a>.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>elasticsearchConfig_7 | **object**<br><p>Elasticsearch 7.x supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html">Elasticsearch documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>elasticsearchConfig_7.<br>maxClauseCount | **integer** (int64)<br><p>The maximum number of clauses a boolean query can contain.</p> <p>The limit is in place to prevent searches from becoming too large and taking up too much CPU and memory. It affects not only Elasticsearch's ``bool`` query, but many other queries that are implicitly converted to ``bool`` query by Elastcsearch.</p> <p>Default value: ``1024``.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html">Elasticsearch documentation</a>.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>elasticsearchConfig_7.<br>fielddataCacheSize | **string**<br><p>The maximum percentage or absolute value (10%, 512mb) of heap space that is allocated to field data cache.</p> <p>All the field values that are placed in this cache, get loaded to memory in order to provide fast document based access to those values. Building the field data cache for a field can be an expensive operations, so its recommended to have enough memory for this cache, and to keep it loaded.</p> <p>Default value: unbounded.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html">Elasticsearch documentation</a>.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>elasticsearchConfig_7.<br>reindexRemoteWhitelist | **string**<br><p>Remote hosts for reindex have to be explicitly allowed in elasticsearch.yml using the reindex.remote.whitelist property. It can be set to a comma delimited list of allowed remote host and port combinations. Scheme is ignored, only the host and port are used.</p> 
configSpec.<br>elasticsearchSpec.<br>dataNode.<br>elasticsearchConfig_7.<br>reindexSslCaPath | **string**<br><p>List of paths to PEM encoded certificate files that should be trusted.</p> <p>See in-depth description in <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html#reindex-ssl">Elasticsearch documentation</a></p> 
configSpec.<br>elasticsearchSpec.<br>masterNode | **object**<br><p>Configuration and resource allocation for Elasticsearch master nodes.</p> 
configSpec.<br>elasticsearchSpec.<br>masterNode.<br>resources | **object**<br><p>Resources allocated to Elasticsearch master nodes.</p> <p>Computational resources.</p> 
configSpec.<br>elasticsearchSpec.<br>masterNode.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-elasticsearch/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>elasticsearchSpec.<br>masterNode.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>elasticsearchSpec.<br>masterNode.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. All available types are listed in the <a href="/docs/managed-elasticsearch/concepts/storage">documentation</a>.</p> 
configSpec.<br>elasticsearchSpec.<br>plugins[] | **string**<br><p>Cluster wide plugins</p> <p>The maximum string length in characters for each value is 50.</p> 
configSpec.<br>edition | **string**<br><p>ElasticSearch edition.</p> 
configSpec.<br>adminPassword | **string**<br><p>ElasticSearch admin password.</p> 
name | **string**<br><p>New name for the Elasticsearch cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
serviceAccountId | **string**<br><p>ID of the service account used for access to Object Storage.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 