---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Database management

## Viewing the list of databases {#db-list}

{% list tabs %}

- Management console
   1. In the [management console](https://console.cloud.yandex.ru), select the folder to get a list of databases for.
   1. In the list of services, select **{{ ydb-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in the default folder, run the command:

   ```
   $ yc ydb database list
   ```

{% endlist %}

## Creating a database {#create-db}

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}

## Updating database settings {#change-db-params}

{% note warning %}

You can only update settings for databases running in the dedicated server configuration.

{% endnote %}

{% list tabs %}

- Management console
   1. In the [management console](https://console.cloud.yandex.ru), select the folder where you want to update DB settings.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Change**.
   1. Configure the DB settings:
      1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/databases.md#compute-units).
      1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/databases.md#storage-groups) that determines the total amount of storage.
   1. Click **Edit database**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update DB settings:

   1. View a description of the CLI's update DB parameter command:

      ```
      $ yc ydb database update --help
      ```

   1. Run a command like:

      ```
      $ yc ydb database update <DB name> \
                     --new-name <new DB name> \
                     --description <new DB description> \
                     --resource-preset <class ID> \
                     --storage groups=<number of storage groups>                     
                     ...
      ```

{% endlist %}

## Deleting a database {#delete-db}

{% list tabs %}

- Management console
   1. In the [management console](https://console.cloud.yandex.ru), select the folder to delete the DB from.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line with the desired DB and select **Delete**.
   1. Confirm the deletion.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a database, run the command:

   ```
   $ yc ydb database delete <DB name>
   ```

{% endlist %}

