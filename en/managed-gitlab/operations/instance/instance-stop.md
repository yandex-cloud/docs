# Stopping and starting a {{ GL }} instance

If necessary, you can stop and restart a [{{ GL }} instance](../../concepts/index.md#instance). When the instance is stopped, all its data is saved.

You don't pay for the time when your instance has been stopped: you continue paying only for the data stored by the instance and the size of backups stored in {{ objstorage-full-name }}, according to your [pricing plan](../../pricing.md#prices-storage).

## Stopping an instance {#stop-instance}

{% list tabs %}

- Management console

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgl-name }}**.
  1. Find the desired instance in the list, click ![options](../../../_assets/horizontal-ellipsis.svg), and select **Stop instance**.
  1. In the dialog box that opens, confirm that you want to stop the instance, then click **Stop**.

{% endlist %}

## Starting an instance {#start-instance}

You can restart your **Stopped** instance.

{% list tabs %}

- Management console

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgl-name }}**.
  1. Find the stopped cluster in the list, click ![options](../../../_assets/horizontal-ellipsis.svg), then select **Start instance**.
  1. In the dialog that opens, confirm that you want to start the instance by clicking **Start**.

{% endlist %}