# Terraform в Yandex Cloud

Terraform — инструмент для управления вашей облачной инфраструктурой как кодом (Infrastructure as a Code, IaC) с помощью файлов конфигурации.

Yandex Cloud предоставляет провайдер, набор модулей и ряд готовых решений, которые  вы можете адаптировать под свои задачи.

# Terraform в Yandex Cloud

 - [Начало работы](quickstart.md)

 - [Настройка аутентификации Terraform-провайдера Yandex Cloud](authentication.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Провайдеры](concepts/providers.md)

 - [Ресурсы](concepts/resources.md)

 - [Источники данных](concepts/data-sources.md)

 - [Модули](concepts/modules.md)

 - [Состояния](concepts/states.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Источники данных Terraform](tutorials/terraform-data-sources.md)

 - [Использование модулей Terraform](tutorials/terraform-modules.md)

 - [Загрузка состояний Terraform в Yandex Object Storage](tutorials/terraform-state-storage.md)

 - [Блокировка состояний Terraform с помощью Yandex Managed Service for YDB](tutorials/terraform-state-lock.md)

 - [Библиотека решений](solution-library.md)

## Справочник Terraform

 - [Обзор](tf-ref/overview.md)

 - [История изменений (англ.)](release-notes.md)

### Ресурсы (англ.)

#### Application Load Balancer

##### Data Sources

 - [alb_backend_group](data-sources/alb_backend_group.md)

 - [alb_http_router](data-sources/alb_http_router.md)

 - [alb_load_balancer](data-sources/alb_load_balancer.md)

 - [alb_target_group](data-sources/alb_target_group.md)

 - [alb_virtual_host](data-sources/alb_virtual_host.md)

##### Resources

 - [alb_backend_group](resources/alb_backend_group.md)

 - [alb_http_router](resources/alb_http_router.md)

 - [alb_load_balancer](resources/alb_load_balancer.md)

 - [alb_target_group](resources/alb_target_group.md)

 - [alb_virtual_host](resources/alb_virtual_host.md)

#### Audit Trails

##### Data Sources

 - [audit_trails_trail](data-sources/audit_trails_trail.md)

##### Resources

 - [audit_trails_trail](resources/audit_trails_trail.md)

#### Billing

##### Data Sources

 - [billing_cloud_binding](data-sources/billing_cloud_binding.md)

##### Resources

 - [billing_cloud_binding](resources/billing_cloud_binding.md)

#### Certificate Manager

##### Data Sources

 - [cm_certificate](data-sources/cm_certificate.md)

 - [cm_certificate_content](data-sources/cm_certificate_content.md)

##### Resources

 - [cm_certificate](resources/cm_certificate.md)

 - [cm_certificate_iam_binding](resources/cm_certificate_iam_binding.md)

 - [cm_certificate_iam_member](resources/cm_certificate_iam_member.md)

#### Client Config

##### Data Sources

 - [client_config](data-sources/client_config.md)

#### Cloud Backup

##### Data Sources

 - [backup_policy](data-sources/backup_policy.md)

##### Resources

 - [backup_policy](resources/backup_policy.md)

 - [backup_policy_bindings](resources/backup_policy_bindings.md)

#### Cloud CDN

##### Data Sources

 - [cdn_origin_group](data-sources/cdn_origin_group.md)

 - [cdn_resource](data-sources/cdn_resource.md)

##### Resources

 - [cdn_origin_group](resources/cdn_origin_group.md)

 - [cdn_resource](resources/cdn_resource.md)

#### Cloud DNS

##### Data Sources

 - [dns_firewall](data-sources/dns_firewall.md)

 - [dns_inbound_endpoint](data-sources/dns_inbound_endpoint.md)

 - [dns_zone](data-sources/dns_zone.md)

##### Resources

 - [dns_firewall](resources/dns_firewall.md)

 - [dns_firewall_iam_binding](resources/dns_firewall_iam_binding.md)

 - [dns_inbound_endpoint](resources/dns_inbound_endpoint.md)

 - [dns_inbound_endpoint_iam_binding](resources/dns_inbound_endpoint_iam_binding.md)

 - [dns_recordset](resources/dns_recordset.md)

 - [dns_zone](resources/dns_zone.md)

 - [dns_zone_iam_binding](resources/dns_zone_iam_binding.md)

