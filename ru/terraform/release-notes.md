---
sourcePath: ru/terraform/tf-ref/yandex-cloud/release-notes.md
---
## 0.146.0 (July 15, 2025)

FEATURES:
* kafka: `enabled` flag in `ClusterConfig.kafka_ui_config`
* audit_trails: yandex_audit_trails_trail renamed field only_recursive_queries to include_nonrecursive_queries
* ydb_topic: add autopartitioning for topics
* storage: add `yandex_storage_bucket_policy` resource.
* YandexDataProcessing: add autoscaling_service_account_id field

ENHANCEMENTS:
* yq: add sweeper tests
* gitlab: add update instance resource support
* storage: deprecate `yandex_storage_bucket.policy`
* storage: deprecate `grant` and `acl` attributes of `yandex_storage_bucket` resource

## 0.145.0 (July 1, 2025)

FEATURES:
* storage: add `yandex_storage_bucket_grant` resource.
* yq: initial support for Yandex Query service: monitoring, object storage, yds, ydb support
* alb: add regex rewrite to http route action
* storage: add `yandex_storage_bucket_iam_binding` resource.

BUG FIXES:
* compute: fix updating filesystem for instance groups
* kafka: fix user resource state corruption on creation failure by removing temporary ID assignment
* kafka: resolve secret_access_key terraform drift in S3 sink connector

ENHANCEMENTS:
* postgresql: remove deprecated field "extension.version" from database resource
* compute: add descriptions for instance group fields
* postgresql: ignore disk size decrease when disk autoscaling is enabled
* postgresql: human readable auto_explain_log_format instead of integers

## 0.144.0 (June 19, 2025)

FEATURES:
* redis: add `yandex_mdb_redis_user` resource and data-source
* managed_metastore: added resource, datasource, acc-tests, docs
* trino: added 'yandex_trino_cluster' resources
* gitlab: Added instance resource and datasource
* kubernetes: added resources `yandex_kubernetes_cluster_iam_binding` and `yandex_kubernetes_cluster_iam_member`
* trino: added 'yandex_trino_catalog' resource and data-source
* redis: ignore decreasing disk size on autoscaling
* mongodb: ignore decreasing disk size on autoscaling
* alb: added auto_scale_policy field to resourse 'yandex_alb_load_balancer'

BUG FIXES:
* mysql: no changes detected on mysql cluster creation when maintenance_window = ANYTIME
* postgresql: no changes detected on postgresql cluster creation when maintenance_window = ANYTIME
* kafka: fix bug with downgrade disk after its autoscale
* postgresql: fix bug leading to panic when user has permissions to non-existent database
* postgresql: fix postgresql settings loss on versions 16-1c and 17-1c

## 0.143.0 (June 3, 2025)

FEATURES:
* YandexDataProcessing: added oslogin field
* audit_trails: yandex_audit_trails_trail added new field dns_filter

BUG FIXES:
* mysql: exception on cluster_v2 creation without description

## 0.142.0 (May 22, 2025)

FEATURES:
* serverless_eventrouter: timer connector
* spark: added `yandex_spark_cluster` resource
* backup: add run_later, sector_by_sector, validation_enabled, lvm_snapshotting_enabled boolean settings to backup policy resource
* backup: deprecate preserve_file_security_settings and quiesce_snapshotting_enabled in backup policy resource

BUG FIXES:
* greenplum: fix issue with `logging` attribute
* kafka: fix update of `enabled` flag in `ClusterConfig.rest_api`
* clickhouse: fix inconsistent result after apply in yandex_mdb_clickhouse_user without settings block
* postgresql: fixing validation error when trying to add an shared preload library that is not present in older versions of postgres
* redis: fix bug with non supported empty zset_max_listpack_entries
* backup: fix error in backup policy resource 
* postgresql: fix removing fields from user settings
* postgresql: exception on cluster_v2 creation without description

ENHANCEMENTS:
* clickhouse: add timeouts block to yandex_mdb_clickhouse_user resource

WARNING:
* kafka: deprecate `log_preallocate` attribute in `kafka_config` attribute in `kafka` entity of `yandex_mdb_kafka_cluster` resource and data source.
* kafka: deprecate `preallocate` attribute in `topic_config` entity of `yandex_mdb_kafka_topic` resource and data source.
* clickhouse: deprecated user and database blocks in yandex_mdb_clickhouse_cluster in favor of new separated resources

## 0.141.0 (April 28, 2025)

FEATURES:
* kafka: add new kafka-user role ACCESS_ROLE_TOPIC_ADMIN
* kafka: `enabled` flag in `ClusterConfig.rest_api`
* clickhouse: generate password using Connection Manager for new user resource
* redis: add "auth_sentinel" attribute and "zset_max_listpack_entries" to resources and datasources
* airflow: possibility to specify maintenance window and versions of Apache Airflow and Python
* alb: add "allow_zonal_shift" attribute to yandex_alb_load_balancer resource and datasource
* IAM: added new resource yandex_iam_workload_identity_oidc_federation_iam_binding

BUG FIXES:
* clickhouse: create shard with correct weight without update
* clickhouse: added retries for API requests with unavailable error codes
* postgresql: fix disabling access flags
* redis: fix update access flags
* connection_manager: fix (known after apply) plan diff on each terraform apply for clusters without connman integration
* postgresql: fix cluster poolerConfig update masks

## 0.140.1 (April 3, 2025)

BUG FIXES:
* connection_manager: fix NPE for clickhouse, mysql and postgresql clusters without connection-manager integration

## 0.140.0 (March 31, 2025)

FEATURES:
* postgresql: generate password using Connection Manager
* greenplum: add `service_account_id` to acceess Yandex Cloud resources. Add `logging` resource to configure logs delivery to Yandex Cloud Logging.
* network_load_balancer: added `allow_zonal_shift` option
* mysql: generate password using Connection Manager
* provider: new retry policy
* ydb: yandex_ydb_database_dedicated add new field security_group_ids
* clickhouse: generate password using Connection Manager
* airflow: added `yandex_airflow_cluster` datasource
* provider: update retry throttling policy
* ymq: add field "tags" to yandex_message_queue
* iot: added attribute `labels` to resource and datasource yandex_iot_core_device

BUG FIXES:
* clickhouse: fix docs example for user and database resources

ENHANCEMENTS:
* airflow: added acceptance tests and docs for resource and datasource

## 0.139.0 (February 27, 2025)

FEATURES:
* clickhouse: added `jdbc_bridge` setting for server configuration
* clickhouse: new resource and datasource `yandex_mdb_clickhouse_database`
* clickhouse: new resource and datasource `yandex_mdb_clickhouse_user`
* greenplum: remove old 6.22 Greenplum version support
* greenplum: support new Greenplum config parameters "gp_enable_global_deadlock_detector" and "gp_global_deadlock_detector_period"
* backup: add to `yandex_backup_policy` file_filters setting

BUG FIXES:
* resource_vpc_security_group_rule: fix resource import from v0.129.0 and earlier

ENHANCEMENTS:
* provider: updated yandex cloud go sdk version
* yandex_ydb_table_changefeed: change TypeSet to TypeList for best performance

## 0.138.0 (February 14, 2025)

BUG FIXES:
* redis: fix panic in terraform provider when applying or importing cluster with empty client_output_buffer_limit settings

## 0.137.0 (February 11, 2025)

FEATURES:
* iam: added attributes `scopes` for API Key
* iam: added `update` method for for API Key
* serverless: `yandex_serverless_container` resource and data source now have `metadata_options` parameter
* serverless: `yandex_function` resource and data source now have `metadata_options` parameter
* mongodb: added web_sql access

BUG FIXES:
* postgresql: the timeout for the cluster creation request is at least 5 minute
* datasphere: removed unused `commit_mode` and `ide` attributes of yandex_datasphere_project resource causing import crashes

## 0.136.0 (January 30, 2025)

FEATURES:
* OrganizationManager: Added resources for organization manager group mapping and group mapping items
* YandexDataProcessing: Added log_group_id field
* YandexDataProcessing: Added environment field
* CertificateManager: added resources `yandex_cm_certificate_iam_binding` and `yandex_cm_certificate_iam_member`
* Lockbox: added resource `yandex_lockbox_secret_iam_member`
* KMS: added resources `yandex_kms_symmetric_key_iam_member`, `yandex_kms_asymmetric_signature_key_iam_member` and `yandex_kms_asymmetric_encryption_key_iam_member`

BUG FIXES:
* yandex_ydb_table_changefeed: fix cdc import
* smartcapcha: fix documentation for the resource and datasource
* IAM: remove field length validation for WLI resources and data-sources
* clickhouse: fix enable_ssl_certificate_verification setting on update
* resource_yandex_compute_instance: remove allow_stopping_for_update for instance file system changes

ENHANCEMENTS:
* YandexDataProcessing: Actualize name of Yandex Data Processing service

## 0.135.0 (December 18, 2024)

FEATURES:
* kafka: `mdb_kafka_cluster` resource and data source now have `kraft` parameter`
* compute: support disk encryption

BUG FIXES:
* audit_trails: `yandex_audit_trails_trail` fixed excluded_events block handling
* loadtesting: fix terraform import acceptance test

ENHANCEMENTS:
* opensearch: use state hosts when no changes in node-groups configuration

WARNING:
* clickhouse: field `service_account_id` is no longer requested from cluster configuration and will alwayse be update to the set value from resource
* postgresql: deprecate `host.priority` and `host_master_name` fields.

## 0.134.0 (December 3, 2024)

FEATURES:
* redis: add parameters use_luajit and io_threads_allowed
* redis: added 9 new parameters to config spec
* alb: add keep_connections_on_host_health_failure flag to yandex_alb_backend_group stream backend.
* serverless: `yandex_serverless_container` resource and data source now have `runtime` parameter
* cdn: add labels in cdn resource schema
* alb: add support of custom healthcheck statuses for backend group http healthcheck

BUG FIXES:
* serverless: `yandex_serverless_container` resource and data source now correctly handle absence of revision

## 0.133.0 (November 19, 2024)

FEATURES:
* alb: add rate limiter to virtual host
* serverless: added new resources yandex_serverless_eventrouter_bus, yandex_serverless_eventrouter_connector, yandex_serverless_eventrouter_rule
* serverless: added new data sources yandex_serverless_eventrouter_bus, yandex_serverless_eventrouter_connector, yandex_serverless_eventrouter_rule
* alb: add `idle_timeout` attribute for Stream and TLS Stream handlers
* postgresql: add postgresql 17 support

BUG FIXES:
* serverless: `yandex_function` resource and data source now correctly handle absence of version
* lockbox: `yandex_lockbox_secret` no longer creates versions on its own.
* clickhouse: fixed adding two hosts with same zone instead of one
* ClickHouse: fix yandex_mdb_clickhouse_cluster segfault on empty kafka settings

ENHANCEMENTS:
* vpc: improve security_group_rule validation

## 0.132.0 (November 5, 2024)

FEATURES:
* Marketplace: **New Resource**: `yandex_kubernetes_marketplace_helm_release`
* IAM: add `yandex_organizationmanager_saml_federation.security_settings.force_authn` parameter
* IAM: make `yandex_organizationmanager_saml_federation.security_settings.encrypted_assertions` optional and computed

BUG FIXES:
* compute: Fix wrong argument name in host_affinity_rules block, from "value" to "values" in docs and templates.
* serverless: fixed `yandex_serverless_container` `concurrency` attribute handling
* serverless: fixed `yandex_function` resource's `execution_timeout` attribute handling
* serverless: fix error handling for incorrect parameters in ymq triggers

ENHANCEMENTS:
* provider: updated yandex cloud go sdk version

## 0.131.0 (October 22, 2024)

FEATURES:
* redis: added backup_window_start
* loadtesting: added `log_settings` parameter group and `log_group_id` parameter to `log_settings` in `resource_yandex_loadtesting_agent` resource.

BUG FIXES:
* compute: fix bug with update instance network interfaces
* storage: fix use of iam token instead of creds
* opensearch: fix managing empty in `description`
* yandex_ydb_topic: fix conflicts in schema
* yandex_ydb_coordination: fix path
* yandex_ydb_table: fix ttl units (max week)

ENHANCEMENTS:
* vpc: allow inplace update of security_group_rule resource

## 0.130.0 (October 8, 2024)

FEATURES:
* greenplum: add background_activities configs: analyze&vacuum and query_killers script configs
* clickhouse: added `background_move_pool_size`, `background_distributed_schedule_pool_size` for server configuration
* clickhouse: added `background_buffer_flush_schedule_pool_size`, `background_common_pool_size` for server configuration
* clickhouse: added `number_of_free_entries_in_pool_to_execute_mutation` for merge tree configuration
* clickhouse: added `allow_remote_fs_zero_copy_replication`, `max_bytes_to_merge_at_max_space_in_pool` for merge tree configuration
* clickhouse: added `inactive_parts_to_delay_insert`, `inactive_parts_to_throw_insert` for merge tree configuration
* clickhouse: added `format_regexp_skip_unmatched`, `format_regexp`, `date_time_output_format` for user settings
* clickhouse: added `input_format_with_names_use_header`, `input_format_null_as_default`, `any_join_distinct_right_table_keys` for user settings
* clickhouse: added `join_algorithm` for user settings
* clickhouse: added `session_log_retention_time`, `zookeeper_log_enabled`, `zookeeper_log_retention_size` for server configuration
* clickhouse: added `zookeeper_log_retention_time` for server configuration
* clickhouse: added `backup_retain_period_days` for cluster settings 
* clickhouse: added `date_time_input_format` for user settings
* clickhouse: added `opentelemetry_span_log_enabled`, `opentelemetry_span_log_retention_size` for server configuration
* clickhouse: added `opentelemetry_span_log_retention_time`, `query_views_log_enabled` for server configuration
* clickhouse: added `query_views_log_retention_size`, `query_views_log_retention_time`, asynchronous_metric_log_enabled` for server configuration
* clickhouse: added `asynchronous_metric_log_retention_size`, `asynchronous_metric_log_retention_time` for server configuration
* clickhouse: added `session_log_enabled`, `session_log_retention_size`, `session_log_retention_time` for server configuration
* clickhouse: added `zookeeper_log_enabled`, `zookeeper_log_retention_size`, `zookeeper_log_retention_time` for server configuration
* clickhouse: added `asynchronous_insert_log_enabled`, `asynchronous_insert_log_retention_size` for server configuration
* clickhouse: added `asynchronous_insert_log_retention_time` for server configuration
* object_storage: iam integration, access_key and secret_key are optional now
* greenplum: add `master_host_group_ids` and `segment_host_group_ids` for greenplum cluster configureation
* clickhouse: added `insert_quorum_parallel`, `deduplicate_blocks_in_dependent_materialized_views` for user settings
* SmartWebSecurity: **New Resource:** `yandex_sws_waf_profile`
* SmartWebSecurity: **New Resource:** `yandex_sws_advanced_rate_limiter_profile`
* SmartWebSecurity: **New Data Source:** `yandex_sws_waf_profile`
* SmartWebSecurity: **New Data Source:** `yandex_sws_advanced_rate_limiter_profile`
* SmartWebSecurity: **New Data Source:** `yandex_sws_waf_rule_set_descriptor`
* SmartWebSecurity: added documentation for SmartWebSecurity providers
* SmartCaptcha: added documentation for SmartCaptcha providers
* lockbox: `password_payload_specification` support
* backup: yandex_backup_policy_bindings check provider activated
* compute: added `hardware_generation` to resources and data sources `yandex_compute_image`, `yandex_compute_disk`, `yandex_compute_snapshot`
* compute: added read only `hardware_generation` to the resource and data source `yandex_compute_instance`

