---
title: Assigning privileges and roles to PostgreSQL users
description: '{{ PG }} manages database access permissions using roles. Roles can own database objects and have privileges. In {{ PG }}, a user is a role that can log in to the database. For more information about access permissions, see the PostgreSQL guide. The user created with a {{ mpg-name }} cluster is the owner of the first database in the cluster. You can create other users and configure their permissions as you wish.'
---

# Assigning privileges and roles to {{ PG }} users

{{ PG }} manages database access permissions using _roles_. Roles can own database objects and have _privileges_.

In {{ PG }}, a user is a role that can log in to the database. The user created with a {{ mpg-name }} cluster is the owner of the first database in the cluster. 

You can [create other users](cluster-users.md#adduser) and configure their permissions as you wish:

- [Updating the list of roles for a user](#grant-role).
- [Granting a privilege to a user](#grant-privilege).
- [Revoking a privilege from a user](#revoke-privilege).

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

For more information about [creating users](https://www.postgresql.org/docs/current/sql-createuser.html) and [setting up access permissions](https://www.postgresql.org/docs/current/user-manag.html), see the {{ PG }} guide.

## Updating the list of roles for a user {#grant-role}

To assign a role to a user, use the {{ yandex-cloud }} interfaces: the roles assigned by the `GRANT` request are canceled during the next database operation.

{% include [users-and-roles](../../_includes/mdb/mpg/users-and-roles.md) %}

With {{ mpg-name }}, you cannot access [predefined](https://www.postgresql.org/docs/current/predefined-roles.html) roles, including the superuser role. You can assign users only the following special roles:

* `mdb_admin`
* `mdb_monitor`
* `mdb_replication`
* `mdb_superuser`

{% note info %}

You cannot create custom roles in {{ mpg-name }}. User permissions depend on a set of privileges the user is granted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. In the user name row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Expand the **{{ ui-key.yacloud.mdb.dialogs.button_advanced-settings }}** list and select the roles you want to assign to the user in the **Grants** field.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign roles to a cluster user, provide the list of required roles in the `--grants` parameter. This will completely overwrite the existing roles. To add or remove roles, first, run the `{{ yc-mdb-pg }} user get` command to get the list of current roles together with the user info.

  To assign roles, run this command:

  ```bash
  {{ yc-mdb-pg }} user update <username> \
         --grants=<role_1>,<role_2> \
         --cluster-id <cluster_ID>
  ```

  You can request the cluster name with the [list of clusters](cluster-list.md) in the folder and the username, with the [list of users](cluster-users.md#list-users).

- {{ TF }} {#tf}

  To assign roles to a cluster user:
  
    1. Open the current {{ TF }} configuration file describing your infrastructure.
  
        For information on how to create this file, see [this guide](cluster-create.md).

        For a complete list of editable fields in the {{ mpg-name }} cluster user configuration, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_user).

    1. Locate the user's `yandex_mdb_postgresql_user` resource.
    1. Add the `grants` attribute with the list of required roles:
  
        ```hcl
        resource "yandex_mdb_postgresql_user" "<username>" {
          ...
          name   = "<username>"
          grants = [ "<role_1>","<role_2>" ]
          ...
        }
        ```

    1. Make sure the settings are correct.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Confirm updating the resources.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To check the list of current roles, use the [User.Get](../api-ref/User/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [cluster’s user list](cluster-users.md#list-users).

     The list of current roles is in the `grants` parameter in the command output.

  1. To change the list of roles for a user, use the [User.Update](../api-ref/User/update.md) method and make a request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "grants",
                 "grants": [
                   "role_1", "role_2", ..., "role_N"
                 ]
               }'
     ```

     Where:

     * `updateMask`: Comma-separated list of settings you want to update.

       In this case, only one parameter is provided.

     * `grants`: Array of strings with new roles. Each row corresponds to a separate role. The possible values are:

       * `mdb_admin`
       * `mdb_monitor`
       * `mdb_replication`
       * `mdb_superuser`

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. To check the list of current roles, use the [UserService.Get](../api-ref/grpc/User/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Get
     ```

     The list of current roles is in the `grants` parameter in the command output.

  1. To change the list of roles for a user, use the [UserService.Update](../api-ref/grpc/User/update.md) call and make a request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "grants"
               ]
             },
             "grants": [
               "role_1", "role_2", ..., "role_N"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `grants`: Array of strings with new roles. Each row corresponds to a separate role. The possible values are:

       * `mdb_admin`
       * `mdb_monitor`
       * `mdb_replication`
       * `mdb_superuser`

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [cluster’s user list](cluster-users.md#list-users).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
  
    1. Add the `postgresql` provider to the `required_providers` section in the provider configuration file:

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
  
        For information on how to create this file, see [this guide](cluster-create.md).

    1. Add the `postgresql` provider and enable it to access the database you need as its owner:

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
          privileges  = ["<list_of_privileges>"]
          schema      = "<schema>"
          objects     = ["<list_of_objects>"]
          columns     = ["<list_of_columns>"]
          with_grant_option = <permission_to_grant_privileges>
        }
        ```

        Where:

        * `<resource_name>`: Name of the {{ TF }} resource with privileges. It must be unique within the {{ TF }} manifest.
        * `database`: Name of the database for which the privileges are granted.
        * `role`: Name of the user the privileges are granted to.
        * `object_type`: Type of {{ PG }} object for which the privileges are granted. Possible values: `database`, `schema`, `table`, `sequence`, `function`, `procedure`, `routine`, `foreign_data_wrapper`, `foreign_server`, `column`.
        * `privileges`: Array of privileges to grant. Possible values: `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `REFERENCES`, `TRIGGER`, `CREATE`, `CONNECT`, `TEMPORARY`, `EXECUTE`, and `USAGE`. You can find the descriptions of privileges in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/ddl-priv.html).
        * `schema`: Schema for which you are granting privileges. You cannot specify it for `database` objects.
        * `objects` (optional): Array of objects for which privileges are granted. If you omit this parameter, privileges will be granted for all objects of the specified type. You cannot specify it for `database` or `schema` objects. If the object type is `column`, the array can contain only one value.
        * `columns`: Array of columns for which privileges are granted. This is a required parameter for `column` objects. You cannot specify it for any object type other than `column`.
        * `with_grant_option` (optional): If `true`, a user with the privileges can grant the same privileges to other users. The default value is `false`.

    1. Initialize {{ TF }} once again:

        ```bash
        terraform init
        ```

    1. Validate your configuration.
  
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
