---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Cluster/create.md
---

# Managed Service for Elasticsearch API, REST: Cluster.create
Creates a new Elasticsearch cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
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
  "userSpecs": [
    {
      "name": "string",
      "password": "string"
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "type": "string",
      "shardName": "string"
    }
  ],
  "networkId": "string",
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

  },
  "extensionSpecs": [
    {
      "name": "string",
      "uri": "string",
      "disabled": true
    }
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the Elasticsearch cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the Elasticsearch cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the Elasticsearch cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Elasticsearch cluster as ``key:value`` pairs.</p> <p>For example, "project": "mvp" or "source": "dictionary".</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Deployment environment of the Elasticsearch cluster.</p> <ul> <li>PRODUCTION: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Required. Elasticsearch and hosts configuration for the cluster.</p> 
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
configSpec.<br>adminPassword | **string**<br><p>Required. ElasticSearch admin password.</p> 
userSpecs[] | **object**<br><p>One or more descriptions of users to be created in Elasticsearch cluster.</p> 
userSpecs[].<br>name | **string**<br><p>Required. Name of the Elasticsearch user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
userSpecs[].<br>password | **string**<br><p>Required. Password of the Elasticsearch user.</p> <p>The string length in characters must be 8-128.</p> 
hostSpecs[] | **object**<br><p>Required. One or more configurations of hosts to be created in the Elasticsearch cluster.</p> <p>Must contain at least one element.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet the host resides in.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the host.</p> <p>If the value is ``true``, then this host is available on the Internet via it's public IP address.</p> 
hostSpecs[].<br>type | **string**<br><p>Required. Host type.</p> <ul> <li>DATA_NODE: the host is an Elasticsearch data node.</li> <li>MASTER_NODE: the host is an Elasticsearch master node.</li> </ul> 
hostSpecs[].<br>shardName | **string**<br><p>The shard name to create on the host.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
networkId | **string**<br><p>Required. ID of the network to create the Elasticsearch cluster in.</p> <p>The maximum string length in characters is 50.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
serviceAccountId | **string**<br><p>ID of the service account used for access to Object Storage.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
extensionSpecs[] | **object**
extensionSpecs[].<br>name | **string**<br><p>Required. Name of the extension.</p> <p>The maximum string length in characters is 50.</p> 
extensionSpecs[].<br>uri | **string**<br><p>URI of the zip archive to create the new extension from. Currently only supports links that are stored in Object Storage.</p> 
extensionSpecs[].<br>disabled | **boolean** (boolean)<br><p>The flag shows whether to create the extension in disabled state.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 