#### Cloud Desktop

##### Data Sources

 - [cloud_desktops_desktop](data-sources/cloud_desktops_desktop.md)

 - [cloud_desktops_desktop_group](data-sources/cloud_desktops_desktop_group.md)

 - [cloud_desktops_image](data-sources/cloud_desktops_image.md)

##### Resources

 - [cloud_desktops_desktop](resources/cloud_desktops_desktop.md)

 - [cloud_desktops_desktop_group](resources/cloud_desktops_desktop_group.md)

#### Cloud Logging

##### Data Sources

 - [api_gateway](data-sources/api_gateway.md)

 - [function](data-sources/function.md)

 - [function_trigger](data-sources/function_trigger.md)

 - [logging_group](data-sources/logging_group.md)

##### Resources

 - [api_gateway](resources/api_gateway.md)

 - [function](resources/function.md)

 - [function_iam_binding](resources/function_iam_binding.md)

 - [function_trigger](resources/function_trigger.md)

 - [logging_group](resources/logging_group.md)

#### Cloud Registry

##### Data Sources

 - [cloudregistry_lifecycle_policy](data-sources/cloudregistry_lifecycle_policy.md)

 - [cloudregistry_registry](data-sources/cloudregistry_registry.md)

 - [cloudregistry_registry_ip_permission](data-sources/cloudregistry_registry_ip_permission.md)

##### Resources

 - [cloudregistry_lifecycle_policy](resources/cloudregistry_lifecycle_policy.md)

 - [cloudregistry_registry](resources/cloudregistry_registry.md)

 - [cloudregistry_registry_iam_binding](resources/cloudregistry_registry_iam_binding.md)

 - [cloudregistry_registry_ip_permission](resources/cloudregistry_registry_ip_permission.md)

#### Compute Cloud

##### Data Sources

 - [compute_disk](data-sources/compute_disk.md)

 - [compute_disk_placement_group](data-sources/compute_disk_placement_group.md)

 - [compute_filesystem](data-sources/compute_filesystem.md)

 - [compute_gpu_cluster](data-sources/compute_gpu_cluster.md)

 - [compute_image](data-sources/compute_image.md)

 - [compute_instance](data-sources/compute_instance.md)

 - [compute_instance_group](data-sources/compute_instance_group.md)

 - [compute_placement_group](data-sources/compute_placement_group.md)

 - [compute_snapshot](data-sources/compute_snapshot.md)

 - [compute_snapshot_schedule](data-sources/compute_snapshot_schedule.md)

##### Resources

 - [compute_disk](resources/compute_disk.md)

 - [compute_disk_iam_binding](resources/compute_disk_iam_binding.md)

 - [compute_disk_placement_group](resources/compute_disk_placement_group.md)

 - [compute_disk_placement_group_iam_binding](resources/compute_disk_placement_group_iam_binding.md)

 - [compute_filesystem](resources/compute_filesystem.md)

 - [compute_filesystem_iam_binding](resources/compute_filesystem_iam_binding.md)

 - [compute_gpu_cluster](resources/compute_gpu_cluster.md)

 - [compute_gpu_cluster_iam_binding](resources/compute_gpu_cluster_iam_binding.md)

 - [compute_image](resources/compute_image.md)

 - [compute_image_iam_binding](resources/compute_image_iam_binding.md)

 - [compute_instance](resources/compute_instance.md)

 - [compute_instance_group](resources/compute_instance_group.md)

 - [compute_instance_iam_binding](resources/compute_instance_iam_binding.md)

 - [compute_placement_group](resources/compute_placement_group.md)

 - [compute_placement_group_iam_binding](resources/compute_placement_group_iam_binding.md)

 - [compute_snapshot](resources/compute_snapshot.md)

 - [compute_snapshot_iam_binding](resources/compute_snapshot_iam_binding.md)

 - [compute_snapshot_schedule](resources/compute_snapshot_schedule.md)

 - [compute_snapshot_schedule_iam_binding](resources/compute_snapshot_schedule_iam_binding.md)

#### Connection Manager

##### Data Sources

 - [connectionmanager_connection](data-sources/connectionmanager_connection.md)

##### Resources

 - [connectionmanager_connection](resources/connectionmanager_connection.md)

#### Container Registry