BUG FIXES:
* postgresql: ix no changes when drop all permissions for user
* serverless: fixed log_options attribute diff generation
* clickhouse: actualize ClickHouse versions in tests
* redis: fix access options on update
* opensearch: improve handling "outside" changes and fix issue with inconsistent result after apply in `subnet_ids`
* vpc: fixed processing of yandex_vpc_private_endpoint.endpoint_address
* opensearch: fix nil pointer dereference while delete dashboards
* mongodb: handle deleted user from not terraform for terraform resource

ENHANCEMENTS:
* audit_trails: yandex_audit_trails_trail added new field filtering_policy
* mdb: Support `NetworkId` field in `UpdateClusterRequest` by `resource_yandex_mdb_*_cluster`
* object_storage: encapsulate all s3 logic in one module
* loadtesting: add computed_labels parameter for yandex_loadtesting_agent resource
* provider: migrate to semi-generated documentation

## 0.129.0 (September 10, 2024)

FEATURES:
* IAM: added new resources `yandex_iam_workload_identity_federated_credential` and `yandex_iam_workload_identity_oidc_federation`
* IAM: added new data sources `yandex_iam_workload_identity_federated_credential` and `yandex_iam_workload_identity_oidc_federation`
* serverless: added object `mounts` to the resource and data source `yandex_function`
* serverless: added object `mounts` to the resource and data source `yandex_serverless_container`
* greenplum: added `yandex_query` to `access` section.
* vpc: added `yandex_vpc_private_endpoint` resource
* iam: added attributes `scope` and `expires_At` for API Key
* vpc: added `yandex_vpc_private_endpoint` data source
* redis: added web_sql and data_lens access
* airflow: added `yandex_airflow_cluster` resource

BUG FIXES:
* redis: fix tests for update redis version
* yandex_message_queue: S3 API response deserialization error was fixed

ENHANCEMENTS:
* yandex_object_storage: reduce retry time for object storage resources
* opensearch: change type for `subnet_ids` field from `set` to `list`
* iam: `yandex_iam_service_account_static_access_key` also includes `access_key` in `output_to_lockbox`
* iam: when IAM key is removed (or `output_to_lockbox` modified), the Lockbox version is destroyed

WARNING:
* serverless: object `storage_mounts` marked as DEPRECATED in the resource and data source `yandex_function`
* serverless: object `storage_mounts` marked as DEPRECATED in the resource and data source `yandex_serverless_container`

## 0.128.0 (August 30, 2024)

FEATURES:
* mongodb: added `disk_size_autoscaling` support for all host types in `resource_yandex_mdb_mongodb_cluster`
* iam: added data source `yandex_iam_service_agent`
* clickhouse: added `log_query_threads`, `max_insert_threads`, `use_hedged_requests`, `idle_connection_timeout` for user settings
* clickhouse: added `hedged_connection_timeout_ms`, `load_balancing`, `prefer_localhost_replica` for user settings
* clickhouse: added `merge_max_block_size`, `check_sample_column_is_correct` for merge tree configuration
* clickhouse: added `max_merge_selecting_sleep_ms`, `max_cleanup_delay_period` for merge tree configuration
* clickhouse: added `path_column_name`, `time_column_name`, `value_column_name`, `version_column_name` for graphite configuration
* clickhouse: added `debug`, `auto_offset_reset` for kafka integration settings
* clickhouse: added `query_masking_rules`, `dictionaries_lazy_load`, `query_cache` for server configuration

BUG FIXES:
* ycp_ydb_topic: fix issues with topics
* yandex_organizationmanager_saml_federation_user_account: Fix provider crashing on missing federation claim
* yandex_lockbox_secret_iam_binding: fix error on empty members list

ENHANCEMENTS:
* redis: allow zero value for `disk_size_limit` to disable disk size autoscaling

## 0.127.0 (August 13, 2024)

FEATURES:
* backup: added `yandex_backup_policy_bindings` resource
* opensearch: add `node_group` name to `hosts` list
* iam: `yandex_iam_service_account_key`, `yandex_iam_service_account_api_key` and `yandex_iam_service_account_static_access_key` now can use `output_to_lockbox`
* mongodb: migrate api to unified config
* storage: support `object_size_greater_than`, `object_size_less_than` in bucket lifecycle configuration in `yandex_storage_bucket` resource
* opensearch: allow setting saml authorization for dashboards
* datatransfer: added clickhouse_cluster_name setting for clickhouse endpoints

BUG FIXES:
* lockbox: yandex_lockbox_secret_version and yandex_lockbox_secret_version_hashed will schedule version deletion
* opensearch: empty or missing desription and/or labels fields will no longer cause an error
* opensearch: fix error while first add dashboards to the existing cluster
* opensearch: fix inconsistent result after apply for labels, description and security_group_ids fields

ENHANCEMENTS:
* serverless: Added provision_policy to serverless containers
* YDBTopics: add missing documentation parameters
* postgresql: pass UpdateMask in PostgreSQL Update Database Request
* compute: support `auto_scale_type` in `scale_policy.auto_scale` in `compute_instance_group` resource and datasource

## 0.126.0 (July 30, 2024)

FEATURES:
* redis: added `disk_size_autoscaling` field for update method in `resource_yandex_mdb_redis_cluster`
* opensearch: allow apply changes in `zone_ids` and/or `network_ids` with other changes, also allow change `assign_public_ip` 
* backup: make `yandex_backup_policy` data source by name

BUG FIXES:
* opensearch: fixed apply changes when `plugins` missing
* opensearch: update state when no changes in config section
* opensearch: unexpected plugins null value after apply
* yandex_compute_instance: disabled recreating instance on update gpus

ENHANCEMENTS:
* kubernetes: deprecate version 1.26

## 0.124.0 (July 16, 2024)

FEATURES:
* backup: added `yandex_backup_policy` data source
* kafka: added `disk_size_autoscaling` field for update method in `resource_yandex_mdb_kafka_cluster`
* backup: add scheduling backup sets, fix max_count retention rule
* opensearch: migrate from SDKv2 to framework. Improve plan output.

BUG FIXES:
* storage: fix cancellation in bucket operation retries
* functions: unsupported loggroup_id field is removed from function schema
* opensearch: fix remove/add network acceptance test

ENHANCEMENTS:
* kafka: disabled recreation of kafka cluster after updating `disk_type_id` field in `resource_yandex_mdb_kafka_cluster`

## 0.123.0 (July 2, 2024)

FEATURES:
* mongodb: support host_parameters and update hosts operation
* Serverless: add concurrency in function resource schema and data source function schema
* serverless: added `execution_timeout` attribute to `api_gateway` resource and data source
* SmartWebSecurity: **New Resource:** `yandex_sws_security_profile`
* SmartCaptcha: **New Resource:** `yandex_smartcaptcha_captcha`
* SmartWebSecurity: **New Data Source:** `yandex_sws_security_profile`
* SmartCaptcha: **New Data Source:** `yandex_smartcaptcha_captcha`
* compute: add access binding resource for `disk` resource.
* compute: add access binding resource for `disk_placement_group` resource.
* compute: add access binding resource for `file_system` resource.
* compute: add access binding resource for `gpu_cluster` resource.
* compute: add access binding resource for `image` resource.
* compute: add access binding resource for `instance` resource.
* compute: add access binding resource for `placement_group` resource.
* compute: add access binding resource for `snapshot` resource.
* compute: add access binding resource for `snapshot_schedule` resource.

BUG FIXES:
* ClickHouse: enable copy_schema_on_new_hosts by default

## 0.122.0 (June 19, 2024)

BUG FIXES:
* opensearch: fix opensearch acceptance test
* alb: fix panic error in Grpc Healthcheck

ENHANCEMENTS:
* provider: freeze goreleaser version
* postgresql: update PostgreSQL Host tests
## 0.121.0 (June 5, 2024)

FEATURES:
* ydb: add imortant consumer flag to yandex_ydb_topic

## 0.120.0 (June 4, 2024)

FEATURES:
* **New Resource:** `yandex_lockbox_secret_version_hashed` that stores sensitive values in hash form
* k8s: fix to pass `AllocationPolicy.Location` config during update as is

BUG FIXES:
* opensearch: allow change zone_ids and subnet_ids
* clickhouse: check Cloud Storage data cache parameters
* postgresql create: set disk_size_autoscaling after cluster is created
* Actualize ClickHouse versions in tests

ENHANCEMENTS:
* postgresql: add exponential retry for all MDB().PostgreSQL().Cluster().ListHosts calls
* opensearch: improve acceptance tests
* datatransfer: added `metrika_source` in `yandex_datatransfer_endpoint` resource.
* provider: upgrade go version to 1.21
* increase timeouts for `mongodb` and `redis` resources
* opensearch: add retry on conflicting operation error

## 0.119.0 (May 21, 2024)

FEATURES:
* postgresql: add 15-1c support

ENHANCEMENTS:
* alb: suppress diff for empty object and nil value of http listener redirect object;
* loadtesting: added `platform_id` parameter for `yandex_loadtesting_agent` resource

## 0.118.0 (May 15, 2024)

FEATURES:
* no diff on migrate mongodb users to separate resource
* clickhouse: batch hosts creation and deletion
* Add support for attach detach instance network interfaces

BUG FIXES:
* clickhouse: save implicit zookeeper subcluster on hosts changes
* redis: fix bug with enable sharding, no longer recreates cluster
* serverless: fixed yandex_function_scaling_policy resource import

ENHANCEMENTS:
* clarified id value in the documentation for `yandex_alb_virtual_host` resource

## 0.117.0 (April 25, 2024)

FEATURES:
* add provider_cname in cdn resource schema and set it for read and update operations.

ENHANCEMENTS:
* opensearch: add `hosts` computed attribute
* opensearch: replace deprecated methods and logger 

## 0.116.0 (April 18, 2024)

FEATURES:
* add MongoDB parameter minSnapshotHistoryWindowInSeconds
* serverless: support `tmpfs_size` attribute in `yandex_function` resource

BUG FIXES:
* storage: added grant validation in `yandex_storage_bucket` resource
* terraform import resource_yandex_mdb_postgresql_cluster fix
* fix documentation for `yandex_cm_certificate` resource
* clickhouse: fixed default shard-name parameter when create cluster

## 0.115.0 (April 10, 2024)

FEATURES:
* mongodb: added delete timeout
* mongodb: added DISABLED value to net.Compressors

BUG FIXES:
* update terraform-plugin-framework terraform-plugin-mux
* fix test in yandex_mdb_mongodb_user 
* fix nil pointer panic during the process of the opensearch resource deployment

ENHANCEMENTS:
* loadtesting: added `update` method for `yandex_loadtesting_agent` resource
* add exponential MDB().PostgreSQL().Cluster().ListHosts() retry
* added seffion affinity documentation for `yandex_alb_backend_group` resource and datasource

## 0.114.0 (April 3, 2024)

BUG FIXES:
* yandex_ydb_table_changefeed: change `supported_codecs` type.
* vpc: fixed parameters of `dns_record` in `yandex_vpc_update` resource
* redis: fixed `upgrade` version problem
* postgresql: host.name field changing works

ENHANCEMENTS:
* dns: added `deletion_protection` parameter to `yandex_dns_zone` resource and datasource.
* kms: support for resolving by name in `yandex_kms_symmetric_key` data source

## 0.113.0 (March 26, 2024)

FEATURES:
* **New Resource:** `yandex_audit_trails_trail`
* **New Data Source:** `yandex_audit_trails_trail`
* serverless: complete update support for triggers

BUG FIXES:
* greenplum: fixed `pxf_config` fetching in yandex_mdb_greenplum_cluster datasource.

