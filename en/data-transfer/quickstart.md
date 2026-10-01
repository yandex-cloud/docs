# Getting started with {{ data-transfer-name }}

With {{ data-transfer-name }}, you can transfer data from a third-party source cluster to a target cluster without interrupting user service. In this guide, you will learn how to transfer a third-party {{ MY }} cluster to {{ mmy-name }}. Replication is performed by configuring [endpoints](concepts/index.md#endpoint) and the [transfer](concepts/index.md#transfer) between them.

For the full list of endpoints and possible transfers between them, see [{#T}](transfer-matrix.md).


You will create resources in the [management console]({{ link-console-main }}) in your [folder](../resource-manager/concepts/resources-hierarchy.md#folder), for which you will need the `editor` [role](../iam/roles-reference.md#editor). Some resources are paid, so make sure your [billing account is active](../billing/concepts/billing-account-statuses.md).



## Configure the source and the target {#db-settings}

1. Create a [target {{ mmy-name }} cluster](../managed-mysql/operations/cluster-create.md) of any suitable configuration. In this case, the following applies:

    * The {{ MY }} version must be the same as or higher than in the source cluster.

        Data transfer with a major {{ MY }} version upgrade is possible but not guaranteed. For more information, see [this {{ MY }} guide](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

        Migration to an earlier {{ MY }} version is [not supported](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

    * [SQL mode](../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

1. [Prepare the target cluster](operations/prepare.md#target-my).

## Creating an endpoint for the source {#source}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate]({{ link-console-main }}/link/data-transfer) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. In the left-hand panel, select ![image](../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
  1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
  1. In the **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** field, select `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
  1. Name the endpoint.
  1. In the **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** field, select `{{ MY }}`.
  1. Specify endpoint parameters in the corresponding settings section.
  
     For more on available parameters, see [{#T}](operations/endpoint/source/mysql.md).

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Creating an endpoint for the target {#target}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate]({{ link-console-main }}/link/data-transfer) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. In the left-hand panel, select ![image](../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
  1. Click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
  1. In the **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** field, select `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
  1. Name the endpoint.
  1. In the **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** field, select `{{ MY }}`.
  1. Specify endpoint parameters in the corresponding settings section.

     For more on available parameters, see [{#T}](operations/endpoint/target/mysql.md).

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a transfer {#create-transfer}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate]({{ link-console-main }}/link/data-transfer) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. In the left-hand panel, select ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Click **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
  1. Enter a name for the transfer.
  1. (Optional) Add a transfer description.
  1. Select the new source and target endpoints.
  1. Select the [type of transfer](./concepts/index.md#transfer-type):

     * {{ dt-type-copy }}: To create a full copy of the data without receiving further updates from the source. You can also use this type to [replicate constantly changing tables](concepts/transfer-lifecycle.md#select-transfer-type).

       If you need to create a full copy of the data at specific intervals, enable **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.regular_snapshot.title }}**.

     * {{ dt-type-repl }}: To continuously receive data updates from the source and apply them to the target (without creating a full copy of the source data).
     * {{ dt-type-copy-repl }}: To create a full copy of the source data and keep it up-to-date.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

For more information, see [{#T}](operations/transfer.md#create).

## Activate the transfer {#activate}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate]({{ link-console-main }}/link/data-transfer) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. In the left-hand panel, select ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Click ![ellipsis](../_assets/console-icons/ellipsis.svg) next to the transfer name and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

{% endlist %}

The data transfer process will begin.

## Complete your data transfer {#finish-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to _read-only_ mode and transfer the workload over to the target cluster.
1. Monitor the transfer status on the [monitoring](operations/monitoring.md) page.

   When the **Maximum data transfer delay** [chart](operations/monitoring.md#sinker.pusher.time.row_max_lag_sec) (data lag in seconds) drops to zero, all the changes in the source cluster that took place after the data copying ended will be transferred to the target cluster. From that point on, you will be able to work with the transferred data.

## What's next {#whats-next}

* Read about the [service concepts](concepts/index.md).
* Learn more about [preparing databases for the service](operations/prepare.md) and [setting up transfers](operations/transfer.md).
* Learn which [roles](security/index.md) exist in {{ data-transfer-name }}.
* Check out [our tutorials on using {{ data-transfer-name }}](tutorials/index.md).
