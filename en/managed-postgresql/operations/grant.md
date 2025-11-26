---
title: Assigning privileges and roles to {{ PG }} users
description: '{{ PG }} manages database access permissions using roles. Roles can own database objects and have privileges. In {{ PG }}, a user is a role that can log in to the database. To learn more about access permissions, see {{ PG }} guides. The user created for a new {{ mpg-name }} cluster is the owner of its first database. You can create more users and configure their permissions as needed.'
---

# Assigning privileges and roles to {{ PG }} users

{{ PG }} manages database access permissions using _roles_. Roles can own database objects and have _privileges_.

In {{ PG }}, a user is a role that can log in to the database. The user created for a new {{ mpg-name }} cluster is the owner of its first database. 

You can [create more users](cluster-users.md#adduser) and configure their permissions as needed:

- [Editing user’s roles](#grant-role).
- [Granting a privilege to a user](#grant-privilege).
- [Revoking a privilege from a user](#revoke-privilege).

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

For more information about [creating users](https://www.postgresql.org/docs/current/sql-createuser.html) and [setting up access permissions](https://www.postgresql.org/docs/current/user-manag.html), see the {{ PG }} guide.

## Editing user’s roles {#grant-role}

To assign a role to a user, use the {{ yandex-cloud }} interfaces: the roles assigned by the `GRANT` request are canceled during the next database operation.

{% include [users-and-roles](../../_includes/mdb/mpg/users-and-roles.md) %}

{{ mpg-name }} does not allow access to [predefined roles](https://www.postgresql.org/docs/current/predefined-roles.html), including the superuser role. You can only assign the following managed service roles to a user:

* `mdb_admin`
* `mdb_monitor`
* `mdb_replication`
* `mdb_superuser`

{% note info %}

You cannot create custom roles in {{ mpg-name }}. A user’s permissions are determined by the combination of granted privileges.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
  1. Find the user you want to update in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in their row, and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
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

  You can get the cluster name from the [folder’s cluster list](cluster-list.md) and the username from the [list of users](cluster-users.md#list-users).

- {{ TF }} {#tf}

  To assign roles to a cluster user:
  
    1. Open the current {{ TF }} configuration file describing your infrastructure.
  
        For information on how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of configurable fields of {{ mpg-name }} cluster user accounts, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_user).

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To check the list of current roles, call the [User.Get](../api-ref/User/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users/<username>'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [cluster’s user list](cluster-users.md#list-users).

     You can find the list of current roles in the `grants` field of the command output.

  1. To change the list of roles for a user, use the [User.Update](../api-ref/User/update.md) method to execute the following request:

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

       Here, we provide only one setting.

     * `grants`: New roles as a string array. Each string represents an individual role. The possible values are:

       * `mdb_admin`
       * `mdb_monitor`
       * `mdb_replication`
       * `mdb_superuser`

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. To check the list of current roles, call [UserService.Get](../api-ref/grpc/User/get.md) via {{ api-examples.grpc.tool }} or another preferred tool:

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

     You can find the list of current roles in the `grants` field of the command output.

  1. To change the list of roles for a user, call [UserService.Update](../api-ref/grpc/User/update.md) as follows:

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

     * `grants`: New roles as a string array. Each string represents an individual role. The possible values are:

       * `mdb_admin`
       * `mdb_monitor`
       * `mdb_replication`
       * `mdb_superuser`

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the username, with the [list of users in the cluster](cluster-users.md#list-users).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Granting a privilege to a user {#grant-privilege}

{% list tabs group=instructions %}

- SQL

    1. [Connect](connect.md) to the database using the owner's account.
    1. Run the `GRANT` command. For full command syntax, see this [{{ PG }} guide](https://www.postgresql.org/docs/current/sql-grant.html).

- {{ TF }} {#tf}

    You can only grant user privileges via {{ TF }} in a cluster that has publicly accessible hosts.

    You can grant user privileges via {{ TF }} using a third-party tool, [Terraform Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

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

    1. Open the {{ TF }} configuration file describing your infrastructure.
  
        For information on how to create this file, see [Creating a cluster](cluster-create.md).

    1. Add the `postgresql` provider and configure it to access your target database using its owner’s credentials:

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

        The full list of settings is available in the [provider documentation](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs).

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

        * `<resource_name>`: Name of the {{ TF }} resource that grants the privileges. This name must be unique within the {{ TF }} manifest.
        * `database`: Name of the target database for granting privileges.
        * `role`: Name of the user receiving the privileges.
        * `object_type`: Type of {{ PG }} object for which the privileges are granted. Possible values: `database`, `schema`, `table`, `sequence`, `function`, `procedure`, `routine`, `foreign_data_wrapper`, `foreign_server`, `column`.
        * `privileges`: Array of privileges to grant. Possible values: `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `REFERENCES`, `TRIGGER`, `CREATE`, `CONNECT`, `TEMPORARY`, `EXECUTE`, and `USAGE`. For privilege descriptions see this [{{ PG }} article](https://www.postgresql.org/docs/current/ddl-priv.html).
        * `schema`: Target schema for granting privileges. You cannot use this parameter with the `database` object type.
        * `objects`: Array of target objects for granting privileges. This is an optional parameter. If you omit it, the system will grant privileges on all objects of the specified type. You cannot use this parameter with `database` and `schema` object types. For the `column` object type, the array of target objects cannot contain more than one item.
        * `columns`: Array of target columns for granting privileges. This parameter is required for the `column` object type and cannot be used with any other type.
        * `with_grant_option`: If `true`, a user with the granted privileges can grant them to other users. This is an optional parameter. The default value is `false`.

    1. Reinitialize {{ TF }}:

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

    1. [Connect](connect.md) to the database using the owner's account.
    1. Run the `REVOKE` command. For full command syntax, see this [{{ PG }} guide](https://www.postgresql.org/docs/current/sql-revoke.html).

- {{ TF }} {#tf}

    If you previously granted a privilege using {{ TF }}:

    1. Open the {{ TF }} configuration file describing your infrastructure.
    1. In the `postgresql_grant` section, remove the privilege you want to revoke from the `privileges` attribute.

        To revoke all privileges, leave the `privileges` array empty or remove the entire `postgresql_grant` section.

    1. Make sure the settings are correct.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Confirm updating the resources.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
