# Managing rights to access functions

You can make a function [public](#public) or [private](#private), [view](#list) roles assigned to a function, [revoke](#revoke) them, or [assign](#add-access) new roles.

## Making a function public {#public}

To allow any user to invoke a function without passing an authorization header, make it public.

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where the function is located.
    1. Select **{{ sf-name }}**.
    1. Select the function you want to make public.
    1. On the **Overview** page, under **General information**, switch the **Public function** option to on.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To make a function public, run the command:

    ```
    yc serverless function allow-unauthenticated-invoke <function name>
    ```

    Result:

    ```
    done (1s)
    ```

- API

    You can make a function public using the [setAccessBindings](../functions/api-ref/Function/setAccessBindings.md) API method.

{% endlist %}

## Making a function private {#private}

For a function to be invoked only by users with rights to invoke it, make the function private.

{% note info %}

If all unauthorized users (`allUsers` system group) of a cloud or folder are granted rights to invoke a function, the function will be public regardless of the settings. [How to revoke a role.](../../iam/operations/roles/revoke.md)

{% endnote %}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where the function is located.
    1. Select **{{ sf-name }}**.
    1. Select the function you want to make private.
    1. On the **Overview** page, under **General information**, switch the **Public function** option to off.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To make a function private, run the command:

    ```
    yc serverless function deny-unauthenticated-invoke <function name>
    ```

    Result:

    ```
    done (1s)
    ```

{% endlist %}

## Viewing roles assigned to a function {#list}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view [roles](../security/index.md#roles) assigned to a function, run the command:

    ```
    yc serverless function list-access-bindings <function name>
    ```

    Result:

    ```
    +------------------------------+--------------+-----------------------+
    |           ROLE ID            | SUBJECT TYPE |       SUBJECT ID      |
    +------------------------------+--------------+-----------------------+
    | serverless.functions.invoker | system       | allAuthenticatedUsers |
    +------------------------------+--------------+-----------------------+
    ```

- API

    You can view [roles](../security/index.md#roles) assigned to a function using the [listAccessBindings](../functions/api-ref/Function/listAccessBindings.md) API method.

{% endlist %}

{% note info %}

[Roles](../security/index.md#roles) assigned to a folder or cloud are automatically [inherited](../../iam/concepts/access-control/index.md#inheritance) by a function. However, they don't appear in the list of assigned roles. Learn more about [viewing roles](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

## Assigning roles to a function {#add-access}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To assign a [role](../security/index.md#roles) to a function, run the command:
    * User:

        ```
        yc serverless function add-access-binding \
          --id <function ID> \
          --user-account-id <user id> \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```
    * [Service account](../../iam/concepts/users/service-accounts.md):

        ```
        yc serverless function add-access-binding \
          --id <function ID> \
          --service-account-id <service account ID> \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```
    * All authorized users (`allAuthenticatedUsers` system group):

        ```
        yc serverless function add-access-binding \
          --id <function ID> \
          --all-authenticated-users \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```

- API

    You can assign roles to a function using the [setAccessBindings](../functions/api-ref/Function/setAccessBindings.md) API method.

{% endlist %}

## Revoking roles assigned to a function {#revoke}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To revoke a [role](../security/index.md#roles) for a function, run the command:
    * User:

        ```
        yc serverless function remove-access-binding \
          --id <function ID> \
          --user-account-id <user id> \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```
    * [Service account](../../iam/concepts/users/service-accounts.md):

        ```
        yc serverless function remove-access-binding \
          --id <function ID> \
          --service-account-id <service account ID> \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```
    * All authorized users (`allAuthenticatedUsers` system group):

        ```
        yc serverless function remove-access-binding \
          --id <function ID> \
          --all-authenticated-users \
          --role <role>
        ```

        Result:

        ```
        done (1s)
        ```

- API

    You can revoke roles for a function using the [updateAccessBindings](../functions/api-ref/Function/updateAccessBindings.md) API method.

{% endlist %}

