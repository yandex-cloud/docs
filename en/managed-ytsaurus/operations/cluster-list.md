---
title: Information about clusters in {{ myt-name }}
description: You can request detailed information about each {{ ytsaurus-name }} cluster you created. To get a list of clusters in a folder, go to the folder dashboard and select {{ myt-name }}.
---

# Information about existing clusters

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

You can request detailed information about each {{ ytsaurus-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Click the cluster name.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ ytsaurus-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of operations for a {{ ytsaurus-name }} cluster:

    1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Select the appropriate cluster.
    1. Navigate to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the cluster you selected.

       You will see a list of operations with the cluster you selected.

{% endlist %}

### Getting operation details {#get-operations-info}

1. [Get a list of operations](#get-operations) for a cluster.
1. Copy the operation ID.
1. Get operation details:

    {% list tabs group=instructions %}

    - CLI {#cli}

        {% include [cli-install](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        Run this command:

        ```bash
        yc operation get <operation_ID>
        ```

        Result:

        ```bash
        id: b9k4900r7k**********
        description: Create cluster
        created_at: "2025-07-11T14:17:29.915505Z"
        created_by: ajeuoi52dg**********
        modified_at: "2025-07-11T15:12:44.572840Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.ytsaurus.v1.CreateClusterMetadata
          cluster_id: cnkgf75gu***********
        response:
          '@type': type.googleapis.com/yandex.cloud.ytsaurus.v1.Cluster
          ...
        ```
    {% endlist %}


