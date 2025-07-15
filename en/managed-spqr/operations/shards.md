---
title: Managing {{ SPQR }} shards
description: Follow this guide to create shards in a {{ mspqr-name }} cluster.
---

# Managing {{ SPQR }} shards

{% include [preview](../../_includes/note-service-preview.md) %}

## Creating a shard {#create-shard}

{{ mpg-full-name }} shards are based on existing {{ mpg-name }} clusters residing in the same folder and cloud network as the {{ SPQR }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}** tab.
    1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
    1. Specify a shard name and select the {{ PG }} cluster whose hosts will serve as data hosts in the {{ SPQR }} cluster.
    1. Click **Create**.

{% endlist %}

## Deleting a shard {#delete-shard}

Deleting a {{ SPQR }} shard does not affect the {{ mpg-name }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}** tab.
    1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon in the shard row and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
