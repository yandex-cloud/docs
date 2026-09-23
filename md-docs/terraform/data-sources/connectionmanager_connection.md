[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Connection Manager > Data Sources > connectionmanager_connection

# yandex_connectionmanager_connection (DataSource)

A Connection resource represents a configured connection to a database or service.


## Arguments & Attributes Reference

- `can_use` (*Read-Only*) (Bool). Whether the current user can use this connection. Filled only when `with_can_use` has been requested in ListConnectionRequest.
- `connection_id` (String). ID of the connection to retrieve.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `created_by` (*Read-Only*) (String). ID of the subject which created the connection.
- `description` (*Read-Only*) (String). Description of the connection.
- `folder_id` (String). ID of the folder that the connection belongs to.
- `id` (String). ID of the connection to retrieve.
- `is_managed` (*Read-Only*) (Bool). Whether this connection is managed by the system (e.g. an MDB cluster).
- `labels` (*Read-Only*) (Map Of String). Connection labels as `key:value` pairs.
- `lockbox_secret` [Block]. Reference to the Lockbox secret containing connection credentials.
  - `connection_id` (*Read-Only*) (String). ID of the Lockbox secret.
  - `id` (String). ID of the Lockbox secret.
  - `newest_version` (*Read-Only*) (String). The newest available version of the Lockbox secret.
  - `version` (*Read-Only*) (String). Lockbox secret version.
- `lockbox_secret_spec` [Block]. Specification for creating a new Lockbox secret.
  - `folder_id` (String). ID of the folder where the Lockbox secret will be created. If omitted, the secret will be created in the connection's folder.
- `name` (*Read-Only*) (String). Name of the connection.
- `params` [Block]. Connection parameters specific to the database or service type.
  - `clickhouse` [Block]. ClickHouse database connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `http_port` (*Read-Only*) (Number). depends on tls params may vary as http or https
        - `shard_name` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `tcp_port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

      - `shard_groups` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `name` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `shard_names` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/clickhouse.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
  - `greenplum` [Block]. Greenplum data warehouse connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `coordinator_hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

        - `role` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/greenplum.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
  - `kafka` [Block]. Apache Kafka message broker connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

      - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

      - `sasl` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `supported_mechanisms` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/kafka.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
  - `mongodb` [Block]. MongoDB database connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

      - `auth_source` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

        - `role` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

        - `type` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mongodb.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
  - `mysql` [Block]. MySQL database connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

        - `role` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/mysql.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
  - `opensearch` [Block]. OpenSearch search engine connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

        - `roles` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/opensearch.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
  - `postgresql` [Block]. PostgreSQL database connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

        - `replica_type` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

        - `role` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/postgresql.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
  - `redis` [Block]. Redis in-memory data store connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

    - `cluster` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

        - `role` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

        - `shard_name` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

      - `sentinel_port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/redis.proto

  - `storedoc` [Block]. StoreDoc document store connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

      - `auth_source` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

        - `role` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

        - `type` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/storedoc.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is mutually
 exclusive with "cluster".
  - `trino` [Block]. Trino distributed SQL query engine connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/trino.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/trino.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `cluster` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/trino.proto

      - `coordinator` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/trino.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/trino.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/trino.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/trino.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

  - `valkey` [Block]. Valkey in-memory data store connection parameters.
    - `auth` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

      - `user_password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

        - `password` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

          - `lockbox_secret_key` (*Read-Only*) (String). Read-only. Do not fill this field in create/update requests.
          - `password_generation_options` [Block]. When creating/updating Password, the field "password_generation_options"
 is mutually exclusive with "raw". In order to switch to the
 "password_generation_options" you have to explicitly clear the "raw"
 field.
            - `cookie` (*Read-Only*) (String). Cookie is an arbitrary non-sensitive string that is saved with the
 password. When updating PasswordGenerationOptions, if the cookie passed
 in the update request differs from the cookie in the current
 PasswordGenerationOptions, the password will be re-generated. If the
 same cookie is passed, the password will not change.
            - `lockbox_password_generation_options` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

              - `excluded_punctuation` (*Read-Only*) (String). a string of punctuation characters to exclude from the default
              - `include_digits` (*Read-Only*) (Bool). whether at least one 0..9 character is included in the password, true by default
              - `include_lowercase` (*Read-Only*) (Bool). whether at least one a..z character is included in the password, true by default
              - `include_punctuation` (*Read-Only*) (Bool). whether at least one punctuation character is included in the password, true by default
 punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 to customize the punctuation characters, see included_punctuation and excluded_punctuation below
              - `include_uppercase` (*Read-Only*) (Bool). whether at least one A..Z character is included in the password, true by default
              - `included_punctuation` (*Read-Only*) (String). If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
 a string of specific punctuation characters to use
              - `length` (*Read-Only*) (Number). password length; by default, a reasonable length will be decided
          - `raw` (*Read-Only*) (String). When creating/updating Password, the field "raw" is mutually exclusive
 with "password_generation_options". In order to switch to the "raw"
 password you have to explicitly clear the "password_generation_options"
 field.
        - `user` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

    - `cluster` [Block]. When creating/updating Connection, the field "cluster" is mutually
 exclusive with "managed_cluster_id".
      - `hosts` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

        - `health` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

        - `host` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

        - `port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

        - `role` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

        - `shard_name` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

      - `sentinel_port` (*Read-Only*) (Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

      - `tls_params` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

        - `disabled` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

        - `tls` [Block]. package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

          - `ca_certificate` (*Read-Only*) (String). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/common.proto

    - `databases` (*Read-Only*) (List Of Number). package: yandex.cloud.connectionmanager.v1
filename: yandex/cloud/connectionmanager/v1/valkey.proto

    - `managed_cluster_id` (*Read-Only*) (String). When creating/updating Connection, the field "managed_cluster_id" is
 mutually exclusive with "cluster".
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Last update timestamp.