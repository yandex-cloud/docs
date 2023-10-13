---
title: "Creating a backup policy"
description: "In this tutorial, you will learn how to create a backup policy in **{{ backup-name }}**."
---

# Creating a backup policy

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a backup policy.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Go to the ![policies](../../../_assets/backup/policies.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
   1. Click **{{ ui-key.yacloud.backup.button_create-policy }}**.
   1. On the policy creation page:

      {% include [policy-options](../../../_includes/backup/policy-options.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

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

- API

   To create a [backup policy](../../concepts/policy.md), use the [create](../../backup/api-ref/Policy/create.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Create](../../backup/api-ref/grpc/policy_service.md#Create) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)
