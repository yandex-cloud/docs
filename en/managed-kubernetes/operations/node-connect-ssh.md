---
title: "How to connect to a {{ k8s }} cluster node in {{ managed-k8s-full-name }}"
description: "Follow this guide to connect to the node over SSH."
---

# Connecting to a node over SSH

To connect to a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) [node](../concepts/index.md#node-group) over SSH:
* Add the public key to the meta information when [creating a {{ managed-k8s-name }} node group](node-group/node-group-create.md).

  {% note info %}

  SSH connection using a login and password is disabled by default on Linux images that are used on {{ managed-k8s-name }} nodes.

  {% endnote %}

* [Configure security groups](connect/security-groups.md) for the {{ managed-k8s-name }} cluster.

  {% note warning %}

  Security group settings may prevent connection to the {{ managed-k8s-name }} cluster.

  {% endnote %}

For more information, see [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).

## Create SSH key pairs {#creating-ssh-keys}

Prepare the keys for use with your {{ managed-k8s-name }} cluster node. To do this:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Open the terminal.
  1. Use the `ssh-keygen` command to create a new key:

     ```bash
     ssh-keygen -t ed25519
     ```

     After you run the command, you will be asked to specify the names of files where the keys will be saved and enter the password for the private key. The default name is `id_ed25519`. Keys are created in the `~/.ssh` directory.

     The public part of the key will be saved to a file named `<key name>.pub`.

- Windows 10 {#windows}

  1. Run `cmd.exe` or `powershell.exe`.
  1. Use the `ssh-keygen` command to create a new key. Run this command:

     ```bash
     ssh-keygen -t ed25519
     ```

     After you run the command, you will be asked to specify the names of files where the keys will be saved and enter the password for the private key. The default name is `id_ed25519`. Keys are created in the `C:\Users\<username>\.ssh\` folder.

     The public part of the key will be saved to a file named `<key name>.pub`.

- Windows 7/8 {#windows7-8}

  To create keys for Windows, use the PuTTY application.
  1. [Download](https://www.putty.org) and install PuTTY.
  1. Make sure that the directory where you installed PuTTY is included in `PATH`:
     1. Right-click **My computer**. Click **Properties**.
     1. In the window that opens, select **Additional system parameters**, then **Environment variables** (located in the lower part of the window).
     1. Under **System variables**, find `PATH` and click **Edit**.
     1. In the **Variable value** field, append the path to the directory where you installed PuTTY.
  1. Launch the PuTTYgen app.
  1. Select **Ed25519** as the pair type to generate. Click **Generate** and move the cursor in the field above it until key creation is complete.

     ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh_generate_key.png)

  1. In **Key passphrase**, enter a strong password. Enter it again in the field below.
  1. Click **Save private key** and save the private key. Never share it with anyone and do not tell anyone the passphrase for it.
  1. Save the key in a text file in a single line. To do this, copy the public key from the text field to a text file with the name `id_ed25519.pub`.

{% endlist %}

## Convert the public key to the relevant format {#key-format}

You can manage users and SSH keys via metadata, which is why you must transmit keys in a defined format.

The file with the public key is created in the format:

```text
ssh-ed25519 AAAAB3NzaC***********lP1ww ed25519-key-20190412
```

You need to convert the key to `<username>:ssh-ed25519 <key_body> <username>` format so that it looks like this:

```text
username:ssh-ed25519 AAAAB3NzaC***********lP1ww username
```

You can pass multiple public keys in the same file to grant access to different users:

```text
username:ssh-ed25519 AAAAB3NzaC***********lP1ww username
username2:ssh-ed25519 ONEMOREkey***********avEHw username2
```

## Create a node group and add the public key {#node-create}

To create a {{ managed-k8s-name }} node group with the required parameters, use the following command:

```bash
yc managed-kubernetes node-group create \
  --name <node_group_name> \
  --cluster-name <cluster_name> \
  --fixed-size <number_of_nodes_in_the_group> \
  --network-interface security-group-ids=[<list_of_security_groups>],subnets=<subnet_name>,ipv4-address=nat \
  --metadata-from-file ssh-keys=<public_key_file_name>
```

{% include [user-data](../../_includes/managed-kubernetes/user-data.md) %}

## Update node group keys {#node-add-metadata}

To update the SSH keys of a {{ managed-k8s-name }} node group, use the following command:

```bash
yc managed-kubernetes node-group add-metadata \
  --name <node_group_name> \
  --metadata-from-file ssh-keys=<public_key_file_name>
```

## Get the public IP address of the node {#node-public-ip}

To connect, specify the {{ managed-k8s-name }} node [public IP address](../../vpc/concepts/address.md#public-addresses). You can find it using one of the following methods.

{% list tabs %}

- kubectl CLI

  1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

  1. Run this command:

     ```bash
     kubectl get nodes -o wide
     ```

     Result:

     ```bash
     NAME                       STATUS  ROLES   AGE  VERSION  INTERNAL-IP  EXTERNAL-IP     OS-IMAGE            KERNEL-VERSION     CONTAINER-RUNTIME
     cl17i6943n92********-itif  Ready   <none>  31m  v1.13.3  10.0.0.27    84.201.145.251  Ubuntu 18.04.1 LTS  4.15.0-29-generic  docker://18.6.2
     cl17i6943n92********-ovah  Ready   <none>  31m  v1.13.3  10.0.0.22    84.201.149.184  Ubuntu 18.04.1 LTS  4.15.0-29-generic  docker://18.6.2
     ```

     The public IP address is listed in the `EXTERNAL-IP` column.

- Management console

  1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** section in the folder where you created your {{ managed-k8s-name }} cluster.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Click the instance group with the name that matches the {{ managed-k8s-name }} node group ID.
  1. In the window that opens, go to the **{{ ui-key.yacloud.compute.group.switch_instances }}** tab.
  1. Click the VM that you want to find the public address for.
  1. The public IP address is shown in the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section in **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}**.

- CLI

  1. Find out the ID of the instance group that corresponds to the {{ managed-k8s-name }} node group.

     This parameter is shown in the `INSTANCE GROUP ID` column.

     ```bash
     yc managed-kubernetes node-group list
     ```

     Result:

     ```bash
     +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
     |          ID          |      CLUSTER ID      |      NAME      |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
     +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
     | cat684ojo3ir******** | cata9ertn6tc******** | test-nodegroup | cl17i6943n92******** | 2019-04-12 12:38:35 | RUNNING |    2 |
     +----------------------+----------------------+----------------+----------------------+---------------------+---------+------+
     ```

  1. View the list of {{ managed-k8s-name }} nodes that belong to this group.

     The public IP address of the {{ managed-k8s-name }} node is shown in the `IP` column after `~`.

     ```bash
     yc compute instance-group list-instances cl17i6943n92********
     ```

     Result:

     ```bash
     +----------------------+---------------------------+--------------------------+---------------+----------------+
     |     INSTANCE ID      |           NAME            |            IP            |    STATUS     | STATUS MESSAGE |
     +----------------------+---------------------------+--------------------------+---------------+----------------+
     | ef31h24k03pg******** | cl17i6943n92********-itif | 10.0.0.27~84.201.145.251 | RUNNING [53m] |                |
     | ef37ddhg9i7j******** | cl17i6943n92********-ovah | 10.0.0.22~84.201.149.184 | RUNNING [53m] |                |
     +----------------------+---------------------------+--------------------------+---------------+----------------+
     ```

{% endlist %}

## Connect to the node {#node-connect}

You can connect to a {{ managed-k8s-name }} node over SSH once it starts (the status is `RUNNING`). You can use the `ssh` utility in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

{% list tabs group=operating_system %}

- Linux/macOS/Windows 10 {#linux-macos-windows10}

  In the terminal, run the following command:

  ```bash
  ssh <username>@<public_IP_address_of_node>
  ```

  If connecting to the {{ managed-k8s-name }} node for the first time, you may get an unknown host warning:

  ```bash
  The authenticity of host '130.193.40.101 (130.193.40.101)' cannot be established.
  ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
  Are you sure you want to continue connecting (yes/no)?
  ```

  Type `yes` in the terminal and press **Enter**.

- Windows 7/8 {#windows7-8}

  In Windows, a connection is established using the PuTTY application.
  1. Run the Pageant application.
     1. Right-click on the Pageant icon in the task bar.
     1. In the context menu, select **Add key**.
     1. Select a PuTTY-generated private key in the `.ppk` format. If a password is set for the key, enter it.
  1. Run PuTTY.
     1. In the **Host Name (or IP address)** field, enter the public IP address of the VM you want to connect to. Specify port `22` and **SSH** as the connection type.

        ![ssh_add_ip](../../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. In the tree on the left, select **Connection** - **SSH** - **Auth**.
     1. Set the **Allow agent forwarding** option.
     1. In the **Private key file for authentication** field, select the file with the private key.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Go back to the **Sessions** menu. In the **Saved sessions** field, enter any session name and click **Save**. The session settings are saved under the specified name. You can use this session profile to connect using Pageant.

        ![ssh_save_session](../../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Click **Open**. If connecting to the {{ managed-k8s-name }} node for the first time, you may get an unknown host warning:

        ![ssh_unknown_host_warning](../../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Click **Yes**. A terminal window opens suggesting that you enter the login of the user on whose behalf the connection is being established. Type the user name you specified in the file with the public key and click **Enter**. If everything is configured correctly, the connection with the server will be established.

        ![ssh_login](../../_assets/compute/ssh-putty/ssh_login.png)

  If you saved the session profile in PuTTY, you can use Pageant to establish a connection in the future:
  1. Right-click on the Pageant icon in the task bar.
  1. Select the **Saved sessions** menu item.
  1. In the saved sessions list, select the necessary session.

{% endlist %}