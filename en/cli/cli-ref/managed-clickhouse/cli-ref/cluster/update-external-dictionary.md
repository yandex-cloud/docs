---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-clickhouse/cli-ref/cluster/update-external-dictionary.md
---

# yc managed-clickhouse cluster update-external-dictionary

Update an external dictionary in a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster update-external-dictionary <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the ClickHouse cluster.|
|`--name`|<b>`string`</b><br/>Name of the ClickHouse cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--dict-name`|<b>`string`</b><br/>Name to set for the external dictionary.|
|`--structure-id`|<b>`string`</b><br/>Numeric key of the column for the dictionary.|
|`--structure-key`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies composite keys for the dictionary.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the column.</li> <li><code>type</code>:     Type of the data in the column.</li> <li><code>null-value</code>:     Default value for an element without data (for example, an empty string).</li> <li><code>expression</code>:     Expression that describes the attribute, if applicable.</li> <li><code>hierarchical</code>:     Indication of hierarchy support.</li> <li><code>injective</code>:     Indication of injective mapping 'id' -&gt; 'attribute'.</li> </ul>|
|`--structure-attribute`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Description of the fields available for database queries.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the column.</li> <li><code>type</code>:     Type of the data in the column.</li> <li><code>null-value</code>:     Default value for an element without data (for example, an empty string).</li> <li><code>expression</code>:     Expression that describes the attribute, if applicable.</li> <li><code>hierarchical</code>:     Indication of hierarchy support.</li> <li><code>injective</code>:     Indication of injective mapping 'id' -&gt; 'attribute'.</li> </ul>|
|`--fixed-lifetime`|<b>`int`</b><br/>Fixed time between dictionary updates.|
|`--lifetime-range`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Range of possible time intervals between dictionary updates.<br/><br/>Possible property names:<br/><ul> <li><code>min</code>:     Minimum time interval between dictionary updates.</li> <li><code>max</code>:     Maximum time interval between dictionary updates.</li> </ul>|
|`--layout-type`|<b>`string`</b><br/>Layout type for the external dictionary.|
|`--layout-size-in-cells`|<b>`int`</b><br/>Number of cells in the cache. Rounded up to a power of two. Applicable only for cache and complex_key_cache layout types.|
|`--layout-allow-read-expired-keys`|Allows to read expired keys. Applicable only for cache and complex_key_cache layout types.|
|`--layout-max-update-queue-size`|<b>`int`</b><br/>Max size of update queue. Applicable only for cache and complex_key_cache layout types.|
|`--layout-update-queue-push-timeout-milliseconds`|<b>`int`</b><br/>Max timeout in milliseconds for push update task into queue. Applicable only for cache and complex_key_cache layout types.|
|`--layout-query-wait-timeout-milliseconds`|<b>`int`</b><br/>Max wait timeout in milliseconds for update task to complete. Applicable only for cache and complex_key_cache layout types.|
|`--layout-max-threads-for-updates`|<b>`int`</b><br/>Max threads for cache dictionary update. Applicable only for cache and complex_key_cache layout types.|
|`--layout-initial-array-size`|<b>`int`</b><br/>Initial dictionary key size. Applicable only for flat layout type.|
|`--layout-max-array-size`|<b>`int`</b><br/>Maximum dictionary key size. Applicable only for flat layout type.|
|`--layout-access-to-key-from-attributes`|Allows to retrieve key attribute using dictGetString function. Applicable only for ip_trie layout type.|
|`--http-source-url`|<b>`string`</b><br/>URL of the source for the external HTTP dictionary.|
|`--http-source-format`|<b>`string`</b><br/>Data format for the external HTTP dictionary.|
|`--http-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Description of the source for the external HTTP dictionary.<br/><br/>Possible property names:<br/><ul> <li><code>url</code>:     URL of the source for the external HTTP dictionary.</li> <li><code>format</code>:     Data format for the external HTTP dictionary.</li> </ul>|
|`--http-header`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Single HTTP header entry.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Identifier name used for the header send on the request. (required)</li> <li><code>value</code>:     Value set for a specific identifier name. (required)</li> </ul>|
|`--mongodb-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Description of the MongoDB source for the external dictionary.<br/><br/>Possible property names:<br/><ul> <li><code>db</code>:     Name of the MongoDB database to use for the dictionary.</li> <li><code>connection</code>:     Name of the collection in the specified database to be used as the dictionary source.</li> <li><code>host</code>:     MongoDB host for the specified database</li> <li><code>port</code>:     Port to use for connecting to the host.</li> <li><code>user</code>:     Name of the MongoDB database user.</li> <li><code>password</code>:     Password of the MongoDB database user.</li> <li><code>options</code>:     MongoDB dictionary options</li> </ul>|
|`--clickhouse-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Description of the ClickHouse source for the external dictionary.<br/><br/>Possible property names:<br/><ul> <li><code>db</code>:     Name of the ClickHouse database to use for the dictionary.</li> <li><code>table</code>:     Name of the table in the specified database.</li> <li><code>host</code>:     ClickHouse host for the specified database.</li> <li><code>port</code>:     Port to use for connecting to the host.</li> <li><code>user</code>:     Name of the ClickHouse database user.</li> <li><code>password</code>:     Password of the ClickHouse database user.</li> <li><code>where</code>:     Selection criteria for the data in the specified ClickHouse table.</li> <li><code>secure</code>:     Use ssl for connection.</li> </ul>|
|`--mysql-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Description of the MySQL source for the external dictionary<br/><br/>Possible property names:<br/><ul> <li><code>db</code>:     Name of the MySQL database to use for the dictionary.</li> <li><code>table</code>:     Name of the table in the specified database to be used as the dictionary source.</li> <li><code>port</code>:     Default port to use for connecting to a replica of the dictionary source.</li> <li><code>user</code>:     Name of the default user for replicas of the dictionary source.</li> <li><code>password</code>:     Password for the default user for all replicas of the dictionary source.</li> <li><code>where</code>:     Selection criteria for the data in the specified MySQL table.</li> <li><code>close-connection</code>:     Should the connection be closed after each request.</li> <li><code>share-connection</code>:     Should a connection be shared for some requests.</li> </ul>|
|`--mysql-replica`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>MySQL replica of the database to be used as the dictionary source.<br/><br/>Possible property names:<br/><ul> <li><code>host</code>:     MySQL host for the specified replica.</li> <li><code>priority</code>:     The priority of the replica that ClickHouse should take into account when connecting to the dictionary source.</li> <li><code>port</code>:     Port to use for connecting to the replica.</li> <li><code>user</code>:     Name of the MySQL database user.</li> <li><code>password</code>:     Password of the MySQL database user.</li> </ul>|
|`--mysql-invalidate-query`|<b>`string`</b><br/>Query for checking the dictionary status, to pull only updated data.|
|`--postgresql-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Description of the PostgreSQL source for the external dictionary<br/><br/>Possible property names:<br/><ul> <li><code>db</code>:     Name of the Postgresql database to use for the dictionary.</li> <li><code>table</code>:     Name of the table in the specified database to be used as the dictionary source.</li> <li><code>port</code>:     Default port to use for connecting to a replica of the dictionary source.</li> <li><code>user</code>:     Name of the default user for replicas of the dictionary source.</li> <li><code>password</code>:     Password for the default user for all replicas of the dictionary source.</li> <li><code>ssl-mode</code>:     SSL mode. Values: 'disable', 'allow', 'prefer', 'verify-ca', 'verify-full'</li> </ul>|
|`--postgresql-source-hosts`|<b>`value[,value]`</b><br/>Replica hosts names.|
|`--postgresql-invalidate-query`|<b>`string`</b><br/>Query for checking the dictionary status, to pull only updated data.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
