# How to use WinSCP to connect to a Linux VM in Yandex Cloud with a key generated at VM creation


## Issue description {#case-description}

You need to connect to a Linux VM in Yandex Cloud via WinSCP with the key generated at creation.

## Solution {#case-resolution}

To connect to a Linux VM using WinSCP, specify these connection parameters:

1. `File protocol`: `SCP` or `SFTP`
2. `Host name`: IP address of the VM
3. `User name`: Username specified when creating the VM
4. `Password`: Leave blank because you are going to use SSH key authentication.

Next, click **Advanced**, select **SSH** – **Authentication**, then enable the `Allow agent forwarding` parameter in the **Authentication parameters** section. After that, in the `Private key file` field, select the SSH private key file and click **OK**. Now you can connect to the VM to transfer files via SCP or SFTP protocol by clicking the **Login** button.

This guide is relevant if you did not set a password for the user. If you have already connected to the VM using an SSH key and set a password using the `sudo passwd username`  command, then, in item **4**, Enter the user password and click **Login**.

For security reasons, access to the VM is [possible only by an SSH key by default](https://cloud.yandex.ru/docs/compute/operations/vm-connect/ssh).