ENHANCEMENTS:
* loadtesting: added `labels` parameter to `yandex_loadtesting_agent` resource.
* compute: change `secondary_disk` attribute type from List to Set in `instance` resource.
* greenplum: fixed `pxf_config` fetching in yandex_mdb_greenplum_cluster datasource.
* vpc: allow to change cidrs in subnet (v4_cidr_blocks)
* vpc: add `dns_record` attribute in `yandex_vpc_address` resource and data source

## 0.112.0 (March 12, 2024)
BUG FIXES:
* open_search: fix nil pointer panic during the process of the yandex_mdb_opensearch_cluster resourse deployment
* mongodb: fix empty default mongod/mongos compressors
* storage: removed default value from optional `object_lock_legal_hold_status` attribute in `object` resource

ENHANCEMENTS:
* datatransfer: added `yds_source` and `yds_target` in `yandex_datatransfer_endpoint` resource.
* datatransfer: added `runtime` and `transformation` parameters in `yandex_datatransfer_transfer` resource.
* datatransfer: added `changefeed_custom_name` parameter to ydb_source in `yandex_datatransfer_endpoint` resource.
* datatransfer: added `unescape_string_values` parameter to `tskv_parser` and `json_parser` in `yandex_datatransfer_endpoint` resource.
* kubernetes: deprecate version 1.25

## 0.111.0 (March 06, 2024)
BUG FIXES:
* k8s: fixed type of EtcdClusterSize

## 0.110.0 (March 04, 2024)
FEATURES:
* **New Resource:** `yandex_dns_zone_iam_binding`
* compute: support `metadata_options` in `instance_template` in `compute_instance_group` resource and datasource

ENHANCEMENTS:
* ydb: add documentation for `yandex_ydb_table_changefeed` and `yandex_ydb_table`
* dns: added example in docs for dns zone import
* dns: added example in docs for dsn zone import

## 0.109.0 (February 27, 2024)
BUG FIXES:
* alb: fixed validation of listener types

## 0.108.1 (February 19, 2024)
BUG FIXES:
* clickhouse: fixed resetting kafka_topics timeout settings to zero when adding a new topic
* storage: fix lifecycle state upgrader
* mongodb: fixed mongocfg/mongos terraform configs behaviour with mongoinfra hosts

ENHANCEMENTS:
* yandex_ydb_table: add auth interface parameters for static creds

## 0.108.0 (February 14, 2024)
FEATURES:
* redis: added `enable_sharding` feature, it works when cluster was not sharded and new value of sharded is true
* storage: support `tags` and `and` operator in bucket lifecycle configuration in `yandex_storage_bucket` resource
* kafka: added `subnet_ids` field for update method in `resource_yandex_mdb_kafka_cluster`
* **New Resource:** `yandex_mdb_mongodb_database`
* **New Resource:** `yandex_mdb_mongodb_user`
* **New Resource:** `yandex_organizationmanager_os_login_settings` 
* **New Resource:** `yandex_organizationmanager_user_ssh_key` 
* **New Data Source:** `yandex_mdb_mongodb_database`
* **New Data Source:** `yandex_mdb_mongodb_user`
* **New Data Source:** `yandex_organizationmanager_os_login_settings`
* **New Data Source:** `yandex_organizationmanager_user_ssh_key`

BUG FIXES:
* fix ydb_table type
* serverless: fix YDS trigger creation.
* lockbox: support `import`

WARNING:
* mongodb: `database` and `user` sections for `yandex_mdb_mongodb_cluster` are now deprecated

## 0.107.0 (January 31, 2024)
FEATURES:
* mongodb: added `enable_flow_control`, `compressors`, `prefix_compression`, `slow_op_sample_rate` parameters to mongodb config
ENHANCEMENTS:
* added running of sweepers and tests for yandex-framework package.
* compute: change `disk_ids` attribute type from List to Set in `snapshot_schedule` resource.
BUG FIXES:
* serverless: fix integer overflow in function memory computation

## 0.106.0 (January 23, 2024)
FEATURES:
* compute: support `placement_strategy` for `yandex_compute_placement_group` resource and data source.
* compute: support `placement_group_partition` for `yandex_compute_instance` resource and data source.
* iot: support `log_options` in `yandex_iot_core_broker` resource and data source
* iot: support `log_options` in `yandex_iot_core_registry` resource and data source
* cdn: add `ip_address_acl.excepted_values` and `ip_address_acl.policy_type` parameters to resource options.

## 0.105.0 (January 10, 2024)
FEATURES:
* alb: support `security_profile_id` in `route_options` for `yandex_alb_virtual_host` resource and data source.
* serverless: support `log_options` in `yandex_serverless_container` resource and data source
* serverless: support `log_options` in `yandex_function` resource and data source
* serverless: support `log_options` in `yandex_api_gateway` resource and data source
* mongodb: do not change user's password if no state changes

BUG FIXES:
* mdb: changed `disk_size_limit` value type from bytes to gibibytes in `disk_size_autoscaling` attribute in `yandex_mdb_postgresql_cluster` resource.

ENHANCEMENTS:
* added documentation for k8s cluster scheme attribute - `master_location`

## 0.104.0 (December 12, 2023)
FEATURES:
* serverless: support Container Registry, Yandex Data Streams and Mail triggers.
* serverless: support `storage_mounts` in `yandex_function` resource and data source
* serverless: support `storage_mounts` in `yandex_serverless_container` resource and data source
* cdn: add `secure_key` and `enable_ip_url_signing` parameters to resource options.
* greenplum: add PXF daemon settings to config
* compute: changes in instance's DNS records are now done without instance restart
* yandex_datatransfer_endpoint: added cleanup_policy into postgres_target and mysql_target
* yandex_datatransfer_endpoint: added service_database into mysql_target
* yandex_datatransfer_endpoint: added topic_names into kafka_source
* yandex_datatransfer_endpoint: added round_robin into clickhouse_target.sharding

BUG FIXES:
* provider: automatically pick up zone records after updating zone visibility

## 0.103.0 (November 28, 2023)
FEATURES:
* **New Data Source:** `yandex_mdb_opensearch_cluster`
* **New Resource:** `yandex_mdb_opensearch_cluster`
* yandex_ydb_database: added the ability to change networks
* serverless: `log_group` trigger is deprecated. Use `logging` trigger instead.
* mongodb: add create cluster timeout
* compute: add `name` attribute to `instance_template.boot_disk` in `yandex_compute_instance_group` resource and data source
* compute: add `name` attribute to `instance_template.secondary_disk` in `yandex_compute_instance_group` resource and data source

ENHANCEMENTS:
* managed-kubernetes: support update of `master.master_locations` section for `yandex_kubernetes_cluster`

BUG FIXES:
* yandex_ydb_database: Add additional wait duration after database was created
* yandex_ydb_topic: Fix consumer type in tf scheme

## 0.102.0 (November 8, 2023)

FEATURES:
* provider: allow creating `public` dns zones along with `private` and `public-private` once
* provider: allow updating dns zone visibility (all transitions are allowed except `public-private -> public` one)

BUG FIXES:
* clickhouse: updating only the changed user settings
* alb: fix bug leading to panic when `log_options` block is empty
* storage: fix bug not allowing to remove grants and acl by removing `grant` and `acl` fields
* certificate-manager: `yandex_cm_certificate` resource now handles the case when the service does not provide challenges of the required type 

## 0.101.0 (October 31, 2023)

ENHANCEMENTS:
* mdb: add `disk_size_autoscaling` attribute to `config` entity in `yandex_mdb_postgresql_cluster` resource and data source
* datasphere: add documentation for datasphere resources and data sources
* kafka: small tests refactor, change kafka version to 3.5 in acc-tests.

FEATURES:
* compute: added support for `instance_tags_pool` in `yandex_compute_instance_group`
* compute: added support for `ignore_health_checks` in `yandex_compute_instance_group`
* managed-kubernetes: add `master_location`, `etcd_cluster_size` in `yandex_kubernetes_cluster` resource and data source
* kafka: support Kafka 3.3,3.4,3.5 in `yandex_mdb_kafka_cluster`
* postgresql: add postgresql 16 support

* **New Resource:** `yandex_loadtesting_agent`

BUG FIXES:
* kafka: fix bug with update of field `schema_registry` in `yandex_mdb_kafka_cluster` resource
* compute: fix `filesystem` in `compute_instance_group` resource
* greenplum: add Cloud Storage support
* postgresql: do not recreate cluster on network change
* kafka: fix bug with import of resource `yandex_mdb_kafka_connector`
* mongodb: fix update `feature_compatibility_version` in `yandex_mdb_mongodb_cluster` resource

WARNING:
* managed-kafka: 'unmanaged_topics' cluster flag are now deprecated

ENHANCEMENTS:
* managed-kubernetes: supprort update of `allocation_policy.locations` section for `yandex_kubernetes_node_group`

## 0.100.0 (October 11, 2023)

FEATURES:

* clickhouse: added `remote_filesystem_read_method`, `max_read_buffer_size`, `insert_keeper_max_retries`, `max_temporary_data_on_disk_size_for_user`, `max_temporary_data_on_disk_size_for_query`, `max_parser_depth`, `memory_overcommit_ratio_denominator`, `memory_overcommit_ratio_denominator_for_user`, `memory_usage_overcommit_max_wait_microseconds` for user settings, `geobase_enabled`, `background_merges_mutations_concurrency_ratio` for server configuration, `max_avg_part_size_for_too_many_parts`, `min_age_to_force_merge_seconds`, `min_age_to_force_merge_on_partition_only`, `merge_selecting_sleep_ms` for merge tree configuration, `enable_ssl_certificate_verification`, `max_poll_interval_ms`, `session_timeout_ms` for kafka_topic configuration, `level` for compression configuration, `prefer_not_to_merge` for cloud storage configratuion
* clickhouse: fix update merge_tree settings 
* hadoop: support `initialization_action` section
* serverless: add `async_invocation` attribute in `yandex_function` resources and data sources
* greenplum: add Greenplum 6.25 support
* compute: support `filesystem` in `compute_instance_group` resource and data source
* **New Resource:** `yandex_datasphere_community`
* **New Resource:** `yandex_datasphere_project`
* **New Resource:** `yandex_datasphere_community_iam_binding`
* **New Resource:** `yandex_datasphere_project_iam_binding`

BUG FIXES:
* dataproc: fix autoscaling subcluster update
* yandex_ydb_table: add trim slashes in table path

