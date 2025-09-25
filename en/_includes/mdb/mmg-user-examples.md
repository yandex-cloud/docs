## Examples {#examples}

### Add a user with read-only permissions {#user-read-only}

To add a new user (`user2`) to an existing cluster with read-only access to the `db1` database:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Enter `user2` for username and enter a password (from 8 to 128 characters).
  1. Select the `db1` database from the **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** drop-down list.
  1. Select the `read` role from the drop-down list next to the `db1` database.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}

  Run this command:

  ```
  yc managed-mongodb user create user2 \
    --cluster-name <cluster_name> \
    --password <user_password> \
    --permission database=db1,role=read
  ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [this guide](../../storedoc/operations/cluster-create.md).

  1. Add the `yandex_mdb_mongodb_user` resource:

      ```hcl
      resource "yandex_mdb_mongodb_user" "user2" {
        cluster_id = <cluster_ID>
        name       = "user2"
        password   = "<password>"
        permission {
          database_name = "db1"
          roles         = [ "read" ]
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_user).

{% endlist %}

### Modify user permissions {#update-user-read-only}

To grant read-only access to the `db2` database to an existing `cluster1` user named `user1`:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click `cluster1` and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with `user1` and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** and select `db2` as your database.
  1. Click ![image](../../_assets/console-icons/plus.svg) and select the `read` role from the drop-down list next to the `db2` database.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  Run this command:

  ```
  {{ yc-mdb-mg }} user grant-permission user1 \
    --cluster-name cluster1 \
    --database db2 \
    --role read
  ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [this guide](../../storedoc/operations/cluster-create.md).

  1. Find the `yandex_mdb_mongodb_user` resource.
  1. Add the `permission` section:

      ```hcl
      resource "yandex_mdb_mongodb_user" "user1" {
        cluster_id = <cluster_ID>
        name       = "user1"
        password   = "<password>"
        permission {
          database_name = "db2"
          roles         = [ "read" ]
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_user).

{% endlist %}
