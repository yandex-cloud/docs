[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Data Transfer > Data Sources > datatransfer_endpoint

# yandex_datatransfer_endpoint (DataSource)

Data Transfer endpoint. For more information, see [the official
 documentation](../../data-transfer/index.md)

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

- `description` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

- `endpoint_id` (String). Identifier of the endpoint to return.

 To get the endpoint ID, make an [EndpointService.List] request.
- `folder_id` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

- `id` (String). Identifier of the endpoint to return.

 To get the endpoint ID, make an [EndpointService.List] request.
- `labels` (*Read-Only*) (Map Of String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

- `name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

- `settings` [Block]. DataTransfer Endpoint Settings block
  - `clickhouse_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `clickhouse_cluster_name` (*Read-Only*) (String). Name of the ClickHouse cluster. For Managed ClickHouse that is name of
 ShardGroup or managed cluster ID by default
    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

        - `connection_manager_connection` [Block]. Get ClickHouse installation params and credentials from Connection Manager
          - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
          - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `database` (*Read-Only*) (String). Database name
        - `mdb_cluster_id` (*Read-Only*) (String). Identifier of the Managed ClickHouse cluster
        - `on_premise` [Block]. Connection settings of the on-premise ClickHouse server
          - `http_port` (*Read-Only*) (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `native_port` (*Read-Only*) (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `shards` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `hosts` (*Read-Only*) (List Of String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `tls_mode` [Block]. TLS settings for server connection. Disabled by default
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for the database access
          - `raw` (*Read-Only*) (String). Raw secret value
        - `user` (*Read-Only*) (String). User for database access. Required unless connection_manager_connection is used
    - `exclude_tables` (*Read-Only*) (List Of String). Exclude list of tables for replication. If none or empty list is presented -
 will replicate all tables. Can contain * patterns.
    - `include_tables` (*Read-Only*) (List Of String). White list of tables for replication. If none or empty list is presented - will
 replicate all tables. Can contain * patterns.
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
  - `clickhouse_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `alt_names` [Block]. Table renaming rules in target
      - `from_name` (*Read-Only*) (String). Source table name
      - `to_name` (*Read-Only*) (String). Target table name
    - `cleanup_policy` (*Read-Only*) (String). How to clean collections when activating the transfer. One of
 `CLICKHOUSE_CLEANUP_POLICY_DISABLED` or `CLICKHOUSE_CLEANUP_POLICY_DROP`
    - `clickhouse_cluster_name` (*Read-Only*) (String). Name of the ClickHouse cluster. For Managed ClickHouse that is name of
 ShardGroup or managed cluster ID by default.
    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

        - `connection_manager_connection` [Block]. Get ClickHouse installation params and credentials from Connection Manager
          - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
          - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `database` (*Read-Only*) (String). Database name
        - `mdb_cluster_id` (*Read-Only*) (String). Identifier of the Managed ClickHouse cluster
        - `on_premise` [Block]. Connection settings of the on-premise ClickHouse server
          - `http_port` (*Read-Only*) (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `native_port` (*Read-Only*) (Number). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `shards` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `hosts` (*Read-Only*) (List Of String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

          - `tls_mode` [Block]. TLS settings for server connection. Disabled by default
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for the database access
          - `raw` (*Read-Only*) (String). Raw secret value
        - `user` (*Read-Only*) (String). User for database access. Required unless connection_manager_connection is used
    - `is_schema_migration_disabled` (*Read-Only*) (Bool). Whether can change table schema if schema changed on source
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `sharding` [Block]. Shard selection rules for the data being transferred
      - `column_value_hash` [Block]. Shard data by the hash value of the specified column
        - `column_name` (*Read-Only*) (String). The name of the column to calculate hash from
      - `custom_mapping` [Block]. A custom shard mapping by the value of the specified column
        - `column_name` (*Read-Only*) (String). The name of the column to inspect when deciding the shard to chose for an
 incoming row
        - `mapping` [Block]. The mapping of the specified column values to the shard names
          - `column_value` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

            - `string_value` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/common.proto

          - `shard_name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/clickhouse.proto

      - `round_robin` [Block]. Distribute incoming rows between ClickHouse shards in a round-robin manner.
 Specify as an empty block to enable
      - `transfer_id` [Block]. Shard data by ID of the transfer
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
  - `kafka_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `auth` [Block]. Authentication settings
      - `no_auth` [Block]. No authentication
      - `sasl` [Block]. Authentication with SASL
        - `mechanism` (*Read-Only*) (String). SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
 KAFKA_MECHANISM_SHA512
        - `password` [Block]. Password for user
          - `raw` (*Read-Only*) (String). Raw secret value
        - `user` (*Read-Only*) (String). User name
    - `connection` [Block]. Connection settings
      - `cluster_id` (*Read-Only*) (String). Managed Service for Kafka cluster ID.
 Set only one of: cluster_id/on_premise/connection_manager_connection
      - `connection_manager_connection` [Block]. Get Kafka installation params and credentials from Connection Manager
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
      - `on_premise` [Block]. Connection options for on-premise Kafka
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `broker_urls` (*Read-Only*) (List Of String). Kafka broker URLs
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for broker connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `parser` [Block]. Data parsing parameters. If not set, the source messages are read in raw
      - `audit_trails_v1_parser` [Block]. Parse Audit Trails data. Empty struct
      - `cloud_logging_parser` [Block]. Parse Cloud Logging data. Empty struct
      - `json_parser` [Block]. Parse data in json format
        - `add_rest_column` (*Read-Only*) (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (*Read-Only*) (Bool). Mark field as Primary Key
              - `name` (*Read-Only*) (String). Field name
              - `path` (*Read-Only*) (String). Path to the field
              - `required` (*Read-Only*) (Bool). Mark field as required
              - `type` (*Read-Only*) (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (*Read-Only*) (String). Description of the data schema as JSON specification
 Deprecated: please use fields instead
        - `null_keys_allowed` (*Read-Only*) (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (*Read-Only*) (Bool). Unescape string values
      - `tskv_parser` [Block]. Parse data in tskv format
        - `add_rest_column` (*Read-Only*) (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (*Read-Only*) (Bool). Mark field as Primary Key
              - `name` (*Read-Only*) (String). Field name
              - `path` (*Read-Only*) (String). Path to the field
              - `required` (*Read-Only*) (Bool). Mark field as required
              - `type` (*Read-Only*) (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (*Read-Only*) (String). Description of the data schema as JSON specification
 Deprecated: please use fields instead
        - `null_keys_allowed` (*Read-Only*) (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (*Read-Only*) (Bool). Unescape string values
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `topic_name` (*Read-Only*) (String). **Deprecated**. Please use `topic_names` instead
 Full source topic name
    - `topic_names` (*Read-Only*) (List Of String). List of full source topic names to read
    - `transformer` [Block]. Transform data with a custom Cloud Function
      - `buffer_flush_interval` (*Read-Only*) (String). Flush interval
      - `buffer_size` (*Read-Only*) (String). Buffer size for function. Maximum 4 GB.  Use value with units, i.e. 10 B, 20 kB,
 2.0 MB, 30 MB, 1.0 GB
      - `cloud_function` (*Read-Only*) (String). Cloud function
      - `invocation_timeout` (*Read-Only*) (String). Invocation timeout
      - `number_of_retries` (*Read-Only*) (Number). Number of retries
      - `service_account_id` (String). Service account
  - `kafka_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `auth` [Block]. Authentication settings
      - `no_auth` [Block]. No authentication
      - `sasl` [Block]. Authentication with SASL
        - `mechanism` (*Read-Only*) (String). SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
 KAFKA_MECHANISM_SHA512
        - `password` [Block]. Password for user
          - `raw` (*Read-Only*) (String). Raw secret value
        - `user` (*Read-Only*) (String). User name
    - `connection` [Block]. Connection settings
      - `cluster_id` (*Read-Only*) (String). Managed Service for Kafka cluster ID.
 Set only one of: cluster_id/on_premise/connection_manager_connection
      - `connection_manager_connection` [Block]. Get Kafka installation params and credentials from Connection Manager
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
      - `on_premise` [Block]. Connection options for on-premise Kafka
 Set only one of: cluster_id/on_premise/connection_manager_connection
        - `broker_urls` (*Read-Only*) (List Of String). Kafka broker URLs
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for broker connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `serializer` [Block]. Data serialization format settings
      - `serializer_auto` [Block]. Empty block. Select the serialization format automatically
      - `serializer_debezium` [Block]. Serialize data in debezium json format
        - `serializer_parameters` [Block]. A list of Debezium parameters set by the structure of the `key` and `value`
 string fields
          - `key` (*Read-Only*) (String). Name of the serializer parameter
          - `value` (*Read-Only*) (String). Value of the serializer parameter
      - `serializer_json` [Block]. Empty block. Serialize data in json format
    - `topic_settings` [Block]. Target topic settings
      - `topic` [Block]. All messages will be sent to one topic
        - `save_tx_order` (*Read-Only*) (Bool). Save transactions order
 Not to split events queue into separate per-table queues.
        - `topic_name` (*Read-Only*) (String). Full topic name
      - `topic_prefix` (*Read-Only*) (String). Topic prefix
 Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>.
 Analogue of the Debezium setting database.server.name.
  - `metrika_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `counter_ids` (*Read-Only*) (List Of Number). Counter IDs
    - `streams` [Block]. Streams
      - `columns` (*Read-Only*) (List Of String). Column names
      - `type` (*Read-Only*) (String). Stream type, one of: METRIKA_STREAM_TYPE_HITS, METRIKA_STREAM_TYPE_VISITS,
 METRIKA_STREAM_TYPE_HITS_V2
    - `token` [Block]. Authentication token
      - `raw` (*Read-Only*) (String). Raw secret value
  - `mongo_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `collections` [Block]. List of collections for replication. Empty list implies replication of all
 tables on the deployment. Allowed to use * as collection name.
      - `collection_name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

      - `database_name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

        - `auth_source` (*Read-Only*) (String). Database name associated with the credentials
        - `connection_manager_connection` [Block]. Get StoreDoc/MongoDB installation params and credentials from Connection Manager
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `connection_id` (*Read-Only*) (String). ID of connectionmanager connection with mongodb/Yandex Storedoc installation
 parameters and credentials
          - `replica_set` (*Read-Only*) (String). Replica set name, used only for on-premise mongodb installations
        - `mdb_cluster_id` (*Read-Only*) (String). Identifier of the Yandex StoreDoc cluster
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
        - `on_premise` [Block]. Connection settings of the on-premise MongoDB server
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `hosts` (*Read-Only*) (List Of String). Host names of the replica set
          - `port` (*Read-Only*) (Number). TCP Port number
          - `replica_set` (*Read-Only*) (String). Replica set name
          - `tls_mode` [Block]. TLS settings for the server connection. Empty implies plaintext connection
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for user
          - `raw` (*Read-Only*) (String). Raw secret value
        - `user` (*Read-Only*) (String). User name, required unless connection_manager_connection is used
    - `excluded_collections` [Block]. List of forbidden collections for replication. Allowed to use * as collection
 name for forbid all collections of concrete schema.
      - `collection_name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

      - `database_name` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

    - `secondary_preferred_mode` (*Read-Only*) (Bool). Read mode for mongo client: whether the secondary server should be preferred to
 the primary when copying data
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
  - `mongo_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `cleanup_policy` (*Read-Only*) (String). How to clean collections when activating the transfer. One of `DISABLED`, `DROP`
 or `TRUNCATE`
    - `connection` [Block]. Connection settings
      - `connection_options` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mongo.proto

        - `auth_source` (*Read-Only*) (String). Database name associated with the credentials
        - `connection_manager_connection` [Block]. Get StoreDoc/MongoDB installation params and credentials from Connection Manager
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `connection_id` (*Read-Only*) (String). ID of connectionmanager connection with mongodb/Yandex Storedoc installation
 parameters and credentials
          - `replica_set` (*Read-Only*) (String). Replica set name, used only for on-premise mongodb installations
        - `mdb_cluster_id` (*Read-Only*) (String). Identifier of the Yandex StoreDoc cluster
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
        - `on_premise` [Block]. Connection settings of the on-premise MongoDB server
 Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
          - `hosts` (*Read-Only*) (List Of String). Host names of the replica set
          - `port` (*Read-Only*) (Number). TCP Port number
          - `replica_set` (*Read-Only*) (String). Replica set name
          - `tls_mode` [Block]. TLS settings for the server connection. Empty implies plaintext connection
            - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
            - `enabled` [Block]. TLS is used for the server connection
              - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
        - `password` [Block]. Password for user
          - `raw` (*Read-Only*) (String). Raw secret value
        - `user` (*Read-Only*) (String). User name, required unless connection_manager_connection is used
    - `database` (*Read-Only*) (String). Database name. If not empty, then all the data will be written to the database
 with the specified name; otherwise the database name is the same as in the
 source endpoint
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
  - `mysql_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Mysql installation params and credentials from Connection Manager
        - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (*Read-Only*) (String). Managed Service for MySQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise MySQL
        - `hosts` (*Read-Only*) (List Of String). List of host names of the MySQL server. Exactly one host is expected
        - `port` (*Read-Only*) (Number). Port for the database connection
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (*Read-Only*) (String). Name of the database to transfer

 You can leave it empty, then it will be possible to transfer tables from several
 databases at the same time from this source.
    - `exclude_tables_regex` (*Read-Only*) (List Of String). Opposite of `include_table_regex`. The tables matching the specified regular
 expressions will not be transferred
    - `include_tables_regex` (*Read-Only*) (List Of String). List of regular expressions of table names which should be transferred. A table
 name is formatted as schemaname.tablename. For example, a single regular
 expression may look like `^mydb.employees$`
    - `object_transfer_settings` [Block]. Schema migration
 Defines which database schema objects should be transferred, e.g. views,
 routines, etc.
 All of the attrubutes in the block are optional and should be either
 `BEFORE_DATA`, `AFTER_DATA` or `NEVER`."
      - `routine` (*Read-Only*) (String). Routines

 CREATE PROCEDURE ... ; CREATE FUNCTION ... ;
      - `tables` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/mysql.proto

      - `trigger` (*Read-Only*) (String). Triggers

 CREATE TRIGGER ...
      - `view` (*Read-Only*) (String). Views

 CREATE VIEW ...
    - `password` [Block]. Password for database access.
      - `raw` (*Read-Only*) (String). Raw secret value
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_database` (*Read-Only*) (String). Database for service tables
 Default: data source database. Here created technical tables (__tm_keeper,
 __tm_gtid_keeper).
    - `timezone` (*Read-Only*) (String). Database timezone

 Is used for parsing timestamps for saving source timezones. Accepts values from
 IANA timezone database. Default: local timezone.
    - `user` (*Read-Only*) (String). User for database access. Required unless connection manager connection is used
  - `mysql_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `cleanup_policy` (*Read-Only*) (String). Cleanup policy for activate, reactivate and reupload processes.
 One of `DISABLED`, `DROP` or `TRUNCATE` Default is `DISABLED`.
    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Mysql installation params and credentials from Connection Manager
        - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (*Read-Only*) (String). Managed Service for MySQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise MySQL
        - `hosts` (*Read-Only*) (List Of String). List of host names of the MySQL server. Exactly one host is expected
        - `port` (*Read-Only*) (Number). Port for the database connection
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (*Read-Only*) (String). Database name

 Allowed to leave it empty, then the tables will be created in databases with the
 same names as on the source. If this field is empty, then you must fill below db
 schema for service table.
    - `is_schema_migration_disabled` (*Read-Only*) (Bool). Whether can change table schema if schema changed on source
    - `password` [Block]. Password for database access.
      - `raw` (*Read-Only*) (String). Raw secret value
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_database` (*Read-Only*) (String). Database schema for service table
 Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).
    - `skip_constraint_checks` (*Read-Only*) (Bool). Disable constraints checks
 When `true`, disables foreign key checks and unique checks. `False` by default.
 See
 [foreign_key_checks](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_foreign_key_checks).
 Recommend to disable for increase replication speed unless schema contains
 cascading operations
    - `sql_mode` (*Read-Only*) (String). [sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html) to use when
 interacting with the server.
 Defaults to `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`
    - `timezone` (*Read-Only*) (String). Database timezone

 Is used for parsing timestamps for saving source timezones. Accepts values from
 IANA timezone database. Default: local timezone.
    - `user` (*Read-Only*) (String). User for database access. Required unless connection manager connection is used
  - `postgres_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `collapse_inherit_table` (*Read-Only*) (Bool). Will collapse pg_inherit table into one big table in replication process
    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Postgres installation params and credentials from Connection Manager
        - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (*Read-Only*) (String). Managed Service for PostgreSQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise PostgreSQL
        - `hosts` (*Read-Only*) (List Of String). PG installation hosts
        - `port` (*Read-Only*) (Number). PG port. Will be used if the cluster ID is not specified.
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (*Read-Only*) (String). Name of the database to transfer
    - `exclude_tables` (*Read-Only*) (List Of String). List of tables which will not be transfered, formatted as `schemaname.tablename`
 If omitted or empty list is specified, all tables are replicated.
 Can contain schema_name.* patterns.
    - `include_tables` (*Read-Only*) (List Of String). List of tables to transfer, formatted as `schemaname.tablename`.
 If omitted or an empty list is specified, all tables will be transferred.
 Can contain schema_name.* patterns.
    - `object_transfer_settings` [Block]. Defines which database schema objects should be transferred, e.g. views,
 functions, etc.
 All of the attributes in this block are optional and should be either
 `BEFORE_DATA`, `AFTER_DATA` or `NEVER`
      - `cast` (*Read-Only*) (String). Casts

 CREATE CAST ...
      - `collation` (*Read-Only*) (String). Collations

 CREATE COLLATION ...
      - `constraint` (*Read-Only*) (String). Constraints

 ALTER TABLE ... ADD CONSTRAINT ...
      - `default_values` (*Read-Only*) (String). Default values

 ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...
      - `fk_constraint` (*Read-Only*) (String). Foreign keys

 ALTER TABLE ... ADD FOREIGN KEY ...
      - `function` (*Read-Only*) (String). Functions

 CREATE FUNCTION ...
      - `index` (*Read-Only*) (String). Indexes

 CREATE INDEX ...
      - `materialized_view` (*Read-Only*) (String). Materialized views

 CREATE MATERIALIZED VIEW ...
      - `policy` (*Read-Only*) (String). Policies

 CREATE POLICY ...
      - `primary_key` (*Read-Only*) (String). Primary keys

 ALTER TABLE ... ADD PRIMARY KEY ...
      - `rule` (*Read-Only*) (String). Rules

 CREATE RULE ...
      - `sequence` (*Read-Only*) (String). Sequences

 CREATE SEQUENCE ...
      - `sequence_owned_by` (*Read-Only*) (String). Owned sequences

 CREATE SEQUENCE ... OWNED BY ...
      - `sequence_set` (*Read-Only*) (String). package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/postgres.proto

      - `table` (*Read-Only*) (String). Tables

 CREATE TABLE ...
      - `trigger` (*Read-Only*) (String). Triggers

 CREATE TRIGGER ...
      - `type` (*Read-Only*) (String). Types

 CREATE TYPE ...
      - `view` (*Read-Only*) (String). Views

 CREATE VIEW ...
    - `password` [Block]. Password for database access.
      - `raw` (*Read-Only*) (String). Raw secret value
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_schema` (*Read-Only*) (String). Name of the database schema in which auxiliary tables needed for the transfer
 will be created (__consumer_keeper, __data_transfer_mole_finder).
 Empty `service_schema` implies schema `public`
    - `slot_gigabyte_lag_limit` (*Read-Only*) (Number). Maximum WAL size held by the replication slot (API - in bytes, terraform - in
 gigabytes);
 Exceeding this limit will result in a replication failure and deletion of the
 replication slot.
 Default is 50 gigabytes
    - `user` (*Read-Only*) (String). User for database access. Required unless Connection Manager connection is used.
  - `postgres_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `cleanup_policy` (*Read-Only*) (String). Cleanup policy for activate, reactivate and reupload processes.
 One of: DISABLED, DROP, TRUNCATE. Default is TRUNCATE
    - `connection` [Block]. Database connection settings
      - `connection_manager_connection` [Block]. Get Postgres installation params and credentials from Connection Manager
        - `connection_id` (*Read-Only*) (String). ID of connection in Connection Manager with installation params and credetials
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
      - `mdb_cluster_id` (*Read-Only*) (String). Managed Service for PostgreSQL cluster ID
      - `on_premise` [Block]. Connection options for on-premise PostgreSQL
        - `hosts` (*Read-Only*) (List Of String). PG installation hosts
        - `port` (*Read-Only*) (Number). PG port. Will be used if the cluster ID is not specified.
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
    - `database` (*Read-Only*) (String). Target database name
    - `is_schema_migration_disabled` (*Read-Only*) (Bool). Whether can change table schema if schema changed on source
    - `password` [Block]. Password for database access.
      - `raw` (*Read-Only*) (String). Raw secret value
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `user` (*Read-Only*) (String). User for database access. Required unless Connection Manager connection is used
  - `ydb_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `authentication` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

      - `service_account` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

        - `service_account_id` (String). Service account ID for interaction with database
    - `changefeed_custom_consumer_name` (*Read-Only*) (String). Consumer for pre-created change feed if any
    - `changefeed_custom_name` (*Read-Only*) (String). Pre-created change feed if any
    - `database` (*Read-Only*) (String). Database path in YDB where tables are stored.
 Example: `/ru/transfer_manager/prod/data-transfer-yt`
    - `instance` (*Read-Only*) (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
 If not specified, will be determined by database
    - `paths` (*Read-Only*) (List Of String). A list of paths which should be uploaded. When not specified, all available
 tables are uploaded
    - `sa_key_content` (*Read-Only*) (String). Authorization Key
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_account_id` (String). Service account ID for interaction with database
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. If omitted, the server has to be accessible via Internet
    - `ydb_connection` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

      - `database_id` (*Read-Only*) (String). Managed Service for YDB database ID
      - `on_premise` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

        - `database` (*Read-Only*) (String). Database path in YDB where tables are stored.
 Example: `/ru/transfer_manager/prod/data-transfer`
        - `instance` (*Read-Only*) (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
  - `ydb_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `authentication` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

      - `service_account` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

        - `service_account_id` (String). Service account ID for interaction with database
    - `cleanup_policy` (*Read-Only*) (String). Cleanup policy determine how to clean collections when activating the transfer.
 One of `YDB_CLEANUP_POLICY_DISABLED` or `YDB_CLEANUP_POLICY_DROP`
    - `database` (*Read-Only*) (String). Database path in YDB where tables are stored.
 Example: `/ru/transfer_manager/prod/data-transfer`
    - `default_compression` (*Read-Only*) (String). Compression that will be used for default columns family on YDB table creation.
 One of `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`,
 `YDB_DEFAULT_COMPRESSION_DISABLED`, `YDB_DEFAULT_COMPRESSION_LZ4`
    - `instance` (*Read-Only*) (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
 If not specified, will be determined by database
    - `is_schema_migration_disabled` (*Read-Only*) (Bool). Whether can change table schema if schema changed on source
    - `is_table_column_oriented` (*Read-Only*) (Bool). Whether a column-oriented (i.e. OLAP) tables should be created.
 Default is `false` (create row-oriented OLTP tables)
    - `path` (*Read-Only*) (String). Path extension for database, each table will be layouted into this path
    - `sa_key_content` (*Read-Only*) (String). Authentication key
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_account_id` (String). Service account ID for interaction with database
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database.
 If omitted, the server has to be accessible via Internet
    - `ydb_connection` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

      - `database_id` (*Read-Only*) (String). Managed Service for YDB database ID
      - `on_premise` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/ydb.proto

        - `database` (*Read-Only*) (String). Database path in YDB where tables are stored.
 Example: `/ru/transfer_manager/prod/data-transfer`
        - `instance` (*Read-Only*) (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
  - `yds_source` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `allow_ttl_rewind` (*Read-Only*) (Bool). Should continue working, if consumer read lag exceed TTL of topic
 False: stop the transfer in error state, if detected lost data. True: continue
 working with losing part of data
    - `authentication` [Block]. Choose one of authentication methods, right now only service account is avaiable
      - `service_account_id` (String). Service account ID for interaction with database
    - `consumer` (*Read-Only*) (String). Custom consumer - for important streams
    - `database` (*Read-Only*) (String). Database path in YDB for streams
 Example: `/ru/transfer_manager/prod/data-transfer`
    - `endpoint` (*Read-Only*) (String). YDS Endpoint for dedicated db
    - `parser` [Block]. Data parsing rules
      - `audit_trails_v1_parser` [Block]. Parse Audit Trails data. Empty struct
      - `cloud_logging_parser` [Block]. Parse Cloud Logging data. Empty struct
      - `json_parser` [Block]. Parse data in json format
        - `add_rest_column` (*Read-Only*) (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (*Read-Only*) (Bool). Mark field as Primary Key
              - `name` (*Read-Only*) (String). Field name
              - `path` (*Read-Only*) (String). Path to the field
              - `required` (*Read-Only*) (Bool). Mark field as required
              - `type` (*Read-Only*) (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (*Read-Only*) (String). Description of the data schema as JSON specification
 Deprecated: please use fields instead
        - `null_keys_allowed` (*Read-Only*) (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (*Read-Only*) (Bool). Unescape string values
      - `tskv_parser` [Block]. Parse data in tskv format
        - `add_rest_column` (*Read-Only*) (Bool). Will add _rest column for all unknown fields
        - `data_schema` [Block]. Data parsing scheme
          - `fields` [Block]. Description of the data schema in the array of `fields` structure
            - `fields` [Block]. Description of the column schema in the array of `fields` structure
              - `key` (*Read-Only*) (Bool). Mark field as Primary Key
              - `name` (*Read-Only*) (String). Field name
              - `path` (*Read-Only*) (String). Path to the field
              - `required` (*Read-Only*) (Bool). Mark field as required
              - `type` (*Read-Only*) (String). Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
 `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
          - `json_fields` (*Read-Only*) (String). Description of the data schema as JSON specification
 Deprecated: please use fields instead
        - `null_keys_allowed` (*Read-Only*) (Bool). Allow null keys, if no - null keys will be putted to unparsed data
        - `unescape_string_values` (*Read-Only*) (Bool). Unescape string values
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `service_account_id` (String). Service account ID which has read access to the stream.
    - `stream` (*Read-Only*) (String). Stream to read
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. If omitted, the server has to be accessible via Internet
    - `supported_codecs` (*Read-Only*) (List Of String). List of supported compression codecs
 Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
 YDS_COMPRESSION_CODEC_GZIP
    - `ydb_connection` [Block]. Connection settings for managed YDB or for on premise
      - `managed_yds` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/yds.proto

        - `database_id` (*Read-Only*) (String). Managed Service for YDB database ID
        - `stream` (*Read-Only*) (String). Stream to read
      - `on_premise` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/yds.proto

        - `database` (*Read-Only*) (String). Database path in YDB where tables are stored.
 Example: `/ru/transfer_manager/prod/data-transfer`
        - `instance` (*Read-Only*) (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
        - `stream` (*Read-Only*) (String). Stream to read
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
  - `yds_target` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/endpoint.proto

    - `authentication` [Block]. Choose one of authentication methods, right now only service account is avaiable
      - `service_account_id` (String). Service account ID for interaction with database
    - `compression_codec` (*Read-Only*) (String). Codec to use for output data compression. If not specified, no compression will
 be done
 Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
 YDS_COMPRESSION_CODEC_GZIP
    - `database` (*Read-Only*) (String). Database path in YDB for streams
 Example: `/ru/transfer_manager/prod/data-transfer`
    - `endpoint` (*Read-Only*) (String). YDS Endpoint for dedicated db
    - `save_tx_order` (*Read-Only*) (Bool). Save transaction order
 Not to split events queue into separate per-table queues.
 Incompatible with setting Topic prefix, only with Topic full name.
    - `security_groups` (*Read-Only*) (List Of String). List of security groups that the transfer associated with this endpoint should
 use
    - `serializer` [Block]. Data serialization format
      - `serializer_auto` [Block]. Empty block. Select the serialization format automatically
      - `serializer_debezium` [Block]. Serialize data in debezium json format
        - `serializer_parameters` [Block]. A list of Debezium parameters set by the structure of the `key` and `value`
 string fields
          - `key` (*Read-Only*) (String). Name of the serializer parameter
          - `value` (*Read-Only*) (String). Value of the serializer parameter
      - `serializer_json` [Block]. Empty block. Serialize data in json format
    - `service_account_id` (String). Service account ID which has read access to the stream
    - `stream` (*Read-Only*) (String). Stream to write to
    - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
 database. If omitted, the server has to be accessible via Internet
    - `ydb_connection` [Block]. Connection settings for managed YDB or for on premise
      - `managed_yds` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/yds.proto

        - `database_id` (*Read-Only*) (String). Managed Service for YDB database ID
        - `stream` (*Read-Only*) (String). Stream to read
      - `on_premise` [Block]. package: yandex.cloud.datatransfer.v1.endpoint
filename: yandex/cloud/datatransfer/v1/endpoint/yds.proto

        - `database` (*Read-Only*) (String). Database path in YDB where tables are stored.
 Example: `/ru/transfer_manager/prod/data-transfer`
        - `instance` (*Read-Only*) (String). Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
        - `stream` (*Read-Only*) (String). Stream to read
        - `subnet_id` (*Read-Only*) (String). Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database.
 If omitted, the server has to be accessible via Internet
        - `tls_mode` [Block]. TLS settings for server connection. Disabled by default.
          - `disabled` [Block]. Empty block designating that the connection is not secured, i.e. plaintext
 connection
          - `enabled` [Block]. TLS is used for the server connection
            - `ca_certificate` (*Read-Only*) (String). CA certificate
 X.509 certificate of the certificate authority which issued the server's
 certificate, in PEM format. When CA certificate is specified, TLS is used to
 connect to the server. If CA certificate is empty, the server's certificate must
 be signed by a well-known CA
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).