##### Data Sources

 - [container_registry](data-sources/container_registry.md)

 - [container_registry_ip_permission](data-sources/container_registry_ip_permission.md)

 - [container_repository](data-sources/container_repository.md)

 - [container_repository_lifecycle_policy](data-sources/container_repository_lifecycle_policy.md)

##### Resources

 - [container_registry](resources/container_registry.md)

 - [container_registry_iam_binding](resources/container_registry_iam_binding.md)

 - [container_registry_ip_permission](resources/container_registry_ip_permission.md)

 - [container_repository](resources/container_repository.md)

 - [container_repository_iam_binding](resources/container_repository_iam_binding.md)

 - [container_repository_lifecycle_policy](resources/container_repository_lifecycle_policy.md)

#### Data Transfer

##### Data Sources

 - [datatransfer_endpoint](data-sources/datatransfer_endpoint.md)

 - [datatransfer_transfer](data-sources/datatransfer_transfer.md)

##### Resources

 - [datatransfer_endpoint](resources/datatransfer_endpoint.md)

 - [datatransfer_transfer](resources/datatransfer_transfer.md)

#### DataLens

##### Data Sources

 - [datalens_connection](data-sources/datalens_connection.md)

##### Resources

 - [datalens_connection](resources/datalens_connection.md)

#### DataSphere

##### Data Sources

 - [datasphere_community](data-sources/datasphere_community.md)

 - [datasphere_project](data-sources/datasphere_project.md)

##### Resources

 - [datasphere_community](resources/datasphere_community.md)

 - [datasphere_community_iam_binding](resources/datasphere_community_iam_binding.md)

 - [datasphere_project](resources/datasphere_project.md)

 - [datasphere_project_iam_binding](resources/datasphere_project_iam_binding.md)

#### Datacatalog

##### Data Sources

 - [datacatalog_catalog](data-sources/datacatalog_catalog.md)

##### Resources

 - [datacatalog_catalog](resources/datacatalog_catalog.md)

#### Identity Hub

##### Data Sources

 - [organizationmanager_group](data-sources/organizationmanager_group.md)

 - [organizationmanager_idp_application_oauth_application](data-sources/organizationmanager_idp_application_oauth_application.md)

 - [organizationmanager_idp_application_saml_application](data-sources/organizationmanager_idp_application_saml_application.md)

 - [organizationmanager_idp_application_saml_signature_certificate](data-sources/organizationmanager_idp_application_saml_signature_certificate.md)

 - [organizationmanager_idp_user](data-sources/organizationmanager_idp_user.md)

 - [organizationmanager_idp_userpool](data-sources/organizationmanager_idp_userpool.md)

 - [organizationmanager_mfa_enforcement](data-sources/organizationmanager_mfa_enforcement.md)

 - [organizationmanager_os_login_settings](data-sources/organizationmanager_os_login_settings.md)

 - [organizationmanager_saml_federation](data-sources/organizationmanager_saml_federation.md)

 - [organizationmanager_saml_federation_user_account](data-sources/organizationmanager_saml_federation_user_account.md)

 - [organizationmanager_user_ssh_key](data-sources/organizationmanager_user_ssh_key.md)

##### Resources

 - [organizationmanager_group](resources/organizationmanager_group.md)

 - [organizationmanager_group_iam_member](resources/organizationmanager_group_iam_member.md)

 - [organizationmanager_group_mapping](resources/organizationmanager_group_mapping.md)

 - [organizationmanager_group_mapping_item](resources/organizationmanager_group_mapping_item.md)

 - [organizationmanager_group_membership](resources/organizationmanager_group_membership.md)

 - [organizationmanager_idp_application_oauth_application](resources/organizationmanager_idp_application_oauth_application.md)

 - [organizationmanager_idp_application_oauth_application_assignment](resources/organizationmanager_idp_application_oauth_application_assignment.md)

 - [organizationmanager_idp_application_saml_application](resources/organizationmanager_idp_application_saml_application.md)

 - [organizationmanager_idp_application_saml_application_assignment](resources/organizationmanager_idp_application_saml_application_assignment.md)

 - [organizationmanager_idp_application_saml_signature_certificate](resources/organizationmanager_idp_application_saml_signature_certificate.md)

 - [organizationmanager_idp_user](resources/organizationmanager_idp_user.md)

 - [organizationmanager_idp_userpool](resources/organizationmanager_idp_userpool.md)

 - [organizationmanager_idp_userpool_domain](resources/organizationmanager_idp_userpool_domain.md)

 - [organizationmanager_mfa_enforcement](resources/organizationmanager_mfa_enforcement.md)

 - [organizationmanager_mfa_enforcement_audience](resources/organizationmanager_mfa_enforcement_audience.md)

 - [organizationmanager_mfa_enforcement_excluded_audience](resources/organizationmanager_mfa_enforcement_excluded_audience.md)

 - [organizationmanager_organization_iam_binding](resources/organizationmanager_organization_iam_binding.md)

 - [organizationmanager_organization_iam_member](resources/organizationmanager_organization_iam_member.md)

 - [organizationmanager_os_login_settings](resources/organizationmanager_os_login_settings.md)

 - [organizationmanager_saml_federation](resources/organizationmanager_saml_federation.md)

 - [organizationmanager_saml_federation_user_account](resources/organizationmanager_saml_federation_user_account.md)

 - [organizationmanager_user_ssh_key](resources/organizationmanager_user_ssh_key.md)