ENHANCEMENTS:
* migration: switched tests imports for helpers modules from SDKv2 to the testing module. [Following](https://developer.hashicorp.com/terraform/plugin/testing/migrating#migration-steps)

## 0.99.1 (September 25, 2023)

BUG FIXES:

* kafka: fix for `allow_hosts` attribute processing

## 0.99.0 (September 22, 2023)

FEATURES:

* clickhouse: added `input_format_import_nested_json`, `input_format_parallel_parsing`, `max_read_buffer_size`, `max_final_threads`, `local_filesystem_read_method` for user settings, `input_format_import_nested_json` for server configuration, `merge_with_ttl_timeout`, `merge_with_recompression_ttl_timeout`, `max_parts_in_total`, `max_number_of_merges_with_ttl_in_pool`, `cleanup_delay_period` for merge tree configuration
* clickhouse: changing `folder_id` attribute in `yandex_mdb_clickhouse_cluster` moves ClickHouse cluster to new folder
* serverless: added `variables` and `canary` attribute to `api_gateway` resource and data source
* mongodb: support `backup_retain_period_days` in `yandex_mdb_mongodb_cluster`
* mongodb: changing `folder_id` attribute in `yandex_mdb_mongodb_cluster` moves MongoDB cluster to new folder
* redis: changing `folder_id` attribute in `yandex_mdb_redis_cluster` moves Redis cluster to new folder
* kafka: changing `folder_id` attribute in `yandex_mdb_kafka_cluster` moves Kafka cluster to new folder
* kafka: add `allow_hosts` attribute for kafka user permission in `yandex_mdb_kafka_user` and `yandex_mdb_kafka_cluster` resources and data sources

BUG FIXES:

* docs: method of resetting `placement_policy` field in `compute_instance` resource
* backup: added `yandex_backup_policy` resource
* clickhouse: fix cluster version upgrade
* clickhouse: fix reset secrets to default for `kafka_topics` on cluster update

ENHANCEMENTS:
* getting lockbox data source via `name` and `folder_id`

## 0.98.0 (September 11, 2023)

FEATURES:

* mongodb: support `performance_diagnostics` in `yandex_mdb_mongodb_cluster`
* serverless: support `stream_names` attribute in logging triggers
* serverless: support batching in `IoT` and `S3` triggers
* k8s: added `gpu_environment` property to `gpu_settings` attribute of `node_group` resource and data source
* clickhouse: fix reset secrets to default for `kafka_topics` on cluster update

BUG FIXES:

* fix `Provider produced inconsistent final plan` error with `resource_yandex_dns_recordset`

## 0.97.0 (August 16, 2023)

FEATURES:

* k8s: added `gpu_settings` attribute with `gpu_cluster_id` to `node_group` resource and data source

ENHANCEMENTS:

* combined provider via muxing (simultaneous support of `terraform-plugin-sdk/v2` and `terraform-plugin-framework`).
* migrate `yandex_billing_cloud_binding` to `terraform-plugin-framework` provider

## 0.96.1 (July 31, 2023)
BUG FIXES:
* compute: revoke support updating host_affinity_rules in the `yandex_compute_instance` resource due to breaking changes in tf state.

## 0.96.0 (July 31, 2023)
FEATURES:
* added `shared_credentials_file` and `profile` provider properties
* storage: support configuration of `storage_access_key`/`storage_secret_key` keys from shared credentials file
* redis: support `maxmemory_percent` in `yandex_mdb_redis_cluster`
* compute: support updating host_affinity_rules in the `yandex_compute_instance` resource.
* storage: added `source_hash` property to `storage_object` resource

BUG FIXES:
* compute: fixed problem with changing health check type for `yandex_compute_instance_group`
* certificate-manager: in `yandex_cm_certificate` resource, `domains` is not `Computed`, to avoid unwanted updates

ENHANCEMENTS:
* provider: the default development, testing and building of the provider is now done with Go 1.20

## 0.95.0 (July 13, 2023)
FEATURES:
* storage: allow `transition`/`noncurrent_version_transition` to `ICE` storage class in bucket lifecycle config.
* datatransfer: added `ydb_source` and `ydb_target` endpoints

BUG FIXES:
* certificate-manager: fixed problem with read `deletion_protection` to `data.yandex_cm_certificate`
* `terraform-provider-ydb` add ttl support for integral types of columns

## 0.94.0 (July 4, 2023)
FEATURES:
* redis: update requests to grpcapi with unified config
* provider: upgrade go-genproto to the latest version. This is needed for migrate redis to unified config.
* **New Resource:** `yandex_kms_asymmetric_encryption_key`
* **New Resource:** `yandex_kms_asymmetric_signature_key`
* **New Resource:** `yandex_kms_asymmetric_encryption_key_iam_binding`
* **New Resource:** `yandex_kms_asymmetric_signature_key_iam_binding`

BUG FIXES:
* vpc: security group rule import fixed
* datatransfer: added `serializer` field for `kafka_target` endpoints
* docs: updated description for `yandex_compute_snapshot_schedule`
* lockbox: better examples for `yandex_lockbox_secret_version` data source

ENHANCEMENTS:
* use ListUserAccounts filter parameter in `yandex_organizationmanager_saml_federation_user_account` data source instead of loop.
* fixed `yandex_organizationmanager_saml_federation_user_account` data source acceptance tests.
* `*_iam_member`, `*_iam_binding`, `*_iam_policy` resources are now context-aware
* Error messages and handling updated for `*_iam_member`, `*_iam_binding`, `*_iam_policy` resources
* `*_iam_member` resources now use update-access-bindings method instead of set-access-bindings

## 0.93.0 (June 14, 2023)
FEATURES:
* provider: the default development, testing and building of the provider is now done with Go 1.18
* clickhouse: minor refactoring of clickhouse tests
* clickhouse: add check Clickhouse config

BUG FIXES:
* organizationmanager: data source `yandex_organizationmanager_saml_federation_user_account` account creation behaviour fixed.


## 0.92.0 (May 31, 2023)
FEATURES:
* mongodb: update mongodb version in tests from deprecated `4.2` to actual `6.0`
* organizationmanager: saml user organization membership management via dedicated resource `yandex_organizationmanager_saml_federation_user_account` is implemented
* dataproc: update dataproc tests
* kms: add `deletion_protection` attribute  in `yandex_kms_symmetric_key` resource
* **New Data Source:** `yandex_kms_symmetric_key`
* storage: added bucket and object `tagging`
* k8s: add `container_network` attribute with `pod_mtu` to `node_group` resource and data source
* k8s: add `audit_enabled` field to `master_logging` attribute in `cluster` resource and data source
* clickhouse: minor refactoring of clickhouse tests
* **New Resource** `yandex_lockbox_secret_iam_binding`
* All supported subjects specified in docs for `*_iam_member`, `*_iam_binding` and other iam access policy resources 
* cdn: added support to set custom headers in requests to origin in `static_request_headers`

BUG FIXES:
* organizationmanager: data source `yandex_organizationmanager_saml_federation_user_account` account creation behaviour deprecation notice added
* clickhouse: fix actual ClickHouse versions in tests
* yandex_ydb_table: add option for disable auto partitioning by size
* compute_instance: fix static ip address unbinding
* cdn: fix documentation

## 0.91.0 (May 18, 2023)
FEATURES:
* mdb: Kafka user management via dedicated resource `yandex_mdb_kafka_user` is implemented
* clickhouse: minor refactoring of clickhouse tests

BUG FIXES:
* mongodb: fix migrate from  `resources` to `resources_*` without changes
* logging: fix refresh failure if logging group has been deleted externally
* clickhouse: fix bug with count zookeepers
* kafka: fix bug in terraform acc tests, data source kafka cluster test.
* redis:   fix fail on create when maintance_window equals ANYTIME

## 0.90.0 (May 4, 2023)
FEATURES:
* redis: support `announce_hostnames` in `yandex_mdb_redis_cluster`
* datatransfer: added `kafka_source` and `kafka_target` endpoints
* mongodb: add the ability to enable sharding in created clusters
* mongodb: support for adding and deleting shards in a sharded mongodb
* serverless: support `payload` for timer triggers

BUG FIXES:
* clickhouse: fix bug with resource's configuration
* clickhouse: fix bug with setting background_pool_size in config
* mongodb: fix `yandex_mdb_mongodb_cluster` restore test
* docs: updated description for `yandex_compute_snapshot_schedule`
* certificate-manager: fix import for `yandex_cm_certificate`
* certificate-manager: add tests for self-managed `yandex_cm_certificate`
* certificate-manager: fix documentation
* **New Resource** `yandex_ydb_table`
* yandex-message-queue: fixed queue creation after manual deletion

## 0.89.0 (April 6, 2023)
FEATURES:
* mongodb: `resources` section for `yandex_mdb_mongodb_cluster` is now deprecated
* mongodb: add new sections `resources_mongod`, `resources_mongos`, `resources_mongocfg`, `resources_mongoinfra` for `yandex_mdb_mongodb_cluster`
* mongodb: add support `MONGOINFRA` host type
* mongodb: allow changing settings for `MONGOS` and `MONGOCFG` host types
* mongodb: support `6.0` enterprise and community versions in `yandex_mdb_mongodb_cluster`
* greenplum: add new 6.22 Greenplum version and remove old 6.17 Greenplum version
* postgresql: add `deletion_protection` attribute to `yandex_mdb_postgresql_user` and `yandex_mdb_postgresql_database` resources

BUG FIXES:
* datatransfer: fixed the setting of `source_id` and `target_id` on the transfer importing 
* yandex message queue: fixed invalid VisibilityTimeout in queue settings when `visibility_timeout_seconds` attribute was set to `0`

## 0.88.0 (March 23, 2023)
FEATURES:
* **New Resource** `yandex_monitoring_dashboard`
* **New Data Source** `yandex_monitoring_dashboard`
* postgresql: fix host recreation when assigning public ip
* postgresql: do not change user's password if no state changes
* logging: support data_stream attribute
* mysql: fix host recreation when assigning public ip
* postgresql: add `database` and `user` attributes to `yandex_mdb_postgresql_cluster` data source
* **New Resource** `yandex_compute_gpu_cluster`
* **New Data Source** `yandex_compute_gpu_cluster`
* compute: add `gpu_cluster_id` attribute in `yandex_compute_instance` resource and data source
* postgresql: add `pool_mode` attribute to `settings` in `yandex_mdb_postgresql_user`

## 0.87.0 (March 14, 2023)
BUG FIXES:
* postgresql: fix owner permissions drop in `yandex_mdb_postgresql_user`

FEATURES:
* **New Resource** `yandex_billing_cloud_binding`
* **New Data Source** `yandex_billing_cloud_binding`
* ydb: add new parameters for serverless database

## 0.86.0 (March 7, 2023)
BUG FIXES:
* provider config: make `storage_secret_key` and `token` attributes sensitive
* serverless: fix documentation of required attributes for `yandex_function` resource
* postgresql: fix adding `shared_preload_libraries` to cluster
* clickhouse: fix bug with empty user settings.
* compute: fix updating `snapshot_schedule` disks
* storage: minor logging fixes

FEATURES:
* clickhouse: add new parameters for user settings, server config.
* clickhouse: add feature to configure resources for shards.
* serverless: add `container` support in `yandex_function_trigger` resource and data source
* vpc: add `deletion_protection` attribute in `yandex_vpc_address` resource and data source
* vpc: add `deletion_protection` attribute in `yandex_lb_network_load_balancer` resource and data source
* vpc: Use the default region if the `region_id` attribute is omitted in `yandex_lb_network_load_balanacer` and `yandex_lb_target_group`
* alb: add `rewrite_request_id` support in `HTTPHandler`
* postgresql: add new parameters for user settings.

## 0.85.0 (January 31, 2023)
FEATURES:
* storage: add `object_lock_configuration` attribute in `bucket` resource
* storage: add `object_lock_legal_hold_status`, `object_lock_mode` and `object_lock_retain_until_date` attributes in `object` resource
* storage: add information about `storage_endpoint` in documents
* storage: add `config_read` property to `anonymous_access_flags` structure.
* **New Resource:** `yandex_ydb_topic`

BUG FIXES:
* storage: import bucket state now does not requires reapply because it's properly syncs acl and grants.
* mongodb: add `restore` entity in `yandex_mdb_mongodb_cluster` resource
* k8s: add `master_logging` attribute to `cluster` resource and data source
* **New Data Source:** `yandex_container_registry_ip_permission`
* **New Resource:** `yandex_container_registry_ip_permission`
* clickhouse: add possibility to update `version` and `resources` in single apply
* alb: add `regex` support in `StringMatch`
* clickhouse: added the feature to set maintenance_window when creating a cluster.
* clickhouse: support cloud_storage with advanced settings
* postgresql: add possibility to rename `yandex_mdb_postgresql_database`
* api_gateway: add `custom_domains` attribute to `api_gateway` resource and data source
* serverless: add `connectivity` attribute to `api_gateway` resource and data source
* serverless: add `connectivity` attribute to `yandex_functions` resource and data source
* serverless: add `connectivity` attribute to `yandex_serverless_container` resource and data source
* clickhouse: add feature to set weight for shards.

## 0.84.0 (December 16, 2022)
BUG FIXES:
* mysql: fix bug leading to cluster recreation when changing folder_id
* mdb: fix bug when description cannot be set to null in `yandex_mdb_postgresql_cluster` and `yandex_mdb_mongodb_cluster`
* clickhouse: fix bug leading to failed updating cluster when set cloud_storage(enabled: false)
* compute: fix validation of local_disk in yandex_compute_instance resource

FEATURES:
* compute: support `metadata_options` in `yandex_compute_instance`
* **New Data Source:** `yandex_compute_filesystem`
* **New Resource:** `yandex_compute_filesystem`
* compute: support `yandex_compute_filesystem` in `yandex_compute_instance`

## 0.83.0 (December 1, 2022)
BUG FIXES:
* compute: fix bug leading to failed instance update when changing subnet_id of a network_interface
* clickhouse: fix bug leading to failed creating cluster when set maintenance_window

FEATURES
* alb: add `log_options` attribute in `yandex_alb_load_balancer` resource and data source.

FEATURES:
* **New Data Source:** `yandex_cm_certificate`
* **New Data Source:** `yandex_cm_certificate_content`
* **New Resource:** `yandex_cm_certificate`

## 0.82.0 (November 11, 2022)
BUG FIXES:
* lockbox: display error cause, when creating resource `yandex_lockbox_secret_version` fails
* greenplum: add default values for pooler_config. Fix bug with greenplum cluster creation.
* postgresql: fix bug leading to cluster recreation when dropping users or databases in `yandex_mdb_postgresql_cluster` resource
* postgresql: fix bug leading to panic when creating user with grants = [""]
* serverless: check retry attributes when creating message queue trigger

FEATURES:
* postgresql: add postgresql 15 support
* datatransfer: add `on_create_activate_mode` for incremental transfers
* datatransfer: ignore deactivation error on destroy
* **New Data Source:** `yandex_compute_snapshot_schedule`
* **New Resource:** `yandex_compute_snapshot_schedule`

ENHANCEMENTS:
* add `sasl_enabled_mechanisms` attribute in `yandex_mdb_kafka_cluster` resource and data source

## 0.81.0 (October 20, 2022)
BUG FIXES:
* compute: fix size validation in `resource_yandex_compute_disk`
* vpc: fix region_id validation in `resource_yandex_lb_network_load_balanacer` and `resource_yandex_lb_target_group`
* postgresql: fix `host_master_name` wrong behaviour in `yandex_mdb_postgresql_cluster` again
* alb: fix `value` wrong behaviour in `yandex_alb_http_router` and `yandex_alb_virtual_host`
* alb: fix default `path` value in `yandex_alb_backend_group`
* greenplum: add expanding greenplum cluster in a case of changing segments host numbers, details in `resource_yandex_mdb_greenplum_cluster`

ENHANCEMENTS:
* provider: Upgrade go-sdk and go-genproto to the latest version. This is needed for ALB RBAC feature. 
* add `message_max_bytes`, `replica_fetch_max_bytes`, `ssl_cipher_suites`, `offsets_retention_minutes` attributes in `yandex_mdb_kafka_cluster` resource and data source
* clickhouse: use version 22.8 for tests

FEATURES:
* mdb: add `backup_retain_period_days` attribute to `config` entity in `yandex_mdb_mysql_cluster` resource and data source
* alb: support `route_options` attribute in `yandex_alb_http_router` and `yandex_alb_virtual_host` resource and data source
* **New Data Source:** `yandex_lockbox_secret`
* **New Data Source:** `yandex_lockbox_secret_version`
* **New Resource:** `yandex_lockbox_secret`
* **New Resource:** `yandex_lockbox_secret_version`
* serverless: add `secrets` attribute in `yandex_function` resource and data source
* serverless: add `secrets` attribute in `yandex_serverless_container` resource and data source
* kafka: support S3-Sink Kafka connector in `yandex_mdb_kafka_connector` resource

## 0.80.0 (September 22, 2022)
BUG FIXES:
* postgresql: fix `host_master_name` wrong behaviour in in `yandex_mdb_postgresql_cluster`
* postgresql: fix `yandex_mdb_postgresql_database` resource wrong behaviour in 0.78.1

FEATURES:
* **New Resource:** `yandex_organizationmanager_group_iam_member`

## 0.79.0 (September 20, 2022)
FEATURES:
* redis: support for Redis 7.0
* **New Data Source:** `yandex_organizationmanager_group`
* **New Resource:** `yandex_organizationmanager_group`
* **New Resource:** `yandex_organizationmanager_group_membership`
* ydb: support `deletion_protection` attribute to `yandex_ydb_database_serverless` and `yandex_ydb_database_dedicated` resources.
* **New Data Source:** `yandex_container_repository_lifecycle_policy`
* **New Resource:** `yandex_container_repository_lifecycle_policy`

BUG FIXES:
* `yandex_container_repository`: fixed bug with orphant `yandex_container_repository` after taint of `yandex_container_registry`


## 0.78.2 (September 9, 2022)
BUG FIXES:
* kafka: sort hosts in listKafkaHosts method to avoid non - deterministic list of hosts.

FEATURES:
* kafka: support Kafka 3.0,3.1,3.2 in `yandex_mdb_kafka_cluster`
* postgresql: added 13-1c, 14-1c Postgresql versions

## 0.78.1 (September 6, 2022)
BUG FIXES:
* dns: fixed `proto: not found` error when creating, updating or deleting `yandex_dns_recordset`

## 0.78.0 (September 1, 2022)
BUG FIXES:
* cdn: fixed wrong documentation example
* postgresql: fix `login` and `conn_limit` wrong behaviour in `yandex_mdb_postgresql_user`
* data source `yandex_organizationmanager_saml_federation_user_account` now works for federations with more than a hundred of users and with viewer role

ENHANCEMENTS:
* vpc: allow usage of `yandex_vpc_gateway` in `yandex_vpc_route_table.static_route` as `gateway_id` next hop

FEATURES:
* greenplum: add `maintenance_window` attribute to resource and data source
* greenplum: support for changing the user's password
* greenplum: support for changing segment and master resources
* mdb: add `template_db` attribute to `yandex_mdb_postgresql_cluster` resource and data source
* clickhouse: add `assign_public_ip` attribute to `host` declaration in resource and data source
* clickhouse: support hosts update
* mdb: add `backup_retain_period_days` attribute to `config` entity in `yandex_mdb_mysql_cluster` resource and data source
* **New Data Source:** `yandex_iot_core_broker`
* **New Data Source:** `yandex_vpc_gateway`
* **New Resource:** `yandex_iot_core_broker`
* **New Resource:** `yandex_vpc_gateway`
* `data_transfer` flag in `ClusterConfig.access` for ClickHouse, Greenplum, MySQL, PostgreSQL, Kafka, MongoDB
* `yandex_query` flag in `ClusterConfig.access` for ClickHouse

WARNING:
* mdb: remove 5 and 6 from supported versions for redis

## 0.77.0 (July 27, 2022)
BUG FIXES:
* iam: fix access bindings deletion
* ydb: fixed panic if database was removed outside of terraform
* storage: fix issue when error, returned from reading extend bucket settings treated as important.
  It will be printed as log output now instead of interrupting plan execution.
* greenplum: fix bug with not setting `security groups_ids` in `resource_yandex_mdb_greenplum_cluster`
* greenplum: fix bug with not setting `access` in `resource_yandex_mdb_greenplum_cluster`

ENHANCEMENTS:
* mdb: add `sqlcollation` attribute to `yandex_mdb_sqlserver_cluster` resource and data source
* serverless: increase operation timeouts in `yandex_function` resource
* cdn: added the ability to set custom `folder_id` attribute for resources `yandex_cdn_origin_group` and `yandex_cdn_resource`

FEATURES:
* k8s: add `instance_template.name` attribute to `node group` resource and data source
* k8s: add `instance_template.ipv4_dns_records`, `instance_template.ipv6_dns_records` attributes to `node group` resource and data source
* k8s: add `instance_template.labels` attribute to `node group` resource and data source
* greenplum: add fields `greenplum_config` and `pooler_config` in `resource_yandex_mdb_greenplum_cluster`
* **New Resource:** `yandex_serverless_container_iam_binding`
* **New Resource:** `yandex_ydb_database_iam_binding`

## 0.76.0 (July 01, 2022)
BUG FIXES:
* alb: `send` and `receive` attributes can be empty now in `yandex_alb_backend_group` resource and data source
* alb: fixed `yandex_alb_load_balancer` resource and data source documentation
* alb: support `mode` attribute in `load_balancing_config` entity in `yandex_alb_backend_group` resource and data source
* mysql: `mysql_config.sql_mode` is setting now when creating a cluster
* mdb: fix changing `maintenance_window` only in `yandex_mdb_redis_cluster`
* clickhouse: fix issue with `shard_group` update
* serverless: fix issue with `retention_period` update in `yandex_logging_group` resource

ENHANCEMENTS:
* alb: refactoring `yandex_alb_backend_group` resource and data source
* alb: extra validation added to `yandex_alb_load_balancer` and `yandex_alb_virtual_host` resources and data sources
* mdb: add `client_output_buffer_limit_normal` and `client_output_buffer_limit_pubsub` attributes to `yandex_mdb_redis_cluster` resource and data source
* mdb: add `replica_priority` attribute to `yandex_mdb_redis_cluster` resource and data source
* mdb: add `assign_public_ip` attribute to `yandex_mdb_redis_cluster` resource and data source
* ymq: add `region_id` attribute to resource

FEATURES:
* compute: support for creating `yandex_compute_instance` with local disks

## 0.75.0 (May 31, 2022)
ENHANCEMENTS:
* compute: support instance's scheduling policy update in-place

FEATURES:
* datatransfer: add ClickHouse endpoint into `yandex_datatransfer_endpoint` resource
* alb: support `session_affinity` attribute in `yandex_alb_backend_group` resource and data source.
* **New Resource:** `yandex_mdb_postgresql_database`
* **New Resource:** `yandex_mdb_postgresql_user`
* **New Resource:** `yandex_mdb_mysql_database`
* **New Resource:** `yandex_mdb_mysql_user`
* **New Data Source:** `yandex_mdb_postgresql_database`
* **New Data Source:** `yandex_mdb_postgresql_user`
* **New Data Source:** `yandex_mdb_mysql_database`
* **New Data Source:** `yandex_mdb_mysql_user`
* storage: support `folder_id`, `max_size`, `anonymous_access_flags`, `https` and `default_storage_class` attributes in bucket.
See `storage_bucket` documentation for important information.

BUG FIXES:
* postgresql: fix bug with applying cluster's settings in PostgreSQL 14
* iam: return error when access bindings not applied
* storage: fix bug of wrong handling permission error denied on reading policy
* mdb: fix setting timeout and slowlog_max_len to 0 value in `yandex_mdb_redis_cluster`

WARNING:
* postgresql: `database` and `user` sections for `yandex_mdb_postgresql_cluster` are now deprecated
* mysql: `database` and `user` sections for `yandex_mdb_mysql_cluster` are now deprecated

## 0.74.0 (April 19, 2022)
ENHANCEMENTS:
* iam: support for changing description of `yandex_iam_service_account_key` without recreation
* mdb: add `performance_diagnostics` section in `yandex_mdb_mysql_cluster` resource and data source
* mdb: change attribute `yandex_mdb_mysql_cluster.user.global_permissions` type from List to Set
* alb: add `enable_proxy_protocol` attribute to `stream_backend` entity in `yandex_alb_backend_group` resource and data source

BUG FIXES:
* postgresql: fix unpredictable behaviour when changing `assign_public_ip` without name
* storage: fix not saving bucket's `policy` to tfstate
* datatransfer: allow updating `tls_mode` attribute of `yandex_datatransfer_endpoint` resource from `enabled` to `disabled` value

FEATURES:
* compute: changing `folder_id` attribute leads to move operation for `yandex_compute_instance` and `yandex_compute_disk` resources if `allow_recreate` flag is set to false (or not set). Otherwise, resource will be recreated.
* mdb: new mysql configuration options added
* mdb: support audit log (filter, audit_authorization_success) and security (enable, kmip) settings in `yandex_mdb_mongodb_cluster`
* add `host_group_ids` attribute in `yandex_mdb_mysql_cluster` resource and data source
* add `host_group_ids` attribute in `yandex_mdb_postgresql_cluster` resource and data source
* datatransfer: add MongoDB endpoint into `yandex_datatransfer_endpoint` resource

## 0.73.0 (March 28, 2022)
ENHANCEMENTS:
* compute: add `host_affinity_rules` attribute to `placement_policy` in `yandex_compute_instance` resource and data source
* alb: support `storage_bucket` as a target in `yandex_alb_backend_group` resource and data source

BUG FIXES:
* compute: avoid unnecessary start/stop operations for instance while updating secondary disk configuration
* compute: detach secondary disk from instance before deleting
* dataproc: add `assign_public_ip` attribute to `subcluster_spec` entity. If set to `true` then public ip addresses will be assigned to hosts of the subcluster
* docs: fixed exported attributes for `yandex_vpc_network` datasource
* docs: fixed `yandex_vpc_address` resource documentation
* dns: fixed `yandex_dns_recordset` resource record data length restriction

FEATURES:
* mdb: support `persistence_mode` in `yandex_mdb_redis_cluster`
* kafka: support connector resource and data source in Kafka clusters

## 0.72.0 (March 02, 2022)
ENHANCEMENTS:
* mdb: add `serverless` attribute to `access` entity in `yandex_mdb_postgresql_cluster` resource and data source
* add `ssl_certificate` attribute in `yandex_cdn_resource` resource and data source
* alb: change `http_backend` and `grpc_backend` and `stream_backend` and `healthcheck` attribute types from Set to List in `yandex_alb_backend_group` resource
* mdb: add `priority` and `backup_priority` attributes to `host` entity in `yandex_mdb_mysql_cluster` resource and data source
* mdb: add `embedded_keeper` attribute in `yandex_mdb_clickhouse_cluster` resource and data_source

FEATURES:
* mdb: support MongoDB enterprise 4.4 and 5.0 in `yandex_mdb_mongodb_cluster`
* kafka: support change `assign_public_ip` flag in Kafka clusters
* resource-manager: add `yandex_resourcemanager_cloud` resource.

BUG FIXES:
* alb: fix behavior of attribute `validation_context` of `tls` entity in `yandex_alb_backend_group` resource
* alb: fix behavior of `send` and `receive` attributes of `stream_healthcheck` entity in `yandex_alb_backend_group` resource
* docs: Fixed few minor inaccuracies of `yandex_alb_load_balancer` resource

## 0.71.0 (February 08, 2021)
ENHANCEMENTS:
* allow `initial` of `0` for `yandex_kubernetes_node_group` `auto_scale` policy.
* dataproc: now cluster version specified in create cluster request is treated as a semantic version prefix. So specified version `2.0` may lead to creation of cluster version `2.0.30` and this will not be considered a change in terraform state.
* add `host_group_ids` attribute in `yandex_mdb_sqlserver_cluster` resource and data source

BUG FIXES:
* alb: fix behavior of attribute `weight` in `http_backend` and `grpc_backend` and `stream_backend` in `yandex_alb_backend_group` resource
* datatransfer: make `yandex_datatransfer_transfer` importable in accordance with the documentation
* mdb: fix the optional parameter `preallocate` for kafka topic config when it is absent

## 0.70.0 (January 17, 2022)
FEATURES:
* **New Resource:** `yandex_datatransfer_endpoint`
* **New Resource:** `yandex_datatransfer_transfer`
* managed-kubernetes: add `container_runtime` attribute to `yandex_kubernetes_node_group` resource and data source
* managed-elasticsearch: add `maintenance_window` section in `yandex_mdb_elasticsearch_cluster` resource and data source
* dns: support for resolving by name in `yandex_dns_zone` data source

BUG FIXES:
* mdb: fix error when simultaneously deleting `yandex_mdb_kafka_topic` resource and modifying `yandex_mdb_kafka_cluster` resource

ENHANCEMENTS:
* mdb: add `maintenance_window` section in `yandex_mdb_kafka_cluster` resource and data source

## 0.69.0 (December 27, 2021)
FEATURES:
* **New Data Source:** `yandex_cdn_origin_group`
* **New Data Source:** `yandex_cdn_resource`
* **New Data Source:** `yandex_serverless_container`
* **New Resource:** `yandex_cdn_origin_group`
* **New Resource:** `yandex_cdn_resource`
* **New Resource:** `yandex_serverless_container`
* alb: add `stream_backend` attribute to `yandex_alb_backend_group` resource and data source
* alb: add `stream` attribute to `listener` entity in `yandex_alb_load_balancer` resource and data source

BUG FIXES:
* docs: Fixed few minor inaccuracies of `yandex_alb_virtual_host` resource

FEATURES:
* compute: added `block_size` in `yandex_compute_disk` and `yandex_compute_instance` resources.

## 0.68.0 (December 10, 2021)
FEATURES:
* mdb: added the ability to upgrade Kafka version using the `version` attribute of `yandex_mdb_kafka_cluster` resource.

BUG FIXES:
* alb: fix behavior of attribute `address_type` in `yandex_alb_target_group` resource
* alb: fix behavior of attribute `route.http_route.http_route_action.host_rewrite` in `yandex_alb_virtual_host` resource
* mdb: fix crash when empty config is specified for Kafka topic within `yandex_mdb_kafka_topic` and `yandex_mdb_kafka_cluster` resources

ENHANCEMENTS:
* alb: add `private_ipv4_address` attribute to `target` entity in `yandex_alb_target_group` resource and data source
* compute: add `pooled` attribute in `yandex_compute_image` resource and data source

## 0.67.0 (November 22, 2021)
ENHANCEMENTS:
* provider: Upgrade to Terraform Plugin SDK V2. There should be no breaking changes from a practitioner's perspective.

BUG FIXES:
* alb: fix behavior of attribute `modify_request_headers.append` in `yandex_alb_virtual_host` resource
* alb: fix error when `route.http_route.http_match.http_method` attribute of `yandex_alb_virtual_host` resource is used.
* alb: fix behavior of attribute `route.http_route.http_match.path` in `yandex_alb_virtual_host` resource.
* mdb: fix `name` update in `yandex_mdb_mongodb_cluster`

FEATURES:
* add new resource and data-source `yandex_organizationmanager_saml_federation`
* add new data-source `yandex_organizationmanager_saml_federation_user_account`

## 0.66.0 (November 3, 2021)
FEATURES:
* mdb: Kafka topic management via dedicated resource `yandex_mdb_kafka_topic` is implemented
* mdb: support update `name`, `description`, `labels`, `config.access.data_lens`, `config.access.web_sql`, `deletion_protection` in `yandex_mdb_greenplum_cluster` resource
* mdb: add `access` and `backup_window_start` entities in `yandex_mdb_greenplum_cluster` resource and data source
* mdb: support MongoDB 5.0 in `yandex_mdb_mongodb_cluster`
* mdb: add `backup_retain_period_days` attribute to `config` entity in `yandex_mdb_postgresql_cluster` resource and data source


ENHANCEMENTS:
* add docs on k8s node group placement groups.
* ydb: increase the default timeout to create serverless database
* add `name`, `replication_source`, `replication_source_name` attributes to `host` entity in `yandex_mdb_mysql_cluster` resource and data source
* mysql, postgresql: support updating `assign_public_ip` without host recreation

WARNING:
* `allow_regeneration_host` for mysql host is now DEPRECATED.

BUG FIXES:
* mdb: fix behavior of attribute `user.settings.log_min_duration_statement` in `yandex_mdb_postgresql_cluster` resource

## 0.65.0 (October 14, 2021)
FEATURES:
* mdb: support Schema Registry in `yandex_mdb_kafka_cluster`

FEATURES:
* **New Resource:** `yandex_kms_symmetric_key_iam_binding`

ENHANCEMENTS:
* elasticsearch: update go-sdk version, add tests
* serverless: supported logging trigger

BUG FIXES:
* mdb: invalid plan was generated when user didn't specify zookeeper resources for multibroker Kafka cluster

## 0.64.1 (September 24, 2021)
BUG FIXES:
* mdb: fix password change in Redis

## 0.64.0 (September 22, 2021)
FEATURES:
* **New Resource:** `yandex_logging_group`
* **New Data Source:** `yandex_logging_group`

BUG FIXES:
* fix sni handler expanding
* fix `internal_ipv4_address` missing `subnet_id` field
* fix non empty plan when `yandex_vpc_security_group_rule` protocol written in non uppercase

## 0.63.1 (September 10, 2021)
BUG FIXES:
* fix alb backend group with empty tls.

## 0.63.0 (September 07, 2021)
FEATURES:
* **New Data Source:** `yandex_mdb_greenplum_cluster`
* **New Resource:** `yandex_mdb_greenplum_cluster`
* docs: add info about internal address for `lb_network_load_balancer`
* docs: add info about loadbalancer_healthchecks predefined target for `vpc_security_group`

BUG FIXES:
* mdb: fix terraform crash when using big integers as Kafka broker and topic config values

## 0.62.0 (August 30, 2021)
FEATURES:
* storage: `yandex_storage_bucket` resource supports website routing rules configuraion
* mdb: support Redis 6.2 in `yandex_mdb_redis_cluster`
* mdb: support Kafka 2.8 in `yandex_mdb_kafka_cluster`
* add yandex_organizationmanager_organization_iam_member and yandex_organizationmanager_organization_iam_binding resources.

BUG FIXES:
* vpc: fix dirty plan of `labels` in vpc resources
* vpc: fix `yandex_vpc_security_group_rule` doc
* vpc: fix ignoring description when changing at inline rules of `yandex_vpc_security_group`
* mdb: ensure that `network_id` is not empty if provided
* mdb: fix host creating with empty `subnet_id` in `yandex_mdb_postgresql_cluster`
* mdb: suppress master nodes config changes if no master node used in `yandex_mdb_elasticsearch_cluster`
* apigateway: fixed spec updating in `yandex_api_gateway`

ENHANCEMENTS:
* add `deletion_protection` attribute to `yandex_mdb_clickhouse_cluster`, `yandex_mdb_elasticsearch_cluster`, `yandex_mdb_kafka_cluster`, `yandex_mdb_mongodb_cluster`, `yandex_mdb_mysql_cluster`, `yandex_mdb_postgresql_cluster`,  `yandex_mdb_redis_cluster`, `yandex_mdb_sqlserver_cluster` resources and data sources
* add `deletion_protection` attribute to `yandex_dataproc_cluster` data source
* support updating of k8s node group `node_labels` without recreation.
* docs: added a description of the port to the documentation for `yandex_mdb_postgresql_cluster`
* support version updaing for `yandex_mdb_elasticsearch_cluster`

## 0.61.0 (July 9, 2021)
FEATURES:
* **New Data Source:** `yandex_alb_load_balancer`
* **New Data Source:** `yandex_function_scaling_policy`
* **New Data Source:** `yandex_vpc_security_group_rule` for getting info about security group rules
* **New Resource:** `yandex_alb_load_balancer`
* **New Resource:** `yandex_resourcemanager_folder`
* **New Resource:** `yandex_function_scaling_policy`
* **New Resource** `yandex_vpc_security_group_rule` for security group rule managment

ENHANCEMENTS:
* add `application_load_balancer` entity in `yandex_compute_instance_group` resource and data source
* add `max_checking_health_duration` and `max_opening_traffic_duration` in `yandex_compute_instance_group`
* add `service` attribute to `auto_scale.custom_rule` in `yandex_compute_instance_group` resource and data source
* add `folder_id` attribute to `auto_scale.custom_rule` in `yandex_compute_instance_group` resource and data source
* add `nat_ip_address` attribute to `instance_template.network_interface` in `yandex_compute_instance_group` resource and data source
* add `disk_id` attribute to `instance_template.boot_disk`,`instance_template.secondary_disk` in `yandex_compute_instance_group`
* support of changing `cloud_storage` attribute in `yandex_mdb_clickhouse_cluster` resource
* apigateway: change `spec` attribute from filename to string
* docs: add info about timeouts for `yandex_compute_snapshot`
* docs: add `yandex_api_gateway`
* add `content_type` attribute in `yandex_storage_object` resource

BUG FIXES:
* compute: Remove restrictions for `type` attribute at `instance_template.boot_disk.initialize_params`,`instance_template.secondary_disk.initialize_params` in `yandex_compute_instance_group`
* functions: `execution_timeout` attribute change now provides `yandex_function` resource update

## 0.60.0 (June 17, 2021)
FEATURES:
* **New Data Source:** `yandex_alb_virtual_host`
* **New Resource:** `yandex_alb_virtual_host`
* **New Data Source:** `yandex_mdb_elasticsearch_cluster`
* **New Resource:** `yandex_mdb_elasticsearch_cluster`

ENHANCEMENTS:
* mdb: add `maintenance_window` section in `yandex_mdb_mongodb_cluster`, `yandex_mdb_postgresql_cluster` resource and data source
* dataproc: added support for properties modification
* k8s: support `network_acceleration_type` in k8s node group resource and data source.
* k8s: support Cilium network implementation in k8s cluster and data source.

BUG FIXES:
* mdb: fixed some errors in implementation of Kafka topics modification
* dns: fixed field name error
* dns: fixed diff with compact ipv6 data records in `yndex_dns_recordset`

## 0.59.0 (June 6, 2021)
FEATURES:
* **New Data Source:** `yandex_alb_http_router`
* **New Resource:** `yandex_alb_http_router`
* **New Data Source:** `yandex_alb_backend_group`
* **New Resource:** `yandex_alb_backend_group`
* add `autoscaling_config` to Yandex Data Processing subcluster specification
* add `ip_address` and `ipv6_address` attributes  to `network_interface` entity in `yandex_compute_instance_group`
* **New Resource** `yandex_vpc_default_security_group` for network's default security group managment

ENHANCEMENTS:
* managed-redis: added `notify_keyspace_events`, `slowlog_log_slower_than`, `slowlog_max_len` and `databases` fields
* mdb: add `maintenance_window` section in `yandex_mdb_clickhouse_cluster`, `yandex_mdb_mysql_cluster` and `yandex_mdb_redis_cluster` resource and data source
* add `num_partitions` and `default_replication_factor` attributes in `yandex_mdb_kafka_cluster` resource and data source
* change of `dns_record`, `ipv6_dns_record` and `nat_dns_record` in `network_interface` entity of `yandex_compute_instance`
  without instance drop

BUG FIXES:
* mdb: throw error when trying to modify `owner` in `database` block in `yandex_mdb_postgresql_cluster`

## 0.58.0 (May 14, 2021)
FEATURES:
* **New Data Source:** `yandex_alb_target_group`
* **New Resource:** `yandex_alb_target_group`
* add `ipv6` and `ipv4` attributes to yandex_kubernetes_node_group network interfaces both in resource and the data source.

## 0.57.0 (April 29, 2021)
FEATURES:
* support k8s node group placement groups both in resource and data source.
* add cluster_ipv6_range and service_ipv6_range attributes both to resource yandex_kubernetes_cluster and data source yandex_kubernetes_cluster
* add `host_group_ids` attribute in `yandex_mdb_kafka_cluster` resource and data source
* add `host_group_ids` attribute in `yandex_dataproc_cluster` resource and data source

ENHANCEMENTS:
* add `dns_record`, `ipv6_dns_record` and `nat_dns_record` to `network_interface` entity in `yandex_compute_instance`

## 0.56.0 (April 15, 2021)
ENHANCEMENTS:
* dataproc: supported `security_group_ids`
* add `dns_record`, `ipv6_dns_record` and `nat_dns_record` to `network_interface` entity in `yandex_compute_instance_group`
* ydb: support for Yandex Database clusters
* compute: increase disk size limit from 4096Gb to 8192Gb
* vpc: add `name` field description at vpc_security_group datasource and example of it usage

BUG FIXES:
* compute: placement_policy update in `yandex_compute_instance_group`

## 0.55.0 (April 1, 2021)
FEATURES:
* storage: `yandex_storage_bucket` resource supports bucket policy configuration

ENHANCEMENTS:
* add extended API logging. Use TF_ENABLE_API_LOGGING=1 with TF_LOG=debug to see extended output.
* support IAM token in tests
* managed-redis: added 'tls_enabled' field
* managed-kafka: added 'unmanaged_topics' cluster flag and some cluster config flags
* mdb: add `host` attribute in `yandex_mdb_kafka_cluster` resource and data source

BUG FIXES:
* serverless: fix API Gateway specification update

## 0.54.0 (March 23, 2021)
ENHANCEMENTS:
* provider: the default development, testing and building of the provider is now done with Go 1.16.
* serverless: supported API Gateway

BUG FIXES:
* mdb: fix user settings diff for ClickHouse cluster

## 0.53.0 (March 19, 2021)
ENHANCEMENTS:
* mdb: add example and update documentation for `yandex_mdb_postgresql_cluster` resource
* serverless: supported log-group trigger

BUG FIXES:
* dns: fix recordset update in `yandex_dns_recordset`
* storage: Fix timeout while applying CORS settings with empty fields

## 0.52.0 (March 10, 2021)
FEATURES:
* **New Resource:** `yandex_mdb_sqlserver_cluster`
* managed-kubernetes: support `security_group_ids` for `yandex_kubernetes_node_group` resource and data source
* **New Resource:** `yandex_dns_zone`
* **New Resource:** `yandex_dns_recordset`
* **New Data Source:** `yandex_dns_zone`
* serverless: support import for all resources
* **New Resource:** `yandex_container_repository`
* **New Resource:** `yandex_container_repository_iam_binding`
* **New Data Source:** `yandex_container_repository`

ENHANCEMENTS:
* mdb: add `service_account_id` section in `yandex_mdb_clickhouse_cluster` resource and data source
* mdb: add `cloud_storage` section in `yandex_mdb_clickhouse_cluster` resource and data source
* managed-kubernetes: added `network_interface` section for `yandex_kubernetes_node_group`
* managed-redis: added 'disk_type_id' field

WARNING:
* managed-kubernetes: `nat` entitiy and `subnet_id` entity in `allocation_policy` section for `yandex_kubernetes_node_group` is now deprecated
* mdb: when changing the `assign_public_ip` attribute to `host` entity in  `yandex_mdb_mysql_cluster`, the old host is deleted and a new host is created
* mdb: add `allow_regeneration_host` attribute in `yandex_mdb_mysql_cluster` resource

BUG FIXES:
* mdb: fix host delete in `yandex_mdb_mysql_cluster`

## 0.51.1 (February 20, 2021)
ENHANCEMENTS:
* compute: add documentation and example for non-replicated disk

## 0.51.0 (February 19, 2021)
FEATURES:
* compute: support yandex_disk_placement_group resource and data source.
* compute: integrate yandex_disk_placement_group with compute disk resource and data source.
* mdb: added the ability to upgrade the Mysql version using the `version` attribute in `yandex_mdb_mysql_cluster`

ENHANCEMENTS:
* mdb: add `restore` entity in `yandex_mdb_mysql_cluster` resource
* mdb: add `connection_limits`, `global_permissions` and `authentication_plugin` attributes to `user` entity in `yandex_mdb_mysql_cluster` resource and data source
* mdb: add `restore` entity in `yandex_mdb_postgresql_cluster` resource
* mdb: add `settings` and `quota` sections to `user` entity in `yandex_mdb_clickhouse_cluster` resource and data source.
* iam: corrected documentation for `yandex_resourcemanager_cloud_iam_binding` resource.
* iam: corrected documentation for `yandex_resourcemanager_folder_iam_binding` resource.

BUG FIXES:
* mdb: fix updating user permissions for Kafka cluster

WARNING:
* mdb: replace sets with lists for users in `yandex_mdb_mysql_cluster`. There can appear changes in diff for users, which will not change anything and will disappear after apply

## 0.50.0 (February 5, 2021)
FEATURES:
* **New Resource:** `yandex_container_registry_iam_binding`
* mdb: version 13 is available in `yandex_mdb_postgresql_cluster`
* storage: `yandex_storage_bucket` resource supports versioning configuration
* storage: `yandex_storage_bucket` resource supports logging configuration
* vpc: add example for ddos protected address documentation
* compute: support yandex_placement_group resource and data source.
* compute: integrate yandex_placement_group with compute instance and instance group resources and data source.

ENHANCEMENTS:
* storage: add bucket configuration example
* mdb: support `security_group_ids` for managed service for kafka
* mdb: add `web_sql` and `data_lens` attribute to `access` entity in `yandex_mdb_mysql_cluster` resource and data source
* mdb: add `mysql_config` attribute in `yandex_mdb_mysql_cluster` resource and data source
* mdb: add `format_schema` section in `yandex_mdb_clickhouse_cluster` resource and data source
* mdb: add `ml_model` section in `yandex_mdb_clickhouse_cluster` resource and data source
* mdb: add `replication_source_name`, `priority` attributes to `host`entity and `host_master_name` attribute in `yandex_mdb_postgresql_cluster` resource and data source
* mdb: add `sql_user_management` and `sql_database_management` attributes in `yandex_mdb_clickhouse_cluster` resource and data_source
* mdb: add `admin_password` attribute in `yandex_mdb_clickhouse_cluster` resource
* kms: add sensitive flag for `plaintext` attribute in `yandex_kms_secret_ciphertext` resource
* managed-kubernetes: support `security_group_ids` for `yandex_kubernetes_cluster` resource and data source

## 0.49.0 (January 15, 2021)
FEATURES:
* storage: `yandex_storage_bucket` resource supports lifecycle configuration

ENHANCEMENTS:
* mdb: changing `folder_id` attribute in `yandex_mdb_postgresql_cluster` moves PostgreSQL cluster to new folder
* mdb: add `web_sql` attribute to `config.access` entity in `yandex_mdb_postgresql_cluster` resource and data source
* mdb: add `performance_diagnostics` attribute to `config` entity in `yandex_mdb_postgresql_cluster` resource and data source
* mdb: add `settings` attribute to `user` entity in `yandex_mdb_postgresql_cluster` resource and data source
* mdb: add `postgresql_config` attribute to `config` entity in `yandex_mdb_postgresql_cluster` resource and data
* mdb: support `security_group_ids` in all database cluster resources and data sources
* compute: `strategy` attribute to `deploy_policy` entity in `yandex_compute_instance_group` resource and data source
* vpc: extend validation for listener spec in `yandex_lb_network_load_balancer` resource

## 0.48.0 (December 22, 2020)
BUG FIXES:
* mdb: fix setting of folder_id field for MongoDB cluster
* dataproc: add documentation for the `ui_proxy` attribute
* vpc: fix panic on reading `yandex_vpc_address` resource

ENHANCEMENTS:
* mdb: add `conn_limit` attribute to `user` entity in `yandex_mdb_postgresql_cluster` resource and data source
* mdb: add `config` section in `yandex_mdb_clickhouse_cluster` resource and data source

## 0.47.0 (November 10, 2020)
BUG FIXES:
* kms: fix import operation
* serverless: folder_id can be using from yandex_function, yandex_function_trigger, yandex_iot_core_registry
* serverless: crash fix for dlq option in yandex_function_trigger

ENHANCEMENTS:
* vpc: default_security_group_id field was added to network resource and data source
* provider: support authentication via IAM token

FEATURES:
* mdb: support ClickHouse shard groups in `yandex_mdb_clickhouse_cluster`

## 0.46.0 (October 19, 2020)
BUG FIXES:
* vpc: Security group rule port bugfix: can create rules without specifying a port
* vpc: Fix internal_address_spec block in network load balancer resource doc
* vpc: Security group ANY port bug fix
* dataproc: support for UI Proxy

ENHANCEMENTS:
* serverless: improved zip archive content size limit excession error message

## 0.45.1 (October 06, 2020)

BUG FIXES:
* fix release issue

## 0.45.0 (October 05, 2020)
FEATURES:
* mdb: support MongoDB 4.4 in `yandex_mdb_mongodb_cluster`
* vpc: address resource & data source

ENHANCEMENTS:
* lb: improve NLB sweeper and tests

BUG FIXES:
* vpc: `static_route` in `yandex_vpc_route_table` is optional now

## 0.44.1 (September 24, 2020)

BUG FIXES:
* vpc: fix "security_group" data source

## 0.44.0 (September 22, 2020)

FEATURES:
* vpc: security group rule targets `security_group_id` and `predefined_target` are supported
* storage: `yandex_storage_bucket` resource can manage SSE

ENHANCEMENTS:
* some changes in security group resource

BUG FIXES:
* lb: fix modifying listener settings

## 0.43.0 (August 20, 2020)

FEATURES:
* iam: support for resolving by name in `yandex_iam_service_account` data source

BUG FIXES:
* compute: fix `yandex_compute_instance` update trying to re-configure dymanic NAT
* mdb: replace sets with lists for users and databases in `yandex_mdb_postgresql_cluster`.
WARNING: there can appear changes in diff for users and databases, which will not change anything and will disappear after apply

## 0.42.1 (August 04, 2020)

BUG FIXES:
* compute: fix panic on parsing `instance_template.network_interface.security_group_ids` attribute in `yandex_compute_instance_group` resource

## 0.42.0 (July 27, 2020)
FEATURES:
* mdb: support Redis 6.0 in `yandex_mdb_redis_cluster`

FEATURES:
* **New Data Source:** `yandex_client_config`

ENHANCEMENTS:
* mdb: add `role` attribute to `host` entity in `yandex_mdb_postgresql_cluster` resource and data source
* compute: support update of `network_interface` attribute for `yandex_compute_instance` resource

BUG FIXES:
* compute: fix `secondary_disk` validation in `yandex_compute_instance_group` resource
* compute: remove `secondary_disk.security_group_ids` attribute from `yandex_compute_instance` data source

## 0.41.1 (June 24, 2020)

BUG FIXES:
* vpc: fix panic on empty subnet dhcp options on `yandex_vpc_subnet` resource ([#82](https://github.com/terraform-providers/terraform-provider-yandex/issues/82))

## 0.41.0 (June 23, 2020)
FEATURES:
* **New Data Source:** `yandex_message_queue`
* **New Resource:** `yandex_message_queue`
* vpc: allow setting dhcp options for `yandex_vpc_subnet`

ENHANCEMENTS:
* mdb: document mdb enumerables for Redis, MongoDB and ClickHouse
* provider: support set 'service_account_key_file' as either the path to or the contents of a Service Account key file in JSON format
* managed-kubernetes: support `gpus` attribute for `yandex_kubernetes_node_group`
* compute: add `instance_template.scale_policy.test_auto_scale` attribute in `yandex_compute_instance_group` resource and data source
* compute: add `deletion_protection` attribute in `yandex_compute_instance_group` resource and data source
* compute: add `instance_template.network_interface.security_group_ids` attribute in `yandex_compute_instance_group` resource and data source
* compute: add `network_interface.security_group_ids` attribute in `yandex_compute_instance` resource and data source

BUG FIXES:
* mdb: fix typo in using mdb api by `resource_yandex_mdb_postgresql_cluster`
* vpc: fix removing `yandex_vpc_subnet` attribute `route_table_id`

## 0.40.0 (May 22, 2020)
FEATURES:
* **New Resource:** `yandex_function_iam_binding`

BUG FIXES:
* compute: add `ipv4` flag in `yandex_compute_instance` data source
* mdb: fix disk size change on `mdb_mongodb` resource update
* mdb: adding database with its owner to existing `resource_yandex_mdb_postgresql_cluster` simultaneously

## 0.39.0 (May 05, 2020)
ENHANCEMENTS:
* mdb: add `roles` attribute to `user` entity in `mdb_mongodb` resource and data source
* compute: change allowed disk type from `network-nvme` to `network-ssd`
* compute: `ipv4` flag determines whether to assign a IPv4 address for `network_interface` in `yandex_compute_instance` and `yandex_compute_instance_group`

## 0.38.0 (April 22, 2020)
FEATURES:
* **New Data Source:** `yandex_vpc_security_group`
* **New Resource:** `yandex_vpc_security_group`

ENHANCEMENTS:
* managed-kubernetes: allow to create cluster with KMS provider for secrets encryption.

## 0.37.0 (April 16, 2020)
ENHANCEMENTS:
* storage: support custom acl grants for `yandex_storage_bucket`

## 0.36.0 (April 16, 2020)
ENHANCEMENTS:
* compute: add `variables` attribute in `yandex_compute_instance_group` resource and data source
* compute: add `status` attribute in `yandex_compute_instance_group` resource and data source
* compute: add `instance_template.name` attribute in `yandex_compute_instance_group` resource and data source
* compute: add `instance_template.hostname` attribute in `yandex_compute_instance_group` resource and data source
* compute: add `instances.status_changed_at` attribute in `yandex_compute_instance_group` resource and data source
* managed-kubernetes: add `node_ipv4_cidr_mask_size` attribute to `yandex_kubernetes_cluster` resource and data source
* managed-kubernetes: add `deploy_policy.max_unavailable` and `deploy_policy.max_expansion` attributes to `yandex_kubernetes_node_group` resource and data source
* serverless: add `environment` attribute in `yandex_function` resource and data source

BUG FIXES:
* mdb: fix modifying `yandex_mdb_mysql_cluster` attribute `backup_window_start`

## 0.35.0 (March 31, 2020)
FEATURES:
* **New Resource:** `yandex_kms_secret_ciphertext`

ENHANCEMENTS:
* mdb: add `config_spec.access.serverless` attribute in `resource_yandex_mdb_clickhouse_cluster` resource and data source

BUG FIXES:
* mdb: forbidden to change user settings that are not present in the scheme of `resource_yandex_mdb_postgresql_cluster`
* compute: compute instance attribute `hostname` is now filled when imported

## 0.34.0 (March 18, 2020)
FEATURES:
* **New Data Source:** `yandex_function`
* **New Data Source:** `yandex_function_trigger`
* **New Resource:** `yandex_function`
* **New Resource:** `yandex_function_trigger`

ENHANCEMENTS:
* compute: add `instance_template.network_settings` attribute in `yandex_compute_instance_group` resource and data source

## 0.33.0 (March 06, 2020)
FEATURES:
* **New Data Source:** `yandex_iot_core_registry`
* **New Data Source:** `yandex_iot_core_device`
* **New Resource:** `yandex_iot_core_registry`
* **New Resource:** `yandex_iot_core_device`

ENHANCEMENTS:
* managed-kubernetes: support network policy provider for `yandex_kubernetes_cluster` ([#45](https://github.com/terraform-providers/terraform-provider-yandex/issues/45))
* managed-kubernetes: add `node_labels`, `node_taints` and `allowed_unsafe_sysctls` fields for `yandex_kubernetes_node_group`

BUG FIXES:
* mdb: throw error when trying to modify `assign_public_ip` in `resource_yandex_mdb_postgresql_cluster`,`resource_yandex_mdb_mysql_cluster`

## 0.32.0 (February 28, 2020)
FEATURES:
* compute: allow setting public IP address for `yandex_compute_instance`
* mdb: support ClickHouse cluster access for Yandex.Metrica

BUG FIXES:
* mdb: disallow change `lc_collate` and `lc_ctype` in `yandex_mdb_postgresql_cluster` after creation.
* container-registry: prevent terraform crash during `terraform destroy` execution for non-existent container registry.
* resourcemanager: data source folder. fixed folder_id resolve by name (would fail without folder_id in provider config)
* managed-kubernetes: k8s cluster version update no longer requires destroying of resource
* managed-kubernetes: update of maintenance window `start_time` and `duration` will now trigger resource update

## 0.31.0 (February 14, 2020)
FEATURES:
* compute: software network acceleration for `yandex_compute_instance`
* mdb: support roles for users in `yandex_mdb_mysql_cluster`

ENHANCEMENTS:
* compute: support metric labels for custom rules in `yandex_compute_instance_group` resource `scale_policy.auto_scale` attribute

BUG FIXES:
* lb: fix modifying health check settings

## 0.30.0 (February 04, 2020)
FEATURES:
* **New Data Source:** `yandex_dataproc_cluster`
* **New Resource:** `yandex_dataproc_cluster`

ENHANCEMENTS:
* managed-kubernetes: support autoscaled `yandex_kubernetes_node_group`

## 0.29.1 (January 29, 2020)
BUG FIXES:
* resourcemanager: data source cloud. fixed cloud_id resolve by name (would fail without folder_id in provider config)

## 0.29.0 (January 24, 2020)
FEATURES:
* **New Data Source:** `yandex_mdb_mysql_cluster`
* **New Data Source:** `yandex_mdb_postgresql_cluster`
* **New Resource:** `yandex_mdb_mysql_cluster`
* **New Resource:** `yandex_mdb_postgresql_cluster`

## 0.28.0 (January 13, 2020)
FEATURES:
* **New Resource:** `yandex_kms_symmetric_key`

ENHANCEMENTS:
* managed-kubernetes: support maintenance policy for `yandex_kubernetes_cluster` and `yandex_kubernetes_node_group`
* lb: `yandex_lb_network_load_balancer` now supports UDP for `protocol` attribute.

BUG FIXES:
* provider: fix `message type "google.protobuf.Empty" isn't linked in` ([#35](https://github.com/terraform-providers/terraform-provider-yandex/issues/35))

## 0.27.0 (December 20, 2019)
FEATURES:
* **New Data Source:** `yandex_mdb_mongodb_cluster`
* **New Resource:** `yandex_mdb_mongodb_cluster`

ENHANCEMENTS:
* mdb: support sharding in `yandex_mdb_clickhouse_cluster`
* lb: changes in `yandex_lb_network_load_balancer` support ipv6 at listener.0.external_address_spec.ip_version

## 0.26.0 (December 06, 2019)
ENHANCEMENTS:
* compute: support for custom rules in `yandex_compute_instance_group.scale_policy.auto_scale`

## 0.25.0 (December 05, 2019)
FEATURES:
* **New Data Source:** `yandex_mdb_clickhouse_cluster`
* **New Resource:** `yandex_mdb_clickhouse_cluster`

## 0.24.0 (December 03, 2019)
BUG FIXES:
* managed-kubernetes: changes in `yandex_kubernetes_node_group` allocation_policy should trigger destroy/add.
* managed-kubernetes: changes in `yandex_kubernetes_cluster` location, release_channel should trigger destroy/add.
* managed-kubernetes: changes in `yandex_kubernetes_cluster` master.0.version should NOT trigger destroy/add, and use update instead.
* managed-kubernetes: forbidden zero values in `yandex_kubernetes_node_group`, in instance_template.0.resources.0.memory(cores)
* managed-kubernetes: fill `instance_group_id` field in `yandex_kubernetes_node_group` datasource and resource.

ENHANCEMENTS:
* compute: support update of service_account_id in `yandex_compute_instance` without resource recreation.
* datasource resolving by name now uses folder_id from its config (when provided), affected datasources:
`yandex_compute_disk`,  `yandex_compute_image`, `yandex_compute_instance`, `yandex_compute_snapshot`,
`yandex_container_registry`, `yandex_kubernetes_cluster`, `yandex_kubernetes_node_group`,
`yandex_lb_network_load_balancer`, `yandex_lb_target_group`, `yandex_mdb_redis_cluster`,
`yandex_vpc_network`, `yandex_vpc_route_table`, `yandex_vpc_subnet`.

## 0.23.0 (November 05, 2019)
ENHANCEMENTS:
* mdb: support sharding in `yandex_mdb_redis_cluster`
* compute: increase `yandex_compute_snapshot` timeout from 5 to 20 minutes

BUG FIXES:
* managed-kubernetes: mark as computable `version` and `public_ip` in `yandex_kubernetes_cluster` resource

## 0.22.0 (October 24, 2019)
ENHANCEMENTS:
* compute: add `instances` to `yandex_compute_instance_group` resource
* mdb: add fqdns of hosts in `yandex_mdb_redis_cluster` resource and data source
* managed-kubernetes: add `version` to `yandex_kubernetes_node_group` resource

## 0.21.0 (October 17, 2019)
ENHANCEMENTS:
* storage: `yandex_storage_bucket` and `yandex_storage_object` resources can manage ACL

## 0.20.0 (October 15, 2019)
FEATURES:
* **New Resource:** `yandex_storage_bucket`
* **New Resource:** `yandex_storage_object`

## 0.19.0 (October 15, 2019)
ENHANCEMENTS:
* managed-kubernetes: `yandex_kubernetes_node_group` resource can now be imported
* managed-kubernetes: `yandex_kubernetes_cluster` resource can now be imported

BUG FIXES:
* minor documentation fixes for Kubernetes cluster resource and instance group datasource.

## 0.18.0 (October 11, 2019)
ENHANCEMENTS:
* provider: support authentication via instance service account from inside an instance

BUG FIXES:
* container: increase default timeout

## 0.17.0 (October 02, 2019)
FEATURES:
* compute: auto_scale support added for `yandex_compute_instance_group` resource and data source

## 0.16.0 (October 01, 2019)
* **New Data Source:** `yandex_mdb_redis_cluster`
* **New Resource:** `yandex_mdb_redis_cluster`

## 0.15.0 (September 30, 2019)
FEATURES:
* **New Data Source:** `yandex_kubernetes_cluster`
* **New Data Source:** `yandex_kubernetes_node_group`
* **New Resource:** `yandex_kubernetes_cluster`
* **New Resource:** `yandex_kubernetes_node_group`

## 0.14.0 (September 27, 2019)
* provider: migrate to standalone Terraform SDK module ([#22](https://github.com/terraform-providers/terraform-provider-yandex/issues/22))
* provider: support graceful shutdown
* iam: use logic lock on cloud while create SA to prevent simultaneous IAM membership changes
* container: resolve data source `yandex_container_registry` by name.

## 0.13.0 (September 23, 2019)
FEATURES:
* **New Resource:** `yandex_iam_service_account_api_key`
* **New Resource:** `yandex_iam_service_account_key`

ENHANCEMENTS:
* compute: `yandex_compute_snapshot` resource can now be imported
* iam: `yandex_iam_service_account` resource can now be imported
* iam: `yandex_iam_service_account_static_access_key` resource now supports `pgp_key` field.

## 0.12.0 (September 20, 2019)
FEATURES:
* **New Data Source:** `yandex_container_registry`
* **New Resource:** `yandex_container_registry`

## 0.11.2 (September 19, 2019)
ENHANCEMENTS:
* provider: provider uses permanent client-request-id identifier while the terraform is running

BUG FIXES:
* provider: fix provider name and version detection

## 0.11.1 (September 13, 2019)
ENHANCEMENTS:
* provider: set provider name and version in user agent header.

BUG FIXES:
* compute: fix flattening of health checks for `yandex_compute_instance_group` resource

## 0.11.0 (September 11, 2019)
ENHANCEMENTS:
* compute: add `resources.0.gpus` attribute in `yandex_compute_instance` resource and data source
* compute: add `resources.0.gpus` attribute in `yandex_compute_instance_group` resource and data source

## 0.10.2 (September 09, 2019)
ENHANCEMENTS:
* compute: `yandex_compute_snapshot` resource can now be imported
* iam: `yandex_iam_service_account` resource can now be imported

BUG FIXES:
* compute: fix read operation of `yandex_compute_instance`

## 0.10.1 (August 26, 2019)
BUG FIXES:
* resourcemanager: resources `yandex_*_iam_binding`, `yandex_•_iam_policy` works with full set of bindings.

## 0.10.0 (August 21, 2019)
BUG FIXES:
* vpc: remove `v6_cidr_blocks` attr in `yandex_vpc_subnet` resource. This property is not available right now.

ENHANCEMENTS:
* compute: instance_group data source and resource support new fields in `load_balancer` section.
* resourcemanager: support lookup `yandex_resourcemanager_folder` at specific cloud_id. ([#17](https://github.com/terraform-providers/terraform-provider-yandex/issues/17))

## 0.9.1 (August 14, 2019)
ENHANCEMENTS:
* compute: use `min_disk_size` of image or `disk_size` of snapshot to set size of boot_disk on instance template for `yandex_compute_instance_group`.

## 0.9.0 (August 07, 2019)
FEATURES:
* **New Data Source:** `yandex_lb_network_load_balancer`
* **New Data Source:** `yandex_lb_target_group`
* **New Resource:** `yandex_lb_network_load_balancer`
* **New Resource:** `yandex_lb_target_group`

ENHANCEMENTS:
* compute: use `min_disk_size` of image or `disk_size` of snapshot to set size of boot_disk on instance create.
* compute: update instance resource spec and platform type in one request.

BUG FIXES:
* compute: change attribute `folder_id` from Required to Optional for `yandex_compute_instance_group` resource [[#14](https://github.com/terraform-providers/terraform-provider-yandex/issues/14)].

## 0.8.1 (July 04, 2019)
BUG FIXES:
* compute: fix `yandex_compute_instance_group` with `load_balancer_spec` defined [[#13](https://github.com/terraform-providers/terraform-provider-yandex/issues/13)].

## 0.8.0 (June 25, 2019)
FEATURES:
* **New Data Source**: `yandex_compute_instance_group`
* **New Resource**: `yandex_compute_instance_group`

## 0.7.0 (June 06, 2019)
ENHANCEMENTS:
* provider: Support SDK retries.

## 0.6.0 (May 29, 2019)
NOTES:
* provider: This release includes a Terraform SDK upgrade with compatibility for Terraform v0.12.
* provider: Switch dependency management to Go modules. ([#5](https://github.com/terraform-providers/terraform-provider-yandex/issues/5))

## 0.5.2 (April 24, 2019)
ENHANCEMENTS:
* compute: fractional values for memory for `yandex_compute_instance`.
* compute: `yandex_compute_instance` support update platform_id in stopped state.

## 0.5.1 (April 20, 2019)
BUG FIXES:
* compute: fix migration process for `yandex_compute_instance`.

## 0.5.0 (April 17, 2019)
ENHANCEMENTS:
* all: save new entity identifiers at start of create operation
* compute: `yandex_compute_instance` support update resources in stopped state.
* compute: change attribute `resources` type from Set to List

## 0.4.1 (April 11, 2019)
BUG FIXES:
* compute: fix properties of `service_account_id` attribute.

## 0.4.0 (April 09, 2019)
ENHANCEMENTS:
* compute: `yandex_compute_instance` adds a `service_account_id` attribute.

## 0.3.0 (April 03, 2019)
FEATURES:
* **New Datasource**: `yandex_vpc_route_table`
* **New Resource**: `yandex_vpc_route_table`

ENHANCEMENTS:
* vpc: `yandex_vpc_subnet` adds a `route_table_id` field.

## 0.2.0 (March 26, 2019)
ENHANCEMENTS:
* provider: authentication with service account key file. ([#3](https://github.com/terraform-providers/terraform-provider-yandex/issues/3))
* vpc: increase subnet create/update/delete timeout.
* vpc: resolve data source `network`, `subnet` by name.
* compute: resolve data source `instance`, `disk`, `image`, `snapshot` objects by names.
* resourcemanager: resolve data source `folder` by name.

## 0.1.16 (March 14, 2019)
ENHANCEMENTS:
* compute: support preemptible instance type.

BUG FIXES:
* compute: fix update method on compute resources for description attribute.

## 0.1.15 (February 22, 2019)

BACKWARDS INCOMPATIBILITIES:
* compute: `yandex_compute_disk.source_image_id` and `yandex_compute_disk.source_snapshot_id` has been removed.
* iam: `iam_service_account_key` was renamed to `iam_service_account_static_access_key`.

ENHANCEMENTS:
* provider: more descriptive error messages.
* compute: `yandex_compute_disk` support for increasing size without force recreation of the resource.

BUG FIXES:
* compute: make consistent disk type attribute name `type_id` -> `type`.
* compute: remove attr `instance_id` from `yandex_compute_instance`.
* compute: make `yandex_compute_instancenet.network_interface.*.nat` ForceNew.

## 0.1.14 (December 26, 2018)

FEATURES:
* **New Data Source:** `yandex_compute_disk`
* **New Data Source:** `yandex_compute_image`
* **New Data Source:** `yandex_compute_instance`
* **New Data Source:** `yandex_compute_snapshot`
* **New Data Source:** `yandex_iam_policy`
* **New Data Source:** `yandex_iam_role`
* **New Data Source:** `yandex_iam_service_account`
* **New Data Source:** `yandex_iam_user`
* **New Data Source:** `yandex_resourcemanager_cloud`
* **New Data Source:** `yandex_resourcemanager_folder`
* **New Data Source:** `yandex_vpc_network`
* **New Data Source:** `yandex_vpc_subnet`
* **New Resource:** `yandex_compute_disk`
* **New Resource:** `yandex_compute_image`
* **New Resource:** `yandex_compute_instance`
* **New Resource:** `yandex_compute_snapshot`
* **New Resource:** `yandex_iam_service_account`
* **New Resource:** `yandex_iam_service_account_iam_binding`
* **New Resource:** `yandex_iam_service_account_iam_member`
* **New Resource:** `yandex_iam_service_account_iam_policy`
* **New Resource:** `yandex_iam_service_account_key`
* **New Resource:** `yandex_vpc_network`
* **New Resource:** `yandex_vpc_subnet`
* **New Resource:** `yandex_resourcemanager_cloud_iam_binding`
* **New Resource:** `yandex_resourcemanager_cloud_iam_member`
* **New Resource:** `yandex_resourcemanager_folder_iam_binding`
* **New Resource:** `yandex_resourcemanager_folder_iam_member`
* **New Resource:** `yandex_resourcemanager_folder_iam_policy`

ENHANCEMENTS:
* compute: support IPv6 addresses
* vpc: support IPv6 addresses
