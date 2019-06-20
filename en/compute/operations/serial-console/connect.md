# Connecting to a VM's serial console via SSH

After [enabling access](index.md), you can connect to the serial console to interact with the VM. Before connecting to the serial console, carefully read the section [#T](#security).

## Security {#security}

{% note important %}

Enabled access to the serial console is not secure: hackers may get access to your VM. Disable access after you finish working with the serial console. In metadata, set the parameter `serial-port-enable=0`.

{% endnote %}

For remote access, it is important to ensure protection against [MITM attacks](https://en.wikipedia.org/wiki/Man-in-the-middle_attack). To do that, you can use client/server encryption.

Set up a secure connection in one of the following ways:

- You can download the current [SHA256 Fingerprint](https://storage.yandexcloud.net/cloud-certs/serialssh-fingerprint.txt) of the key before each connection to the VM.

    The first time you connect to the VM, the client sends the key fingerprint to the server and awaits a decision on establishing a connection:

    - YES: establish the connection.
    - NO: reject.

    Make sure the fingerprint from the link matches the fingerprint received from the client.

- You can download the public [key](https://storage.yandexcloud.net/cloud-certs/serialssh-knownhosts) of the host before each connection to the serial console.

    Use the received public key when connecting to the serial console.

    Recommended startup options:

    ```bash
    $ ssh -o ControlPath=none -o IdentitiesOnly=yes -o CheckHostIP=no -o StrictHostKeyChecking=yes -o UserKnownHostsFile=./serialssh-knownhosts -p 9600 -i ~/.ssh/<secret key name> <VM ID>.<user name>@serialssh.cloud.yandex.net
    ```

    The host's public key may be changed in the future.

Check the specified files often. Download these files only via HTTPS after verifying the validity of the `https://storage.yandexcloud.net` website certificate. If the website cannot securely encrypt your data  due to certificate problems, the browser will warn you about that.

## Connecting to a serial console

To connect to the serial console:

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Get a list of VMs in the default folder:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Select the `ID` of the appropriate VM (for example, `fhm0b28lgfp4tkoa3jl6`).
  
  1. Connect to the serial console:
  
      ```bash
      $ ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/<secret key name> <VM ID>.<user name>@serialssh.cloud.yandex.net
      ```
  
      Example for `yc-user`:
  
      ```bash
      $ ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_rsa fhm0b28lgfp4tkoa3jl6.yc-user@serialssh.cloud.yandex.net
      ```
  
  Access to the serial console is provided to users with `serial-port-enable=1` parameter in metadata and SSH key authentication configured:
  
  - If nothing appears on the screen after you connect to the serial console, press `Enter`. If the problem persists, restart the VM.
  - If the system requests user data to provide access to the VM, enter the login and password.
  - If you see the error `Warning: remote host identification has changed!` when connecting to the VM, run `ssh-keygen -R <IP address of VM>`.
  
{% endlist %}

## Disconnecting from the serial console

To disconnect from the serial console:

1. Press `Enter`.
1. Sequentially enter the characters: `~.`.