#### Identity and Access Management

##### Data Sources

 - [iam_oauth_client](data-sources/iam_oauth_client.md)

 - [iam_policy](data-sources/iam_policy.md)

 - [iam_role](data-sources/iam_role.md)

 - [iam_service_account](data-sources/iam_service_account.md)

 - [iam_service_agent](data-sources/iam_service_agent.md)

 - [iam_user](data-sources/iam_user.md)

 - [iam_workload_identity_federated_credential](data-sources/iam_workload_identity_federated_credential.md)

 - [iam_workload_identity_oidc_federation](data-sources/iam_workload_identity_oidc_federation.md)

##### Resources

 - [iam_oauth_client](resources/iam_oauth_client.md)

 - [iam_oauth_client_secret](resources/iam_oauth_client_secret.md)

 - [iam_service_account](resources/iam_service_account.md)

 - [iam_service_account_api_key](resources/iam_service_account_api_key.md)

 - [iam_service_account_iam_binding](resources/iam_service_account_iam_binding.md)

 - [iam_service_account_iam_member](resources/iam_service_account_iam_member.md)

 - [iam_service_account_iam_policy](resources/iam_service_account_iam_policy.md)

 - [iam_service_account_key](resources/iam_service_account_key.md)

 - [iam_service_account_static_access_key](resources/iam_service_account_static_access_key.md)

 - [iam_workload_identity_federated_credential](resources/iam_workload_identity_federated_credential.md)

 - [iam_workload_identity_oidc_federation](resources/iam_workload_identity_oidc_federation.md)

 - [iam_workload_identity_oidc_federation_iam_binding](resources/iam_workload_identity_oidc_federation_iam_binding.md)

#### IoT Core Broker

##### Data Sources

 - [iot_core_broker](data-sources/iot_core_broker.md)

##### Resources

 - [iot_core_broker](resources/iot_core_broker.md)

#### IoT Core Devices

##### Data Sources

 - [iot_core_device](data-sources/iot_core_device.md)

 - [iot_core_registry](data-sources/iot_core_registry.md)

##### Resources

 - [iot_core_device](resources/iot_core_device.md)

 - [iot_core_registry](resources/iot_core_registry.md)

#### Key Management Service

##### Data Sources

 - [kms_asymmetric_encryption_key](data-sources/kms_asymmetric_encryption_key.md)

 - [kms_asymmetric_signature_key](data-sources/kms_asymmetric_signature_key.md)

 - [kms_symmetric_key](data-sources/kms_symmetric_key.md)

##### Resources

 - [kms_asymmetric_encryption_key](resources/kms_asymmetric_encryption_key.md)

 - [kms_asymmetric_encryption_key_iam_binding](resources/kms_asymmetric_encryption_key_iam_binding.md)

 - [kms_asymmetric_encryption_key_iam_member](resources/kms_asymmetric_encryption_key_iam_member.md)

 - [kms_asymmetric_signature_key](resources/kms_asymmetric_signature_key.md)

 - [kms_asymmetric_signature_key_iam_binding](resources/kms_asymmetric_signature_key_iam_binding.md)

 - [kms_asymmetric_signature_key_iam_member](resources/kms_asymmetric_signature_key_iam_member.md)

 - [kms_secret_ciphertext](resources/kms_secret_ciphertext.md)

 - [kms_symmetric_key](resources/kms_symmetric_key.md)

 - [kms_symmetric_key_iam_binding](resources/kms_symmetric_key_iam_binding.md)

 - [kms_symmetric_key_iam_member](resources/kms_symmetric_key_iam_member.md)

