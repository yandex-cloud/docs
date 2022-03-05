# Database management

You can add and remove databases, as well as view information about them.

{% include [db-sql](../../_includes/mdb/mdb-db-sql-limits.md) %}

## Getting a list of cluster databases {#list-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  $ {{ yc-mdb-pg }} database list
       --cluster-name <cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

  To get a list of cluster databases, use the [list](../api-ref/Database/list.md) method.

{% endlist %}

## Creating a database {#add-db}

You can create an unlimited number of databases in each {{ mpg-name }} cluster.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mpg-name }}**.

  1. Click on the name of the cluster you need.

  1. If the owner of the new database still doesn't exist, [add the user](cluster-users.md#adduser).

  1. Select the **Databases** tab.

  1. Click **Add**.

  1. Name the database, select its owner, and specify the required collation locale and character set.

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a database in a cluster:

  1. View a description of the CLI create database command:

     ```
     $ {{ yc-mdb-pg }} database create --help
     ```

  1. Request a list of cluster users to select the owner of the new database:

     ```
     $ {{ yc-mdb-pg }} user list
          --cluster-name <cluster name>
     ```

     If the required user is not in the list, [create it](cluster-users.md#adduser).

  1. Run the create database command. If necessary, specify the required collation locale and character set (default settings are `LC_COLLATE=C` and `LC_CTYPE=C`):

     ```
     $ {{ yc-mdb-pg }} database create <database name>
          --cluster-name <cluster name>
          --owner <username of the DB owner>
          --lc-collate <locale for sorting>
          --lc-type <character set locale>
     ```

     {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     {{ mpg-short-name }} runs the create database operation.

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Add a `database` block to the {{ mpg-name }} cluster description. If necessary, specify the required collation locale and character set (default settings are `LC_COLLATE=C` and `LC_CTYPE=C`):

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
          ...
          database {
            name       = "<DB name>"
            owner      = "<DB owner username: must be specified under user>"
            lc_collate = "<locale for sorting>"
            lc_type    = "<character set locale>"
            ...
          }
        }
        ```

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [{{ TF }} documentation]({{ tf-provider-mpg }}).

- API

  You can create a new database in a cluster using the [create](../api-ref/Database/create.md) method.

{% endlist %}

## Deleting a database {#remove-db}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a database, run the command:

  ```
  $ {{ yc-mdb-pg }} database delete <database name>
       --cluster-name <cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For information about how to create this file, see [{#T}](cluster-create.md).

  1. Delete the `database` block with the DB name from the {{ mpg-name }} cluster description.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [provider's documentation]({{ tf-provider-mpg }}).

- API

  You can delete a database using the [delete](../api-ref/Database/delete.md) method.

{% endlist %}

{% note warning %}

Before creating a new database with the same name, wait for the delete operation to complete, otherwise the database being deleted will be restored. Operation status can be obtained with a [list of cluster operations](cluster-list.md#list-operations).

{% endnote %}

