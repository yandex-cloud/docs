# Connecting to a VM's serial console via SSH

After [enabling access](index.md), you can connect to the serial console to work with the VM. Before connecting to the serial console, carefully read the section [#T](#security).

## Security {#security}

{% note warning %}

Serial console access is not secure, so enabling it might allow hackers to access your VM. [Disable](disable.md) access after you finish working with the serial console.

{% endnote %}

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

    ```bash
    $ ssh -o ControlPath=none -o IdentitiesOnly=yes -o CheckHostIP=no -o StrictHostKeyChecking=yes -o UserKnownHostsFile=./serialssh-knownhosts -p 9600 -i ~/.ssh/<secret key name> <VM ID>.<user name>@serialssh.cloud.yandex.net
    ```

    The host's public key may be changed in the future.

Check the specified files often. Download these files only via HTTPS after verifying the validity of the `https://storage.yandexcloud.net` website certificate. If the website cannot securely encrypt your data  due to certificate problems, the browser will warn you about that.

## Connecting to the serial console

{% note info %}

How the serial console works depends on the operating system settings. Yandex Compute Cloud provides a communication channel between the user and the COM port on the VM, but it does not guarantee that the console will work correctly on the operating system.

{% endnote %}

To connect to the VM, you must use its ID. To get the ID, read [#T](../vm-info/get-info.md).

Connection command example:

```bash
$ ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/<private key name> <username>@serialssh.cloud.yandex.net
```

Example with `yc-user` and the virtual machine with the ID `fhm0b28lgfp4tkoa3jl6`:

```bash
$ ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_rsa fhm0b28lgfp4tkoa3jl6.yc-user@serialssh.cloud.yandex.net
```

The  `yc-user` user is generated automatically when the VM is being created. For more information, see [#T](../vm-create/create-linux-vm.md).

#### Troubleshooting

- If you connect to the serial console and nothing appears on the screen:
    - Press `Enter`.
    - Restart the VM (for virtual machines created before February 22).
- If the system requests user data to provide access to the VM, enter the login and password.
- If you see the error `Warning: remote host identification has changed!` when connecting to the VM, run `ssh-keygen -R <IP address of VM>`.

## Disconnecting from the serial console

To disconnect from the serial console:

1. Press `Enter`.
1. Enter the following characters in order: `~.`.