#### Kubernetes Marketplace

##### Resources

 - [kubernetes_marketplace_helm_release](resources/kubernetes_marketplace_helm_release.md)

#### Lockbox

##### Data Sources

 - [lockbox_secret](data-sources/lockbox_secret.md)

 - [lockbox_secret_version](data-sources/lockbox_secret_version.md)

 - [lockbox_secret_version_entry](data-sources/lockbox_secret_version_entry.md)

##### Resources

 - [lockbox_secret](resources/lockbox_secret.md)

 - [lockbox_secret_iam_binding](resources/lockbox_secret_iam_binding.md)

 - [lockbox_secret_iam_member](resources/lockbox_secret_iam_member.md)

 - [lockbox_secret_version](resources/lockbox_secret_version.md)

 - [lockbox_secret_version_hashed](resources/lockbox_secret_version_hashed.md)

#### Managed Service for Apache Airflow™

##### Data Sources

 - [airflow_cluster](data-sources/airflow_cluster.md)

##### Resources

 - [airflow_cluster](resources/airflow_cluster.md)

 - [airflow_cluster_iam_binding](resources/airflow_cluster_iam_binding.md)

#### Managed Service for Apache Kafka®

##### Data Sources

 - [mdb_kafka_cluster](data-sources/mdb_kafka_cluster.md)

 - [mdb_kafka_connector](data-sources/mdb_kafka_connector.md)

 - [mdb_kafka_topic](data-sources/mdb_kafka_topic.md)

 - [mdb_kafka_user](data-sources/mdb_kafka_user.md)

##### Resources

 - [mdb_kafka_cluster](resources/mdb_kafka_cluster.md)

 - [mdb_kafka_cluster_iam_binding](resources/mdb_kafka_cluster_iam_binding.md)

 - [mdb_kafka_connector](resources/mdb_kafka_connector.md)

 - [mdb_kafka_topic](resources/mdb_kafka_topic.md)

 - [mdb_kafka_user](resources/mdb_kafka_user.md)

#### Managed Service for ClickHouse

##### Data Sources

 - [mdb_clickhouse_cluster](data-sources/mdb_clickhouse_cluster.md)

 - [mdb_clickhouse_cluster_v2](data-sources/mdb_clickhouse_cluster_v2.md)

 - [mdb_clickhouse_database](data-sources/mdb_clickhouse_database.md)

 - [mdb_clickhouse_user](data-sources/mdb_clickhouse_user.md)

##### Resources

 - [mdb_clickhouse_cluster](resources/mdb_clickhouse_cluster.md)

 - [mdb_clickhouse_cluster_iam_binding](resources/mdb_clickhouse_cluster_iam_binding.md)

 - [mdb_clickhouse_cluster_v2](resources/mdb_clickhouse_cluster_v2.md)

 - [mdb_clickhouse_database](resources/mdb_clickhouse_database.md)

 - [mdb_clickhouse_user](resources/mdb_clickhouse_user.md)

#### Managed Service for Gitlab

##### Data Sources

 - [gitlab_instance](data-sources/gitlab_instance.md)

##### Resources

 - [gitlab_instance](resources/gitlab_instance.md)

#### Managed Service for Greenplum®

##### Data Sources

 - [mdb_greenplum_cluster](data-sources/mdb_greenplum_cluster.md)

 - [mdb_greenplum_cluster_v2](data-sources/mdb_greenplum_cluster_v2.md)

 - [mdb_greenplum_resource_group](data-sources/mdb_greenplum_resource_group.md)

 - [mdb_greenplum_user](data-sources/mdb_greenplum_user.md)

##### Resources

 - [mdb_greenplum_cluster](resources/mdb_greenplum_cluster.md)

 - [mdb_greenplum_cluster_iam_binding](resources/mdb_greenplum_cluster_iam_binding.md)

 - [mdb_greenplum_cluster_v2](resources/mdb_greenplum_cluster_v2.md)

 - [mdb_greenplum_resource_group](resources/mdb_greenplum_resource_group.md)

 - [mdb_greenplum_user](resources/mdb_greenplum_user.md)

