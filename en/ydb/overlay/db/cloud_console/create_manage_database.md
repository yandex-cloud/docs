# Creating, updating, and deleting databases

This section describes how to use the cloud management console to:

* [{#T}](#create-db).
* [{#T}](#db-list).
* [{#T}](#change-db-params).
* [{#T}](#delete-db).

You can also perform these operations in the command line [using the {{ yandex-cloud }} CLI](../yc_cli.md).

## Creating a database {#create-db}

You can create a database in a Serverless configuration or with dedicated servers. For more information about differences in configurations, see [Serverless and Dedicated modes](../../concepts/serverless_and_dedicated.md).

{% include [create-db-via-console](../../_includes/create-db-via-console.md) %}

## Viewing the list of databases {#db-list}

1. In the [management console]({{ link-console-main }}), select the folder to get the DB list for.
1. In the list of services, select **{{ ydb-name }}**.

## Updating database settings {#change-db-params}

1. In the [management console]({{ link-console-main }}), select the folder to update the DB settings in.
1. In the list of services, select **{{ ydb-name }}**.
1. Click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Change**.
1. Configure the DB settings:
   1. Under **Computing resources**, select the type and amount of [computing resources](../../concepts/databases.md#compute-units).
   1. Under **Storage groups**, select the disk type and number of [storage groups](../../concepts/databases.md#storage-groups) that determine the total storage size.
1. Click **Update database**.

## Deleting a database {#delete-db}

1. In the [management console]({{ link-console-main }}), select the folder to delete the DB from.
1. In the list of services, select **{{ ydb-name }}**.
1. Click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Delete**.
1. Confirm the deletion.
