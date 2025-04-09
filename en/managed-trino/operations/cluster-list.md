---
title: Information about clusters in {{ mtr-name }}
description: You can request detailed information about each {{ mtr-name }} cluster you created. To get a list of clusters in a folder, go to the folder page and select {{ mtr-name }}.
noIndex: true
---

# Information about existing clusters in {{ mtr-name }}

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

You can request detailed information about each {{ mtr-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
    1. Click the cluster name.

{% endlist %}

## Viewing operations with clusters {#list-operations}

All actions with {{ mtr-name }} clusters are logged as a list of operations. Each operation gets its own unique ID.

### Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of operations for a {{ mtr-name }} cluster:

    1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.mdb.clusters.label_title }}**.
    1. Select the cluster.
    1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

        You will see a list of operations with the selected cluster.

{% endlist %}

## See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
