# Method create
Creates a MongoDB cluster in the specified folder.
 

 
## HTTP request {#https-request}
`POST https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters`
 
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

    // `configSpec`includes only one of the fields `mongodbSpec_3_6`
    "mongodbSpec_3_6": {
      "mongod": {
        "config": {
          "storage": {
            "wiredTiger": {
              "engineConfig": {
                "cacheSizeGb": "number"
              },
              "collectionConfig": {
                "blockCompressor": "string"
              }
            },
            "journal": {
              "enabled": true,
              "commitInterval": "integer"
            }
          },
          "operationProfiling": {
            "mode": "string",
            "slowOpThreshold": "integer"
          },
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    // end of the list of possible fields`configSpec`

  },
  "databaseSpecs": [
    {
      "name": "string"
    }
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "networkId": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create MongoDB cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. The name can’t be changed after the MongoDB cluster is created.</p> <p>The string length in characters must be 1-63. Value must match the regular expression <code>[a-zA-Z0-9_]+</code>.</p> 
description | **string**<br><p>Description of the MongoDB cluster. 0-256 characters long.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the MongoDB cluster as <code>key:value</code> pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
environment | **string**<br><p>Required. Deployment environment of the MongoDB cluster.</p> <p>Deployment environment.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Required. Configuration and resources for hosts that should be created for the MongoDB cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of MongoDB used in the cluster. The only valid value: 3.6</p> 
configSpec.<br>mongodbSpec_3_6 | **object** <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`<br><br>
configSpec.<br>mongodbSpec_3_6.<br>mongod | **object**<br><p>Required. Configuration and resource allocation for a mongod host.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config | **object**<br><p>Configuration for a mongod 3.6 host.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage | **object**<br><p><code>storage</code> section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) — the journal is enabled.</li> <li>false — the journal is disabled.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p><code>operationProfiling</code> section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of slowOpThreshold.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net | **object**<br><p><code>net</code> section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources | **object**<br><p>Required. Resources allocated to mongod hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/mdb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
databaseSpecs | **object**<br><p>Required. Descriptions of databases to be created in the MongoDB cluster.</p> <p>Must contain at least one element.</p> 
databaseSpecs.<br>name | **string**<br><p>Required. Name of the MongoDB database. 1-63 characters long.</p> <p>The string length in characters must be 1-63. Value must match the regular expression <code>[a-zA-Z0-9_]+</code>.</p> 
userSpecs | **object**<br><p>Required. Descriptions of database users to be created in the MongoDB cluster.</p> <p>Must contain at least one element.</p> 
userSpecs.<br>name | **string**<br><p>Required. Name of the MongoDB user.</p> <p>The string length in characters must be 1-63. Value must match the regular expression <code>[a-zA-Z0-9_]+</code>.</p> 
userSpecs.<br>password | **string**<br><p>Required. Password of the MongoDB user.</p> <p>The string length in characters must be 8-128.</p> 
userSpecs.<br>permissions | **object**<br><p>Set of permissions to grant to the user.</p> 
userSpecs.<br>permissions.<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
userSpecs.<br>permissions.<br>roles | **string**<br><p>MongoDB roles for the databaseName database that the permission grants.</p> 
hostSpecs | **object**<br><p>Required. Individual configurations for hosts that should be created for the MongoDB cluster.</p> <p>Must contain at least one element.</p> 
hostSpecs.<br>zoneId | **string**<br><p>ID of the availability zone where the host resides. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs.<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the <a href="/docs/mdb/api-ref/mongodb/Cluster#representation">Cluster.networkId</a> field.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs.<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with assignPublicIp set as needed.</p> <p>Possible values:</p> <ul> <li>false — don't assign a public IP to the host.</li> <li>true — the host should have a public IP address.</li> </ul> 
networkId | **string**<br><p>Required. ID of the network to create the cluster in.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified. This value is in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 