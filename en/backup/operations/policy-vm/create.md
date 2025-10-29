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
  1. In the left-hand panel, select ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Click **{{ ui-key.yacloud.backup.button_create-policy }}**.
  1. On the backup policy creation page:

      * Specify the policy name. Follow these naming requirements:

        {% include [name-format](../../../_includes/name-format.md) %}

      * Select the [type of backup](../../concepts/backup.md#types):

          * `{{ ui-key.yacloud.backup.policy-form.title_incremental-backup-card }}`: Saves only data that is different from the previous backup. On the first run, a full backup of the resource will be made.
          * `{{ ui-key.yacloud.backup.policy-form.title_full-backup-card }}`: Saves all VM or {{ baremetal-name }} server data.

          Once the policy is created, you cannot change the type.

      * Under **{{ ui-key.yacloud.backup.policy-form.title_schedule-section }}**, select the run schedule type:

          {% include [policy-options-schedule-type](../../../_includes/backup/policy-options-schedule-type.md) %}

          Once the policy is created, you cannot change the type.

      {% include [policy-options-retention](../../../_includes/backup/policy-options-retention.md) %}

      * Expand the **{{ ui-key.yacloud.backup.policy-form.title_additional-section }}** section and, in the form that opens, proceed as follows:

          {% include [policy-options-additional](../../../_includes/backup/policy-options-additional.md) %}

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

      {% note info %}

      The `preserveFileSecuritySettings` and `quiesceSnapshottingEnabled` parameters are no longer supported.
     
      {% endnote %}

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

      {% include [json-output-cli](../../../_includes/backup/operations/json-output-cli.md) %}

      For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/create.md).

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
         sector_by_sector                  = true
         run_later                         = true
         validation_enabled                = true
         lvm_snapshotting_enabled          = true
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

             backup_sets {
                 execute_by_time {
                     type                      = "MONTHLY"
                     include_last_day_of_month = true
                     monthdays                 = []
                     months                    = [1,2,3,4,5,6,7,8,9,10,11,12]
                     repeat_at                 = ["04:10"]
                     repeat_every              = "30m"
                     weekdays                  = []
                 }
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
     * `cbt`: Configuration for tracking [backup](../../concepts/backup.md) contents. This is an optional parameter. The possible values include:
       * `CHANGED_BLOCK_TRACKING_UNSPECIFIED`: Not specified.
       * `USE_IF_ENABLED`: Use if enabled.
       * `ENABLE_AND_USE`: Enable and use.
       * `DO_NOT_USE`: Do not use.

       The default value is `DO_NOT_USE`.
     * `compression`: Backup compression ratio. This is an optional parameter. The possible values include:
       * `NORMAL`: Standard compression ratio.
       * `HIGH`: High compression ratio.
       * `MAX`: Maximum compression ratio.
       * `OFF`: Disabled.

       The default value is `NORMAL`.
     * `fast_backup_enabled`: Fast backup for tracking changes to files. When enabled, file changes are detected by the file size and its timestamp. When disabled, files are checked for changes by comparing their contents to backed up files. It can either be `true` or `false`.
     * `format`: Backup format. This is an optional parameter. The possible values include:
       * `VERSION_11`: Deprecated format, not recommended.
       * `VERSION_12`: Recommended format for high-speed backup and recovery.
       * `AUTO`: Automatic format selection. The default option is `VERSION_12`, unless you are creating [incremental](../../concepts/backup.md#types) backups for the images created in other versions.
     * `multi_volume_snapshotting_enabled`: Creating backups for multiple volumes at the same time. This is an optional parameter. It can either be `true` or `false`.
     * `name`: Name of the backup policy.
     * `performance_window_enabled`: Time windows to limit backup performance. This is an optional parameter. It can either be `true` or `false`. The default value is `false`.
     * `sector_by_sector`: Sector-by-sector backup. Backs up all disk or volume sectors, including empty areas and unallocated space. If no compression level is selected, the backup size will be equal to the disk size. This mode is used automatically for disks with unsupported file systems. You cannot recover app data from a backup like that. It can either be `true` or `false`. The default value is `false`.
     * `run_later`: If the VM was `Stopped` during a scheduled backup, all skipped backup jobs will be executed after the VM starts. It can either be `true` or `false`. The default value is `false`.
     * `validation_enabled`: Checks the possibility of recovering data from the new backup. During the check, a checksum is calculated for each section available for recovery. The check may take a long time because it scans all recoverable data. It can either be `true` or `false`. The default value is `false`.
     * `lvm_snapshotting_enabled`: Uses LVM to create a volume snapshot. If the snapshot cannot be created using LVM, it will be created using the {{ backup-name }} agent. It can either be `true` or `false`. The default value is `false`.
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

          The `max_age` and `max_count` attributes are mutually exclusive, i.e., the use of one makes it impossible to use the other.
     * `scheduling`: Backup scheduling options:
       * `enabled`: Enable backup scheduling. This is an optional parameter. It can either be `true` or `false`. The default value is `true`.
       * `max_parallel_backups`: Maximum number of concurrent backups. This is an optional parameter. The default value is `0` (unlimited).
       * `random_max_delay`: Sets a random delay between concurrent jobs. This is an optional parameter. The default value is `30m`.
       * `scheme`: Backup schedule scheme. This is an optional parameter. The possible values include:
         * `ALWAYS_INCREMENTAL`: Always incremental.
         * `ALWAYS_FULL`: Always full.
         * `WEEKLY_FULL_DAILY_INCREMENTAL`: Create an incremental backup every day and a full one weekly.
         * `WEEKLY_INCREMENTAL`: Create an incremental backup every week.

         The default value is `ALWAYS_INCREMENTAL`.
       * `weekly_backup_day`: Day of the week when the weekly backup is run. This is an optional parameter. The default value is `MONDAY`.
       * `backup_sets`: List of schedules with backup sets:
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

     {% note info %}

     The `preserveFileSecuritySettings` and `quiesceSnapshottingEnabled` parameters are no longer supported.
     
     {% endnote %}


     For more information about `yandex_backup_policy` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/backup_policy).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```bash
     yc backup policy list
     ```

- API {#api}

  To create a [backup policy](../../concepts/policy.md), use the [create](../../backup/api-ref/Policy/create.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Create](../../backup/api-ref/grpc/Policy/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](update.md).
* [{#T}](delete.md).