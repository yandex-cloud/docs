# Connecting to a VM serial console via SSH

{% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

After [enabling access](./index.md), you can connect to the serial console to interact with the [VM](../../concepts/vm.md). Before connecting to the serial console, carefully read the [security](#security) section.

## Security {#security}

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

For remote access, it is important to ensure protection against [MITM attacks](https://en.wikipedia.org/wiki/Man-in-the-middle_attack). To do that, you can use client/server encryption.

To establish a secure connection, you can use the following methods:
* Download the current [SHA256 fingerprint](https://{{ s3-storage-host }}/cloud-certs/serialssh-fingerprint.txt) of the SSH key before each VM connection.

  The first time you connect to a VM, the client shows the SSH key fingerprint and awaits confirmation to establish a connection:
  * `YES`: Establish a connection.
  * `NO`: Reject.

  Make sure the fingerprint from the link matches the fingerprint given by the client.
* Download the host's public [SSH key](https://{{ s3-storage-host }}/serialssh-certs/serialssh-knownhosts) before each serial console connection.

  Use the public SSH key you got when connecting to the serial console.

  Recommended startup options:

  ```bash
  ssh -o ControlPath=none -o IdentitiesOnly=yes -o CheckHostIP=no -o StrictHostKeyChecking=yes -o UserKnownHostsFile=./serialssh-knownhosts -p 9600 -i ~/.ssh/<private_SSH_key_name> <VM_ID>.<username>@{{ serial-ssh-host }}
  ```

  The host's public SSH key may be changed in the future.

Regularly check the specified files. Download them only via HTTPS after verifying the validity of the `https://{{ s3-storage-host }}` website certificate. If the website cannot securely encrypt your data due to certificate issues, your browser will display a warning.

## Connecting to a serial console {#connect-to-serial-console}

{% note info %}

How a serial console works depends on how the operating system is set up. {{ compute-name }} provides a communication channel between the user and the VM COM port; however, it does not guarantee that the console works properly on your OS.

{% endnote %}

To connect to a VM, you need its ID. For info on how to get the VM ID, see [{#T}](../vm-info/get-info.md).

Your next steps depend on whether [{{ oslogin }}](../../../organization/concepts/os-login.md) access is enabled for the VM. With OS Login access [enabled](../vm-connect/enable-os-login.md), you can connect to the serial console using the exported SSH certificate. SSH keys are used to connect to VMs with {{ oslogin }} access disabled.

Some operating systems may prompt you for your user credentials to access the VM. So, before connecting to the serial console of VMs running on such systems, create a local user password.

{% list tabs %}

- With an SSH key

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a local user password on the VM:
      1. [Connect](../vm-connect/ssh.md) to the VM via SSH.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Disconnect from the VM. To do this, enter the `logout` command.

  1. {% include [enable-metadata-serial-console-auth](../../../_includes/compute/enable-metadata-serial-console-auth.md) %}

  1. Connect to the VM.

      Here is a connection command example:

      ```bash
      ssh -t -p 9600 -o IdentitiesOnly=yes -i <path_to_private_SSH_key> <VM_ID>.<username>@{{ serial-ssh-host }}
      ```

      Where: 
      * `private_SSH_key_path`: Path to the private part of the [SSH key](../vm-connect/ssh.md#creating-ssh-keys) obtained when [creating the VM](../vm-create/create-linux-vm.md).
      * `VM_ID`: VM ID. For info on how to get the VM ID, see [{#T}](../vm-info/get-info.md).
      * `username`: Admin name specified when creating the VM.

      ```bash
      ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519 fhm0b28lgfp4********.yc-user@{{ serial-ssh-host }}
      ```

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created earlier to gain access to the serial console.

- With an SSH certificate via {{ oslogin }}

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a local user password on the VM:
      1. [Connect](../vm-connect/os-login.md) to the VM via {{ oslogin }}.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Disconnect from the VM. To do this, enter the `logout` command.

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

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

  1. Connect to the VM.

      Here is a connection command example:

      ```bash
      ssh -t -p 9600 -i <SSH_certificate_path> <VM_ID>.<OS_Login_username>@{{ serial-ssh-host }}
      ```

      Where:
      * `<SSH_certificate_path>`: Path to the exported SSH certificate, the value of the `Identity` field.
      * `<VM_ID>`: ID of the virtual machine whose serial console you want to connect to.
      * `<OS_Login_username>`: {{ oslogin }} user ID in the organization. You can find the {{ oslogin }} username at the end of the exported certificate name, after the organization [ID](../../../organization/operations/organization-get-id.md).

          You can also get the username using the `yc organization-manager os-login profile list` [{{ yandex-cloud }} CLI](../../../cli/cli-ref/organization-manager/cli-ref/oslogin/profile/list.md) command or in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}) in the user profile on the **{{ ui-key.yacloud_org.page.user.title_tab-os-login }}** tab.

          {% include [os-login-profile-tab-access-notice](../../../_includes/organization/os-login-profile-tab-access-notice.md) %}

      Example for a user with the `yid-orgusername` username and a VM with the `epd22a2tj3gd********` ID:

      ```bash
      ssh -p 9600 -i /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername epd22a2tj3gd********.yid-orgusername@{{ serial-ssh-host }}
      ```

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created earlier to gain access to the serial console.

{% endlist %}

You can also connect to the serial console using [SSH keys for other users](../vm-connect/ssh.md#vm-authorized-keys).


### Troubleshooting {#troubleshooting}

* If you connect to the serial console and nothing appears on the screen:
  * Press **Enter**.
  * Restart the VM (for VMs created before February 22, 2019).
* If you get the `Warning: remote host identification has changed!` error when connecting with an SSH key, run the `ssh-keygen -R <VM_IP_address>` command.
* If you get the `Permission denied (publickey).` error when connecting with an SSH certificate, make sure {{ oslogin }} authorization is enabled on the VM for serial console connections and the certificate is valid. Enable {{ oslogin }} authorization on the VM for serial console connections or re-export the SSH certificate as required.
* If you get the `Connection closed by 2a0d:d6c1:0:**::*** port 9600` error when connecting using an SSH certificate, open the `known_hosts` file on your local machine and delete all lines that start with `[serialssh.cloud.yandex.net]:9600`. Then try connecting again and respond with `yes` to `Are you sure you want to continue connecting (yes/no/[fingerprint])?`.


## Disconnecting from a serial console {#turn-off-serial-console}

To disconnect from a serial console:
1. Press **Enter**.
1. Enter `~.` in succession.