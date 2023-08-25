1. Select the folder the VM belongs to.
1. Select **{{ compute-name }}**.
1. Select the VM.
1. Click **Reset password**.

   {% note info %}

   In the window that opens, if you see a message that the password reset agent is not running on the VM, make sure it is installed and review its runtime logs. For more information, see [{#T}](../../compute/operations/vm-guest-agent/check.md).

   {% endnote %}

1. Specify the **Username** to reset the password for. If there is no user with that name on the VM, this user will be created with administrator access.
1. Click **Generate password**.
1. Save the **New password**. It will become unavailable once you close the window.
