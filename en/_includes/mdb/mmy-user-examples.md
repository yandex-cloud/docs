## Examples {#examples}

### Creating a user with read-only permissions {#user-read-only}

To create a new user named `user2` with `SecretPassword` for password, deletion protection, and read-only access to the `db1` database in the existing cluster named `cluster1`:

{% list tabs group=instructions %}

- Management console {#console}

  [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) named `user2`. When creating the user:

  1. Add `db1` to the database list.
  1. Add the `SELECT` role for `db1`.
  1. Enable deletion protection.

- CLI {#cli}

  Create a user named `user2` with the required privileges:

  ```bash
  {{ yc-mdb-my }} user create "user2" \
    --cluster-name "cluster1" \
    --password "SecretPassword" \
    --permissions database=db1,role=SELECT \
    --deletion-protection enabled
  ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      For information on how to create this file, see [this guide](../../managed-mysql/operations/cluster-create.md).

  1. Add the `yandex_mdb_mysql_user_v2` resource:

      ```hcl
      resource "yandex_mdb_mysql_user_v2" "user2" {
        cluster_id               = yandex_mdb_mysql_cluster.cluster1.id
        name                     = "user2"
        password                 = "SecretPassword"
        deletion_protection_mode = "DELETION_PROTECTION_MODE_ENABLED"
        permission {
          database_name = "db1"
          roles         = ["SELECT"]
        ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_mysql_user).

{% endlist %}
