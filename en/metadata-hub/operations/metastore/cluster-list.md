---
title: Getting information about {{ metastore-full-name }} clusters
description: Follow this guide to request detailed information about existing {{ metastore-full-name }} clusters.
---

# Getting information about {{ metastore-full-name }} clusters

{% include [Preview](../../../_includes/note-preview.md) %}

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.


- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To get a list of {{ metastore-name }} clusters in the default folder, run this command:

  ```bash
  {{ yc-metastore }} cluster list
  ```

  Result:

  ```bash
  +----------------------+--------------+---------------------+--------+---------+
  |          ID          |     NAME     |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+--------------+---------------------+--------+---------+
  | c9q76od34u8j******** | metastore1   | 2025-08-10 19:15:29 | ALIVE  | RUNNING |
  | c9qipdqpe0dt******** | metastore2   | 2025-05-09 15:03:56 | ALIVE  | RUNNING |
  +----------------------+--------------+---------------------+--------+---------+
  ```

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

  1. Click the cluster name.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To get information about a {{ metastore-name }} cluster, run the following command:

  ```bash
  {{ yc-metastore }} cluster get <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ metastore-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the cluster name.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  To get a list of operations, run the following command:

    ```bash
    {{ yc-metastore }} cluster list-operations <cluster_name_or_ID>
    ```

  You can get the cluster ID and name with the [list of clusters in the folder](#list-clusters).

{% endlist %}

### Getting operation details {#get-operations-info}

1. [Get the list of operations](#get-operations) for a cluster.
1. Copy the operation ID.
1. Get operation details:

    {% list tabs group=instructions %}
    
    - CLI {#cli}
    
      {% include [cli-install](../../../_includes/cli-install.md) %}
    
      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
      Run this command:
    
        ```bash
        yc operation get <operation_ID>
        ```
    
      Result:
    
        ```text
        id: fltpnb1a6llk********
        description: Create Metastore cluster
        created_at: "2025-08-10T19:15:29.794361Z"
        created_by: ajejut7dk2dp********
        modified_at: "2025-08-10T19:23:38.978798Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.metastore.v1.CreateClusterMetadata
          cluster_id: c9q76od34u8j********
        response:
          '@type': type.googleapis.com/yandex.cloud.metastore.v1.Cluster
          id: c9q76od34u8j********
          folder_id: b1gutjgdvq50********
          created_at: "2025-08-10T19:15:29.794361Z"
          name: metastore2
          ...
        ```
    
    {% endlist %}

