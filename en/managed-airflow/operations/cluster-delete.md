---
title: Deleting an {{ AF }} cluster
description: You can delete an {{ AF }} cluster if you no longer need it.
keywords:
  - Deleting an {{ AF }} cluster
  - '{{ AF }} cluster'
  - '{{ AF}}'
  - Airflow
---

# Deleting an {{ AF }} cluster

You can delete an {{ AF }} cluster if you no longer need it.

## Deleting a cluster {#delete}

Before deleting a cluster, disable its deletion protection if it is enabled.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder you want to delete a cluster from.
   1. Select **{{ maf-name }}**.
   1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon for the required cluster and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
   1. In the window that opens, confirm the deletion and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-delete-cluster_button }}**.

{% endlist %}
