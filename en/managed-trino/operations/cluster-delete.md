---
title: Deleting a {{ TR }} cluster
description: You can delete an {{ TR }} cluster if you no longer need it.
keywords:
  - deleting an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
noIndex: true
---

# Deleting a {{ TR }} cluster

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

You can delete an {{ TR }} cluster if you no longer need it.

## Deleting a cluster {#delete}

Before deleting a cluster, disable its deletion protection if it is enabled.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
  1. Select **{{ mtr-name }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the cluster and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
  1. In the window that opens, confirm the deletion and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

{% endlist %}
