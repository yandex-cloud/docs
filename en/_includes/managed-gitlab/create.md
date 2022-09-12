1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
1. In the **Name** field, enter the VM name as follows: `ci-tutorial-gitlab`.
1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
1. Under **Image/boot disk** selection, click the **{{ marketplace-name }}** tab and then **Show more**. In the resulting window, select [{{ GL }} 14.8](/marketplace/products/yc/gitlab) as your image and click **Use**.
1. Under **Computing resources**, specify the following configuration:
   * **vCPU**: `4`.
   * **Guaranteed vCPU share**: `100%`.
   * **RAM**: `8 GB`.
1. Under **Network settings**:
   * Select a subnet to connect your VM to. If the desired network or subnet does not exist, create them using the **Create network** and **Add subnet** buttons.
   * In the **Public address** field, select `Auto`.
1. Under **Access**, specify the information required to access the instance:
   * Enter the username in the **Login** field.

     {% note alert %}

     Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

     {% endnote %}

   * In the **SSH key** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to create a key pair for the SSH connection yourself. See the [section about how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).
1. Click **Create VM**.

The VM may take several minutes to create. When your VM's status changes to `RUNNING`, and {{ GL }} starts, you can proceed to setup.