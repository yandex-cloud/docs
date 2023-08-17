## Create a transfer {#create-transfer}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a transfer.
   1. Select **{{ data-transfer-name }}**.
   1. Create a source endpoint:
      1. In the ![endpoint](../../_assets/data-transfer/endpoint.svg) **Endpoints** tab, click **Create endpoint**.
      1. In the **Direction** field, select `Source`.
      1. Enter the endpoint name, for example, `logs-source`.
      1. In the **Database type** list, select `{{ yds-full-name }}`.
      1. Select the database you specified in the settings of the stream you previously created.
      1. Enter the stream name: `logs-stream`.
      1. Select the previously created `logs-sa` service account.
      1. Under **Advanced settings**, specify the conversion rules for the `CloudLogging parser` data.
      1. Click **Create**.
   1. Create a target endpoint:
      1. In the ![endpoint](../../_assets/data-transfer/endpoint.svg) **Endpoints** tab, click **Create endpoint**.
      1. In the **Direction** field, select `Target`.
      1. Enter the endpoint name, for example, `logs-receiver`.
      1. In the **Database type** list, select `{{ objstorage-name }}`.
      1. Enter the name of the previously created bucket.
      1. Select the previously created `logs-sa` service account.
      1. In the **Output format** field, select `JSON`.
      1. Click **Create**.
   1. Create a transfer:
      1. In the ![image](../../_assets/data-transfer/transfer.svg) **Transfers** tab, click **Create transfer**.
      1. Enter the transfer name, e.g., `logs-transfer`.
      1. Select the previously created source endpoint, `logs-source`.
      1. Select the previously created target endpoint, `logs-receiver`.
      1. Click **Create**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the created transfer and select **Activate**.

   Wait until the transfer is activated. Once the transfer is ready for use, its status will change from {{ dt-status-creation }} to {{ dt-status-repl }}.

{% endlist %}