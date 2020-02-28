# Managing rights to access functions

You can make a function [public](#public) or [private](#private), as well as [view the roles assigned for the function](#list).

## Make your function public {#public}

To allow any user to call the function, you must make it public, meaning enable the function call over HTTPS without passing the authorization header.

{% list tabs %}

- Management console

    Make the function public:
    1. Open **{{ sf-name }}** in the folder with the function that you want to make public.
    1. Select it from the list of functions.
    1. On the **Overview** page under **General information**, click the toggle in the **Public function** field.

- CLI

    Make the function public:

    ```
    $ yc serverless function allow-unauthenticated-invoke my-function
    done (1s)    
    ```

    You can also make the function public by assigning the `serverless.functions.invoker` role to it for all unauthorized users (`allUsers` system group). To learn how to assign a role to a function, see [{#T}](../../iam/operations/roles/grant.md).

{% endlist %}

## View the roles assigned to the function {#list}

{% list tabs %}

- CLI

    View the roles assigned to the function:

    ```
    $ yc serverless function list-access-bindings my-function
    +------------------------------+--------------+------------+
    |           ROLE ID            | SUBJECT TYPE | SUBJECT ID |
    +------------------------------+--------------+------------+
    | serverless.functions.invoker | system       | allUsers   |
    +------------------------------+--------------+------------+
    ```

{% endlist %}

## Make the function private {#private}

{% list tabs %}

- Management console

    Make the function private:
    1. Open **{{ sf-name }}** in the folder with the function that you want to make private.
    1. Select it from the list of functions.
    1. On the **Overview** page under **Common function**, click the toggle in the **Public function** field.

- CLI

    Make the function private:

    ```
    $ yc serverless function deny-unauthenticated-invoke my-function
    done (1s)   
    ```

    You can also make the function private by revoking its `serverless.functions.invoker` role. To learn how to revoke a role, see [{#T}](../../iam/operations/roles/revoke.md).

{% endlist %}

For more information about access rights, see [{#T}](../security/index.md).

