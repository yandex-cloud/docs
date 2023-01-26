# Making a function private

For a function to be invoked only by users with rights to invoke it, make the function private.

{% note info %}

If all unauthorized users (`allUsers` system group) of a cloud or folder are granted rights to invoke a function, the function will be public regardless of the settings. [How to revoke a role](../../iam/operations/roles/revoke.md).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
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