#### Managed Service for Hive Metastore™

##### Data Sources

 - [metastore_cluster](data-sources/metastore_cluster.md)

##### Resources

 - [metastore_cluster](resources/metastore_cluster.md)

 - [metastore_cluster_iam_binding](resources/metastore_cluster_iam_binding.md)

#### Managed Service for MongoDB

##### Data Sources

 - [mdb_mongodb_cluster](data-sources/mdb_mongodb_cluster.md)

 - [mdb_mongodb_database](data-sources/mdb_mongodb_database.md)

 - [mdb_mongodb_user](data-sources/mdb_mongodb_user.md)

##### Resources

 - [mdb_mongodb_cluster](resources/mdb_mongodb_cluster.md)

 - [mdb_mongodb_cluster_iam_binding](resources/mdb_mongodb_cluster_iam_binding.md)

 - [mdb_mongodb_database](resources/mdb_mongodb_database.md)

 - [mdb_mongodb_user](resources/mdb_mongodb_user.md)

#### Managed Service for MySQL

##### Data Sources

 - [mdb_mysql_cluster](data-sources/mdb_mysql_cluster.md)

 - [mdb_mysql_database](data-sources/mdb_mysql_database.md)

 - [mdb_mysql_database_v2](data-sources/mdb_mysql_database_v2.md)

 - [mdb_mysql_user](data-sources/mdb_mysql_user.md)

 - [mdb_mysql_user_v2](data-sources/mdb_mysql_user_v2.md)

##### Resources

 - [mdb_mysql_cluster](resources/mdb_mysql_cluster.md)

 - [mdb_mysql_cluster_iam_binding](resources/mdb_mysql_cluster_iam_binding.md)

 - [mdb_mysql_cluster_v2](resources/mdb_mysql_cluster_v2.md)

 - [mdb_mysql_database](resources/mdb_mysql_database.md)

 - [mdb_mysql_database_v2](resources/mdb_mysql_database_v2.md)

 - [mdb_mysql_user](resources/mdb_mysql_user.md)

 - [mdb_mysql_user_v2](resources/mdb_mysql_user_v2.md)

#### Managed Service for OpenSearch

##### Data Sources

 - [mdb_opensearch_cluster](data-sources/mdb_opensearch_cluster.md)

##### Resources

 - [mdb_opensearch_cluster](resources/mdb_opensearch_cluster.md)

 - [mdb_opensearch_cluster_iam_binding](resources/mdb_opensearch_cluster_iam_binding.md)

#### Managed Service for PostgreSQL

##### Data Sources

 - [mdb_postgresql_cluster](data-sources/mdb_postgresql_cluster.md)

 - [mdb_postgresql_database](data-sources/mdb_postgresql_database.md)

 - [mdb_postgresql_user](data-sources/mdb_postgresql_user.md)

##### Resources

 - [mdb_postgresql_cluster](resources/mdb_postgresql_cluster.md)

 - [mdb_postgresql_cluster_iam_binding](resources/mdb_postgresql_cluster_iam_binding.md)

 - [mdb_postgresql_cluster_v2](resources/mdb_postgresql_cluster_v2.md)

 - [mdb_postgresql_database](resources/mdb_postgresql_database.md)

 - [mdb_postgresql_user](resources/mdb_postgresql_user.md)

 - [mdb_sharded_postgresql_cluster](resources/mdb_sharded_postgresql_cluster.md)

 - [mdb_sharded_postgresql_cluster_iam_binding](resources/mdb_sharded_postgresql_cluster_iam_binding.md)

#### Managed Service for SPQR

##### Resources

 - [mdb_sharded_postgresql_database](resources/mdb_sharded_postgresql_database.md)

 - [mdb_sharded_postgresql_shard](resources/mdb_sharded_postgresql_shard.md)

 - [mdb_sharded_postgresql_user](resources/mdb_sharded_postgresql_user.md)

#### Managed Service for Trino

##### Data Sources

 - [trino_access_control](data-sources/trino_access_control.md)

 - [trino_catalog](data-sources/trino_catalog.md)

 - [trino_cluster](data-sources/trino_cluster.md)

