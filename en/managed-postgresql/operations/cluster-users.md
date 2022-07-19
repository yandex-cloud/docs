---
title: "PostgreSQL user management"
description: "This article will show you how to add and remove users, as well as manage their individual settings in the PostgreSQL database management service."
---

# Managing database users

You can add and remove users, as well as manage their individual settings.

{% note warning %}

You can use SQL commands to assign privileges to users, but you can't use them to add or change users. For more information, see [{#T}](grant.md).

{% endnote %}

## Getting a list of users {#list-users}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster users, run the command:

   ```
   {{ yc-mdb-pg }} user list
        --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click **Add**.
   1. Enter the database username and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   1. Select one or more databases that the user should have access to:
      1. Select the database from the **Database** drop-down list.
      1. Click **Add** to the right of the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, click ![image](../../_assets/cross.svg) to the right of the database name in the **Rights** list.
   1. Configure the [DBMS settings](../concepts/settings-list.md#dbms-user-settings) for the user.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user in a cluster, run the command:

   ```
   {{ yc-mdb-pg }} user create <username>
        --cluster-name <cluster name>
        --password=<user password>
        --permissions=<list of DBs user can access>
        --conn-limit=<maximum number of connections per user>
   ```

   This command configures only the main user settings.

   {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   To customize the DBMS for the user, use the parameters described in [User settings](../concepts/settings-list.md#dbms-user-settings).

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Add a `user` section to the {{ mpg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        user {
          name       = "<username>"
          password   = "<password>"
          grants     = [ "<list of privileges>" ]
          login      = <allow logging in to the DB: true or false>
          conn_limit = <maximum number of connections per user>
          settings   = [ "<list of DB settings>" ]
          permission {
            database_name = "<database name>"
          }
        }
      }
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

{% endlist %}

{% note info %}

When created, the user only gets the `CONNECT` privilege for the selected databases and can't perform any operations with the databases. To give the user access to the database, [assign](grant.md) them the required privileges or roles.

{% endnote %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click the ![image](../../_assets/vertical-ellipsis.svg) icon and select **Change password**.
   1. Set a new password and click **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the user's password, run the command:

   ```
   {{ yc-mdb-pg }} user update <username>
        --cluster-name=<cluster name>
        --password=<new password>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the {{ mpg-name }} cluster description, find the `user` block for the required user.
   1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        user {
          name     = "<username>"
          password = "<new password>"
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

{% endlist %}

{% include [password-limits](../../_includes/mdb/mms/note-info-password-limits.md) %}

## Changing user settings {#update-settings}

{% note info %}

The privileges and roles in {{ PG }} are not affected by these settings and are configured separately.

For information about setting up user privileges and roles, see [{#T}](grant.md).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Settings**.
   1. Set up user permissions to access certain databases:
      1. To grant access to the required databases:
         1. Select the database from the **Database** drop-down list.
         1. Click **Add** to the right of the drop-down list.
         1. Repeat the previous two steps until all the required databases are selected.
      1. To revoke access to a specific database, delete it from the **Rights** list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
   1. Change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user in **DBMS settings**.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   You can change the user settings from the command line interface:

   1. To set up the user's permissions to access certain databases, run the command, listing the database names in the `--permissions` parameter:

      ```
      {{ yc-mdb-pg }} user update <username>
           --cluster-name=<cluster name>
           --permissions=<list of databases to grant a user access to>
      ```

      The cluster name can be requested with a [list of clusters in the folder](#list-clusters).

      This command grants the user access rights to the databases listed.

      To revoke access to a specific database, remove its name from the list and pass the updated list to the command.

   1. To change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, pass their parameters in the command:

      ```
      {{ yc-mdb-pg }} user update <username>
           --cluster-name=<cluster name>
           --<setting 1>=<value 1>
           --<setting 2>=<value 2>
           --<setting 3>=<list of values>
           ...
      ```

      The cluster name can be requested with a [list of clusters in the folder](#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. To grant the user permissions to access certain databases:
      1. In the {{ mpg-name }} cluster description, find the `user` block for the required user.
      1. Add `permission` blocks with the appropriate DB names:

         ```hcl
         resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
           ...
           user {
             name     = "<username>"
             permission {
               database_name = "<DB name>"
             }
             permission {
               database_name = "<DB name>"
             }
             ...
           }
         }
         ```

   1. To revoke the user's permission to access a specific database, delete the `permission` block with the name of this DB from the configuration file.

   1. To change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, pass their parameters in the `settings` block:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        user {
          name       = "<username>"
          ...
          settings   = [ "<list of DB settings>" ]
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```
   {{ yc-mdb-pg }} user delete <username>
        --cluster-name <cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Delete the user block with a description of the required `user` from the {{ mpg-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
