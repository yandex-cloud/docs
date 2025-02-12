1. Select the folder the VM belongs to.
1. Select **{{ compute-name }}**.
1. Select the VM.
1. Click **Reset password**.

   {% note info %}

   If the window that opens shows a message saying that the password reset agent is not running on the VM, make sure it is installed and check its runtime logs. For more information, see [{#T}](../../compute/operations/vm-guest-agent/check.md).

   {% endnote %}

1. Specify the **Username** to reset the password for. If there is no user with that name on your VM, it will automatically be created with admin permissions.
1. Click **Generate password**.
1. Save the **New password**, as it will not be shown again after you close the window.
