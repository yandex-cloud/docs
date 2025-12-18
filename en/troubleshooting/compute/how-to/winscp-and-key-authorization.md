# How to use WinSCP to connect to a Linux VM in {{ yandex-cloud }} with a key generated on VM creation



## Case description {#case-description}

You need to use WinSCP to connect to a Linux VM in {{ yandex-cloud }} with a key generated on VM creation.

## Solution {#case-resolution}

To connect to a Linux VM using WinSCP, specify these connection properties in your WinSCP:

1. `File protocol`: `SCP` or `SFTP`.
1. `Host name`: VM IP address.
1. `User name`: Username specified when creating the VM.
1. `Password`: Leave blank, since you are going to use SSH key authentication.

Next, click **Advanced**, select **SSH** → **Authentication**, and then enable `Allow agent forwarding` in the **Authentication parameters** section. After that, in the **Private key file** field, select the SSH private key file and click **OK**. Now you can connect to the VM to transfer files via SCP or SFTP by clicking the **Login** button.

This above steps are relevant if you did not set a password for the user. If you have already connected to the VM using an SSH key and set a password using the `sudo passwd username` command, enter the user password on step **4** and click **Login**.

For security reasons, access to the VM is [only possible through an SSH key by default](../../../compute/operations/vm-connect/ssh.md).