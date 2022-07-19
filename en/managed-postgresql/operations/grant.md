---
title: "Assigning privileges and roles to PostgreSQL users"
description: "Atomic permissions in PostgreSQL are called privileges, permissions groups are called roles. For more information on organizing access rights, see the PostgreSQL documentation. The user created with the Managed Service for PostgreSQL cluster is the owner of the first database in the cluster. You can create other users and customize their rights as you see fit."
---

# Assigning privileges and roles to users

Atomic permissions in **{{ PG }}** are called _privileges_ and permission groups are called _roles_. For more information about access permissions, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/user-manag.html).

The user created with a **{{ mpg-name }}** cluster is the owner of the first database in the cluster. You can [create other users](cluster-users.md#adduser) and configure their permissions as you wish:

- [Updating the list of user roles](#grant-role).
- [Granting a privilege to a user](#grant-privilege).
- [Revoking a privilege from a user](#revoke-privilege).

## Updating the list of user roles {#grant-role}

To assign a [role](../concepts/roles.md) to a user, use the {{ yandex-cloud }} CLI or API: the roles assigned by the `GRANT` query are canceled during the next database operation.

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To assign roles to a cluster user, pass the list of required roles in the `--grants` parameter. This completely overwrites existing roles: if you want to extend or reduce the available list, first request the current roles with user information by running the `{{ yc-mdb-pg }} user get` command.

   To assign roles, run the command:

   ```
   {{ yc-mdb-pg }} user update <username> \
          --grants=<role1,role2> \
          --cluster-id <cluster ID>
   ```

   You can query the cluster name with the [list of clusters](cluster-list.md) in the folder and the username with the [list of users](cluster-users.md#list-users).

- {{ TF }}

   To assign roles to a cluster user:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the {{ mpg-name }} cluster description, find the `user` block for the required user.
   1. Add an attribute named `grants` with a list of required roles:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        user {
          name   = "<username>"
          ...
          grants = [ "<role1>","<role2>" ]
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To pass the list of required user roles, you can use the [update](../api-ref/User/update.md) method.

   This completely overwrites the existing roles: if you want to extend or reduce the available list, first request the current roles with user information via the [get](../api-ref/User/get.md) method.

{% endlist %}

## Granting a privilege to a user {#grant-privilege}

1. [Connect](connect.md) to the database under the database owner's account.
2. Run the `GRANT` command. For a detailed description of the command syntax, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-grant.html).


## Revoking a privilege from a user {#revoke-privilege}

1. [Connect](connect.md) to the database under the database owner's account.
2. Run the `REVOKE` command. For a detailed description of the command syntax, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-revoke.html).

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
