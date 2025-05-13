---
title: Creating a backup policy
description: In this tutorial, you will learn how to create a backup policy in {{ backup-name }}.
---

# Creating a backup policy

Creating a [policy](../../concepts/policy.md) becomes available after you [activate](../../concepts/index.md#providers) {{ backup-name }}.

You can create or [update](update.md) a policy using the {{ yandex-cloud }} management console, {{ TF }}, or a [JSON](https://en.wikipedia.org/wiki/JSON) [specification](../../concepts/policy.md#specification) via the {{ yandex-cloud }} [CLI](../../../cli/quickstart.md) or API.

{% note info %}

You cannot create backup policies with some advanced settings in the {{ yandex-cloud }} management console. Use the CLI, {{ TF }}, or API to create such policies.

{% endnote %}

{% include [default-policies](../../../_includes/backup/default-policies.md) %}

{% include [policy-execute-time](../../../_includes/backup/policy-execute-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [backup policy](../../../backup/concepts/policy.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Navigate to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
  1. Click **{{ ui-key.yacloud.backup.button_create-policy }}**.
  1. On the backup policy creation page:

      {% include [policy-options](../../../_includes/backup/policy-options.md) %}

        * Optionally, select a data **{{ ui-key.yacloud.backup.policy-overview.field_compression }}** in the backup. The higher the compression level, the longer it takes to create a backup, but such a backup will be smaller in size. How efficient compression is depends on the type of data you are backing up: files that are already compressed, such as JPG, PDF, or MP3, are difficult to compress further, unlike, for example, DOC or XLS. 

          {% note info %}

          You can only select a compression level when creating a policy. You cannot change it for an existing policy.

          {% endnote %}

        {% include [policy-options-extra](../../../_includes/backup/policy-options-extra.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command to create a [backup policy](../../../backup/concepts/policy.md):

     ```bash
     yc backup policy create --help
     ```

  1. Specify the configuration of the backup policy you are creating as a data schema in [JSON](https://en.wikipedia.org/wiki/JSON) format.

     {% cut "Sample configuration file" %}

     {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

     {% endcut %}

     Save the configuration to a `.json` file.

     The example describes a configuration for a backup policy that will create [incremental](../../concepts/backup.md#types) [VM](../../../compute/concepts/vm.md) or [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md) [backups](../../concepts/backup.md) every Monday at 00:05 (UTC+0). Only the last 10 backups will be stored.

     See the [full backup policy specification](../../concepts/policy.md#specification) for details.

  1. Create a backup policy:

     ```bash
     yc backup policy create \
       --name <policy_name> \
       --settings-from-file <path_to_configuration_file>
     ```

     Where:

     * `--name`: Name of the backup policy you are creating.
     * `--settings-from-file`: Path to the backup policy configuration file in JSON format.

     Result:

     ```text
     id: cbq5rwepukxn********
     name: test2
     created_at: "2023-07-03T08:24:16.735555276Z"
     updated_at: "2023-07-03T08:24:16.746377738Z"
     enabled: true
     settings:
       compression: NORMAL
       format: AUTO
       multi_volume_snapshotting_enabled: true
       preserve_file_security_settings: true
       reattempts:
         enabled: true
         interval:
           type: SECONDS
           count: "30"
         max_attempts: "30"
       silent_mode_enabled: true
       splitting:
         size: "1099511627776"
       vm_snapshot_reattempts:
         enabled: true
         interval:
           type: MINUTES
           count: "5"
         max_attempts: "3"
       vss:
         enabled: true
         provider: TARGET_SYSTEM_DEFINED
       archive:
         name: '''[Machine Name]-[Plan ID]-[Unique ID]A'''
       performance_window: {}
       retention:
         rules:
           - max_count: "10"
         before_backup: true
       scheduling:
         backup_sets:
           - time:
               weekdays:
                 - MONDAY
               repeat_at:
                 - minute: "5"
               type: WEEKLY
         enabled: true
         max_parallel_backups: "2"
         rand_max_delay:
           type: MINUTES
           count: "30"
         scheme: ALWAYS_INCREMENTAL
         weekly_backup_day: MONDAY
       cbt: ENABLE_AND_USE
       fast_backup_enabled: true
       quiesce_snapshotting_enabled: true
     folder_id: d2q792qpemb4********
     ```

     For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a [backup policy](../../concepts/policy.md):
  1. In the {{ TF }} configuration file, describe the backup policy parameters:

     ```hcl
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[Machine Name]-[Plan ID]-[Unique ID]a"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<backup_policy_name>"
         performance_window_enabled        = true
         preserve_file_security_settings   = true
         quiesce_snapshotting_enabled      = true
         silent_mode_enabled               = true
         splitting_bytes                   = "9223372036854775807"
         vss_provider                      = "NATIVE"

         reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }

         retention {
             after_backup = false

             rules {
                 max_age       = "365d"
                 repeat_period = []
             }
         }

         scheduling {
             enabled              = false
             max_parallel_backups = 0
             random_max_delay     = "30m"
             scheme               = "ALWAYS_INCREMENTAL"
             weekly_backup_day    = "MONDAY"

             execute_by_time {
                 include_last_day_of_month = true
                 monthdays                 = []
                 months                    = [1,2,3,4,5,6,7,8,9,10,11,12]
                 repeat_at                 = ["04:10"]
                 repeat_every              = "30m"
                 type                      = "MONTHLY"
                 weekdays                  = []
             }
         }

         vm_snapshot_reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }
     }
     ```

     Where:

     * `archive_name`: Names of generated archives. This is an optional parameter. The parameter variables include:
       * `Machine Name`: [VM](../../../compute/concepts/vm.md) or [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md) name.
       * `Plan ID`: Plan ID.
       * `Unique ID`: Unique ID.

       Make sure the last character in the generated archive name is not a variable.
     * `cbt`: Configuration for tracking [backup](../../concepts/backup.md) contents. This is an optional parameter. It can take either of these two values:
       * `CHANGED_BLOCK_TRACKING_UNSPECIFIED`: Not specified.
       * `USE_IF_ENABLED`: Use if enabled.
       * `ENABLE_AND_USE`: Enable and use.
       * `DO_NOT_USE`: Do not use.

       The default value is `DO_NOT_USE`.
     * `compression`: Backup compression ratio. This is an optional parameter. It can take either of these two values:
       * `NORMAL`: Standard compression ratio.
       * `HIGH`: High compression ratio.
       * `MAX`: Maximum compression ratio.
       * `OFF`: Disabled.

       The default value is `NORMAL`.
     * `fast_backup_enabled`: Fast backup for tracking changes to files. When enabled, file changes are detected by the file size and its timestamp. When disabled, files are checked for changes by comparing their contents to backed up files. It can either be `true` or `false`.
     * `format`: Backup format. This is an optional parameter. It can take either of these two values:
       * `VERSION_11`: Deprecated format, not recommended.
       * `VERSION_12`: Recommended format for high-speed backup and recovery.
       * `AUTO`: Automatic format selection. The default option is `VERSION_12`, unless you are creating [incremental](../../concepts/backup.md#types) backups for the images created in other versions.
     * `multi_volume_snapshotting_enabled`: Creating backups for multiple volumes at the same time. This is an optional parameter. It can either be `true` or `false`.
     * `name`: Name of the backup policy.
     * `performance_window_enabled`: Time windows to limit backup performance. This is an optional parameter. It can either be `true` or `false`. The default value is `false`.
     * `preserve_file_security_settings`: Retain security file settings. This is an optional parameter. It can either be `true` or `false`. The default value is `true`. We recommend using the `true` value.
     * `quiesce_snapshotting_enabled`: Use `quiescing` mode when creating backups. This is an optional parameter. It can either be `true` or `false`. The default value is `false`.
     * `silent_mode_enabled`: Silent mode that assumes minimum interaction with users. This is an optional parameter. It can either be `true` or `false`. The default value is `true`.
     * `splitting_bytes`: Defines the size for splitting backups. This is an optional parameter. The default value is `9223372036854775807`.
     * `vss_provider`: VSS settings. This is an optional parameter. It can either be `NATIVE` or `TARGET_SYSTEM_DEFINED`. The default value is `NATIVE`.
     * `reattempts`: Defines repeat attempts in case the backup operation fails:
       * `enabled`: Retry creating a backup if non-critical errors occur (e.g., when failing to connect to a target [disk](../../../compute/concepts/disk.md)). This is an optional parameter. It can either be `true` or `false`. The default value is `true`.
       * `interval`: Interval between retries. This is an optional parameter. The default value is `5m`.
       * `max_attempts`: Maximum number of retry attempts. If reached, the operation is considered failed. This is an optional parameter. The default value is `5`.
     * `retention`: Backup retention options:
       * `after_backup`: Apply backup retention rules after the backup is completed. It can either be `true` or `false`.
       * `rules`: Backup retention rules:
          * `max_age`: Delete backups whose age exceeds `max_age`.
          * `max_count`: Delete backups if their number exceeds `max_count`.
          * `repeat_period`: Period for applying the rules.

          The `max_age` and `max_count` attributes are mutually exclusive. i.e., the use of one makes it impossible to use the other.
     * `scheduling`: Backup scheduling options:
       * `enabled`: Enable backup scheduling. This is an optional parameter. It can either be `true` or `false`. The default value is `true`.
       * `max_parallel_backups`: Maximum number of concurrent backups. This is an optional parameter. The default value is `0` (unlimited).
       * `random_max_delay`: Sets a random delay between concurrent jobs. This is an optional parameter. The default value is `30m`.
       * `scheme`: Backup schedule scheme. This is an optional parameter. It can take either of these two values:
         * `ALWAYS_INCREMENTAL`: Always incremental.
         * `ALWAYS_FULL`: Always full.
         * `WEEKLY_FULL_DAILY_INCREMENTAL`: Create an incremental backup every day and a full one weekly.
         * `WEEKLY_INCREMENTAL`: Create an incremental backup every week.

         The default value is `ALWAYS_INCREMENTAL`.
       * `weekly_backup_day`: Day of the week when the weekly backup is run. This is an optional parameter. The default value is `MONDAY`.
       * `execute_by_time`: Settings for backups at a specific time:
         * `include_last_day_of_month`: Running backups on the last day of each month. This is an optional parameter. It can either be `true` or `false`. The default value is `false`.
         * `monthdays`: List of days to to which the schedule applies. This is an optional parameter. It can be used for the `MONTHLY` format.
         * `months`: List of months to which the schedules applies. This is an optional parameter.
         * `repeat_at`: List of time values in `HH:MM` (24-hour) format to which the schedule applies. This is an optional parameter.
         * `repeat_every`: Frequency for repeat backups. This is an optional parameter.
         * `type`: Schedule type. The possible values are `HOURLY`, `DAILY`, `WEEKLY`, and `MONTHLY`.
         * `weekdays`: List of days of the week to which the schedule applies. It can be used for the `WEEKLY` format.
     * `vm_snapshot_reattempts`: Backup retries in case of failures:
       * `enabled`: Retry a backup if any errors occur. This is an optional parameter. It can either be `true` or `false`. The default value is `true`.
       * `interval`: Interval between retries. This is an optional parameter. The default value is `5m`.
       * `max_attempts`: Maximum number of retry attempts. If reached, the operation is considered failed. This is an optional parameter. The default value is `5`.

     For more information about `yandex_backup_policy` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/backup_policy).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

     ```bash
     yc backup policy list
     ```

- API {#api}

  To create a [backup policy](../../concepts/policy.md), use the [create](../../backup/api-ref/Policy/create.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Create](../../backup/api-ref/grpc/Policy/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](update.md).
* [{#T}](delete.md).