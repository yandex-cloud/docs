# Creating a VM and connecting to it

Once your billing account is set up, you can start using {{ yandex-cloud }} services, e.g., create a [VM](../../compute/concepts/vm.md) in [{{ compute-full-name }}](../../compute/concepts/index.md).

## Create a VM {#create-vm}

1. Go to the [management console]({{ link-console-main }}) and click your profile image in the left-hand panel.
1. Select `Example organization`.
1. In the left-hand panel, select `default`.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Select **{{ ui-key.yacloud.compute.group.switch_instances }}** ![image](../../_assets/console-icons/server.svg).
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}** and set the VM parameters:

   1. Select **Basic setup**.
   1. Under **Operating systems and products**, select **Ubuntu 24.04 LTS**.
   1. Under **Computing resources**, specify the computing resource configuration for the VM.
   1. Under **Disks**, specify the size and type of the disk.
   1. Enter the **VM name**.
   1. Set the **Login** of the VM administrator.
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**. In the window that opens, do the following:
      1. Enter a **Name** for the SSH key.
      1. Under **SSH key**, select **Generate key**.
      1. Click **{{ ui-key.yacloud.common.add }}**.

         The SSH key will be downloaded to your computer and added to your organization user profile.

         If, due to organization restrictions, you cannot add SSH keys to your user profile, the system will save the key to the VM user profile.

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

## Configure a security group to connect to the VM {#security-group}

A *security group* (SG) is a resource created at the [cloud network](../../vpc/concepts/network.md#network) level. Once created, a security group can be used in {{ yandex-cloud }} services to control network access to an object it applies to.

The VM you created was assigned the default security group. To allow a connection to the VM over SSH, create a rule in this security group that allows incoming traffic via TCP to port 22:

1. Navigate to the [management console]({{ link-console-main }}).
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** and open the VM you created earlier.
1. On the VM information page, under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, open the security group assigned to the VM.
1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
1. Open the **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab and click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
1. In the window that opens, set the following parameters:
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   1. **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.
   1. Click **{{ ui-key.yacloud.common.save }}**. Add other rules, if required.
1. Click **{{ ui-key.yacloud.common.save }}**.

## Connecting to a VM {#vm-connect}

You can connect to a VM with the `RUNNING` status over SSH. It may take some time for all services to initialize after the VM [starts](../../compute/operations/vm-control/vm-stop-and-start.md#start). If you get a connection error, try again in a few minutes.

To connect, specify the VM [public IP address](../../vpc/concepts/address.md#public-addresses). You can find out the public IP address in the management console: on the VM page, go to the **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** section and find the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** field. If you created your VM with an internal IP address only, [assign it a public IP address](../../compute/operations/vm-control/vm-attach-public-ip.md).

You can also use [internal IP addresses](../../vpc/concepts/address.md#internal-addresses) and [FQDNs](../../vpc/concepts/address.md#fqdn) to establish an SSH connection between VMs within a single [cloud network](../../vpc/concepts/network.md#network) in {{ yandex-cloud }}.

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  In the terminal, run this command:

  ```bash
  ssh <username>@<VM_public_IP_address>
  ```

  Where `<username>` is the VM account username. If you created your VM via the CLI, `yc-user` is the default user.

  If you have multiple private keys, specify the one you need:

  ```bash
  ssh -i <key_path/key_file_name> <username>@<VM_public_IP_address>
  ```

  If this is your first time connecting to the VM, you will get this unknown host warning:

  ```text
  The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
  ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Type `yes` into the terminal and press **Enter**.

- Windows 10/11 {#windows}

  Make sure the Windows account has read access to the key folder.

  To connect to the VM, run the following command in the command line:

  ```shell
  ssh <username>@<VM_public_IP_address>
  ```

  Where `<username>` is the VM account username. If you created your VM via the CLI, `yc-user` is the default user.

  If you have multiple private keys, specify the one you need:

  ```shell
  ssh -i <key_path\key_file_name> <username>@<VM_public_IP_address>
  ```

  If this is your first time connecting to the VM, you will get this unknown host warning:

  ```text
  The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
  ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Type `yes` in the command line and press **Enter**.

- Windows 7/8 {#windows7-8}

  Establish a connection using PuTTY:
  1. Run Pageant:
     1. Right-click the Pageant icon in the task bar.
     1. In the context menu, select **Add key**.
     1. Select a PuTTY-generated private key in `.ppk` format. Enter the password for this key, if it is set.
  1. Run PuTTY:
     1. In the **Host Name (or IP address)** field, enter the public IP address of the VM you want to connect to. Specify port `22` and **SSH** connection type.

        ![ssh_add_ip](../../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. In the tree on the left, select **Connection** → **SSH** → **Auth**.
     1. Enable **Allow agent forwarding**.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/authentication_parameters.png)

     1. In the tree on the left, select **Connection** → **SSH** → **Auth** → **Credentials**.

     1. In the **Private key file for authentication** field, select the private key file.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Go back to the **Sessions** menu. In the **Saved sessions** field, enter any name for the session and click **Save**. This will save the session settings under the specified name. You can use this session profile to connect with Pageant.

        ![ssh_save_session](../../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Click **Open**. If this is your first time connecting to the VM, you may get this unknown host warning:

        ![ssh_unknown_host_warning](../../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Click **Accept**. This will open a terminal window prompting you to enter the username to use for connection. Type the username you specified when creating the VM and press **Enter**. If you created your VM via the CLI, `yc-user` is the default user.

        If everything is configured correctly, a connection to the server will be established.

        ![ssh_login](../../_assets/compute/ssh-putty/ssh_login.png)

  If you saved the session profile in PuTTY, you can use Pageant for future connections:
  1. Right-click the Pageant icon in the task bar.
  1. Select **Saved sessions**.
  1. In the saved sessions list, select the session you need.

{% endlist %}

For more information on how to solve connection issues, see [FAQ](../../compute/qa/connection.md).
