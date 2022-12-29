# Managing rights to access a container

You can make a container [public](#public) or [private](#private), view roles [assigned](#list) to a container, [revoke](#revoke) them, or [assign](#add-access) new roles.

## Making a container public {#public}

If you want any user to be able to invoke a container without passing the authorization header, make it public.

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To make a container public, run the command:

   ```
   yc serverless container allow-unauthenticated-invoke <container_name>
   ```

   Result:

   ```
   done (1s)
   ```

- API

   You can make a container public using the [setAccessBindings](../../serverless-containers/containers/api-ref/Container/setAccessBindings.md) API method.

{% endlist %}

## Making a container private {#private}

For a container to be invoked only by users with rights to invoke it, make the container private.

{% note info %}

If all unauthorized users (the `allUsers` system group) of a cloud or folder are granted rights to invoke a container, the container will be public regardless of the settings. [How to revoke a role.](../../iam/operations/roles/revoke.md)

{% endnote %}

{% list tabs %}

- CLI

   To make a container private, run the command:

   ```
   yc serverless container deny-unauthenticated-invoke <container_name>
   ```

   Result:

   ```
   done (1s)
   ```

{% endlist %}

## Viewing roles assigned to a container {#list}

{% list tabs %}

- CLI

   To view [roles](../security/index.md) assigned to a [container](../concepts/container.md), run the command:

   ```
   yc serverless container list-access-bindings --name=<container_name>
   ```

   Result:

   ```
   +---------+--------------+-----------------------+
   | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
   +---------+--------------+-----------------------+
   | editor  | system       | allAuthenticatedUsers |
   +---------+--------------+-----------------------+
   ```

- API

   You can view roles assigned to a container using the [listAccessBindings](../../serverless-containers/containers/api-ref/Container/listAccessBindings.md) API method.

{% endlist %}

{% note info %}

[Roles](../security/index.md#roles) assigned to a folder or cloud are automatically [inherited](../../iam/concepts/access-control/index.md#inheritance) by a container. However, they don't appear in the list of assigned roles. Learn more about [viewing roles](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

## Assigning roles to a container {#add-access}

{% list tabs %}

- CLI

   To assign a [role](../security/index.md) to a container, run the command:

   * User:
      ```
      yc serverless container add-access-binding \
        --name <container_name> \
        --user-account-id <user_ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * [Service account](../../iam/concepts/users/service-accounts.md):
      ```
      yc serverless container add-access-binding \
        --name <container_name> \
        --service-account-id <service_account_ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * All authorized users (`allAuthenticatedUsers` system group):
      ```
      yc serverless container add-access-binding \
        --name <container_name> \
        --all-authenticated-users \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```

- API

   You can assign roles to a container using the [setAccessBindings](../../serverless-containers/containers/api-ref/Container/setAccessBindings.md) API method.

{% endlist %}

## Revoking roles assigned to a container {#revoke}

{% list tabs %}

- CLI

   To revoke a [role](../security/index.md) for a container, run the command:

   * User:
      ```
      yc serverless container remove-access-binding \
        --name <container_name> \
        --user-account-id <user_ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * [Service account](../../iam/concepts/users/service-accounts.md):
      ```
      yc serverless container remove-access-binding \
        --name <container_name> \
        --service-account-id <service_account_ID> \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```
   * All authorized users (`allAuthenticatedUsers` system group):
      ```
      yc serverless container remove-access-binding \
        --name <container_name> \
        --all-authenticated-users \
        --role <role>
      ```
      Result:
      ```
      done (1s)
      ```

- API

   You can revoke roles assigned to a container using the [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) API method.

{% endlist %}