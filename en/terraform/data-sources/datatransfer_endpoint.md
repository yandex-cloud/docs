---
subcategory: Data Transfer
---

# yandex_datatransfer_endpoint (DataSource)

Data Transfer endpoint. For more information, see [the official
 documentation](https://yandex.cloud/docs/data-transfer/)

## Example usage

```terraform
//
// Get information about existing Datatransfer Endpoint
//
data "yandex_datatransfer_endpoint" "pg_source_ds" {
  endpoint_id = yandex_datatransfer_endpoint.pg_source.id
}
```

## Arguments & Attributes Reference

- `description` (String). Description of the endpoint.
- `endpoint_id` (String). Identifier of the endpoint to return.
 
 To get the endpoint ID, make an [EndpointService.List] request.
- `folder_id` (String). ID of the folder to create the endpoint in.
 
 To get the folder ID, make a
 [yandex.cloud.resourcemanager.v1.FolderService.List] request.
- `id` (String). Identifier of the endpoint to return.
 
 To get the endpoint ID, make an [EndpointService.List] request.
- `labels` (Map Of String). Endpoint labels as `key:value` pairs.
 
 For details about the concept, see [documentation]( api-url-prefix
 /resource-manager/concepts/labels).
- `name` (String). Name of the endpoint.
 
 The name must be unique within the folder.
- `settings` [Block]. DataTransfer Endpoint Settings block
  - `clickhouse_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `clickhouse_cluster_name` (String). Name of the ClickHouse cluster. For Managed ClickHouse that is name of
 ShardGroup or managed cluster ID by default
    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

        - `connection_manager_connection` [Block]. Get ClickHouse installation params and credentials from Connection Manager
          - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
          - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
        - `database` (String). Database name
        - `mdb_cluster_id` (String). Identifier of the Managed ClickHouse cluster
        - `on_premise` [Block]. Connection settings of the on-premise ClickHouse server
          - `http_port` (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `native_port` (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `shards` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `hosts` (List Of String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `name` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `tls_mode` [Block]. TLS settings for server connection. Disabled by default
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for the database access
          - `raw` (String). Raw secret value
        - `user` (String). User for database access. Required unless connection_manager_connection is used
    - `exclude_tables` (List Of String). Exclude list of tables for replication. If none or empty list is presented -
 will replicate all tables. Can contain * patterns.
    - `include_tables` (List Of String). White list of tables for replication. If none or empty list is presented - will
 replicate all tables. Can contain * patterns.
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
  - `clickhouse_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `alt_names` [Block]. Table renaming rules in target
      - `from_name` (String). Source table name
      - `to_name` (String). Target table name
    - `cleanup_policy` (String). How to clean collections when activating the transfer. One of
 `CLICKHOUSE_CLEANUP_POLICY_DISABLED` or `CLICKHOUSE_CLEANUP_POLICY_DROP`
    - `clickhouse_cluster_name` (String). Name of the ClickHouse cluster. For Managed ClickHouse that is name of
 ShardGroup or managed cluster ID by default.
    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

        - `connection_manager_connection` [Block]. Get ClickHouse installation params and credentials from Connection Manager
          - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
          - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
        - `database` (String). Database name
        - `mdb_cluster_id` (String). Identifier of the Managed ClickHouse cluster
        - `on_premise` [Block]. Connection settings of the on-premise ClickHouse server
          - `http_port` (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `native_port` (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `shards` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `hosts` (List Of String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `name` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `tls_mode` [Block]. TLS settings for server connection. Disabled by default
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for the database access
          - `raw` (String). Raw secret value
        - `user` (String). User for database access. Required unless connection_manager_connection is used
    - `is_schema_migration_disabled` (Bool). Whether can change table schema if schema changed on source
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `sharding` [Block]. Shard selection rules for the data being transferred
      - `column_value_hash` [Block]. Shard data by the hash value of the specified column
        - `column_name` (String). The name of the column to calculate hash from
      - `custom_mapping` [Block]. A custom shard mapping by the value of the specified column
        - `column_name` (String). The name of the column to inspect when deciding the shard to chose for an
 incoming row
        - `mapping` [Block]. The mapping of the specified column values to the shard names
          - `column_value` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `string_value` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/common.proto

          - `shard_name` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

      - `round_robin` [Block]. Distribute incoming rows between ClickHouse shards in a round-robin manner.
 Specify as an empty block to enable
      - `transfer_id` [Block]. Shard data by ID of the transfer
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
  - `kafka_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `auth` [Block]. Authentication settings
      - `no_auth` [Block]. No authentication
      - `sasl` [Block]. Authentication with SASL
        - `mechanism` (String). SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
 KAFKA_MECHANISM_SHA512
        - `password` [Block]. Password for user
          - `raw` (String). Raw secret value
        - `user` (String). User name
    - `connection` [Block]. Connection settings
      - `cluster_id` (String). Managed Service for Kafka cluster ID. 
 Set only one of: cluster_id/on_premise/connection_manager_connection
      - `connection_manager_connection` [Block]. Get Kafka installation params and credentials from Connection Manager
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
      - `on_premise` [Block]. Connection options for on-premise Kafka
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `broker_urls` (List Of String). Kafka broker URLs
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for broker connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `parser` [Block]. Data parsing parameters. If not set, the source messages are read in raw
      - `audit_trails_v1_parser` [Block]. Parse Audit Trails data. Empty struct
      - `cloud_logging_parser` [Block]. Parse Cloud Logging data. Empty struct
      - `json_parser` [Block]. Parse data in json format
        - `add_rest_column` (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (Bool). Mark field as Primary Key
              - `name` (String). Field name
              - `path` (String). Path to the field
              - `required` (Bool). Mark field as required
              - `type` (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (String). Description of the data schema as JSON specification
        - `null_keys_allowed` (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (Bool). Unescape string values
      - `tskv_parser` [Block]. Parse data in tskv format
        - `add_rest_column` (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (Bool). Mark field as Primary Key
              - `name` (String). Field name
              - `path` (String). Path to the field
              - `required` (Bool). Mark field as required
              - `type` (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (String). Description of the data schema as JSON specification
        - `null_keys_allowed` (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (Bool). Unescape string values
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `topic_name` (String). **Deprecated**. Please use `topic_names` instead
 Full source topic name
    - `topic_names` (List Of String). List of full source topic names to read
    - `transformer` [Block]. Transform data with a custom Cloud Function
      - `buffer_flush_interval` (String). Flush interval
      - `buffer_size` (String). Buffer size for function. Maximum 4 GB.  Use value with units, i.e. 10 B, 20 kB,
 2.0 MB, 30 MB, 1.0 GB
      - `cloud_function` (String). Cloud function
      - `invocation_timeout` (String). Invocation timeout
      - `number_of_retries` (Number). Number of retries
      - `service_account_id` (String). Service account
  - `kafka_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `auth` [Block]. Authentication settings
      - `no_auth` [Block]. No authentication
      - `sasl` [Block]. Authentication with SASL
        - `mechanism` (String). SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
 KAFKA_MECHANISM_SHA512
        - `password` [Block]. Password for user
          - `raw` (String). Raw secret value
        - `user` (String). User name
    - `connection` [Block]. Connection settings
      - `cluster_id` (String). Managed Service for Kafka cluster ID. 
 Set only one of: cluster_id/on_premise/connection_manager_connection
      - `connection_manager_connection` [Block]. Get Kafka installation params and credentials from Connection Manager
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
      - `on_premise` [Block]. Connection options for on-premise Kafka
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `broker_urls` (List Of String). Kafka broker URLs
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for broker connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `serializer` [Block]. Data serialization format settings
      - `serializer_auto` [Block]. Empty block. Select the serialization format automatically
      - `serializer_debezium` [Block]. Serialize data in debezium json format
        - `serializer_parameters` [Block]. A list of Debezium parameters set by the structure of the `key` and `value`
 string fields
          - `key` (String). Name of the serializer parameter
          - `value` (String). Value of the serializer parameter
      - `serializer_json` [Block]. Empty block. Serialize data in json format
    - `topic_settings` [Block]. Target topic settings
      - `topic` [Block]. All messages will be sent to one topic
        - `save_tx_order` (Bool). Save transactions order
 Not to split events queue into separate per-table queues.
        - `topic_name` (String). Full topic name
      - `topic_prefix` (String). Topic prefix
 Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>.
 Analogue of the Debezium setting database.server.name.
  - `metrika_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `counter_ids` (List Of Number). Counter IDs
    - `streams` [Block]. Streams
      - `columns` (List Of String). Column names
      - `type` (String). Stream type, one of: METRIKA_STREAM_TYPE_HITS, METRIKA_STREAM_TYPE_VISITS,
 METRIKA_STREAM_TYPE_HITS_V2
    - `token` [Block]. Authentication token
      - `raw` (String). Raw secret value
  - `mongo_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `collections` [Block]. List of collections for replication. Empty list implies replication of all
 tables on the deployment. Allowed to use * as collection name.
      - `collection_name` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

      - `database_name` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

        - `auth_source` (String). Database name associated with the credentials
        - `connection_manager_connection` [Block]. Get StoreDoc/MongoDB installation params and credentials from Connection Manager
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `connection_id` (String). ID of connectionmanager connection with mongodb/Yandex Storedoc installation
 parameters and credentials
          - `replica_set` (String). Replica set name, used only for on-premise mongodb installations
        - `mdb_cluster_id` (String). Identifier of the Yandex StoreDoc cluster
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
        - `on_premise` [Block]. Connection settings of the on-premise MongoDB server
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `hosts` (List Of String). Host names of the replica set
          - `port` (Number). TCP Port number
          - `replica_set` (String). Replica set name
          - `tls_mode` [Block]. TLS settings for the server connection. Empty implies plaintext connection
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for user
          - `raw` (String). Raw secret value
        - `user` (String). User name, required unless connection_manager_connection is used
    - `excluded_collections` [Block]. List of forbidden collections for replication. Allowed to use * as collection
 name for forbid all collections of concrete schema.
      - `collection_name` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

      - `database_name` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

    - `secondary_preferred_mode` (Bool). Read mode for mongo client: whether the secondary server should be preferred to
 the primary when copying data
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
  - `mongo_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `cleanup_policy` (String). How to clean collections when activating the transfer. One of `DISABLED`, `DROP`
 or `TRUNCATE`
    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

        - `auth_source` (String). Database name associated with the credentials
        - `connection_manager_connection` [Block]. Get StoreDoc/MongoDB installation params and credentials from Connection Manager
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `connection_id` (String). ID of connectionmanager connection with mongodb/Yandex Storedoc installation
 parameters and credentials
          - `replica_set` (String). Replica set name, used only for on-premise mongodb installations
        - `mdb_cluster_id` (String). Identifier of the Yandex StoreDoc cluster
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
        - `on_premise` [Block]. Connection settings of the on-premise MongoDB server
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `hosts` (List Of String). Host names of the replica set
          - `port` (Number). TCP Port number
          - `replica_set` (String). Replica set name
          - `tls_mode` [Block]. TLS settings for the server connection. Empty implies plaintext connection
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for user
          - `raw` (String). Raw secret value
        - `user` (String). User name, required unless connection_manager_connection is used
    - `database` (String). Database name. If not empty, then all the data will be written to the database
 with the specified name; otherwise the database name is the same as in the
 source endpoint
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
  - `mysql_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Mysql installation params and credentials from Connection Manager
        - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (String). Managed Service for MySQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise MySQL
        - `hosts` (List Of String). List of host names of the MySQL server. Exactly one host is expected
        - `port` (Number). Port for the database connection
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (String). Name of the database to transfer
 
 You can leave it empty, then it will be possible to transfer tables from several
 databases at the same time from this source.
    - `exclude_tables_regex` (List Of String). Opposite of `include_table_regex`. The tables matching the specified regular
 expressions will not be transferred
    - `include_tables_regex` (List Of String). List of regular expressions of table names which should be transferred. A table
 name is formatted as schemaname.tablename. For example, a single regular
 expression may look like `^mydb.employees$`
    - `object_transfer_settings` [Block]. Schema migration
 Defines which database schema objects should be transferred, e.g. views,
 routines, etc. 
 All of the attrubutes in the block are optional and should be either
 `BEFORE_DATA`, `AFTER_DATA` or `NEVER`."
      - `routine` (String). Routines
 
 CREATE PROCEDURE ... ; CREATE FUNCTION ... ;
      - `tables` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mysql.proto

      - `trigger` (String). Triggers
 
 CREATE TRIGGER ...
      - `view` (String). Views
 
 CREATE VIEW ...
    - `password` [Block]. Password for database access.
      - `raw` (String). Raw secret value
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_database` (String). Database for service tables
 Default: data source database. Here created technical tables (__tm_keeper,
 __tm_gtid_keeper).
    - `timezone` (String). Database timezone
 
 Is used for parsing timestamps for saving source timezones. Accepts values from
 IANA timezone database. Default: local timezone.
    - `user` (String). User for database access. Required unless connection manager connection is used
  - `mysql_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `cleanup_policy` (String). Cleanup policy for activate, reactivate and reupload processes.  
 One of `DISABLED`, `DROP` or `TRUNCATE` Default is `DISABLED`.
    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Mysql installation params and credentials from Connection Manager
        - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (String). Managed Service for MySQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise MySQL
        - `hosts` (List Of String). List of host names of the MySQL server. Exactly one host is expected
        - `port` (Number). Port for the database connection
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (String). Database name
 
 Allowed to leave it empty, then the tables will be created in databases with the
 same names as on the source. If this field is empty, then you must fill below db
 schema for service table.
    - `is_schema_migration_disabled` (Bool). Whether can change table schema if schema changed on source
    - `password` [Block]. Password for database access.
      - `raw` (String). Raw secret value
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_database` (String). Database schema for service table
 Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).
    - `skip_constraint_checks` (Bool). Disable constraints checks
 When `true`, disables foreign key checks and unique checks. `False` by default.
 See
 [foreign_key_checks](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_foreign_key_checks).
 Recommend to disable for increase replication speed unless schema contains
 cascading operations
    - `sql_mode` (String). [sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html) to use when
 interacting with the server. 
 Defaults to `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`
    - `timezone` (String). Database timezone
 
 Is used for parsing timestamps for saving source timezones. Accepts values from
 IANA timezone database. Default: local timezone.
    - `user` (String). User for database access. Required unless connection manager connection is used
  - `postgres_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Postgres installation params and credentials from Connection Manager
        - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (String). Managed Service for PostgreSQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise PostgreSQL
        - `hosts` (List Of String). PG installation hosts
        - `port` (Number). PG port. Will be used if the cluster ID is not specified.
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (String). Name of the database to transfer
    - `exclude_tables` (List Of String). List of tables which will not be transfered, formatted as `schemaname.tablename`
 If omitted or empty list is specified, all tables are replicated. 
 Can contain schema_name.* patterns.
    - `include_tables` (List Of String). List of tables to transfer, formatted as `schemaname.tablename`. 
 If omitted or an empty list is specified, all tables will be transferred.
 Can contain schema_name.* patterns.
    - `object_transfer_settings` [Block]. Defines which database schema objects should be transferred, e.g. views,
 functions, etc. 
 All of the attributes in this block are optional and should be either
 `BEFORE_DATA`, `AFTER_DATA` or `NEVER`
      - `cast` (String). Casts
 
 CREATE CAST ...
      - `collation` (String). Collations
 
 CREATE COLLATION ...
      - `constraint` (String). Constraints
 
 ALTER TABLE ... ADD CONSTRAINT ...
      - `default_values` (String). Default values
 
 ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...
      - `fk_constraint` (String). Foreign keys
 
 ALTER TABLE ... ADD FOREIGN KEY ...
      - `function` (String). Functions
 
 CREATE FUNCTION ...
      - `index` (String). Indexes
 
 CREATE INDEX ...
      - `materialized_view` (String). Materialized views
 
 CREATE MATERIALIZED VIEW ...
      - `policy` (String). Policies
 
 CREATE POLICY ...
      - `primary_key` (String). Primary keys
 
 ALTER TABLE ... ADD PRIMARY KEY ...
      - `rule` (String). Rules
 
 CREATE RULE ...
      - `sequence` (String). Sequences
 
 CREATE SEQUENCE ...
      - `sequence_owned_by` (String). Owned sequences
 
 CREATE SEQUENCE ... OWNED BY ...
      - `sequence_set` (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/postgres.proto

      - `table` (String). Tables
 
 CREATE TABLE ...
      - `trigger` (String). Triggers
 
 CREATE TRIGGER ...
      - `type` (String). Types
 
 CREATE TYPE ...
      - `view` (String). Views
 
 CREATE VIEW ...
    - `password` [Block]. Password for database access.
      - `raw` (String). Raw secret value
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_schema` (String). Name of the database schema in which auxiliary tables needed for the transfer
 will be created (__consumer_keeper, __data_transfer_mole_finder). 
 Empty `service_schema` implies schema `public`
    - `slot_gigabyte_lag_limit` (Number). Maximum WAL size held by the replication slot (API - in bytes, terraform - in
 gigabytes); 
 Exceeding this limit will result in a replication failure and deletion of the
 replication slot.
 Default is 50 gigabytes
    - `user` (String). User for database access. Required unless Connection Manager connection is used.
  - `postgres_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `cleanup_policy` (String). Cleanup policy for activate, reactivate and reupload processes. 
 One of: DISABLED, DROP, TRUNCATE. Default is TRUNCATE
    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Postgres installation params and credentials from Connection Manager
        - `connection_id` (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (String). Managed Service for PostgreSQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise PostgreSQL
        - `hosts` (List Of String). PG installation hosts
        - `port` (Number). PG port. Will be used if the cluster ID is not specified.
        - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (String). CA certificate
 
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (String). Target database name
    - `is_schema_migration_disabled` (Bool). Whether can change table schema if schema changed on source
    - `password` [Block]. Password for database access.
      - `raw` (String). Raw secret value
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `user` (String). User for database access. Required unless Connection Manager connection is used
  - `ydb_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `changefeed_custom_consumer_name` (String). Consumer for pre-created change feed if any
    - `changefeed_custom_name` (String). Pre-created change feed if any
    - `database` (String). Database path in YDB where tables are stored. 
 Example: `/ru/transfer_manager/prod/data-transfer-yt`
    - `instance` (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
 If not specified, will be determined by database
    - `paths` (List Of String). A list of paths which should be uploaded. When not specified, all available
 tables are uploaded
    - `sa_key_content` (String). Authorization Key
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_account_id` (String). Service account ID for interaction with database
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. If omitted, the server has to be accessible via Internet
  - `ydb_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `cleanup_policy` (String). Cleanup policy determine how to clean collections when activating the transfer. 
 One of `YDB_CLEANUP_POLICY_DISABLED` or `YDB_CLEANUP_POLICY_DROP`
    - `database` (String). Database path in YDB where tables are stored. 
 Example: `/ru/transfer_manager/prod/data-transfer`
    - `default_compression` (String). Compression that will be used for default columns family on YDB table creation.
 One of `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`,
 `YDB_DEFAULT_COMPRESSION_DISABLED`, `YDB_DEFAULT_COMPRESSION_LZ4`
    - `instance` (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
 If not specified, will be determined by database
    - `is_schema_migration_disabled` (Bool). Whether can change table schema if schema changed on source
    - `is_table_column_oriented` (Bool). Whether a column-oriented (i.e. OLAP) tables should be created. 
 Default is `false` (create row-oriented OLTP tables)
    - `path` (String). Path extension for database, each table will be layouted into this path
    - `sa_key_content` (String). Authentication key
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_account_id` (String). Service account ID for interaction with database
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. 
 If omitted, the server has to be accessible via Internet
  - `yds_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `allow_ttl_rewind` (Bool). Should continue working, if consumer read lag exceed TTL of topic
 False: stop the transfer in error state, if detected lost data. True: continue
 working with losing part of data
    - `consumer` (String). Custom consumer - for important streams
    - `database` (String). Database path in YDB for streams 
 Example: `/ru/transfer_manager/prod/data-transfer`
    - `endpoint` (String). YDS Endpoint for dedicated db
    - `parser` [Block]. Data parsing rules
      - `audit_trails_v1_parser` [Block]. Parse Audit Trails data. Empty struct
      - `cloud_logging_parser` [Block]. Parse Cloud Logging data. Empty struct
      - `json_parser` [Block]. Parse data in json format
        - `add_rest_column` (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (Bool). Mark field as Primary Key
              - `name` (String). Field name
              - `path` (String). Path to the field
              - `required` (Bool). Mark field as required
              - `type` (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (String). Description of the data schema as JSON specification
        - `null_keys_allowed` (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (Bool). Unescape string values
      - `tskv_parser` [Block]. Parse data in tskv format
        - `add_rest_column` (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (Bool). Mark field as Primary Key
              - `name` (String). Field name
              - `path` (String). Path to the field
              - `required` (Bool). Mark field as required
              - `type` (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (String). Description of the data schema as JSON specification
        - `null_keys_allowed` (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (Bool). Unescape string values
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_account_id` (String). Service account ID which has read access to the stream.
    - `stream` (String). Stream to read
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. If omitted, the server has to be accessible via Internet
    - `supported_codecs` (List Of String). List of supported compression codecs
 Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
 YDS_COMPRESSION_CODEC_GZIP
  - `yds_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `compression_codec` (String). Codec to use for output data compression. If not specified, no compression will
 be done
 Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
 YDS_COMPRESSION_CODEC_GZIP
    - `database` (String). Database path in YDB for streams 
 Example: `/ru/transfer_manager/prod/data-transfer`
    - `endpoint` (String). YDS Endpoint for dedicated db
    - `save_tx_order` (Bool). Save transaction order
 Not to split events queue into separate per-table queues.
 Incompatible with setting Topic prefix, only with Topic full name.
    - `security_groups` (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `serializer` [Block]. Data serialization format
      - `serializer_auto` [Block]. Empty block. Select the serialization format automatically
      - `serializer_debezium` [Block]. Serialize data in debezium json format
        - `serializer_parameters` [Block]. A list of Debezium parameters set by the structure of the `key` and `value`
 string fields
          - `key` (String). Name of the serializer parameter
          - `value` (String). Value of the serializer parameter
      - `serializer_json` [Block]. Empty block. Serialize data in json format
    - `service_account_id` (String). Service account ID which has read access to the stream
    - `stream` (String). Stream to write to
    - `subnet_id` (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. If omitted, the server has to be accessible via Internet


