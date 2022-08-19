1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM: `ci-tutorial-gitlab`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Images from {{ marketplace-name }}**, click **Select**. In the window that opens, select the [GitLab 14.8](/marketplace/products/yc/gitlab) image.

1. Under **Computing resources**, specify the following configuration:
   - **vCPU**: `2`
   - **Guaranteed vCPU share**: `100%`
   - **RAM**: `2 GB`

1. Under **Network settings**, select the subnet to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.

1. In the **Public address** field, choose `Auto`.

1. Specify data required for accessing the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, copy the contents of the public key file. You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING` and GitLab is run, you can start configuring it.

