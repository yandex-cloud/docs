---
title: "MongoDB user management"
description: "This article will show you how to add and remove users, as well as manage their individual settings in the MongoDB database management service."
---

# Managing database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster users, run the command:

   ```
   {{ yc-mdb-mg }} user list
     --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of users, use the [list](../api-ref/User/list.md) method.

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

   1. Click on the name of the cluster you need and select the **Users** tab.

   1. Click **Add**.

   1. Enter the DB user's name and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

   1. Configure the [roles](../concepts/users-and-roles.md) for the user:

      1. Click **Add database** and select the database where you want to grant a role.
      1. Add roles using ![image](../../_assets/plus-sign.svg).

      You can grant multiple roles to a user in different databases.

   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user in a cluster:

   1. See the description of the CLI's create user command:

      ```
      {{ yc-mdb-mg }} user create --help
      ```

   1. Specify the user properties in the create command:
      ```
      {{ yc-mdb-mg }} user create <username>
        --cluster-name <cluster name>
        --password <user password>
        --permission database=<DB name>,role=<role>,role=<another role>,...
        --permission database=<another DB name>,role=<role>,...
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a `user` section to the {{ mmg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        user {
          name     = "<username>"
          password = "<password>"
          permission {
            database_name = "<name of database that access is granted to>"
            roles         = [ "<list of user's roles>" ]
          }
        }
      }
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

- API

   You can add users using the [create](../api-ref/User/create.md) method.

{% endlist %}

## Changing users {#updateuser}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

   1. Click on the name of the cluster you need and select the **Users** tab.

   1. To change a user's password, click ![image](../../_assets/options.svg) and select **Change password**.

      {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

   1. To change the user's [roles](../concepts/users-and-roles.md):

      1. Click ![image](../../_assets/options.svg) and select **Configure**.
      1. To add a role, click ![image](../../_assets/plus-sign.svg) next to the appropriate database and select the role.
      1. To delete a role, click ![image](../../_assets/cross.svg) next to the role name.

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a user's password or list of roles:

   1. See the description of the CLI's update user command:

      ```
      {{ yc-mdb-mg }} user update --help
      ```

   1. Specify the user properties in the update command:
      ```
      {{ yc-mdb-mg }} user update <username>
        --cluster-name <cluster name>
        --password <user password>
        --permission database=<database name>,role=<role>,role=<another role>,...
        --permission database=<another DB name>,role=<role>,...
      ```

      {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mmg-name }} cluster description, find the `user` block for the required user.
   1. Change the values of the `password` and `permission` fields:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        user {
          name     = "<username>"
          password = "<new password>"
          permission {
            database_name = "<database name>"
            roles         = [ "<new list of user's roles>" ]
          }
        }
      }
      ```

      {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

- API

   To edit the user data, use the [update](../api-ref/User/update.md) method.

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the cluster you need and select the **Users** tab.
   1. Click ![image](../../_assets/options.svg) and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```
   {{ yc-mdb-mg }} user delete <username>
     --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the user block with a description of the required `user` from the {{ mmg-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

- API

   You can delete a user using the [delete](../api-ref/User/delete.md) method.

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmg-user-examples.md) %}
