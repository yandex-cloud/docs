# Getting started with {{ data-transfer-name }}

Copy or replicate data from a source to a target by creating [endpoints](concepts/index.md#endpoint) and configuring [transfers](concepts/index.md#transfer) between them.
See the [full list of endpoints](transfer-matrix.md) and possible transfers between them.


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register a new account.
1. Go to [{{ billing-name }}]({{ link-console-billing }}) and make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its [status](../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account, [create one](../billing/quickstart/index.md) and [link](../billing/operations/pin-cloud.md) a cloud to it.
1. Navigate to the {{ yandex-cloud }} [console]({{ link-console-main }}) and select a folder you are going to operate in. If there is no such folder, [create it](../resource-manager/operations/folder/create.md).
1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the `editor` role or higher for the desired folder or the cloud that the folder belongs to.

If you are creating a managed database endpoint for a cluster residing in a different folder, you will need a service or primitive [`viewer`](../iam/roles-reference.md#viewer) role for that folder.

{% note info %}

When creating an endpoint, you can select a cluster from a different folder only if using the {{ yandex-cloud }} CLI, Terraform, or API.

{% endnote %}

For more information about the roles required to use {{ data-transfer-name }}, see [Required roles](security/index.md#required-roles).


## Configure the source and the target {#db-settings}

Different systems can act as a source and as a target.

### Compatibility of sources and targets {#connectivity-matrix}

{% include [include](../_includes/data-transfer/connectivity-marix.md) %}

### Preparing sources and targets {#prepare-source-and-target}

Prepare the source for sending data:

* {{ AB }}:
    * [AWS CloudTrail](operations/prepare.md#source-aws)
    * [BigQuery](operations/prepare.md#source-bigquery)
    * [Microsoft SQL Server](operations/prepare.md#source-mssql)
    * [S3](operations/prepare.md#source-s3)
* [{{ KF }}](operations/prepare.md#source-kf)
* [{{ CH }}](operations/prepare.md#source-ch)
* [{{ ES }}](operations/prepare.md#source-es)
* [{{ GP }}](operations/prepare.md#source-gp)
* [{{ MG }}](operations/prepare.md#source-mg)
* [{{ MY }}](operations/prepare.md#source-my)
* [{{ OS }}](operations/prepare.md#source-os)
* [Oracle](operations/prepare.md#source-oracle)
* [{{ PG }}](operations/prepare.md#source-pg)
* [{{ yds-full-name }}](operations/prepare.md#source-yds)

* [{{ ydb-full-name }}](operations/prepare.md#source-ydb)

Prepare the target for receiving the data:

* [{{ CH }}](operations/prepare.md#target-ch)
* [{{ ES }}](operations/prepare.md#target-es)
* [{{ GP }}](operations/prepare.md#target-gp)
* [{{ MG }}](operations/prepare.md#target-mg)
* [{{ MY }}](operations/prepare.md#target-my)
* [{{ objstorage-name }}](operations/prepare.md#target-storage)
* [{{ OS }}](operations/prepare.md#target-os)
* [{{ PG }}](operations/prepare.md#target-pg)


* [{{ ydb-name }}](operations/prepare.md#target-ydb)


## Creating an endpoint for the source {#source}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
1. Click **Create endpoint**.
1. Make sure that the **Direction** field is set to `Source`.
1. Enter a name for the endpoint.
1. In the **Database type** field, select the type of the DBMS to transfer data from.
1. Specify endpoint parameters in the corresponding settings section.
1. Click **Create**.

For more information, see [{#T}](operations/endpoint/index.md).

## Creating an endpoint for the target {#target}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
1. Click **Create endpoint**.
1. Make sure that the **Direction** field is set to `Target`.
1. Enter a name for the endpoint.
1. In the **Database type** field, select the type of DBMS that you want to transfer data to.
1. Specify endpoint parameters in the corresponding settings section.
1. Click **Create**.

For more information, see [{#T}](./operations/endpoint/index.md).

## Create a transfer {#create-transfer}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **Transfers**.
1. Click **Create transfer**.
1. Enter a name for the transfer.
1. (Optional) Add a transfer description.
1. Select the endpoint for the source and the endpoint for the target.
1. Select the [type of transfer](./concepts/index.md#transfer-type.md):
    * {{ dt-type-copy }}: To create a full copy of the data without receiving further updates from the source. You can also use this type to [replicate constantly changing tables](concepts/transfer-lifecycle.md#select-transfer-type).
        If you need to create a full copy of the data at specific intervals, enable **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.regular_snapshot.title }}**.
    * {{ dt-type-repl }}: To continuously receive data updates from the source and apply them to the target (without creating a full copy of the source data).
    * {{ dt-type-copy-repl }}: To create a full copy of the source data and keep it up-to-date.
1. Click **Create**.

For more information, see [Types of transfers](./concepts/transfer-lifecycle.md#transfer-types).

## Activate the transfer {#activate}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **Transfers**.
1. Click ![ellipsis](../_assets/console-icons/ellipsis.svg) next to the transfer name and select **Activate**.

The data transfer process will begin.

For more information, see [{#T}](operations/transfer.md).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [preparing databases for the service](operations/prepare.md) and [setting up transfers](operations/transfer.md).
* Learn which [roles](security/index.md) exist in {{ data-transfer-name }}.
* Check out [our tutorials on using {{ data-transfer-name }}](tutorials/index.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
