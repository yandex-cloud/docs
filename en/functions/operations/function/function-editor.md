# Working in the code editor

To work with your function code in the code editor:

1. Select **{{ sf-name }}** in the [management console]({{ link-console-main }}).
1. Click ![image](../../../_assets/vertical-ellipsis.svg) in the row of the function you want to edit.
1. In the window that opens, go to **Editor**.
1. Under **Function code**:
    - Select the runtime environment.
    - Select how you want to edit the function: **Code editor**.
    - In the function edit window, select an existing file in the left navigation panel or create a new file by clicking **Create file**. In the window that opens, enter the file name with its extension and click **Create**.
    - Specify the entry point: the name of the function to be called as a handler. It is specified in the format `<name of the function  file>.<handler name>`, for example, `index.myFunction`.
1. Under **Parameters**:
    - Specify the timeout.
    - Specify the amount of RAM.
    - (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). When you add a service account for a function, you can [get its IAM token from the function context](../function-sa).
    - (optional) Add environment variables.
1. In the upper-right corner, click **Create version**.

