## Examples {#examples}

### Creating a user with read-only permissions {#user-read-only}

To create a new user named `user2` with the password `SecretPassword` and read-only access to the `db1` database in an existing cluster named `cluster1`:

{% list tabs %}

- Management console

  [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) named `user2`. When creating a user:

  1. Add the `db1` database to the list of DBs.
  1. Add the `SELECT` role for the `db1` database.

- CLI

  1. Create a user named `user2`:

      ```bash
      yc managed-mysql user create "user2" \
        --cluster-name "cluster1" \
        --password "SecretPassword"
      ```

  1. Add the `SELECT` role for the `db1` database:

      ```bash
      yc managed-mysql users grant-permission "user2" \
        --cluster-name "cluster1" \
        --database "db1" \
        --permissions "SELECT"
      ```

- {{ TF }}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](../../managed-mysql/operations/cluster-create.md).

  1. Add a `user` block to the `cluster1` description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "cluster1" {
        ...
        user {
          name     = "user2"
          password = "SecretPassword"
          permission {
            database_name = "db1"
            roles         = ["SELECT"]
          }
        }
        ...
      }
      ```
  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

{% endlist %}
