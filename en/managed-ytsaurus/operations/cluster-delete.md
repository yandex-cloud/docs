---
title: Deleting a {{ ytsaurus-name }} cluster
description: You can delete an {{ ytsaurus-name }} cluster if you no longer need it.
keywords:
  - deleting an {{ ytsaurus-name }} cluster
  - '{{ ytsaurus-name }} cluster'
  - '{{ ytsaurus-name }}'
---

# Deleting a {{ ytsaurus-name }} cluster

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

You can delete an {{ ytsaurus-name }} cluster if you no longer need it.

## Deleting a cluster {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
  1. Select **{{ myt-name }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the cluster and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. In the window that opens, confirm the deletion and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

{% endlist %}