##### Resources

 - [trino_access_control](resources/trino_access_control.md)

 - [trino_catalog](resources/trino_catalog.md)

 - [trino_cluster](resources/trino_cluster.md)

 - [trino_cluster_iam_binding](resources/trino_cluster_iam_binding.md)

#### Managed Service for ValKey

##### Data Sources

 - [mdb_redis_cluster](data-sources/mdb_redis_cluster.md)

 - [mdb_redis_cluster_v2](data-sources/mdb_redis_cluster_v2.md)

 - [mdb_redis_user](data-sources/mdb_redis_user.md)

##### Resources

 - [mdb_redis_cluster](resources/mdb_redis_cluster.md)

 - [mdb_redis_cluster_iam_binding](resources/mdb_redis_cluster_iam_binding.md)

 - [mdb_redis_cluster_v2](resources/mdb_redis_cluster_v2.md)

 - [mdb_redis_user](resources/mdb_redis_user.md)

#### Managed Service for YDB

##### Data Sources

 - [ydb_database_dedicated](data-sources/ydb_database_dedicated.md)

 - [ydb_database_serverless](data-sources/ydb_database_serverless.md)

##### Resources

 - [ydb_database_dedicated](resources/ydb_database_dedicated.md)

 - [ydb_database_iam_binding](resources/ydb_database_iam_binding.md)

 - [ydb_database_serverless](resources/ydb_database_serverless.md)

 - [ydb_table](resources/ydb_table.md)

 - [ydb_table_changefeed](resources/ydb_table_changefeed.md)

 - [ydb_table_index](resources/ydb_table_index.md)

 - [ydb_topic](resources/ydb_topic.md)

#### Managed Services for Kubernetes

##### Data Sources

 - [kubernetes_cluster](data-sources/kubernetes_cluster.md)

 - [kubernetes_node_group](data-sources/kubernetes_node_group.md)

##### Resources

 - [kubernetes_cluster](resources/kubernetes_cluster.md)

 - [kubernetes_cluster_iam_binding](resources/kubernetes_cluster_iam_binding.md)

 - [kubernetes_cluster_iam_member](resources/kubernetes_cluster_iam_member.md)

 - [kubernetes_node_group](resources/kubernetes_node_group.md)

#### Managed Spark

##### Data Sources

 - [spark_cluster](data-sources/spark_cluster.md)

##### Resources

 - [spark_cluster](resources/spark_cluster.md)

 - [spark_cluster_iam_binding](resources/spark_cluster_iam_binding.md)

#### Message Queue

##### Data Sources

 - [message_queue](data-sources/message_queue.md)

##### Resources

 - [message_queue](resources/message_queue.md)

#### Monitoring

##### Data Sources

 - [monitoring_dashboard](data-sources/monitoring_dashboard.md)

##### Resources

 - [monitoring_dashboard](resources/monitoring_dashboard.md)

#### Network Load Balancer

##### Data Sources

 - [lb_network_load_balancer](data-sources/lb_network_load_balancer.md)

 - [lb_target_group](data-sources/lb_target_group.md)

##### Resources

 - [lb_network_load_balancer](resources/lb_network_load_balancer.md)

 - [lb_target_group](resources/lb_target_group.md)

#### Object Storage

##### Resources

 - [storage_bucket](resources/storage_bucket.md)

 - [storage_bucket_grant](resources/storage_bucket_grant.md)

 - [storage_bucket_iam_binding](resources/storage_bucket_iam_binding.md)

 - [storage_bucket_policy](resources/storage_bucket_policy.md)

 - [storage_object](resources/storage_object.md)

#### Resource Manager

##### Data Sources

 - [resourcemanager_cloud](data-sources/resourcemanager_cloud.md)

 - [resourcemanager_folder](data-sources/resourcemanager_folder.md)

##### Resources

 - [resourcemanager_cloud](resources/resourcemanager_cloud.md)

 - [resourcemanager_cloud_iam_binding](resources/resourcemanager_cloud_iam_binding.md)

 - [resourcemanager_cloud_iam_member](resources/resourcemanager_cloud_iam_member.md)

 - [resourcemanager_folder](resources/resourcemanager_folder.md)

 - [resourcemanager_folder_iam_binding](resources/resourcemanager_folder_iam_binding.md)

 - [resourcemanager_folder_iam_member](resources/resourcemanager_folder_iam_member.md)

 - [resourcemanager_folder_iam_policy](resources/resourcemanager_folder_iam_policy.md)

 - [yq_monitoring_connection](resources/yq_monitoring_connection.md)

