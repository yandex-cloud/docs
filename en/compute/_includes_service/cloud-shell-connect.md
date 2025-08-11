1. On the left-hand panel in the [management console]({{ link-console-main }}), click ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**, or find it using the search bar on the dashboard.
1. Navigate to the VM you want to connect to.
1. Click ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-ssh }}** at the top right.
1. Enter a username. The default login is the one specified when creating the VM.
1. Paste the contents of the public SSH key file or upload the file.
1. Click **{{ ui-key.yacloud.compute.components.SshViaPrivateKeyDialog.connect-via-private-key_6DKKe }}**.

This will open the ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.cloud-shell.label_service }}** terminal at the bottom with an established connection to the VM over SSH.

To close the connection, click ![image](../../_assets/console-icons/xmark.svg) or use the `exit` command.