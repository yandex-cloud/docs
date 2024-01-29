---
title: "Creating a backup policy"
description: "In this tutorial, you will learn how to create a backup policy in **{{ backup-name }}**."
---

# Creating a backup policy

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a backup policy.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Go to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
   1. Click **{{ ui-key.yacloud.backup.button_create-policy }}**.
   1. On the policy creation page:

      {% include [policy-options](../../../_includes/backup/policy-options.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a backup policy:

      ```bash
      yc backup policy create --help
      ```

   1. Specify the configuration of a new backup policy as a data schema in JSON format.

      {% cut "Sample configuration file" %}

      {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

      {% endcut %}

      Once completed, save the configuration to a `.json` file.

      The example describes a configuration for a backup policy that will create [incremental](../../concepts/backup.md#types) VM backups every Monday at 00:05 (UTC+0). Only the last 10 backups will be stored.

      See [Full backup policy specification](../../concepts/policy.md#specification).

   1. Create a backup policy:

      ```bash
      yc backup policy create \
        --name <policy_name> \
        --settings-from-file <configuration_file_path>
      ```

      Where:

      * `--name`: Name of the backup policy being created.
      * `--settings-from-file`: Path to the backup policy configuration file in JSON format.

      Result:

      ```bash
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
          after_backup: true
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

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a [backup policy](../../concepts/policy.md):

  1. In the {{ TF }} configuration file, describe the backup policy parameters:

     
     ```
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[<Machine Name>]-[<Plan ID>]-[<Unique ID>]a"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<policy_name>"
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

      * `archive_name`: Generated archive names. This is an optional parameter. The parameter variables include:
         * `Machine Name`: VM name.
         * `Plan ID`: Plan ID.
         * `Unique ID`: Unique identifier.
            Make sure the last character in the generated archive name is not a variable.
      * `cbt`: Configuration for tracking backup contents. This is an optional parameter. The possible values include:
         * `CHANGED_BLOCK_TRACKING_UNSPECIFIED`: Not set.
         * `USE_IF_ENABLED`: Use if enabled.
         * `ENABLE_AND_USE`: Enable and use.
         * `DO_NOT_USE`: Do not use.
            The default value is `DO_NOT_USE`.
      * `compression`: Backup compression ratio. This is an optional parameter. The possible values include:
         * `NORMAL`: Standard compression.
         * `HIGH`: High compression ratio.
         * `MAX`: Maximum compression.
         * `OFF`: Disabled.
            The default value is `NORMAL`.
      * `fast_backup_enabled`: Fast backup for tracking changes to files. When enabled, file changes are detected by the file size and timestamp. When disabled, files are checked for changes by comparing their contents to backed up files. It may take either the `true` or `false` value.
      * `format`: Backup format. This is an optional parameter. The possible values include:
         * `VERSION_11`: Deprecated format, not recommended.
         * `VERSION_12`: Recommended format for fast backup and recovery.
         * `AUTO`: Automatic format selection. The default value is `VERSION_12`. The exception is creating incremental backups for images created in other versions.
      * `multi_volume_snapshotting_enabled`: Creating snapshots of multiple volumes at the same time. This is an optional parameter. It may take either the `true` or `false` value.
      * `name`: Backup policy name.
      * `performance_window_enabled`: Time windows to limit backup performance. This is an optional parameter. It may take either the `true` or `false` value. The default value is `false`.
      * `preserve_file_security_settings`: Retain security file settings. This is an optional parameter. It may take either the `true` or `false` value. The default value is `true`. We recommend using the `true` value.
      * `quiesce_snapshotting_enabled`: Using `quiescing` mode when creating snapshots. This is an optional parameter. It may take either the `true` or `false` value. The default value is `false`.
      * `silent_mode_enabled`: Silent mode that assumes minimum interaction with users. This is an optional parameter. It may take either the `true` or `false` value. The default value is `true`.
      * `splitting_bytes`: Parameter that defines the size for splitting backups. This is an optional parameter. The default value is `9223372036854775807`.
      * `vss_provider`: VSS settings. This is an optional parameter. The value can be `NATIVE` or `TARGET_SYSTEM_DEFINED`. The default value is `NATIVE`.

      * `reattempts`: Parameters of backup reattempts in the event of failure:
         * `enabled`: Retry creating a backup if noncritical errors occur (for example, when failing to connect to a target disk). This is an optional parameter. It may take either the `true` or `false` value. The default value is `true`.
         * `interval`: Reattempt interval. This is an optional parameter. The default value is `5m`.
         * `max_attempts`: Maximum number of reattempts. If reached, the operation is considered failed. This is an optional parameter. The default value is `5`.

      * `retention`: Backup retention parameters:
         * `after_backup`: Apply backup retention rules after the backup is completed. It may take either the `true` or `false` value.
         * `rules`: Backup retention rules:
            * `max_age`: Delete backups whose age exceeds `max_age`.
            * `max_count`: Delete backups if their number exceeds `max_count`.
            * `repeat_period`: Period for applying the rules.
               The `max_age` and `max_count` attributes are mutually exclusive. Using one of them disables the use of the other.

      * `scheduling`: Backup schedule parameters:
         * `enabled`: Enable backup scheduling. This is an optional parameter. It may take either the `true` or `false` value. The default value is `true`.
         * `max_parallel_backups`: Maximum number of parallel backups. This is an optional parameter. The default value is `0` (unlimited).
         * `random_max_delay`: Sets a random delay between concurrent jobs. This is an optional parameter. The default value is `30m`.
         * `scheme`: Backup schedule scheme. This is an optional parameter. The possible values include:
            * `ALWAYS_INCREMENTAL`: Always incremental.
            * `ALWAYS_FULL`: Always full.
            * `WEEKLY_FULL_DAILY_INCREMENTAL`: Weekly: full; daily: incremental.
            * `WEEKLY_INCREMENTAL`: Weekly: incremental.
               The default value is `ALWAYS_INCREMENTAL`.
         * `weekly_backup_day`: Day of the week for weekly backups. This is an optional parameter. The default value is `MONDAY`.
         * `execute_by_time`: Settings for backups at a specified time:
            * `include_last_day_of_month`: Making backups on the last day of each month. This is an optional parameter. It may take either the `true` or `false` value. The default value is `false`.
            * `monthdays`: List of days to apply the schedule on. This is an optional parameter. Used in `MONTHLY` format.
            * `months`: List of months to apply the schedule in. This is an optional parameter.
            * `repeat_at`: List of time periods in the `HH:MM` (24-hour) format to apply the schedule in. This is an optional parameter.
            * `repeat_every`: Frequency for repeating backups. This is an optional parameter.
            * `type`: Schedule type. The possible values are `HOURLY`, `DAILY`, `WEEKLY`, or `MONTHLY`.
            * `weekdays`: List of days of the week to apply the backup on. Used in `WEEKLY` format.

      * `vm_snapshot_reattempts`: Parameters of snapshot creation reattempts in the event of failure:
         * `enabled`: Retry creating a VM snapshot if an error occurs. This is an optional parameter. It may take either the `true` or `false` value. The default value is `true`.
         * `interval`: Interval between reattempts. This is an optional parameter. The default value is `5m`.
         * `max_attempts`: Maximum number of reattempts. If reached, the operation is considered failed. This is an optional parameter. The default value is `5`.

      For more information about the `yandex_backup_policy` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/backup_policy).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc backup policy list
      ```

- API {#api}

   To create a [backup policy](../../concepts/policy.md), use the [create](../../backup/api-ref/Policy/create.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Create](../../backup/api-ref/grpc/policy_service.md#Create) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)
