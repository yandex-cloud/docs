# Working in the code editor

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ sf-name }}**.

   1. Select a function.

   1. Go to the **Editor** tab.

   1. If the function is empty, select the runtime environment and click **Next**.

   1. Under **Function code**:

      * Select the [runtime environment](../../concepts/runtime/index.md).
      * Select how you want to edit the function: **Code editor**.
      * Select an existing file in the navigation panel or click Create file.
      * In the window that opens, enter the file name with its extension and click **Create**.
      * Specify the entry point: the name of the function to be called as a handler.
         Format: `<filename without extension>.<handler name>`. For example, `index.myFunction`.

   1. Under **Parameters**:

      * Specify the timeout.
      * Specify the amount of RAM.
      * (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). When you add a service account for a function, you can [get its IAM token from the function context](../function-sa.md).
      * (optional) Add [environment variables](../../concepts/runtime/environment-variables.md).

   1. In the top right-hand corner, click **Create version**.

{% endlist %}

