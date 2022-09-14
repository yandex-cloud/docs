# Getting started with {{ data-transfer-name }}

Copy or replicate data from a source to a target by creating [endpoints](concepts/index.md#endpoint) and configuring [transfers](concepts/index.md#transfer) between them.

{% if audience != "internal" %}

## Before you begin {#before-you-begin}

1. Go to the {{ yandex-cloud }} [console]({{ link-console-main }}) and select the folder where you want to perform the operations. If that folder doesn't exist, create it:

   {% list tabs %}

   - Management console

      {% include [create-folder](../_includes/create-folder.md) %}

   - CLI

      {% include [cli-install](../_includes/cli-install.md) %}

      1. See a description of the create folder command:

         ```bash
         yc resource-manager folder create --help
         ```

      1. Create a new folder:

         * with a name and without a description:

            ```bash
            yc resource-manager folder create \
              --name new-folder
            ```

            {% include [name-format](../_includes/name-format.md) %}

         * with a name and description:

            ```bash
            yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
            ```

   - API

      Use the [create](../resource-manager/api-ref/Folder/create.md) method for the [Folder](../resource-manager/api-ref/Folder/index.md) resource of the {{ resmgr-full-name }} service.

   {% endlist %}


{% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
   {% endif %}
1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the `editor` role or higher for the desired folder or the cloud that the folder belongs to.

{% endif %}

## Configure the source and the target {#db-settings}

Different systems can act as a source and as a target.

### Compatibility of sources and targets {#connectivity-matrix}

{% include [include](../_includes/data-transfer/connectivity-marix.md) %}

### Preparing sources and targets {#prepare-source-and-target}

Prepare the source for sending data:

* Airbyte®:
   * [AWS CloudTrail](operations/prepare.md#source-aws)
   * [BigQuery](operations/prepare.md#source-bigquery)
   * [S3](operations/prepare.md#source-s3)
* [{{ KF }}](operations/prepare.md#source-kf)
* [{{ CH }}](operations/prepare.md#source-ch)
* [{{ GP }}](operations/prepare.md#source-gp)
* [{{ MG }}](operations/prepare.md#source-mg)
* [{{ MY }}](operations/prepare.md#source-my)
* [{{ PG }}](operations/prepare.md#source-pg)
* [{{ yds-full-name }}](operations/prepare.md#source-yds)

Prepare the target for receiving the data:

* [{{ CH }}](operations/prepare.md#target-ch)
* [{{ GP }}](operations/prepare.md#target-gp)
* [{{ MG }}](operations/prepare.md#target-mg)
* [{{ MY }}](operations/prepare.md#target-my)
* [{{ objstorage-name }}](operations/prepare.md#target-storage)
* [{{ PG }}](operations/prepare.md#target-pg)

{% if product == "yandex-cloud" %}

To receive data in {{ ydb-name }}, no setup is necessary.

{% endif %}

## Creating an endpoint for the source {#source}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. Click **Create endpoint**.
1. Make sure that the **Direction** field is set to `Source`.
1. Enter a name for the endpoint.
1. In the **Database type** field, select the type of the DBMS to transfer data from.
1. Specify endpoint parameters in the corresponding settings section.
1. Click **Create**.

For more information, see [{#T}](operations/endpoint/index.md).

## Creating an endpoint for the target {#target}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. Click **Create endpoint**.
1. Make sure that the **Direction** field is set to `Target`.
1. Enter a name for the endpoint.
1. In the **Database type** field, select the type of DBMS that you want to transfer data to.
1. Specify endpoint parameters in the corresponding settings section.
1. Click **Create**.

For more information, see [{#T}](./operations/endpoint/index.md).

## Create a transfer {#create-transfer}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. On the left-hand panel, select ![image](../_assets/data-transfer/transfer.svg) **Transfers**.
1. Click **Create transfer**.
1. Select the endpoint for the source and the endpoint for the target.
1. Enter a name for the transfer.
1. Select the [type of transfer](./concepts/index.md#transfer-type.md):
   * `{{ dt-type-copy-repl }}`: To create a full copy of the source data and keep it up-to-date.
   * `{{ dt-type-copy }}`: To create a full copy of the data without receiving further updates from the source. You can also use this type to [replicate constantly changing tables](concepts/transfer-lifecycle.md#select-transfer-type).
   * `{{ dt-type-repl }}`: To continuously receive data updates from the source and apply them to the target (without creating a full copy of the source data).
1. (optional) Add a transfer description.
1. Click **Create**.

For more information, see [Types of transfers](./concepts/transfer-lifecycle.md#transfer-types).

## Activate the transfer {#activate}

1. Go to the folder page and select **{{ data-transfer-full-name }}**.
1. On the left-hand panel, select ![image](../_assets/data-transfer/transfer.svg) **Transfers**.
1. Click ![ellipsis](../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Activate**.

The data transfer process will begin.

For more information, see [{#T}](operations/transfer.md).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [preparing databases for the service](operations/prepare.md) and [setting up transfers](operations/transfer.md).
* Read [questions and answers](qa/index.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
