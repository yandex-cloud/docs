---
title: Getting started with {{ baremetal-full-name }}
description: Follow this guide to lease and set up your first physical server in {{ baremetal-full-name }}.
---

# Getting started with {{ baremetal-full-name }}

{% note info %}

{{ baremetal-full-name }} will be launched at the Preview stage in Q4 2024.

{% endnote %}

Lease your first physical server and connect to it. All the leased server's resources are exclusively yours, thus providing better performance than an equivalent virtual machine.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Lease a server {#server-lease}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to lease a server in.
  1. In the list of services, select **{{ baremetal-name }}**.
  1. Click **Order server**.
  1. Select the `{{ region-id }}-m` [availability zone](../overview/concepts/geo-scope.md).
  1. Select the `{{ region-id }}-m3` pool.
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:
  
     1. Select the `BA-i103-S-10G` server configuration.
     1. Optionally, configure disk partitioning:

        1. Click **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
        1. Specify the layout parameters and click **{{ ui-key.yacloud.common.save }}**.
  
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select the `Ubuntu 22.04 LTS` image.
  1. Under **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**, specify:

     1. **{{ ui-key.yacloud.baremetal.field_server-count }}**: `1`
     1. **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}**: `{{ ui-key.yacloud.baremetal.label_one-month-duration }}`
  
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

     1. In the **Private subnet** field, click **{{ ui-key.yacloud.common.create }}**.
     1. Enter `bm-subnetwork` for the subnet name and click **Create subnet**.
     1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}`.
  
  1. {% include [server-lease-access](../_includes/baremetal/server-lease-access.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-info }}**, enter the server **{{ ui-key.yacloud.baremetal.field_name }}**: `bm-server`.
  1. Click **Order server**.

{% endlist %}

## Connect to the server {#server-connect}

{% list tabs group=operating_system %}

- KVM console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the server belongs to.
  1. In the list of services, select **{{ baremetal-name }}**.
  1. In the row with the server you need, click ![image](../_assets/console-icons/ellipsis.svg) and select **KVM console**.

- Linux/macOS {#linux-macos}
   
  To establish a server connection, specify its public IP address which can be found in the management console, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** on the server page.

  In the terminal, run this command:

  ```bash
  ssh root@<server_public_IP_address>
  ```

  If this is your first time connecting to the server, you will get an unknown host warning:

  ```text
  The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
  ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Type `yes` in the terminal and press **Enter**.

- Windows 10/11 {#windows}

  To establish a server connection, specify its public IP address which can be found in the management console, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** on the server page.

  Make sure that the Windows account has read privileges on the folder containing the keys.

  To connect to the server, run the following command in the command line:

  ```shell
  ssh root@<server_public_IP_address>
  ```

  If this is your first time connecting to the server, you will get an unknown host warning:

  ```text
  The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
  ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Type `yes` in the command line and press **Enter**.

- Windows 7/8 {#windows7-8}

  To establish a server connection, specify its public IP address which can be found in the management console, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** on the server page.

  Establish a connection using the PuTTY app:

  1. Run the Pageant application.
     1. Right-click the pageant icon in the task bar.
     1. In the context menu, select **Add key**.
     1. Select a PuTTY-generated private key in `.ppk` format. If a password is set for the key, enter it.
  1. Run PuTTY.
     1. In the **Host Name (or IP address)** field, enter the public IP address of the server you want to connect to. Set the port to `22` and connection type to **SSH**.

        ![ssh_add_ip](../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. In the tree on the left, select **Connection** → **SSH** → **Auth**.
     1. Set the **Allow agent forwarding** option.

        ![ssh_choose_private_key](../_assets/compute/ssh-putty/authentication_parameters.png)

     1. In the tree on the left, select **Connection** → **SSH** → **Auth** → **Credentials**.
     1. In the **Private key file for authentication** field, select the file with the private key.

        ![ssh_choose_private_key](../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Go back to the **Sessions** menu. In the **Saved sessions** field, enter any session name and click **Save**. The session settings are saved under the specified name. You can use this session profile to connect using Pageant.

        ![ssh_save_session](../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Click **Open**. If this is your first time connecting to the server, you may get this unknown host warning:

        ![ssh_unknown_host_warning](../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Click **Accept**. A terminal window will open prompting you to enter the username of the user on whose behalf the connection is being established. Enter the `root` username.

        If all the settings are correct, the connection with the server will be established.

        ![ssh_login](../_assets/compute/ssh-putty/ssh_login.png)

  If you saved the session profile in PuTTY, you can use Pageant to establish a connection in the future:

  1. Right-click the pageant icon in the task bar.
  1. Select the **Saved sessions** menu item.
  1. In the saved sessions list, select the session you need.

{% endlist %}
