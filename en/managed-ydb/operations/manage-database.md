# Database management via console {{ yandex-cloud }}

This section describes the following operations in the cloud management console:

* [{#T}](#create-db).
* [{#T}](#db-list).
* [{#T}](#change-db-params).
* [{#T}](#delete-db).

You can also perform these operations in the command line [using the {{ yandex-cloud }} CLI](yc-cli.md).

## Creating a database {#create-db}

You can create a database in a Serverless configuration or with dedicated servers. For more information about differences in configurations, see [Serverless and Dedicated modes](../concepts/serverless-and-dedicated.md).

To create a database:

{% list tabs %}

- Serverless

   1. In the [management console]({{ link-console-main }}), select a folder to create your database in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the database **Name**. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Serverless** option.
   1. You will be suggested default values for parameters of the database created. You can leave the parameters as they are: they've been selected to get you started in the most efficient way. Afterwards you can review them and [change](../concepts/serverless-and-dedicated.md) if needed.
   1. Click **Create database**.

   Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

- Dedicated

   1. In the [management console]({{ link-console-main }}), select a folder to create your database in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the database **Name**. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Dedicated** option.
   1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/resources.md#resource-presets).
   1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/resources.md#storage-groups) that determines the total amount of storage.
   1. Under **Network**, configure network settings:
      1. (optional) In the **Public IP addresses** field, select **Assign** if you plan to query the database from the {{ yandex-cloud }} network and the internet.

         {% include  [traffic_metering](../_includes/traffic_metering.md) %}

      1. Select an existing network from the **Cloud network** list or create a new one:
         * Click **Create new**.
         * In the window that opens, enter a **Name** for the new network.
         * (optional) Select the **Create subnets** option. Subnets in each availability zone will be created automatically.
         * Click **Create**.
      1. Under **Subnets**, select a network or create a new one for each [availability zone](../../overview/concepts/geo-scope.md):
         * Click **Create new**.
         * In the window that opens, enter a **Name** for the new subnet.
         * (optional) Enter a **Description** of the subnet.
         * Select the desired availability zone from the **Availability zone** list.
         * Specify the subnet address in [**CIDR**](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format.
         * Click **Create**.
   1. Click **Create database**.

      Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

{% endlist %}

## Viewing the list of databases {#db-list}

1. In the [management console]({{ link-console-main }}), select the folder to get a list of databases for.
1. In the list of services, select **{{ ydb-name }}**.

## Updating database settings {#change-db-params}

{% list tabs %}

- Serverless

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update DB settings.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Edit**.
   1. Configure the DB settings:
      1. Change the DB name if necessary.
      1. Under **Limits**, specify the [throughput](../pricing/serverless.md#prices-ru) and [max size](../pricing/serverless.md#rules-storage).
      1. Under **Pricing**, set the [provisioned capacity](../pricing/serverless.md#prices-ru).
   1. Click **Update database**.

- Dedicated

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update DB settings.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Edit**.
   1. Configure the DB settings:
      1. Change the DB name if necessary.
      1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/index.md#resource-presets).
      1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/index.md#storage-groups) that determines the total amount of storage.
   1. Click **Update database**.

{% endlist %}

## Deleting a database {#delete-db}

1. In the [management console]({{ link-console-main }}), select the folder to delete the DB from.
1. In the list of services, select **{{ ydb-name }}**.
1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Delete**.
1. Confirm the deletion.