#### Serverless Cloud Functions

##### Data Sources

 - [function_scaling_policy](data-sources/function_scaling_policy.md)

##### Resources

 - [function_scaling_policy](resources/function_scaling_policy.md)

#### Serverless Containers

##### Data Sources

 - [serverless_container](data-sources/serverless_container.md)

##### Resources

 - [serverless_container](resources/serverless_container.md)

 - [serverless_container_iam_binding](resources/serverless_container_iam_binding.md)

#### Serverless Event Router

##### Data Sources

 - [serverless_eventrouter_bus](data-sources/serverless_eventrouter_bus.md)

 - [serverless_eventrouter_connector](data-sources/serverless_eventrouter_connector.md)

 - [serverless_eventrouter_rule](data-sources/serverless_eventrouter_rule.md)

##### Resources

 - [serverless_eventrouter_bus](resources/serverless_eventrouter_bus.md)

 - [serverless_eventrouter_connector](resources/serverless_eventrouter_connector.md)

 - [serverless_eventrouter_rule](resources/serverless_eventrouter_rule.md)

#### Smart Captcha

##### Data Sources

 - [smartcaptcha_captcha](data-sources/smartcaptcha_captcha.md)

##### Resources

 - [smartcaptcha_captcha](resources/smartcaptcha_captcha.md)

#### Smart Web Security

##### Data Sources

 - [sws_advanced_rate_limiter_profile](data-sources/sws_advanced_rate_limiter_profile.md)

 - [sws_security_profile](data-sources/sws_security_profile.md)

 - [sws_waf_profile](data-sources/sws_waf_profile.md)

 - [sws_waf_rule_set_descriptor](data-sources/sws_waf_rule_set_descriptor.md)

##### Resources

 - [sws_advanced_rate_limiter_profile](resources/sws_advanced_rate_limiter_profile.md)

 - [sws_security_profile](resources/sws_security_profile.md)

 - [sws_waf_profile](resources/sws_waf_profile.md)

#### Virtual Private Cloud

##### Data Sources

 - [vpc_address](data-sources/vpc_address.md)

 - [vpc_gateway](data-sources/vpc_gateway.md)

 - [vpc_network](data-sources/vpc_network.md)

 - [vpc_private_endpoint](data-sources/vpc_private_endpoint.md)

 - [vpc_route_table](data-sources/vpc_route_table.md)

 - [vpc_security_group](data-sources/vpc_security_group.md)

 - [vpc_security_group_rule](data-sources/vpc_security_group_rule.md)

 - [vpc_subnet](data-sources/vpc_subnet.md)

##### Resources

 - [vpc_address](resources/vpc_address.md)

 - [vpc_default_security_group](resources/vpc_default_security_group.md)

 - [vpc_gateway](resources/vpc_gateway.md)

 - [vpc_network](resources/vpc_network.md)

 - [vpc_private_endpoint](resources/vpc_private_endpoint.md)

 - [vpc_route_table](resources/vpc_route_table.md)

 - [vpc_security_group](resources/vpc_security_group.md)

 - [vpc_security_group_rule](resources/vpc_security_group_rule.md)

 - [vpc_subnet](resources/vpc_subnet.md)

#### Yandex Data Processing

##### Data Sources

 - [dataproc_cluster](data-sources/dataproc_cluster.md)

##### Resources

 - [dataproc_cluster](resources/dataproc_cluster.md)

 - [dataproc_cluster_iam_binding](resources/dataproc_cluster_iam_binding.md)

#### Yandex Query

##### Resources

 - [yq_object_storage_binding](resources/yq_object_storage_binding.md)

 - [yq_object_storage_connection](resources/yq_object_storage_connection.md)

 - [yq_ydb_connection](resources/yq_ydb_connection.md)

 - [yq_yds_binding](resources/yq_yds_binding.md)

 - [yq_yds_connection](resources/yq_yds_connection.md)

#### Ytsaurus

##### Data Sources

 - [ytsaurus_cluster](data-sources/ytsaurus_cluster.md)

##### Resources

 - [ytsaurus_cluster](resources/ytsaurus_cluster.md)