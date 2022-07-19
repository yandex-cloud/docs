## Examples {#examples}

### Add a user with read-only permissions {#user-read-only}

To add a new user `user2` to an existing cluster with read-only access to the `db1` database:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click the name of the desired cluster and select the ![image](../../_assets/mdb/user.svg) **Users** tab.
   1. Click **Add**.
   1. Enter the `user2` username and password (from 8 to 128 characters).
   1. Select the `db1` database from the **Add database** drop-down list.
   1. Select the role `read` from the drop-down list next to the `db1` database.
   1. Click **Add**.

- CLI

   Run the following command:

   ```
   yc managed-mongodb user create user2 \
     --cluster-name <cluster name> \
     --password <user password> \
     --permission database=db1,role=read
   ```

{% endlist %}

### Modify user permissions {#update-user-read-only}

To grant read-only access to the `db2` database to user `user1` of cluster `cluster1`:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click the name of the `cluster1` cluster and select the ![image](../../_assets/mdb/user.svg) **Users** tab.
   1. Click ![image](../../_assets/options.svg) next to `user1` and select **Configure**.
   1. Click **Add database** and select `db2` as your database.
   1. Click ![image](../../_assets/plus-sign.svg) and select the `read` role from the drop-down list next to the `db2` database.
   1. Click **Save**.

- CLI

   Run the following command:

   ```
   {{ yc-mdb-mg }} user grant-permission user1 \
     --cluster-name cluster1 \
     --database db2 \
     --role read
   ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](../../managed-mongodb/operations/cluster-create.md).

   1. In the {{ mmg-name }} cluster description, find the `user` block for `user1`.
   1. Add a `permission` section:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "cluster1" {
        ...
        user {
          name     = "user1"
          password = "<password>"
          ...
          permission {
            database_name = "db2"
            roles         = [ "read" ]
          }
        }
      }
      ```

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm the update of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

{% endlist %}
