# Connecting to a VM's serial console via SSH

After [enabling access](./index.md), you can connect to the serial console to work with the VM. Before connecting to the serial console, carefully read the [{#T}](#security).

## Security {#security}

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

For remote access, it is important to ensure protection against [MITM attacks](https://en.wikipedia.org/wiki/Man-in-the-middle_attack). To do that, you can use client/server encryption.

To set up a secure connection:

- You can download the current [SHA256 Fingerprint](https://storage.yandexcloud.net/cloud-certs/serialssh-fingerprint.txt) of the key before each connection to the VM.

   The first time you connect to the VM, the client sends the key fingerprint to the server and awaits a decision on establishing a connection:

   - YES: establish the connection.
   - NO: reject.

   Make sure the fingerprint from the link matches the fingerprint received from the client.

- You can download the public [key](https://storage.yandexcloud.net/cloud-certs/serialssh-knownhosts) of the host before each connection to the serial console.

   Use the received public key when connecting to the serial console.

   Recommended startup options:

   {% if product == "yandex-cloud" %}```bash
   ssh -o ControlPath=none -o IdentitiesOnly=yes -o CheckHostIP=no -o StrictHostKeyChecking=yes -o UserKnownHostsFile=./serialssh-knownhosts -p 9600 -i ~/.ssh/<private key name> <VM ID>.<username>@serialssh.cloud.yandex.net
   ```{% endif %}
   
   {% if product == "cloud-il" %}```bash
   ssh -o ControlPath=none -o IdentitiesOnly=yes -o CheckHostIP=no -o StrictHostKeyChecking=yes -o UserKnownHostsFile=./serialssh-knownhosts -p 9600 -i ~/.ssh/<private key name> <VM ID>.<username>@serialssh.cloudil.co.il
   ```{% endif %}
   
   You can change the host's public key later.
   
   
Check the specified files often. Download these files only via HTTPS after verifying the validity of the `https://{{ s3-storage-host }}` website certificate. If the website cannot securely encrypt your data  due to certificate problems, the browser will warn you about that.

## Connecting to the serial console {#connect-to-serial-console}

{% note info %}

How the serial console works depends on the operating system settings. {{ compute-full-name }} provides a communication channel between the user and COM port on the VM, but it doesn't guarantee that the console works properly on the operating system.

{% endnote %}

To connect to the VM, you must use its ID. For more information about how to get the ID of a VM, see [{#T}](../vm-info/get-info.md).

Connection command example:

{% if product == "yandex-cloud" %}```bash
ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/<private key name> <VM ID>.<username>@serialssh.cloud.yandex.net
```{% endif %}

{% if product == "cloud-il" %}```bash
ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/<private key name> <VM ID>.<username>@serialssh.cloudil.co.il
```{% endif %}

Example for `yc-user` and the VM with the ID `fhm0b28lgfp4tkoa3jl6`:

{% if product == "yandex-cloud" %}```bash
ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519 fhm0b28lgfp4tkoa3jl6.yc-user@serialssh.cloud.yandex.net
```{% endif %}

{% if product == "cloud-il" %}```bash
ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519 fhm0b28lgfp4tkoa3jl6.yc-user@serialssh.cloudil.co.il
```{% endif %}

The `yc-user` user is created automatically when creating the VM. Learn more in [{#T}](../vm-create/create-linux-vm.md).

### Troubleshooting {#troubleshooting}

* If nothing appears on the screen after you connect to the serial console:

    * Press **Enter**.
    * Restart the VM (for VMs created before February 22, 2019).

* If the system requests user data to provide access to the VM, enter the login and password.

    * On a Linux VM, set a user password first. Run `sudo passwd <username>`. For more information, see [Getting started with the serial console](./index.md#linux-configuration).
    * On a Windows VM, enter your username, domain (VM name), and password. For more information, see [Starting your terminal in the Windows serial console (SAC)](./windows-sac.md).

* If you see an error saying `Warning: remote host identification has changed!` when connecting to the VM, run `ssh-keygen -R <IP address of VM>`.

## Disconnecting from the serial console {#turn-off-serial-console}

To disconnect from the serial console:

1. Press **Enter**.
1. Sequentially enter the characters: `~.`.

