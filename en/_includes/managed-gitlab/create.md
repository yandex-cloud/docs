1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
1. In the **Name** field, enter the [VM](../../compute/concepts/vm.md) name as follows: `ci-tutorial-gitlab`.
1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
1. Under **Image/boot disk** selection, click the **{{ marketplace-name }}** tab and then **Show more**. In the window that opens, select [{{ GL }}](/marketplace/products/yc/gitlab) as your image and click **Use**.
1. Under **Computing resources**, specify the following configuration:
   * **vCPU**: `4`.
   * **Guaranteed vCPU share**: `100%`.
   * **RAM**: `8 GB`.
1. Under **Network settings**:
   * Select a [subnet](../../vpc/concepts/network.md#subnet) to connect your VM to. If the [network](../../vpc/concepts/network.md#network) or subnet you need do not exist, create them using the **Create network** and **Add subnet** buttons.

     {% include [GL CIDR Warning](../../_includes/managed-gitlab/cidr-note.md) %}

   * In the **Public address** field, select `Auto`.
1. Under **Access**, specify the information required to access the instance:
    * Enter the username in the **Login** field.

      {% note alert %}

      Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

      {% endnote %}

    * In the **SSH key** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to create a key pair for the SSH connection yourself. See [this section](../../compute/operations/vm-connect/ssh.md) to learn how to connect to VMs via SSH.
1. Click **Create VM**.

It may take a few minutes to create a VM. When your VM's status changes to `RUNNING` and {{ GL }} starts, you can proceed to setup.