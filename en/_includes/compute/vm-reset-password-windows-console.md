1. In the [management console]({{ link-console-main }}), select your VM folder.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Select the VM.
1. At the top right, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.compute.instances.button_action-password-reset }}**.

    {% note info %}

    If the window that opens shows a message saying that the password reset agent is not running on the VM, make sure it is installed and check its runtime logs. For more information, see [{#T}](../../compute/operations/vm-guest-agent/check.md).

    {% endnote %}

1. Specify the username to reset the password for. If there is no user with that name on your VM, it will be created automatically and get admin permissions.

    To reset the admin password, specify `Administrator`.

1. Click **{{ ui-key.yacloud.compute.instance.popup-confirm_button_password-reset }}**.