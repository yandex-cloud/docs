## Examples {#examples}

### Add a user with read-only permissions {#user-readonly}

{% list tabs group=instructions %}

- SQL {#sql}

    {% note alert %}

    Do not use this example if a user is created using {{ TF }}: subsequent changes made via {{ TF }} may cancel the user's privileges granted through SQL.

    {% endnote %}

    To add a new user (`user2`) to an existing cluster with read-only access to the `db1` database:

    1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser) named `user2`. Select the databases that the user should have access to.
    1. [Connect](../../managed-postgresql/operations/connect.md#connection-string) to the `db1` database under the database owner account.
    1. Grant `user2` the required permissions.

        Examples:

        * Grant access only to the `Products` table in the default `public` schema:

            ```sql
            GRANT SELECT ON public.Products TO user2;
            ```

        * Grant access to objects in `myschema`:

            ```sql
            GRANT USAGE ON SCHEMA myschema TO user2;
            ```

        * Grant access to all tables and sequences in `myschema`:

            ```sql
            GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
            GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA myschema to user2;
            ```

        * Allow calling `my_function` in `myschema`:

            ```sql
            GRANT EXECUTE ON FUNCTION myschema.my_function TO user2;
            ```

        * Change the default privileges for tables and sequences in `myschema`:

            ```sql
            ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT SELECT ON TABLES TO user2;
            ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT USAGE, SELECT ON SEQUENCES TO user2;
            ```

            The `ALTER DEFAULT PRIVILEGES` commands allow you to change access permissions for new objects you will create later (in this case, `myschema` tables and sequences) but do not affect permissions granted for existing objects.

            To update privileges for existing objects, use the `GRANT` and `REVOKE` commands.

- {{ TF }} {#tf}

    You can grant user privileges via {{ TF }} only in a cluster with public hosts.

    User privileges are granted via {{ TF }} using a third-party provider, [{{ TF }} Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

    {% include [pg-provider-disclaimer](../../_includes/mdb/mpg/terraform/pg-provider-disclaimer.md) %}

    For more information about granting privileges, see [{#T}](../../managed-postgresql/operations/grant.md#grant-privilege).

    Let's say you have a cluster named `mypg` with `user1` as the owner. To add a new user (`user2`) to this cluster with read-only access to `db1` tables with the `public` schema:

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

{% endlist %}

### Revoking permissions {#revoke-access}

{% list tabs group=instructions %}

- SQL {#sql}

    1. [Connect](../../managed-postgresql/operations/connect.md#connection-string) to the `db1` database under the database owner account.
    1. Revoke the relevant access permissions from `user2`.

        Examples:

        1. Revoke all privileges for tables in the `myschema` schema:

            ```sql
            REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA myschema FROM user2;
            ```

        1. Revoke access for the `Products` table in the default `public` schema:

            ```sql
            REVOKE SELECT ON public.Products FROM user2;
            ```

        1. Revoke access to all tables in `myschema`:

            ```sql
            REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
            ```

        1. Revoke access for objects in the `myschema` schema:

            ```sql
            REVOKE USAGE ON SCHEMA myschema FROM user2;
            ```

- {{ TF }} {#tf}

    1. Open the {{ TF }} configuration file you used to [grant privileges](#user-readonly).

    1. In the `postgresql_grant` section, remove the privilege you want to revoke from the `privileges` parameter.

        To revoke all privileges, leave the `privileges` array empty or completely remove the `postgresql_grant` resource.

        ```hcl
        resource "postgresql_grant" "readonly_tables" {
          database          = yandex_mdb_postgresql_database.db1.name
          role              = yandex_mdb_postgresql_user.user2.name
          object_type       = "table"
          privileges        = []
          schema            = "public"
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}
