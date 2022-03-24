# Managing ClickHouse users

{{ mch-name }} lets you manage users and their individual settings in two ways:

- Using {{ yandex-cloud }} standard interfaces (CLI, API, or management console). Select this method if you wish to create, update, and delete users and custom user settings using {{ mch-full-name }} features.
- SQL queries to the cluster. This method is suitable if you wish to use your existing solution to create and manage users, or if you are using [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control).

## Managing users via SQL {#sql-user-management}

To manage users via SQL, [create a cluster](cluster-create.md) with the **User management via SQL** setting enabled.

In a cluster with user management via SQL enabled:

- You can only manage users via SQL.
- User management using standard {{ yandex-cloud }} interfaces (CLI, API, or management console) isn't possible.
- Users are managed under the `admin` account. The password for this account is set when creating a cluster.

{% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

For more information about managing users using SQL, see the [{{ CH }} documentation](https://clickhouse.tech/docs/en/operations/access-rights).

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the command:

  ```
  $ {{ yc-mdb-ch }} user list
       --cluster-name=<cluster name>
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).
  1. Get a list of users:

      ```sql
      SHOW USERS;
      ```

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Users** tab.
  1. Click **Add**.
  1. Enter the database username and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  1. Select one or more databases that the user should have access to:
     1. Select the database from the **Database** drop-down list.
     1. Click **Add** to the right of the drop-down list.
     1. Repeat the previous two steps until all the required databases are selected.
     1. To delete a database that was added by mistake, click ![image](../../_assets/cross.svg) to the right of the database name in the **Permissions** list.
  1. Configure [additional settings](../concepts/settings-list.md) for the user:
     1. Set [quotas](../concepts/settings-list.md#quota-settings) in **Additional settings → Quotas**:
        1. To add a quota, click ![image](../../_assets/plus.svg) or **+ Quotas**. You can add multiple quotas that will be valid at the same time.
        1. To delete a quota, click ![image](../../_assets/vertical-ellipsis.svg) to the right of the quota name and select **Delete**.
        1. To change a quota, set the required values of its settings.
     1. Configure [{{ CH }}](../concepts/settings-list.md#user-level-settings) in **Additional settings → Settings**.
  1. Click **Add**.

  See also: [Example of creating a read-only user](#example-create-readonly-user).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ {{ yc-mdb-ch }} user create <username>
       --cluster-name=<cluster name>
       --password=<user password>
       --permissions=<list of DBs the user can access>
       --quota=<list of a user's single quota settings>
       --settings=<list of {{ CH }} settings for the user>
  ```

  {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  For more information about [quotas](../concepts/settings-list.md#quota-settings) and [{{ CH }} settings](../concepts/settings-list.md#user-level-settings), see [{#T}](../concepts/settings-list.md).

  To set multiple quotas, list them using the required number of `--quota` parameters in the command:

  ```
  $ {{ yc-mdb-ch }} user create <username>
      ...
      --quota="<settings of quota 0>"
      --quota="<settings of quota 1>"
      ...
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

  See also: [Example of creating a read-only user](#example-create-readonly-user).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Add a `user` block to the {{ mch-name }} cluster description.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          user {
            name     = "<username>"
            password = "<password>"
            ...
          }
        }
        ```

        {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).
  1. Create a user:

      ```sql
      CREATE USER <username> IDENTIFIED WITH sha256_password BY '<user password>';
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  To learn more about creating users, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/create/user/).

{% endlist %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Users** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.
  1. Set a new password and click **Edit**.

  {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password, run the command:

  ```
  $ {{ yc-mdb-ch }} user update <username>
       --cluster-name=<cluster name>
       --password=<new password>
  ```

  {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mch-name }} cluster description, find the `user` block for the required user.

    1. Change the value of the `password` field:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          user {
            name     = "<username>"
            password = "<new password>"
            ...
          }
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. Change the user's password:

      ```sql
      ALTER USER <username> IDENTIFIED BY '<new password>';
      ```

      {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  To learn more about changing users, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/alter/user/).

{% endlist %}

## Changing the admin password {#admin-password-change}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the `admin` password, run the command below:

    ```bash
    {{ yc-mdb-ch }} cluster update <cluster name or ID> \
       --admin-password <new admin password>
    ```

    You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

    {% note tip %}
	
    * For increased security, instead of `--admin-password`, use the `--read-admin-password` parameter: you will need to enter the new password using the keyboard, and it will not be saved in the command history.
    * To generate a password automatically, use `--generate-admin-password`. The command output will contain the new password.

    {% endnote %}

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Change the value of the `admin_password` field:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          admin_password = "<admin password>"
          ...
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- SQL

    1. [Connect](./connect.md) to the cluster  as the `admin` [user](#sql-user-management).
    1. Execute the SQL query below:

        ```sql
        ALTER USER admin IDENTIFIED BY '<new password>';
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    For more information, see the [{{ CH }} documentation ](https://clickhouse.tech/docs/ru/sql-reference/statements/alter/user/).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
	
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * The new password in the `configSpec.adminPassword` parameter.
    * The list of cluster configuration fields to be edited (`ConfigSpec.adminPassword` in this case) in the `updateMask` parameter.

    {% include [note-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Changing user settings {#update-settings}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Users** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Settings**.
  1. Set up user permissions to access certain databases:
     1. To grant access to the required databases:
        1. Select the database from the **Database** drop-down list.
        1. Click **Add** to the right of the drop-down list.
        1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke access to a specific database, remove it from the **Permissions** list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
  1. Set [quotas](../concepts/settings-list.md#quota-settings) for the user in **Additional settings → Quotas**:
     1. To add a quota, click ![image](../../_assets/plus.svg) or **+ Quotas**. You can add multiple quotas that will be valid at the same time.
     1. To delete a quota, click ![image](../../_assets/vertical-ellipsis.svg) to the right of the quota name and select **Delete**.
     1. To change a quota, set the required values of its settings.
  1. Change the [{{ CH }} settings](../concepts/settings-list.md#dbms-user-settings) for the user in **Additional settings → Settings**.
  1. Tap **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can change the user settings from the command line interface:

  1. To set up the user's permissions to access certain databases, run the command, listing the database names in the `--permissions` parameter:

     ```
     $ {{ yc-mdb-ch }} user update <username>
          --cluster-name=<cluster name>
          --permissions=<list of DBs the user can access>
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     This command grants the user the permission to access the databases listed.

     To revoke access to a specific database, remove its name from the list and pass the updated list to the command.

  1. To change the user's [quota settings](../concepts/settings-list.md#quota-settings), run the command with a list of all quotas, using `--quota` parameters (one parameter per quota):

     ```
     $ {{ yc-mdb-ch }} user update <username>
          --cluster-name=<cluster name>
          --quota=<settings of quota 0 (unchanged)>
          --quota=<settings of quota 1 (unchanged)>
          --quota=<settings of quota 2 (changed)>
          --quota=<settings of quota 3 (unchanged)>
          --quota=<settings of quota 4 (changed)>
          --quota=<settings of quota 5 (new quota)>       
         ...
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     This command overwrites all existing user quota settings with the new settings that you passed to the command.
     Before running the command, make sure that you included the settings for new and changed quotas and the settings for existing quotas that haven't changed.

     To delete one or more user quotas, exclude their settings from the list and pass the updated list of `--quota` parameters to the command.

     When setting an interval, you can use an entry with units: hours (`h`), minutes (`m`), seconds (`s`), and milliseconds (`ms`). Sample entry: `3h20m10s7000ms` (the resulting value is still represented in milliseconds: `12017000`). The interval value must be a multiple of 1000 milliseconds (a value like `1s500ms` is incorrect).

  1. To change the [{{ CH }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, run the command by listing the updated settings in the `--settings` parameter:

     ```
     $ {{ yc-mdb-ch }} user update <username>
          --cluster-name=<cluster name>
          --settings=<list of {{ CH }} settings>    
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     The command only changes the settings that are explicitly specified in the `--settings` parameter. For example, the command with the parameter `--settings="readonly=1"` only changes the `readonly` setting and doesn't reset the values of the other settings. This is how changing {{ CH }} settings differs from changing quota settings.

     This command doesn't delete a configured setting, it just explicitly assigns it the default value (specified for [each setting](#clickhouse-settings)).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. To configure the user's permissions to access certain databases, add the required number of `permission` blocks to the cluster user description — one for each database:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          user {
            name     = "<username>"
            password = "<password>"
            permission {
              database_name = "<database 1>"
            }
            ...
            permission {
              database_name = "<database N>"
            }
          }
        }
        ```

        In the `database_name` field, specify the name of the database to grant access to.

    1. To change [quota settings](../concepts/settings-list.md#quota-settings) for the user, add the required number of `quota` blocks to the cluster user description.

        When describing quotas, only the `interval_duration` field is required.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          user {
            name     = "<username>"
            password = "<password>"
            ...
            quota {
              interval_duration = <interval duration in milliseconds>
              ...
            }
          }
        }
        ```

    1. To change [{{ CH }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, add the `settings` block to the cluster user description.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          user {
            name     = "<username>"
            password = "<password>"
            ...
            settings {
              <DBMS settings for an individual user>
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. To change a set of user privileges and roles, use the [GRANT](https://clickhouse.tech/docs/en/sql-reference/statements/grant/) and [REVOKE](https://clickhouse.tech/docs/en/sql-reference/statements/revoke/) queries. For example, grant the user read rights to all objects in a specific database:

      ```sql
      GRANT SELECT ON <database name>.* TO <username>;
      ```

  1. To change [quota settings](../concepts/settings-list.md#quota-settings) for the user, use the [CREATE QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/create/quota/#create-quota-statement), [ALTER QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/alter/quota/#alter-quota-statement), and [DROP QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/drop/#drop-quota-statement) queries. For example, limit the total number of user requests for a 15-month period:

      ```sql
      CREATE QUOTA <quota name> FOR INTERVAL 15 MONTH MAX QUERIES 100 TO <username>;
      ```

  1. To change the user account, use the [ALTER USER](https://clickhouse.tech/docs/en/sql-reference/statements/alter/user/) query. For example, to change the [{{ CH }} settings](../concepts/settings-list.md#dbms-user-settings), run the following command listing the settings you want to change:

      ```sql
      ALTER USER <username> SETTINGS <list of {{ CH }} settings>;
      ```

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Users** tab.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  $ {{ yc-mdb-ch }} user delete <username>
       --cluster-name=<cluster name>
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Delete the `user` block with a description of the required user from the {{ mch-name }} cluster description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- SQL

  1. [Connect](connect.md) to the cluster using the [admin account](#sql-user-management).

  1. Delete the user:

      ```sql
      DROP USER <username>;
      ```

  To learn more about deleting objects, see the [documentation for{{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/drop/).

{% endlist %}

## Examples {#examples}

### Creating a read-only user {#example-create-readonly-user}

Let's say you need to add to the existing `mych` cluster a new user named `ro-user` with the password `Passw0rd`, provided that:

- The user has access to the `db1` database of the cluster.
- The access is read-only, so the user isn't allowed to change any settings.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the cluster named `mych` and select the **Users** tab.
  1. Click **Add**.
  1. Enter `ro-user` as the DB username and `Passw0rd` as the password.
  1. Select the `db1` database from the **Database** drop-down list and click **Add** to the right of the list.
  1. Choose **Additional settings → Settings → Readonly**.
  1. Set the **Readonly** field value to `1`.
  1. Click **Add**.

- CLI

  Run the command:

  ```
  $ {{ yc-mdb-ch }} user create "ro-user" \
       --cluster-name="mych" \
       --password="Passw0rd" \
       --permissions="db1" \
       --settings="readonly=1"
  ```

    After creating the user, check that it is actually in read-only mode:

    1. [Connect to the {{ CH }} cluster](connect.md) `mych` using the `ro-user` user that you created.

    1. Try changing a setting, for example, disable read-only mode:

       ```
       SET readonly=0
       ```

       As a result, the command should display a message stating that you can't change the setting in read-only mode:

       ```
       DB::Exception: Cannot modify 'readonly' setting in readonly mode.
       ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Add the `user` block to the cluster description.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "mych" {
          name = "mych"
        
          database {
            name = "db1"
          }
        
          user {
            name     = "ro-user"
            password = "Passw0rd"
            permission {
              database_name = "db1"
            }
            settings {
              readonly = 1
            }
          }
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- SQL

  1. [Connect](connect.md) to the `mych` cluster using the [admin account](#sql-user-management).

  1. Create a user:

      ```sql
      CREATE USER ro-user IDENTIFIED WITH sha256_password BY 'Passw0rd';
      ```

  1. Grant the user read rights to all objects in the `db1` database:

      ```sql
      GRANT SELECT ON db1.* TO ro-user;
      ```

{% endlist %}

