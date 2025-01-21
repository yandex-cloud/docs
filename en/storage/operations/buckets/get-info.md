---
title: Getting bucket information and statistics in {{ objstorage-full-name }}
description: Follow this guide to get bucket information and statistics in {{ objstorage-name }}.
---

# Getting bucket information and statistics

## Getting bucket information {#get-information}

To view full information about a [bucket](../../concepts/bucket.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select the appropriate section with bucket information.
     * ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**: List of objects stored in the bucket.
     * ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**: Main bucket settings, information about website hosting in the bucket, versioning, logging, and lifecycles of bucket objects.
     * ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**: Description of access permissions and policy in the bucket, information about HTTPS and CORS configurations, object locks and object encryption in the bucket.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See a description of the CLI command to get bucket information:

     ```bash
     yc storage bucket get --help
     ```

  1. Get a list of buckets in the default folder:

     ```bash
     yc storage bucket list
     ```

     Result:

       ```text
       +------------------+----------------------+----------+-----------------------+---------------------+
       |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
       +------------------+----------------------+----------+-----------------------+---------------------+
       | first-bucket     | b1gmit33ngp6******** | 0        | STANDARD              | 2022-12-16 13:58:18 |
       +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Save the name of the bucket (`NAME` column) you want to get information on.

  1. Get the bucket information:

     ```bash
     yc storage bucket get <bucket_name> --full
     ```

     Result:

     ```text
     name: first-bucket
     folder_id: b1gmit33ngp6********
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     default_storage_class: ICE
     versioning: VERSIONING_ENABLED
     max_size: "5368709120"
     acl:
       grants:
         - permission: PERMISSION_READ
           grant_type: GRANT_TYPE_ACCOUNT
           grantee_id: ajep03tkmqqr********
     created_at: "2023-04-10T19:41:30.266075Z"
     website_settings:
       index: index.html
       error: 404.html
       redirect_all_requests: {}
     ```

{% endlist %}

## Getting bucket statistics {#get-statistics}

To view the statistics for a bucket:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. On the page that opens, you can view bucket statistics for a certain period:
     
     {% include [storage-monitoring-dashboards](../../_includes_service/storage-monitoring-dashboards.md) %}


- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See a description of the CLI command to get bucket statistics:

     ```bash
     yc storage bucket stats --help
     ```

  1. Get a list of buckets in the default folder:

     ```bash
     yc storage bucket list
     ```

     Result:

       ```text
       +------------------+----------------------+----------+-----------------------+---------------------+
       |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
       +------------------+----------------------+----------+-----------------------+---------------------+
       | first-bucket     | b1gmit33ngp6******** | 0        | STANDARD              | 2022-12-16 13:58:18 |
       +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Save the name of the bucket (`NAME` column) you want to get statistics on.

  1. Get the bucket statistics:

     ```bash
     yc storage bucket stats <bucket_name>
     ```

     Result:

     ```text
     name: first-bucket
     max_size: "5368709120"
     used_size: "621552"
     storage_class_used_sizes:
       - storage_class: STANDARD
         class_size: "607467"
       - storage_class: COLD
         class_size: "14085"
     storage_class_counters:
       - storage_class: STANDARD
         counters:
           simple_object_size: "607467"
           simple_object_count: "41"
       - storage_class: COLD
         counters:
           simple_object_size: "14085"
           simple_object_count: "16"
     default_storage_class: ICE
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     created_at: "2023-04-10T19:41:30.266075Z"
     updated_at: "2023-08-02T04:05:44.564924Z"
     ```

{% endlist %}