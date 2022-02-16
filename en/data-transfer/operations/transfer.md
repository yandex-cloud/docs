# Managing the transfer process

You can:

* [Get a list of transfers](#list).
* [Create a transfer](#create).
* [Update a transfer](#update).
* [Activate a transfer](#activate).
* [Deactivate a transfer](#deactivate).
* [Restart a transfer](#reupload).
* [Delete a transfer](#delete).

For more information about transfer statuses, possible actions with transfers, and existing restrictions, see [{#T}](../concepts/transfer-lifecycle.md).

## Getting a list of transfers {#list}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ data-transfer-name }}**.
    1. Go to the **Transfers** tab.

{% endlist %}

## Creating a transfer {#create}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ data-transfer-name }}**.

    1. Go to the **Transfers** tab.

    1. Click **Create transfer**.

    1. Select the source endpoint or [create](source-endpoint.md#create-endpoint) a new one.

    1. Select the target endpoint or [create](target-endpoint.md#create-endpoint) a new one.

    1. Under **Transfer parameters**, specify:

        * Transfer name.

        * Transfer type:
            * `{{ dt-type-copy-repl }}`: To create a full copy of the source data and keep it up-to-date.
            * `{{ dt-type-copy }}`: To create a full copy of the data without receiving further updates from the source.
            * `{{ dt-type-repl }}`: To continuously receive data updates from the source and apply them to the target (without creating a full copy of the source data).

        * (Optional) Description of the transfer.

    1. Click **Create**.

{% endlist %}

## Updating a transfer {#update}

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ data-transfer-name }}**.
    1. On the **Transfers** tab, select a transfer and click ![pencil](../../_assets/pencil.svg) **Edit** in the top panel.
    1. Change the name and description of the transfer.
    1. Tap **Save**.

{% endlist %}

## Activating a transfer {#activate}

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ data-transfer-name }}**.
    1. Go to the **Transfers** tab.
    1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Activate**.

{% endlist %}

## Restarting a transfer {#reupload}

If you assume that the transfer replication stage may fail (for example, due to [changes to the schema of the transferred data](db-actions.md) on the source), force restart the transfer.

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ data-transfer-name }}**.
    1. Go to the **Transfers** tab.
    1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Restart**.

{% endlist %}

For more information, see [{#T}](../concepts/transfer-lifecycle.md).

## Deactivating a transfer {#deactivate}

During transfer deactivation:

* The replication slot on the source is disabled.
* Temporary data transfer logs are deleted.
* The target is brought into the aligned state:
    * The data schema objects of the source are transferred for the final stage.
    * Indexes are created.

{% list tabs %}

- Management console
    1. Switch the source to <q>read-only</q>.
    1. Go to the folder page and select **{{ data-transfer-name }}**.
    1. Go to the **Transfers** tab.
    1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Deactivate**.
    1. Wait for the transfer status to switch to **Stopped**.

{% endlist %}

{% note warning %}

Do not interrupt the deactivation of the transfer! If the process fails, the performance of the source and target is not guaranteed.

{% endnote %}

For more information, see [{#T}](../concepts/transfer-lifecycle.md).

## Deleting a transfer {#delete}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ data-transfer-name }}**.
    1. Go to the **Transfers** tab.
    1. If the desired transfer is active, [deactivate it](#deactivate).
    1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Delete**.
    1. Click **Delete**.

{% endlist %}

