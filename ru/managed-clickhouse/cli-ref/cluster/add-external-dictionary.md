---
editable: false
---

# yc managed-clickhouse cluster add-external-dictionary

Add an external dictionary to a ClickHouse cluster.

#### Command Usage

Syntax:

`yc managed-clickhouse cluster add-external-dictionary <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the ClickHouse cluster. ||
|| `--name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--dict-name` | `string`

Name to set for the external dictionary. ||
|| `--structure-id` | `string`

Numeric key of the column for the dictionary. ||
|| `--structure-key` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies composite keys for the dictionary.

Possible property names:

- `name`: Name of the column.

- `type`: Type of the data in the column.

- `null-value`: Default value for an element without data (for example, an empty string).

- `expression`: Expression that describes the attribute, if applicable.

- `hierarchical`: Indication of hierarchy support.

- `injective`: Indication of injective mapping 'id' -> 'attribute'. ||
|| `--structure-attribute` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Description of the fields available for database queries.

Possible property names:

- `name`: Name of the column.

- `type`: Type of the data in the column.

- `null-value`: Default value for an element without data (for example, an empty string).

- `expression`: Expression that describes the attribute, if applicable.

- `hierarchical`: Indication of hierarchy support.

- `injective`: Indication of injective mapping 'id' -> 'attribute'. ||
|| `--fixed-lifetime` | `int`

Fixed time between dictionary updates. ||
|| `--lifetime-range` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Range of possible time intervals between dictionary updates.

Possible property names:

- `min`: Minimum time interval between dictionary updates.

- `max`: Maximum time interval between dictionary updates. ||
|| `--layout-type` | `string`

Layout type for the external dictionary. ||
|| `--layout-size-in-cells` | `int`

Number of cells in the cache. Rounded up to a power of two. Applicable only for cache and complex_key_cache layout types. ||
|| `--layout-allow-read-expired-keys` | Allows to read expired keys. Applicable only for cache and complex_key_cache layout types. ||
|| `--layout-max-update-queue-size` | `int`

Max size of update queue. Applicable only for cache and complex_key_cache layout types. ||
|| `--layout-update-queue-push-timeout-milliseconds` | `int`

Max timeout in milliseconds for push update task into queue. Applicable only for cache and complex_key_cache layout types. ||
|| `--layout-query-wait-timeout-milliseconds` | `int`

Max wait timeout in milliseconds for update task to complete. Applicable only for cache and complex_key_cache layout types. ||
|| `--layout-max-threads-for-updates` | `int`

Max threads for cache dictionary update. Applicable only for cache and complex_key_cache layout types. ||
|| `--layout-initial-array-size` | `int`

Initial dictionary key size. Applicable only for flat layout type. ||
|| `--layout-max-array-size` | `int`

Maximum dictionary key size. Applicable only for flat layout type. ||
|| `--layout-access-to-key-from-attributes` | Allows to retrieve key attribute using dictGetString function. Applicable only for ip_trie layout type. ||
|| `--http-source-url` | `string`

URL of the source for the external HTTP dictionary. ||
|| `--http-source-format` | `string`

Data format for the external HTTP dictionary. ||
|| `--http-source` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Description of the source for the external HTTP dictionary.

Possible property names:

- `url`: URL of the source for the external HTTP dictionary.

- `format`: Data format for the external HTTP dictionary. ||
|| `--http-header` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Single HTTP header entry.

Possible property names:

- `name`: Identifier name used for the header send on the request. (required)

- `value`: Value set for a specific identifier name. (required) ||
|| `--mongodb-source` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Description of the MongoDB source for the external dictionary.

Possible property names:

- `db`: Name of the MongoDB database to use for the dictionary.

- `connection`: Name of the collection in the specified database to be used as the dictionary source.

- `host`: MongoDB host for the specified database

- `port`: Port to use for connecting to the host.

- `user`: Name of the MongoDB database user.

- `password`: Password of the MongoDB database user.

- `options`: MongoDB dictionary options ||
|| `--clickhouse-source` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Description of the ClickHouse source for the external dictionary.

Possible property names:

- `db`: Name of the ClickHouse database to use for the dictionary.

- `table`: Name of the table in the specified database.

- `host`: ClickHouse host for the specified database.

- `port`: Port to use for connecting to the host.

- `user`: Name of the ClickHouse database user.

- `password`: Password of the ClickHouse database user.

- `where`: Selection criteria for the data in the specified ClickHouse table.

- `secure`: Use ssl for connection. ||
|| `--mysql-source` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Description of the MySQL source for the external dictionary

Possible property names:

- `db`: Name of the MySQL database to use for the dictionary.

- `table`: Name of the table in the specified database to be used as the dictionary source.

- `port`: Default port to use for connecting to a replica of the dictionary source.

- `user`: Name of the default user for replicas of the dictionary source.

- `password`: Password for the default user for all replicas of the dictionary source.

- `where`: Selection criteria for the data in the specified MySQL table.

- `close-connection`: Should the connection be closed after each request.

- `share-connection`: Should a connection be shared for some requests. ||
|| `--mysql-replica` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

MySQL replica of the database to be used as the dictionary source.

Possible property names:

- `host`: MySQL host for the specified replica.

- `priority`: The priority of the replica that ClickHouse should take into account when connecting to the dictionary source.

- `port`: Port to use for connecting to the replica.

- `user`: Name of the MySQL database user.

- `password`: Password of the MySQL database user. ||
|| `--mysql-invalidate-query` | `string`

Query for checking the dictionary status, to pull only updated data. ||
|| `--postgresql-source` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Description of the PostgreSQL source for the external dictionary

Possible property names:

- `db`: Name of the Postgresql database to use for the dictionary.

- `table`: Name of the table in the specified database to be used as the dictionary source.

- `port`: Default port to use for connecting to a replica of the dictionary source.

- `user`: Name of the default user for replicas of the dictionary source.

- `password`: Password for the default user for all replicas of the dictionary source.

- `ssl-mode`: SSL mode. Values: 'disable', 'allow', 'prefer', 'verify-ca', 'verify-full' ||
|| `--postgresql-source-hosts` | `value[,value]`

Replica hosts names. ||
|| `--postgresql-invalidate-query` | `string`

Query for checking the dictionary status, to pull only updated data. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#