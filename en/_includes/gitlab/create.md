1. On the folder page in [management console]({{ link-console-main }}), click **Create resource** and select
**Virtual machine**.
1. In the **Name** field, enter the VM name: `ci-tutorial-gitlab`.
1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.
1. Under **Images**, click **Choose**.
1. In the window that opens, open the **DevTools** tab.
1. Choose the **GitLab** image.
1. Under **Computing resources**, specify the following configuration:

   - **vCPU**: `2`
   - **Guaranteed vCPU share**: `100%`
   - **RAM**: `2 GB`
1. Under **Network settings**, select the subnet to connect the VM to during creation.
1. In the **Public address** field, choose `Auto`.
1. Specify data required for accessing the VM:

    - Enter the username in the **Login** field.
    - In the **SSH key** field, copy the contents of the public key file. You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` in Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) in Windows.
1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING`, you can start configuring it.

When a VM is created, it is assigned an IP address and hostname (FQDN). You can use this data for SSH access.

