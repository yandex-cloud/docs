## Examples {#examples}

### Add a user with read-only permissions {#user-readonly}

{% list tabs group=instructions %}

- SQL {#sql}

    {% note alert %}

    Do not use this example for users created with {{ TF }} as subsequent changes made via {{ TF }} may overwrite privileges granted via SQL.

    {% endnote %}

    To add a new `user2` account with read-only access for the `db1` database to an existing cluster:

    1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser) named `user2`. While creating the user, specify which databases they can access.
    1. [Connect](../../managed-postgresql/operations/connect.md#connection-string) to the `db1` database as the owner.
    1. Grant `user2` the required permissions.

        Examples:

        * Grant access to the `Products` table in the default `public` schema:

            ```sql
            GRANT SELECT ON public.Products TO user2;
            ```

        * Grant access to all objects in `myschema`:

            ```sql
            GRANT USAGE ON SCHEMA myschema TO user2;
            ```

        * Grant access to all tables and sequences in `myschema`:

            ```sql
            GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
            GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA myschema to user2;
            ```

        * Grant execution permission for `my_function` in `myschema`:

            ```sql
            GRANT EXECUTE ON FUNCTION myschema.my_function TO user2;
            ```

        * Change the default privileges for tables and sequences in `myschema`:

            ```sql
            ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT SELECT ON TABLES TO user2;
            ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT USAGE, SELECT ON SEQUENCES TO user2;
            ```

            The `ALTER DEFAULT PRIVILEGES` commands allow you to change the default access privileges for future objects, without affecting existing ones. In the example above, we change default privileges for new `myschema` tables and sequences.

            To update privileges for existing objects, use the `GRANT` and `REVOKE` statements.

- {{ TF }} {#tf}

    You can only grant user privileges via {{ TF }} in a cluster with publicly accessible hosts.

    You can grant user privileges via {{ TF }} using the third-party [{{ TF }} Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

    {% include [pg-provider-disclaimer](../../_includes/mdb/mpg/terraform/pg-provider-disclaimer.md) %}

    To learn more about granting privileges, see [{#T}](../../managed-postgresql/operations/grant.md#grant-privilege).

    Suppose you have a cluster named `mypg` with a user named `user1` as its owner. To add a new cluster account `user2` with read-only access to the tables in the `public` schema of the `db1` database, do the following:

    1. Add the `postgresql` provider to the `required_providers` section in the provider configuration file:

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

    1. Open the {{ TF }} configuration file describing your infrastracture.
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

    1. Add the `postgresql` provider and configure its access permissions to the `db1` database:

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

    1. Reinitialize {{ TF }}:

        ```bash
        terraform init
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

### Revoking privileges {#revoke-access}

{% list tabs group=instructions %}

- SQL {#sql}

    1. [Connect](../../managed-postgresql/operations/connect.md#connection-string) to the `db1` database as the owner.
    1. Revoke access privileges from `user2`.

        Examples:

        1. Revoke all privileges for the tables within the `myschema` schema:

            ```sql
            REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA myschema FROM user2;
            ```

        1. Revoke access to the `Products` table in the default `public` schema:

            ```sql
            REVOKE SELECT ON public.Products FROM user2;
            ```

        1. Revoke access to all tables in `myschema`:

            ```sql
            REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
            ```

        1. Revoke access to all objects in `myschema`:

            ```sql
            REVOKE USAGE ON SCHEMA myschema FROM user2;
            ```

- {{ TF }} {#tf}

    1. Open the {{ TF }} configuration file used for [granting privileges](#user-readonly).

    1. In the `postgresql_grant` section, remove the privilege you want to revoke from the `privileges` attribute.

        To revoke all privileges, leave the `privileges` array empty or remove the entire `postgresql_grant` section.

        ```hcl
        resource "postgresql_grant" "readonly_tables" {
          database          = yandex_mdb_postgresql_database.db1.name
          role              = yandex_mdb_postgresql_user.user2.name
          object_type       = "table"
          privileges        = []
          schema            = "public"
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}
