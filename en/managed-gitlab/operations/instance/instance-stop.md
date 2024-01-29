# Stopping and starting a {{ GL }} instance

If necessary, you can stop and restart a [{{ GL }} instance](../../concepts/index.md#instance). When the instance is stopped, all its data is saved.

You are not charged while your instance is stopped: you continue to pay only for the data stored by the instance and the size of backups stored in {{ objstorage-full-name }} based on the [pricing policy](../../pricing.md#prices-storage).

## Stopping a {#stop-instance} instance

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Find the required instance in the list, click ![options](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.common.stop }}**.
  1. In the dialog box that opens, confirm that you want to stop the instance, then click **{{ ui-key.yacloud.common.stop }}**.

{% endlist %}

## Starting a {#start-instance} instance

You can restart your **Stopped** instance.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Find the stopped cluster in the list, click ![options](../../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.common.start }}**.
  1. In the dialog box that opens, confirm that you want to start the instance by clicking **{{ ui-key.yacloud.common.start }}**.

{% endlist %}