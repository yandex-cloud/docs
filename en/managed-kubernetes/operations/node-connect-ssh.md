---
title: How to connect to a {{ k8s }} cluster node in {{ managed-k8s-full-name }}
description: Follow this guide to connect to the node over SSH.
---

# Connecting to a node over SSH

To connect to a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) [node](../concepts/index.md#node-group) over SSH:
* Add the public key to the metadata when [creating a {{ managed-k8s-name }} node group](node-group/node-group-create.md).

  {% note info %}

  SSH connection using a login and password is disabled by default on Linux images that are used on {{ managed-k8s-name }} nodes.

  {% endnote %}

* [Configure security groups](connect/security-groups.md) for the {{ managed-k8s-name }} cluster.

  {% note warning %}

  Security group settings may prevent connection to the {{ managed-k8s-name }} cluster.

  {% endnote %}

For more information, see [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).

{% include [node-vm-explained](../../_includes/managed-kubernetes/node-vm-explained.md) %}

{% include [node-vm-manipulation-warning](../../_includes/managed-kubernetes/node-vm-manipulation-warning.md) %}

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

- Windows 10/11 {#windows}

  1. Run `cmd.exe` or `powershell.exe`.
  1. Use the `ssh-keygen` command to create a new key. Run this command:

     ```bash
     ssh-keygen -t ed25519
     ```

     After you run the command, you will be asked to specify the names of files where the keys will be saved and enter the password for the private key. The default name is `id_ed25519`. Keys are created in `C:\Users\<username>\.ssh\`.

     The public part of the key will be saved to a file named `<key name>.pub`.

- Windows 7/8 {#windows7-8}

  Create keys using the PuTTY app:
  1. [Download](https://www.putty.org) and install PuTTY.
  1. Make sure the directory where you installed PuTTY is included in `PATH`:
     1. Right-click **My computer**. Click **Properties**.
     1. In the window that opens, select **Additional system parameters**, then **Environment variables** (located in the lower part of the window).
     1. Under **System variables**, find `PATH` and click **Edit**.
     1. In the **Variable value** field, append the path to the directory where you installed PuTTY.
  1. Launch the PuTTYgen app.
  1. Select **Ed25519** as the pair type to generate. Click **Generate** and move the cursor in the field above it until key creation is complete.

     ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh_generate_key.png)

  1. In **Key passphrase**, enter a strong password. Enter it again in the field below.
  1. Click **Save private key** and save the private key. Do not share its key phrase with anyone.
  1. Save the key in a text file in a single line. To do this, copy the public key from the text field to a text file named `id_ed25519.pub`.

{% endlist %}

## Convert the public key to the metadata format {#key-format}

The credentials for connecting to the {{ managed-k8s-name }} cluster nodes over SSH are the username and public key. These credentials are provided using metadata in a specific format.

The [previously created](#creating-ssh-keys) public key has the following format:

```text
<key_type> <public_key_body> <optional_comment>
```

Example:

> ```text
> ssh-ed25519 AAAAB3NzaC***********lP1ww ed25519-key-20190412
> ```

Create a file with credentials for connecting over SSH in the following format:

```text
<username>:<key_type> <public_key_body> <username>
```

Example:

> ```text
> testuser:ssh-ed25519 AAAAB3NzaC***********lP1ww testuser
> ```

This format is suitable for creating and updating a {{ managed-k8s-name }} node group using the CLI, {{ TF }}, and API interfaces, and for updating a node group using the management console. When creating a node group, separate **{{ ui-key.yacloud.compute.instances.create.field_user }}** and **{{ ui-key.yacloud.compute.instances.create.field_key }}** fields are used in the management console.

You can provide credentials for multiple users in one file.

Example:

> ```text
> testuser1:ssh-ed25519 AAAAB3NzaC***********lP1ww testuser1
> testuser2:ssh-ed25519 ONEMOREkey***********avEHw testuser2
> ```

## Create a node group and add the public key {#node-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. In the left-hand panel, select **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
  1. Set the node group parameters.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}**, specify the information required to access the {{ managed-k8s-name }} node:
      * Enter the username into the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Metadata with credentials for connecting over SSH is provided to the {{ managed-k8s-name }} node group as `key=value` pairs.

  {% include [user-data](../../_includes/managed-kubernetes/user-data.md) %}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ managed-k8s-name }} node group and provide user credentials for connecting over SSH, run the following command:

  ```bash
  yc managed-kubernetes node-group create \
    --name <node_group_name> \
    --cluster-name <cluster_name> \
    --fixed-size <node_number_in_group> \
    --network-interface security-group-ids=[<list_of_security_groups>],subnets=<subnet_name>,ipv4-address=nat \
    --metadata-from-file ssh-keys=<credentials_file_path>
  ```

  Where `--metadata-from-file` is the parameter to transfer metadata to the node group as `key=value` pairs. In `ssh-keys`, specify the path to the file with credentials for connecting over SSH.

- {{ TF }} {#tf}

  Metadata with credentials for connecting over SSH is provided to the {{ managed-k8s-name }} node group as `key=value` pairs.

  {% include [user-data](../../_includes/managed-kubernetes/user-data.md) %}

  1. Create a {{ TF }} configuration file describing the {{ managed-k8s-name }} node group by following the steps described in [{#T}](./node-group/node-group-create.md).

  1. In the node group description, set the `ssh-keys` metadata key value for the `instance_template.metadata` parameter:

      ```hcl
      resource "yandex_kubernetes_node_group" "<node_group_name>" {
        cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
        ...
        instance_template {
          metadata = {
            "ssh-keys" = file("<credentials_file_path>")
            ...
          }
          ...
        }
        ...
      }
      ```

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  Metadata with credentials for connecting over SSH is provided to the {{ managed-k8s-name }} node group as `key=value` pairs.

  {% include [user-data](../../_includes/managed-kubernetes/user-data.md) %}

  To provide multiple credentials for connecting over SSH, convert the contents of the credentials file to a single line by separating the credentials from each other with a sequence of special CRLF characters (`\r\n`). You cannot use multiline messages in an API request with a JSON body.

  Example of converted credentials:

  > ```text
  > testuser1:ssh-ed25519 AAAAB3NzaC***********lP1ww testuser1\r\ntestuser2:ssh-ed25519 ONEMOREkey***********avEHw testuser2
  > ```

  Use the [create](../managed-kubernetes/api-ref/NodeGroup/create.md) REST API method for the [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) resource or the [NodeGroupService/Create](../managed-kubernetes/api-ref/grpc/node_group_service.md#Create) gRPC API call.

  Credentials for connecting over SSH are provided in the `nodeTemplate.metadata` parameter in `ssh-keys`.

{% endlist %}

For more information about creating a {{ managed-k8s-name }} node group and parameters to provide, see [{#T}](./node-group/node-group-create.md).

## Update node group keys {#node-add-metadata}

To change the credentials for connecting over SSH to a {{ managed-k8s-name }} node group, update its metadata.

{% note warning %}

The credentials for connecting over SSH will be completely overwritten. You will not be able to connect to the {{ managed-k8s-name }} cluster nodes using the previous credentials.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. In the left-hand panel, select **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. On the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab, select the node group in which you want to update the credentials.
  1. In the top panel, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Open **{{ ui-key.yacloud.common.metadata }}**.
  1. Replace the current value of `ssh-keys` with the contents of the credentials file.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. View the description of the CLI command for adding and updating the {{ managed-k8s-name }} node group metadata:

      ```bash
      {{ yc-k8s }} node-group add-metadata --help
      ```

  1. Run this command:

      ```bash
      {{ yc-k8s }} node-group add-metadata \
        --name <node_group_name> \
        --metadata-from-file ssh-keys=<credentials_file_path>
      ```

      You can request the name of a node group with a [list of node groups in the folder](./node-group/node-group-list.md#list).

- {{ TF }} {#tf}

  1. Open the {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

      For more information about creating this file, see [{#T}](./node-group/node-group-create.md).

  1. In the node group description, change the value of the `ssh-keys` metadata key for the `instance_template.metadata` parameter:

      ```hcl
      resource "yandex_kubernetes_node_group" "<node_group_name>" {
        cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
        ...
        instance_template {
          metadata = {
            "ssh-keys" = file("<credentials_file_path>")
            ...
          }
          ...
        }
        ...
      }
      ```

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  1. To provide multiple credentials for connecting over SSH, convert the contents of the credentials file to a single line by separating the credentials from each other with a sequence of special CRLF characters (`\r\n`). You cannot use multiline messages in an API request with a JSON body.

      Example of converted credentials:

      > ```text
      > testuser1:ssh-ed25519 AAAAB3NzaC***********lP1ww testuser1\r\ntestuser2:ssh-ed25519 ONEMOREkey***********avEHw testuser2
      > ```

  1. {% include [get-metadata-via-api](../../_includes/managed-kubernetes/get-metadata-via-api.md) %}

  1. Use the [update](../managed-kubernetes/api-ref/NodeGroup/update.md) REST API method for the [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) resource and include the following in the request:

      * Node group ID in the `nodeGroupId` parameter.

      * `updateMask` set to `nodeTemplate.metadata`.

          {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

      * `nodeTemplate.metadata` listing all existing node group metadata as `key=value` pairs without modification.

          For `ssh-keys`, replace the current value with the created line with credentials.

          {% cut "Example of listing metadata in a parameter" %}

          > * Existing metadata keys in a node group:
          >
          >     ```json
          >     "nodeTemplate": {
          >         "metadata": {
          >             "ssh-keys": "<existing_credentials_in_single_line>",
          >             "<existing_key_1>": "<existing_value_1>",
          >             "<existing_key_2>": "<existing_value_2>"
          >         },
          >         ...
          >     }
          >     ```
          >
          > * Metadata keys to provide in an API request:
          >
          >     ```json
          >     "nodeTemplate": {
          >         "metadata": {
          >             "ssh-keys": "<new_credentials_in_single_line>",
          >             "<existing_key_1>": "<existing_value_1>",
          >             "<existing_key_2>": "<existing_value_2>"
          >         }
          >     }
          >     ```

          {% endcut %}

          {% include [Alert API Updating Metadata](../../_includes/managed-kubernetes/metadata-updating-alert.md) %}

{% endlist %}

## Get the public IP address of the node {#node-public-ip}

To connect to a {{ managed-k8s-name }} cluster node, specify the [public IP address](../../vpc/concepts/address.md#public-addresses) of a {{ managed-k8s-name }} node. You can find it using one of the following methods.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** section in the folder where you created your {{ managed-k8s-name }} cluster.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Click the instance group with the name that matches the {{ managed-k8s-name }} node group ID.
  1. In the window that opens, go to the **{{ ui-key.yacloud.compute.group.switch_instances }}** tab.
  1. Click the VM that you want to find the public address for.
  1. The public IP address is shown in the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section in **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}**.

- CLI {#cli}

  1. Find out the ID of the instance group that corresponds to the {{ managed-k8s-name }} node group.

     The ID is shown in the `INSTANCE GROUP ID` column.

     ```bash
     yc managed-kubernetes node-group list
     ```

     Result:

     ```text
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

     ```text
     +----------------------+---------------------------+--------------------------+---------------+----------------+
     |     INSTANCE ID      |           NAME            |            IP            |    STATUS     | STATUS MESSAGE |
     +----------------------+---------------------------+--------------------------+---------------+----------------+
     | ef31h24k03pg******** | cl17i6943n92********-itif | 10.0.0.27~84.201.145.251 | RUNNING [53m] |                |
     | ef37ddhg9i7j******** | cl17i6943n92********-ovah | 10.0.0.22~84.201.149.184 | RUNNING [53m] |                |
     +----------------------+---------------------------+--------------------------+---------------+----------------+
     ```

- kubectl CLI {#kubectl}

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

{% endlist %}

## Connect to the node {#node-connect}

You can connect to a {{ managed-k8s-name }} node over SSH once it is started (with the `RUNNING` status). To do this, use `ssh` in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

{% list tabs group=operating_system %}

- Linux/macOS/Windows 10 {#linux-macos-windows10}

  In the terminal, run the following command, specifying the username and [public IP address](#node-public-ip) of the node:

  ```bash
  ssh <username>@<node_public_IP_address>
  ```

  If you provided SSH connection credentials when you [created the node group](#node-create) using the management console, use the username you specified in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

  If you provided SSH connection credentials when you [created the node group](#node-create) using the CLI, {{ TF }}, API, or [updated the credentials](#node-add-metadata), use the username that you [specified in the SSH connection credentials file](#key-format).

  If this is your first time connecting to a {{ managed-k8s-name }} node, you may get an unknown host warning:

  ```bash
  The authenticity of host '130.193.40.101 (130.193.40.101)' cannot be established.
  ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
  Are you sure you want to continue connecting (yes/no)?
  ```

  Type `yes` in the terminal and press **Enter**.

- Windows 7/8 {#windows7-8}

  In Windows, a connection is established using the PuTTY application.
  1. Run the Pageant application.
     1. Right-click the pageant icon in the task bar.
     1. In the context menu, select **Add key**.
     1. Select a PuTTY-generated private key in `.ppk` format. If a password is set for the key, enter it.
  1. Run PuTTY.
     1. In the **Host Name (or IP address)** field, enter the [public IP address](#node-public-ip) of the VM you want to connect to. Set the port to `22` and connection type to **SSH**.

        ![ssh_add_ip](../../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. In the tree on the left, select **Connection** - **SSH** - **Auth**.
     1. Set the **Allow agent forwarding** option.
     1. In the **Private key file for authentication** field, select the file with the private key.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Go back to the **Sessions** menu. In the **Saved sessions** field, enter any session name and click **Save**. The session settings are saved under the specified name. You can use this session profile to connect using Pageant.

        ![ssh_save_session](../../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Click **Open**. If connecting to the {{ managed-k8s-name }} node for the first time, you may get an unknown host warning:

        ![ssh_unknown_host_warning](../../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Click **Yes**. A terminal window will open prompting you to enter the username of the user on whose behalf the connection is being established.

        Enter the username:
        * If you provided SSH connection credentials when you [created the node group](#node-create) using the management console, enter the username you specified in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
        * If you provided SSH connection credentials when you [created the node group](#node-create) using the CLI, {{ TF }}, API, or [updated the credentials](#node-add-metadata), enter the username that you [specified in the SSH connection credentials file](#key-format).

        Click **Enter**. If all the settings are correct, the connection with the server will be established.

        ![ssh_login](../../_assets/compute/ssh-putty/ssh_login.png)

  If you saved the session profile in PuTTY, you can use Pageant to establish a connection in the future:
  1. Right-click the pageant icon in the task bar.
  1. Select the **Saved sessions** menu item.
  1. In the saved sessions list, select the session you need.

{% endlist %}
