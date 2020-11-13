# Creating a transfer

To create a transfer:

{% list tabs %}

- Management console

  1. Click **Create transfer**.

  1. Select the **Source** endpoint or [create](../source/create-endpoint.md) a new one.

  1. Select the **Target** endpoint or [create](../target/create-endpoint.md) a new one.

  1. Under **Transfer parameters**:
      - Enter the transfer **Name**.
      - Select the transfer **Type**:
        - **Copy and replicate** to transfer the data and keep the target database in sync with the source database.
        - **Copy** to make a one-time transfer of the database snapshot.
        - **Replicate** to continuously retrieve changes from the source database and apply them to the target database.
      - Enter the transfer **Description**.

  1. Click **Create**.

      Wait until the transfer is created.

  1. In the line with the created transfer, click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) and select **Activate**.

      Wait until the transfer is activated.

{% endlist %}

