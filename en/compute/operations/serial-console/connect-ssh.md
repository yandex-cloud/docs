---
title: Connecting to a Linux VM serial console
description: Follow this guide to connect to the serial console of a {{ compute-full-name }} VM instance running Linux.
---

# Connecting to a Linux VM serial console

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

To connect to a VM's [serial console](../../concepts/serial-console.md), first [enable serial console access](./index.md#enable) for the VM instance.

You can connect to the serial console through the [management console]({{ link-console-main }}), as well as using the standard SSH client or via [{{ oslogin }}](../../../organization/concepts/os-login.md).

Before connecting to the serial console, carefully read this section: [{#T}](../../concepts/serial-console.md#security).

## Getting started {#before-you-begin}

Some operating systems may request local user data to access the VM serial console. Therefore, before connecting to the serial console of a VM running such an OS, create a local user password.

In the example below, you will create a new local Linux user account with password protection:

1. Connect to the VM [over SSH](../vm-connect/ssh.md) or [via {{ oslogin }}](../vm-connect/os-login.md).
1. Create a new local user account with password protection:

    ```bash
    export NEW_USERNAME=<new_username>
    sudo useradd -m -d /home/$NEW_USERNAME -s /bin/bash $NEW_USERNAME \
    && sudo passwd $NEW_USERNAME
    ```

    The system will prompt you to enter and confirm the password for the new user:

    ```text
    New password:
    Retype new password:
    passwd: password updated successfully
    ```

{% include [serial-console-os-dependency-warn](../../../_includes/compute/serial-console-os-dependency-warn.md) %}

## Connecting via the management console {#connect-via-console}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the VM instance resides in.
  1. Navigate to **{{ compute-name }}**.
  1. In the left-hand panel, select ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and select the VM instance from the list that opens.
  1. In the left-hand menu, select **{{ ui-key.yacloud.compute.instance.switch_console }}**.
  1. At the top of the screen, in the drop-down list, select the [serial port](../../concepts/serial-console.md#serial-ports) used by the serial console for VM connections.

      {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

  1. In the serial console window that opens, enter the username and password you set [earlier](#before-you-begin).

{% endlist %}

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

## Connecting using a standard SSH client {#connect-with-ssh-client}

{% note alert %}

{% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

{% endnote %}

Make sure you have the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) installed and configured on your machine.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

Your next steps depend on whether [{{ oslogin }}](../../../organization/concepts/os-login.md) access is enabled for the VM. With {{ oslogin }} access [enabled](../vm-connect/enable-os-login.md), you can connect to the serial console using the exported SSH certificate. To connect to VMs with {{ oslogin }} access disabled, use SSH keys.

{% list tabs group=os_login_type %}

- Connecting with an SSH key {#ssh-key}

  1. {% include [enable-metadata-serial-console-auth](../../../_includes/compute/enable-metadata-serial-console-auth.md) %}
  1. Connect to the VM's serial console:

      ```bash
      ssh -t \
        -p 9600 \
        -o IdentitiesOnly=yes \
        -i <path_to_private_SSH_key> \
        <VM_ID>.<username>.port=1@{{ serial-ssh-host }}
      ```

      Where:

      * `private_SSH_key_path`: Path to the private part of the [SSH key](../vm-connect/ssh.md#creating-ssh-keys) you use to access the VM.
      * `VM_ID`: VM ID.
      * `user_name`: Username for SSH connections, as stated in the VM metadata.
      * `port=1`: Number of the [serial port](../../concepts/serial-console.md#serial-ports) used by the serial console for VM connections.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created [earlier](#before-you-begin) to gain access to the VM instance.
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

- Using a certificate via {{ oslogin }} {#ssh-cert}

  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}
  1. [Export](../vm-connect/os-login-export-certificate.md) the {{ oslogin }} certificate by specifying your organization [ID](../../../organization/operations/organization-get-id.md):

      ```bash
      yc compute ssh certificate export \
        --organization-id <organization_ID>
      ```

      Result:

      ```text
      Identity: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername
      Certificate: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername-cert.pub
      ```

      The exported certificate is valid for one hour.
  1. Connect to the VM's serial console:

      ```bash
      ssh -t \
        -p 9600 \
        -i <SSH_certificate_path> \
        <VM_ID>.<OS_Login_username>.port=1@{{ serial-ssh-host }}
      ```

      Where:
      * `<SSH_certificate_path>`: Path to the SSH certificate (`Identity`) you exported earlier.
      * `<VM_ID>`: VM ID.
      * `<OS_Login_username>`: {{ oslogin }} username in the organization. You can find the {{ oslogin }} username at the end of the exported certificate name, after the organization [ID](../../../organization/operations/organization-get-id.md).

          You can also get the username using the `yc organization-manager os-login profile list` [{{ yandex-cloud }} CLI](../../../cli/cli-ref/organization-manager/cli-ref/oslogin/profile/list.md) command or in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}) in the user profile on the **{{ ui-key.yacloud_org.user.title_oslogin-profiles }}** tab.

          {% note info %}
          
          {% include [os-login-profile-tab-access-notice](../../../_includes/organization/os-login-profile-tab-access-notice.md) %}

          {% endnote %}

      * `port=1`: Number of the [serial port](../../concepts/serial-console.md#serial-ports) used by the serial console for VM connections.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created [earlier](#before-you-begin) to gain access to the VM instance.
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

{% endlist %}

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

## Connecting via the {{ yandex-cloud }} CLI {#connect-with-yc-cli}

{% note alert %}

{% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

{% endnote %}

Make sure you have the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) installed and configured on your machine.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

Your next steps depend on whether [{{ oslogin }}](../../../organization/concepts/os-login.md) access is enabled for the VM. With {{ oslogin }} access [enabled](../vm-connect/enable-os-login.md), you can connect to the serial console using short-lived SSH certificates. To connect to VMs with {{ oslogin }} access disabled, use SSH keys.

{% list tabs group=os_login_type %}

- Connecting with an SSH key {#ssh-key}

  1. See the description of the CLI command for connecting to a serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. {% include [enable-metadata-serial-console-auth](../../../_includes/compute/enable-metadata-serial-console-auth.md) %}
  1. Connect to the VM's serial console:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name> \
        --ssh-key <path_to_private_SSH_key> \
        --port 1
      ```

      Where:
      * `--instance-name`: VM name. Instead of the VM name, you can provide its ID in the `--instance-id` parameter.
      * `--ssh-key`: Path to the private key for SSH access to the VM, e.g., `~/.ssh/id_ed25519`.
      * `--port`: Number of the [serial port](../../concepts/serial-console.md#serial-ports) used by the serial console for VM connections.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created earlier to gain access to the VM instance.

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

- Using a certificate via {{ oslogin }} {#ssh-cert}

  1. See the description of the CLI command for connecting to a serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}
  1. Connect to the VM's serial console:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name> \
        --port 1
      ```

      Where:
      
      * `--instance-name`: VM name. Instead of the VM name, you can provide its ID in the `--instance-id` parameter.
      * `--port`: Number of the [serial port](../../concepts/serial-console.md#serial-ports) used by the serial console for VM connections.

          {% include [serial-console-default-port-linux](../../../_includes/compute/serial-console-default-port-linux.md) %}

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created earlier to gain access to the VM instance.

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).
  1. {% include [serial-console-endgame](../../../_includes/compute/serial-console-endgame.md) %}

{% endlist %}

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

## Troubleshooting connection issues {#troubleshooting-ssh}

* If you connect to the serial console and nothing appears on the screen:
    * Press **Enter**.
    * Restart the VM (for VMs created before February 22, 2019).
* If you get the `Warning: remote host identification has changed!` error when connecting with an SSH key, run the `ssh-keygen -R <VM_IP_address>` command.
* If you get the `Permission denied (publickey).` error when connecting with an SSH certificate, make sure {{ oslogin }} authorization is enabled on the VM for serial console connections and the certificate is valid. Enable {{ oslogin }} authorization on the VM for serial console connections or re-export the SSH certificate as required.
* If you get the `Connection closed by 2a0d:d6c1:0:**::*** port 9600` error when connecting using an SSH certificate, open the `known_hosts` file on your local machine and delete all lines that start with `[serialssh.cloud.yandex.net]:9600`. Then try connecting again and respond with `yes` to `Are you sure you want to continue connecting (yes/no/[fingerprint])?`.

#### See also {#see-also}

* [{#T}](../../concepts/serial-console.md)
* [{#T}](./index.md)
* [{#T}](./windows-sac.md)