---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-clickhouse/cluster/add-external-dictionary.md
---
# yc managed-clickhouse cluster add-external-dictionary

Add an external dictionary to a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster add-external-dictionary <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the ClickHouse cluster.|
|`--name`|<b>`string`</b><br/> Name of the ClickHouse cluster.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--dict-name`|<b>`string`</b><br/> Name to set for the external dictionary.|
|`--structure-id`|<b>`string`</b><br/> Numeric key of the column for the dictionary.|
|`--structure-key`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Specifies composite keys for the dictionary.  Possible property names:  name Name of the column.  type Type of the data in the column.  null-value Default value for an element without data (for example, an empty string).  expression Expression that describes the attribute, if applicable.  hierarchical Indication of hierarchy support.  injective Indication of injective mapping 'id' -> 'attribute'.  |
|`--structure-attribute`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Description of the fields available for database queries.  Possible property names:  name Name of the column.  type Type of the data in the column.  null-value Default value for an element without data (for example, an empty string).  expression Expression that describes the attribute, if applicable.  hierarchical Indication of hierarchy support.  injective Indication of injective mapping 'id' -> 'attribute'.  |
|`--fixed-lifetime`|<b>`int`</b><br/> Fixed time between dictionary updates.|
|`--lifetime-range`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Range of possible time intervals between dictionary updates.  Possible property names:  min Minimum time interval between dictionary updates.  max Maximum time interval between dictionary updates.  |
|`--layout-type`|<b>`string`</b><br/> Layout type for the external dictionary.|
|`--layout-size-in-cells`|<b>`int`</b><br/> Number of cells in the cache. Rounded up to a power of two.|
|`--http-source-url`|<b>`string`</b><br/> URL of the source for the external HTTP dictionary.|
|`--http-source-format`|<b>`string`</b><br/> Data format for the external HTTP dictionary.|
|`--http-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Description of the source for the external HTTP dictionary.  Possible property names:  url URL of the source for the external HTTP dictionary.  format Data format for the external HTTP dictionary.  |
|`--mongodb-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Description of the MongoDB source for the external dictionary.  Possible property names:  db Name of the MongoDB database to use for the dictionary.  connection Name of the collection in the specified database to be used as the dictionary source.  host MongoDB host for the specified database  port Port to use for connecting to the host.  user Name of the MongoDB database user.  password Password of the MongoDB database user.  |
|`--clickhouse-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Description of the ClickHouse source for the external dictionary.  Possible property names:  db Name of the ClickHouse database to use for the dictionary.  table Name of the table in the specified database.  host ClickHouse host for the specified database.  port Port to use for connecting to the host.  user Name of the ClickHouse database user.  password Password of the ClickHouse database user.  where Selection criteria for the data in the specified ClickHouse table.  |
|`--mysql-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Description of the MySQL source for the external dictionary  Possible property names:  db Name of the MySQL database to use for the dictionary.  table Name of the table in the specified database to be used as the dictionary source.  port Default port to use for connecting to a replica of the dictionary source.  user Name of the default user for replicas of the dictionary source.  password Password for the default user for all replicas of the dictionary source.  where Selection criteria for the data in the specified MySQL table.  |
|`--mysql-replica`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> MySQL replica of the database to be used as the dictionary source.  Possible property names:  host MySQL host for the specified replica.  priority The priority of the replica that ClickHouse should take into account when connecting to the dictionary source.  port Port to use for connecting to the replica.  user Name of the MySQL database user.  password Password of the MySQL database user.  |
|`--mysql-invalidate-query`|<b>`string`</b><br/> Query for checking the dictionary status, to pull only updated data.|
|`--postgresql-source`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Description of the PostgreSQL source for the external dictionary  Possible property names:  db Name of the Postgresql database to use for the dictionary.  table Name of the table in the specified database to be used as the dictionary source.  port Default port to use for connecting to a replica of the dictionary source.  user Name of the default user for replicas of the dictionary source.  password Password for the default user for all replicas of the dictionary source.  ssl-mode SSL mode. Values: 'disable', 'allow', 'prefer', 'verify-ca', 'verify-full'  |
|`--postgresql-source-hosts`|<b>`value[,value]`</b><br/> Replica hosts names.|
|`--postgresql-invalidate-query`|<b>`string`</b><br/> Query for checking the dictionary status, to pull only updated data.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
