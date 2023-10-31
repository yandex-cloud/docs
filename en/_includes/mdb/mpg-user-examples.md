## Examples {#examples}

### Add a user with read-only permissions {#user-readonly}

{% list tabs %}

- SQL

   To add a new user `user2` to an existing cluster with read-only access to the `db1` database:

   1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser) named `user2`. Select the databases that the user should have access to.
   1. [Connect](../../managed-postgresql/operations/connect.md#connection-string) to the `db1` database under the account of the database owner.
   1. To only grant access rights to the `Products` table, in the default `public` schema, run the command:

      ```sql
      GRANT SELECT ON public.Products TO user2;
      ```

   1. To grant access to all the `myschema` schema tables, run the command:

      ```sql
      GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
      GRANT USAGE ON SCHEMA myschema TO user2;
      ```

   To revoke the granted privileges, run the commands:

   ```sql
   REVOKE SELECT ON public.Products FROM user2;

   REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
   REVOKE USAGE ON SCHEMA myschema FROM user2;
   ```

- {{ TF }}

   You can grant user privileges via {{ TF }} only in a cluster with public hosts.

   User privileges are granted via {{ TF }} using a third-party provider, [Terraform Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

   {% include [pg-provider-disclaimer](../../_includes/mdb/mpg/terraform/pg-provider-disclaimer.md) %}

   For more information about granting privileges, see [{#T}](../../managed-postgresql/operations/grant.md#grant-privilege).

   Let's say you have a cluster named `mypg` with `user1` as the owner. To add a new user (`user2`) to this cluster with read-only access to `db1` tables with the `public` schema:

   1. Add a `postgresql` provider to the `required_providers` section in the provider configuration file:

      ```hcl
      terraform {
        required_providers {
          ...
          postgresql = {
            source   = "cyrilgdn/postgresql"
          }
          ...
        }
      }
      ```

   1. Open the {{ TF }} configuration file with the infrastructure plan.
   1. Add the `yandex_mdb_postgresql_user` resource:

      ```hcl
      resource "yandex_mdb_postgresql_user" "user2" {
        cluster_id      = yandex_mdb_postgresql_cluster.mypg.id
        name            = "user2"
        password        = "user2user2"
        permission {
          database_name = yandex_mdb_postgresql_database.db1.name
        }
      }
      ```

   1. Add the `postgresql` provider and configure its access permissions to `db1`:

      ```hcl
      provider "postgresql" {
        host            = yandex_mdb_postgresql_cluster.mypg.host[0].fqdn
        port            = 6432
        database        = yandex_mdb_postgresql_database.db1.name
        username        = yandex_mdb_postgresql_user.user1.name
        password        = yandex_mdb_postgresql_user.user1.password
      }
      ```

   1. Add the `postgresql_grant` resource with the following attributes:

      ```hcl
      resource "postgresql_grant" "readonly_tables" {
        database          = yandex_mdb_postgresql_database.db1.name
        role              = yandex_mdb_postgresql_user.user2.name
        object_type       = "table"
        privileges        = ["SELECT"]
        schema            = "public"
      }
      ```

   1. Initialize {{ TF }} once again:

      ```bash
      terraform init
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   To revoke the granted privilege, remove it from the `privileges` list and confirm updating the resources.

{% endlist %}
