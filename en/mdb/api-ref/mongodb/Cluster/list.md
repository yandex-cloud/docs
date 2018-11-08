# Method list
Retrieves the list of MongoDB Cluster resources that belong
to the specified folder.
 

 
## HTTP request {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters`
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list MongoDB clusters in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/mdb/api-ref/mongodb/Cluster/list#query_params) to the [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/mdb/api-ref/mongodb/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 3-63 characters long and match the regular expression `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**


 
Field | Description
--- | ---
clusters | **object**<br><p>A MongoDB Cluster resource. For more information, see the <a href="/docs/mdb/concepts">Cluster</a> section in the Developer's Guide.</p> 
clusters.<br>id | **string**<br><p>ID of the MongoDB cluster. This ID is assigned by MDB at creation time.</p> 
clusters.<br>folderId | **string**<br><p>ID of the folder that the MongoDB cluster belongs to.</p> 
clusters.<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters.<br>name | **string**<br><p>Name of the MongoDB cluster. The name is unique within the folder. 3-63 characters long.</p> 
clusters.<br>description | **string**<br><p>Description of the MongoDB cluster. 0-256 characters long.</p> 
clusters.<br>labels | **object**<br><p>Custom labels for the MongoDB cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
clusters.<br>environment | **string**<br><p>Deployment environment of the MongoDB cluster.</p> <p>Deployment environment.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters.<br>monitoring | **object**<br><p>Monitoring system.</p> 
clusters.<br>monitoring.<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters.<br>monitoring.<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters.<br>monitoring.<br>link | **string**<br><p>Link to the monitoring system charts for the MongoDB cluster.</p> 
clusters.<br>config | **object**<br><p>Configuration of the MongoDB cluster.</p> 
clusters.<br>config.<br>version | **string**<br><p>Version of MongoDB server software.</p> 
clusters.<br>config.<br>mongodb_3_6 | **object** <br>`clusters.config` includes only one of the fields `mongodb_3_6`<br><br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod | **object**<br><p>Configuration and resource allocation for a MongoDB 3.6 cluster.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config | **object**<br><p>Configuration of a MongoDB 3.6 server.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective settings for a MongoDB 3.6 cluster (a combination of settings defined in userConfig and [default_config]).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p><code>storage</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) — the journal is enabled.</li> <li>false — the journal is disabled.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p><code>operationProfiling</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of slowOpThreshold.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p><code>net</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined settings for a MongoDB 3.6 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p><code>storage</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) — the journal is enabled.</li> <li>false — the journal is disabled.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p><code>operationProfiling</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of slowOpThreshold.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p><code>net</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default configuration for a MongoDB 3.6 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p><code>storage</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) — the journal is enabled.</li> <li>false — the journal is disabled.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p><code>operationProfiling</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of slowOpThreshold.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p><code>net</code> section of mongod configuration.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources | **object**<br><p>Resources allocated to MongoDB hosts.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/mdb/concepts/instance-types">documentation</a>.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
clusters.<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters.<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown ([Host.health] for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well ([Host.health] for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable ([Host.health] for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity ([Host.health] for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters.<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/mdb/api-ref/mongodb/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/mdb/api-ref/mongodb/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/mdb/api-ref/mongodb/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/mdb/api-ref/mongodb/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 