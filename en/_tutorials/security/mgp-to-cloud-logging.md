# Transferring {{ mgp-name }} cluster logs to {{ cloud-logging-full-name }}

You can set up regular collection of {{ mgp-name }} cluster performance logs. Logs will be delivered to a [log group](../../logging/concepts/log-group.md) in {{ cloud-logging-name }}. You can choose between these two types of log groups:

* [Default log group of the cluster folder](#default)
* [Custom log group](#custom)

## Getting started {#before-you-begin}

[Create a service account](../../iam/operations/sa/create.md#create-sa) with the `logging.writer` [role](../../logging/security/index.md#logging-writer).

## Transferring data to the default log group {#default}

1. Create a {{ mgp-name }} cluster with active logging and a service account [created earlier](#before-you-begin):

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
      1. Select **Yandex MPP Analytics for PostgreSQL**.
      1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Enter a name for the cluster.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:

         * Cloud network.
         * Security group.
         * Availability zone and subnet.

      1. Under **{{ ui-key.yacloud.mdb.forms.section_user }}**, specify the admin user credentials:

         * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** may contain Latin letters, numbers, hyphens, and underscores, but cannot start with a hyphen. It must be from 1 to 32 characters long.
         * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** must be from 8 to 128 characters long.

      1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

         * Select the service account with the `logging.writer` role.
         * Enable **{{ ui-key.yacloud.logging.field_logging }}**.
         * To write logs to the default log group, select **{{ ui-key.yacloud.common.folder }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
         * Select the folder whose log group you want to use.
         * Enable the **{{ ui-key.yacloud.greenplum.LoggingSection.greenplum_pN6jU }}** and **{{ ui-key.yacloud.greenplum.LoggingSection.commandCenter_e9fKV }}** options. Use [Log min messages](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) under **{{ ui-key.yacloud.mdb.forms.section_settings }}** to specify the logging level.

      1. Click **{{ ui-key.yacloud.common.create }}**.

   * CLI {#cli}

      ```bash
      yc managed-greenplum cluster create <cluster_name> \
         --greenplum-version=6.25 \
         --environment=PRODUCTION \
         --network-name=<cluster_network_name> \
         --user-name=<VM_user_name> \
         --user-password=<cluster_user_password> \
         --master-config resource-id=s3-c8-m32,`
                        `disk-size=10,`
                        `disk-type=network-hdd \
         --segment-config resource-id=s3-c8-m32,`
                        `disk-size=93,`
                        `disk-type=network-ssd-nonreplicated \
         --zone-id=<availability_zone_ID> \
         --subnet-id=<cluster_subnet_ID> \
         --assign-public-ip=true \
         --security-group-ids=<cluster_security_group_IDs> \
         --service-account <cluster_service_account_ID> \
         --log-enabled \
         --log-greenplum-enabled \
         --log-command-center-enabled \
         --log-folder-id <folder_ID>
      ```

      Where:

      * `--service-account`: ID of the service account you [created earlier](#before-you-begin).

      * `--log-enabled`: Enables log transfer. Required for other flags responsible for transferring specific logs, e.g., `--log-greenplum-enabled`.

      * `--log-greenplum-enabled`: Transferring {{ GP }} logs.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `--log-command-center-enabled`: Transferring [Command Center](../../managed-greenplum/concepts/command-center.md) logs.

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `--log-folder-id`: ID of the folder the {{ mgp-name }} cluster was created in.

   * {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Specify the following parameters in the configuration file with the cluster description:

          ```hcl
          resource "yandex_mdb_greenplum_cluster" "gp-cluster" {
            name               = "<cluster_name>"
            environment        = "PRODUCTION"
            network_id         = "<network_ID>"
            zone               = "<availability_zone_ID>"
            subnet_id          = "<cluster_subnet_ID>"
            assign_public_ip   = true
            version            = "6.25"
            master_host_count  = 2
            segment_host_count = 2
            segment_in_host    = 2
            service_account_id = "<service_account_ID>"

            master_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 10          # GB
                disk_type_id       = "network-hdd"
              }
            }

            segment_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 93          # GB
                disk_type_id       = "network-ssd-nonreplicated"
              }
            }

            user_name          = "<VM_user_name>"
            user_password      = "<cluster_user_password>"
            security_group_ids = ["<cluster_security_group_IDs>"]

            logging {
              enabled = true
              greenplum_enabled  = true
              command_center_enabled = true
              folder_id = <folder_ID>
            }
          }
          ```

          Where:

          * `service_account_id`: ID of the service account you [created earlier](#before-you-begin).

          * `enabled`: Manages log transferring. To enable parameters responsible for transferring specific logs, provide the `true` value.

          * `greenplum_enabled`: Transferring {{ GP }} logs.

              {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

          * `command_center_enabled`: Transferring [Command Center](../../managed-greenplum/concepts/command-center.md) logs.

              {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

          * `folder_id`: Specify the ID of the folder whose log group you want to use.

      1. Validate your {{ TF }} configuration files using this command:

          ```bash
          terraform validate
          ```

          {{ TF }} will display any configuration errors detected in your files.

      1. Create the required infrastructure:

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   * API {#api}

      Specify the following parameters in the body of the cluster create request ([Cluster.Create](../../managed-greenplum/api-ref/Cluster/create.md) in the REST API or [ClusterService.Create](../../managed-greenplum/api-ref/grpc/Cluster/create.md) in the gRPC API):

      ```json
      {
        ...
        "serviceAccountId": "<service_account_ID>",
        "logging": {
          "enabled": "true",
          "greenplumEnabled": "true",
          "commandCenterEnabled": "true",
          "folderId": "<folder_ID>"
        }
        ...
      }
      ```

      Where:

      * `serviceAccountId`: ID of the service account you [created earlier](#before-you-begin).

      * `enabled`: Manages log transferring. To enable parameters responsible for transferring specific logs, provide the `true` value.

      * `greenplumEnabled`: Transferring {{ GP }} logs.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `commandCenterEnabled`: Transferring [Command Center](../../managed-greenplum/concepts/command-center.md) logs.

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `folderId`: Specify the ID of the folder whose log group you want to use.

   {% endlist %}

1. Test the transfer of cluster logs to the log group:

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the management console, navigate to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `default` log group.

      The page that opens will show the log group entries.

   * CLI {#cli}

      To view the entries in JSON format, run this command:

      ```bash
      yc logging read --group-name=default --format=json
      ```

      Result:

      ```text
      [
        {
          "uid": "22:********:15",
          "resource": {
            "type": "mdb.greenplum.cluster",
            "id": "c9qao2tkhbdt********"
          },
          "timestamp": "2025-04-25T07:50:21.871157Z",
          "ingested_at": "2025-04-25T07:50:24.553Z",
          "saved_at": "2025-04-25T07:50:26.125189Z",
          "level": "INFO",
          "message": "2025-04-25 10:50:20.209664 MSK,\"monitor\",\"postgres\",p29034,th1258748352,\"localhost\",\"47384\",2025-04-25 07:38:20 MSK,0,con40,cmd20190,seg-1,,,,sx1,\"LOG\",\"00000\",\"statement: \n\t\treset log_min_messages\n\t\",,,,,,,0,,\"postgres.c\",1664,",
          "json_payload": {
            "cid": "c9qao2tkhbdt********",
            "gp_host_type": "master",
            "gp_preferred_role": "primary",
            "hostname": "rc1d-jds7okr4********.mdb.yandexcloud.net",
            "segment_id": "-1",
            "username": "monitor"
          },
          "stream_name": "greenplum-logs-master-primary"
        }
      ]
      ```

   * API {#api}

      To view log group records, use the [Cluster.ListLogs](../../managed-greenplum/api-ref/Cluster/listLogs.md) REST API method or the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [Reading records](../../logging/operations/read-logs.md).

## Sending data to a custom log group {#custom}

1. [Create a log group](../../logging/operations/create-group.md) named `greenplum-log-group`.
1. Create a {{ mgp-name }} cluster with active logging and a service account [created earlier](#before-you-begin):

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
      1. Select **Yandex MPP Analytics for PostgreSQL**.
      1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Enter a name for the cluster.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:

         * Cloud network.
         * Security group.
         * Availability zone and subnet.

      1. Under **{{ ui-key.yacloud.mdb.forms.section_user }}**, specify the admin user credentials:

         * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** may contain Latin letters, numbers, hyphens, and underscores, but cannot start with a hyphen. It must be from 1 to 32 characters long.
         * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** must be from 8 to 128 characters long.

      1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

         * Select the service account with the `logging.writer` role.
         * Enable **{{ ui-key.yacloud.logging.field_logging }}**.
         * To write logs to a custom log group, select **{{ ui-key.yacloud.logging.label_loggroup }}** in the **{{ ui-key.yacloud.logging.label_destination }}** field.
         * Select the `greenplum-log-group` log group.
         * Enable the **{{ ui-key.yacloud.greenplum.LoggingSection.greenplum_pN6jU }}** and **{{ ui-key.yacloud.greenplum.LoggingSection.commandCenter_e9fKV }}** options. Use [Log min messages](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) under **{{ ui-key.yacloud.mdb.forms.section_settings }}** to specify the logging level.

      1. Click **{{ ui-key.yacloud.common.create }}**.

   * CLI {#cli}

      ```bash
      yc managed-greenplum cluster create <cluster_name> \
         --greenplum-version=6.25 \
         --environment=PRODUCTION \
         --network-name=<cluster_network_name> \
         --user-name=<VM_user_name> \
         --user-password=<cluster_user_password> \
         --master-config resource-id=s3-c8-m32,`
                        `disk-size=10,`
                        `disk-type=network-hdd \
         --segment-config resource-id=s3-c8-m32,`
                        `disk-size=93,`
                        `disk-type=network-ssd-nonreplicated \
         --zone-id=<availability_zone_ID> \
         --subnet-id=<cluster_subnet_ID> \
         --assign-public-ip=true \
         --security-group-ids=<cluster_security_group_IDs> \
         --service-account <cluster_service_account_ID> \
         --log-enabled \
         --log-greenplum-enabled \
         --log-command-center-enabled \
         --log-group-id <log_group_ID>
      ```

      Where:

      * `--service-account`: ID of the service account you [created earlier](#before-you-begin).

      * `--log-enabled`: Enables log transfer. Required for other flags responsible for transferring specific logs, e.g., `--log-greenplum-enabled`.

      * `--log-greenplum-enabled`: Transferring {{ GP }} logs.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `--log-command-center-enabled`: Transferring [Command Center](../../managed-greenplum/concepts/command-center.md) logs.

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `--log-group-id`: ID of the log group to write logs to.

   * {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Specify the following parameters in the configuration file with the cluster description:

          ```hcl
          resource "yandex_mdb_greenplum_cluster" "gp-cluster" {
            name               = "<cluster_name>"
            environment        = "PRODUCTION"
            network_id         = "<network_ID>"
            zone               = "<availability_zone_ID>"
            subnet_id          = "<cluster_subnet_ID>"
            assign_public_ip   = true
            version            = "6.25"
            master_host_count  = 2
            segment_host_count = 2
            segment_in_host    = 2
            service_account_id = "<service_account_ID>"

            master_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 10          # GB
                disk_type_id       = "network-hdd"
              }
            }

            segment_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 93          # GB
                disk_type_id       = "network-ssd-nonreplicated"
              }
            }

            user_name          = "<VM_user_name>"
            user_password      = "<cluster_user_password>"
            security_group_ids = ["<cluster_security_group_IDs>"]

            logging {
              enabled = true
              greenplum_enabled  = true
              command_center_enabled = true
              log_group_id = <log_group_ID>
            }
          }
          ```

          Where:

          * `service_account_id`: ID of the service account you [created earlier](#before-you-begin).

          * `enabled`: Manages log transferring. To enable parameters responsible for transferring specific logs, provide the `true` value.

          * `greenplum_enabled`: Transferring {{ GP }} logs.

              {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

          * `command_center_enabled`: Transferring [Command Center](../../managed-greenplum/concepts/command-center.md) logs.

              {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

          * `log_group_id`: ID of the log group to write logs to.

      1. Validate your {{ TF }} configuration files using this command:

          ```bash
          terraform validate
          ```

          {{ TF }} will display any configuration errors detected in your files.

      1. Create the required infrastructure:

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   * API {#api}

      Specify the following parameters in the body of the cluster create request ([Cluster.Create](../../managed-greenplum/api-ref/Cluster/create.md) in the REST API or [ClusterService.Create](../../managed-greenplum/api-ref/grpc/Cluster/create.md) in the gRPC API):

      ```json
      {
        ...
        "serviceAccountId": "<service_account_ID>",
        "logging": {
          "enabled": "true",
          "greenplumEnabled": "true",
          "commandCenterEnabled": "true",
          "logGroupId": "<log_group_ID>"
        }
        ...
      }
      ```

      Where:

      * `serviceAccountId`: ID of the service account you [created earlier](#before-you-begin).

      * `enabled`: Manages log transferring. To enable parameters responsible for transferring specific logs, provide the `true` value.

      * `greenplumEnabled`: Transferring {{ GP }} logs.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `commandCenterEnabled`: Transferring [Command Center](../../managed-greenplum/concepts/command-center.md) logs.

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `logGroupId`: Log group ID.

   {% endlist %}

1. Test the transfer of cluster logs to the log group:

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the management console, navigate to the relevant folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Click the row with the `greenplum-log-group` log group.

      The page that opens will show the log group entries.

   * CLI {#cli}

      To view the entries in JSON format, run this command:

      ```bash
      yc logging read --group-name=greenplum-log-group --format=json
      ```

      Result:

      ```text
      [
        {
          "uid": "22:********:15",
          "resource": {
            "type": "mdb.greenplum.cluster",
            "id": "c9qao2tkhbdt********"
          },
          "timestamp": "2025-04-25T07:50:21.871157Z",
          "ingested_at": "2025-04-25T07:50:24.553Z",
          "saved_at": "2025-04-25T07:50:26.125189Z",
          "level": "INFO",
          "message": "2025-04-25 10:50:20.209664 MSK,\"monitor\",\"postgres\",p29034,th1258748352,\"localhost\",\"47384\",2025-04-25 07:38:20 MSK,0,con40,cmd20190,seg-1,,,,sx1,\"LOG\",\"00000\",\"statement: \n\t\treset log_min_messages\n\t\",,,,,,,0,,\"postgres.c\",1664,",
          "json_payload": {
            "cid": "c9qao2tkhbdt********",
            "gp_host_type": "master",
            "gp_preferred_role": "primary",
            "hostname": "rc1d-jds7okr4********.mdb.yandexcloud.net",
            "segment_id": "-1",
            "username": "monitor"
          },
          "stream_name": "greenplum-logs-master-primary"
        }
      ]
      ```

   * API {#api}

      To view log group records, use the [Cluster.ListLogs](../../managed-greenplum/api-ref/Cluster/listLogs.md) REST API method or the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

   {% endlist %}

   For more information, see [Reading records](../../logging/operations/read-logs.md).
