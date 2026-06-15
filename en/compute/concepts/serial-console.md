---
title: Serial console in {{ compute-full-name }}
description: In this guide, you will learn about the serial console of a {{ compute-full-name }} virtual machine, how and why to use it, and the risks associated with it.
---

# VM serial console

{% include [sc-warning](../../_includes/compute/serial-console-warning.md) %}

The _serial console_ allows you to access a [virtual machine](./vm.md) no matter what state its [network](../../vpc/concepts/network.md#network) is in. The serial console operates based on the [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) interface and uses the Baseboard Management Controller (BMC) of the cloud server hosting the VM instance.

This means you can use the serial console for things like troubleshooting the virtual machine or access to it over SSH or [{{ oslogin }}](../../organization/concepts/os-login.md).

{% include [serial-console-roles](../../_includes/compute/serial-console-roles.md) %}

You can connect to the serial console of a Linux VM instance using the management console, standard SSH client, or {{ yandex-cloud }} CLI. For more information, see [{#T}](../operations/serial-console/connect-ssh.md).

You can connect to the serial console of a Windows VM instance using the management console or {{ yandex-cloud }} CLI. For more information, see [{#T}](../operations/serial-console/windows-sac.md).

Access to the VM serial console is disabled by default.

## Serial ports {#serial-ports}

{% include [serial-console-os-dependency-warn](../../_includes/compute/serial-console-os-dependency-warn.md) %}

You can use the serial console for connection to {{ compute-name }} VM instances via different [serial ports](https://en.wikipedia.org/wiki/Serial_port) (COM ports): `COM1`, `COM2`, `COM3`, or `COM4`.

The default, the serial ports used for the purpose are `COM1` (Linux) and `COM2` (Windows). To use a different port, configure it manually on your VM instance OS side.

## Security when using SSH {#security}

{% note info %}

{% include [key-without-password-alert](../../_includes/compute/key-without-password-alert.md) %}

{% endnote %}

For remote access, it is important to ensure protection against [MITM attacks](https://en.wikipedia.org/wiki/Man-in-the-middle_attack). You can achieve this using client/server encryption.

A secure connection can be established using the following methods:

* Before each connection to the VM, you can download the current [SHA256 fingerprint](https://{{ s3-storage-host }}/cloud-certs/serialssh-fingerprint.txt) of the SSH key.

    The first time you connect to a VM, the client shows the SSH key fingerprint and awaits confirmation to establish a connection:

    * `YES`: Establish a connection.
    * `NO`: Reject.

    Make sure the fingerprint from the link matches the fingerprint given by the client.
* Before each connection to the serial console, you can download the host's public [SSH key](https://{{ s3-storage-host }}/serialssh-certs/serialssh-knownhosts) (file named `serialssh-knownhosts`) and use it to connect.

    Recommended startup options:

    ```bash
    ssh \
      -o ControlPath=none \
      -o IdentitiesOnly=yes \
      -o CheckHostIP=no \
      -o StrictHostKeyChecking=yes \
      -o UserKnownHostsFile=./serialssh-knownhosts \
      -p 9600 \
      -i ~/.ssh/<private_SSH_key_name> \
      <VM_ID>.<username>@{{ serial-ssh-host }}
    ```

    
    
    The host's public SSH key can be changed later on.

Check the specified files often. Download them only via HTTPS but first make sure that the `https://{{ s3-storage-host }}` website has a valid certificate. If the website cannot guarantee secure encryption of your data due to certificate issues, your browser will display a warning.

#### See also {#see-also}

* [{#T}](../operations/serial-console/index.md)
* [{#T}](../operations/serial-console/connect-ssh.md)
* [{#T}](../operations/serial-console/windows-sac.md)