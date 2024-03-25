---
title: "Assigning privileges and roles to PostgreSQL users"
description: "Atomic permissions in PostgreSQL are called privileges and permission groups are called roles. For more information about access permissions, see the PostgreSQL documentation. The user created with a {{ mpg-name }} cluster is the owner of the first database in the cluster. You can create other users and configure their permissions as you wish."
---

# Assigning privileges and roles to {{ PG }} users

Atomic permissions in **{{ PG }}** are called _privileges_ and permission groups are called _roles_. For more information about access permissions, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/user-manag.html).

The user created with a **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}** cluster is the owner of the first database in the cluster. You can [create other users](cluster-users.md#adduser) and configure their permissions as you wish:

- [Updating the list of user roles](#grant-role).
- [Granting a privilege to a user](#grant-privilege).
- [Revoking a privilege from a user](#revoke-privilege).

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

## Updating the list of user roles {#grant-role}

To assign a role to a user, use the {{ yandex-cloud }} interfaces: the roles assigned by the `GRANT` query are canceled during the next database operation.

With {{ mpg-name }}, you cannot access [predefined](https://www.postgresql.org/docs/current/predefined-roles.html) roles, including the superuser role. You can assign users only the following special roles:

* `mdb_admin`
* `mdb_monitor`
* `mdb_replication`

The highest privileges for working with clusters are granted to users with the `mdb_admin` [role](../concepts/roles.md#mdb-admin). For more information, see [Assigning roles](../concepts/roles.md).

{% note info %}

You cannot create custom roles in {{ mpg-name }}. User permissions depend on a set of privileges the user is granted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
   1. In the appropriate user row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. Expand the **{{ ui-key.yacloud.mdb.dialogs.button_advanced-settings }}** list and select the roles you want to assign to the user in the **Grants** field.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign roles to a cluster user, pass the list of required roles in the `--grants` parameter. This completely overwrites existing roles: if you want to extend or reduce the available list, first request the current roles with user information by running the `{{ yc-mdb-pg }} user get` command.

   To assign roles, run the command:

   ```
   {{ yc-mdb-pg }} user update <username> \
          --grants=<role1,role2> \
          --cluster-id <cluster_ID>
   ```

   You can request the cluster name with the [list of clusters](cluster-list.md) in the folder and the username, with the [list of users](cluster-users.md#list-users).

- {{ TF }} {#tf}

   To assign roles to a cluster user:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster user configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

   1. Find the `yandex_mdb_postgresql_user` resource of the desired user.
   1. Add an attribute named `grants` with a list of required roles:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<username>" {
        ...
        name   = "<username>"
        grants = [ "<role1>","<role2>" ]
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To specify a new list of the required user roles, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Username in the `userName` parameter.
   * List of new user roles in the `grants` parameter.

      This completely overwrites the existing roles: if you want to extend or reduce the available list, first request the current roles with user information via the [get](../api-ref/User/get.md) method.

   * List of user configuration fields to update (`grants` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Granting a privilege to a user {#grant-privilege}

{% list tabs group=instructions %}

- SQL

   1. [Connect](connect.md) to the database under the database owner's account.
   1. Run the `GRANT` command. For a detailed description of the command syntax, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-grant.html).

- {{ TF }} {#tf}

   You can grant user privileges via {{ TF }} only in a cluster with public hosts.

   You can grant privileges to your users via {{ TF }} using the third-party [Terraform Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

   {% include [pg-provider-disclaimer](../../_includes/mdb/mpg/terraform/pg-provider-disclaimer.md) %}

   To grant a privilege to a cluster user:

   1. Add a `postgresql` provider to the `required_providers` section in the provider configuration file:

      ```hcl
      terraform {
        required_providers {
          ...
          postgresql = {
            source = "cyrilgdn/postgresql"
          }
          ...
        }
      }
      ```

   1. Open the {{ TF }} configuration file with the infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Add the `postgresql` provider and configure its access to the database on behalf of its owner:

      ```hcl
      provider "postgresql" {
        host            = <host_FQDN>
        port            = 6432
        database        = <DB_name>
        username        = <DB_owner_username>
        password        = <user_password>
      }
      ```

      {% include [see-fqdn](../../_includes/mdb/mpg/fqdn-host.md) %}

      For a full list of settings, see the [provider documentation](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs).

   1. Add the `postgresql_grant` resource:

      ```hcl
      resource "postgresql_grant" "<resource_name>" {
        database    = "<DB_name>"
        role        = "<username>"
        object_type = "<object_type>"
        privileges  = ["<list_of_priviledges>"]
        schema      = "<schema>"
        objects     = ["<object_list>"]
        columns     = ["<column_list>"]
        with_grant_option = <permission_to_grant_privileges>
      }
      ```

      Where:

      * `<Resource_name>`: Name of the {{ TF }} resource with privileges. It must be unique within the {{ TF }} manifest.
      * `database`: Name of the database for which privileges are granted.
      * `role`: Name of the user to whom privileges are granted.
      * `object_type`: Type of {{ PG }} object for which privileges are granted. The possible values are `database`, `schema`, `table`, `sequence`, `function`, `procedure`, `routine`, `foreign_data_wrapper`, `foreign_server`, and `column`.
      * `privileges`: Array of granted privileges. The possible values are `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `REFERENCES`, `TRIGGER`, `CREATE`, `CONNECT`, `TEMPORARY`, `EXECUTE`, and `USAGE`. You can find the descriptions of privileges in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/ddl-priv.html).
      * `schema`: Schema for which you are granting privileges. You cannot specify it for the `database` object type.
      * (Optional) `objects`: Array of objects for which privileges are granted. If you omit this parameter, privileges will be granted for all objects of the specified type. You cannot specify it for the `database` or `schema` object types. If the object type is `column`, the array can contain only one value.
      * `columns`: Array of columns for which privileges are granted. This parameter is required for the `column` object type. You cannot specify it for any object type other than `column`.
      * (Optional) `with_grant_option`: If `true`, a user with the privileges can grant them to other users. The default value is `false`.

   1. Initialize {{ TF }} once again:

      ```bash
      terraform init
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Revoking a privilege from a user {#revoke-privilege}

{% list tabs group=instructions %}

- SQL

   1. [Connect](connect.md) to the database under the database owner's account.
   1. Run the `REVOKE` command. For a detailed description of the command syntax, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-revoke.html).

- {{ TF }} {#tf}

   If you previously granted a privilege using {{ TF }}:

   1. Open the {{ TF }} configuration file with the infrastructure plan.
   1. In the `postgresql_grant` section, remove the privilege you want to revoke from the `privileges` parameter.

      To revoke all privileges, leave the `privileges` array empty or completely remove the `postgresql_grant` resource.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
