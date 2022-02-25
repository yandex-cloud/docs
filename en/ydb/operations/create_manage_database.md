---
sourcePath: en/ydb/overlay/operations/create_manage_database.md
---
# Database management in {{ ydb-name }}

This section describes the following operations:

* [{#T}](#create-db).
* [{#T}](#db-list).
* [{#T}](#change-db-params).
* [{#T}](#delete-db).

## Creating a database {#create-db}

You can create a database in a Serverless configuration or with dedicated servers. For more information about differences in configurations, see [Serverless and Dedicated modes](../concepts/serverless_and_dedicated.md).

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}

## Viewing the list of databases {#db-list}

{% list tabs %}

* Management console
   1. In the [management console]({{ link-console-main }}), select the folder to get the DB list for.
   1. In the list of services, select **{{ ydb-name }}**.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI get DB list command:

      ```bash
      {{ yc-ydb }} database list --help
      ```

   1. To get a list of databases in the default folder, run the command:

      ```bash
      {{ yc-ydb }} database list
      ```

{% endlist %}

## Updating database settings {#change-db-params}

{% note warning %}

You can only update settings for databases running in the dedicated server configuration.

{% endnote %}

{% list tabs %}

* Management console
   1. In the [management console]({{ link-console-main }}), select the folder to update the DB settings in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Change**.
   1. Configure the DB settings:
      1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/databases.md#compute-units).
      1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/databases.md#storage-groups) that determines the total amount of storage.
   1. Click **Update database**.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update DB settings:

   1. View a description of the CLI update DB parameter command:

      ```bash
      {{ yc-ydb }} database update --help
      ```

   1. Run a command in the format:

      ```bash
      {{ yc-ydb }} database update <DB name> \
                     --new-name <new DB name> \
                     --description <new DB description> \
                     --resource-preset <class ID> \
                     --storage type=<storage type ID>,groups=<number of storage groups>
                     ...
      ```

{% endlist %}

## Deleting a database {#delete-db}

{% list tabs %}

* Management console
   1. In the [management console]({{ link-console-main }}), select the folder to delete the DB from.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Delete**.
   1. Confirm the deletion.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI delete database command:

      ```bash
      {{ yc-ydb }} database delete --help
      ```

   1. To delete a database, run the command:

      ```bash
      {{ yc-ydb }} database delete <DB name>
      ```

{% endlist %}

