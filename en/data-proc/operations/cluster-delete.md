---
title: "Deleting Data Proc clusters"
description: "You can delete a Data Proc cluster along with all the data stored in it. Keep in mind that backups are not created automatically – if you want to save data for cluster recovery or later use, for example, use the Yandex Object Storage service."
---

# Deleting clusters

You can delete a cluster along with all the data stored in it. Note that data backups are not created automatically: if you want to save data for cluster recovery or future use, you can do that, for example, using [{{ objstorage-full-name }}](https://cloud.yandex.ru/services/storage).

## Before deleting a cluster {#before-you-delete}

[Disable deletion protection](./cluster-update.md) for the cluster if it is enabled.

## Deleting the cluster {#delete}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the desired cluster and select **Delete**.
   1. (optionally) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. Confirm cluster deletion.

   {{ dataproc-name }} runs the delete cluster operation.

- {{ TF }}

   {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

{% endlist %}
