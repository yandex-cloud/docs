---
title: "Working with VMs"
description: "This tutorial describes how to work with a VM from a public image in {{ yandex-cloud }}. Find out how to perform operations, such as connecting to a VM using an SSH key pair, generating an SSH key pair on Linux/MacOS, Windows 7, 8, 10, connecting to a VM via OS Login, using SSL certificates, filtering network traffic, and installing updates."
---

# Working with a VM from a public image

## Connecting to a VM {#ways-to-connect}

You can connect to a [virtual machine](../../concepts/vm.md) via SSH using an SSH key pair, [via OS Login](../vm-connect/os-login.md), or using a username and password.

### Connecting via SSH {#connect}

This method for connecting to a virtual machine uses an SSH key pair: the public key resides on the VM, while the private one is kept by the user. Connecting with a key pair is more secure than with a username and password.

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

#### Creating an SSH key pair {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

#### Connecting using an SSH key pair {#vm-connect}

{% include [vm-connect-ssh-keys](../../../_includes/vm-connect-ssh-keys.md) %}

### Connecting via OS Login {#os-login-connect}

{% include [vm-connect-ssh-login](../../../_includes/vm-connect-ssh-login.md) %}

### Connecting using your username and password {#logins-passwords}

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

To get usernames and passwords for VMs from public images, use the following command:

```
sudo cat /root/default_passwords.txt
```

If password authentication is not supported, you will not get a file with passwords.

## Using SSL {#ssl}

To use SSL, generate an SSL certificate yourself and configure the web server to use it.

To [create](../../../certificate-manager/operations/managed/cert-create.md) an SSL certificate, you can use [{{ certificate-manager-full-name }}](../../../certificate-manager/). You can [export](../../../certificate-manager/operations/managed/cert-get-content.md) the certificate and use it on the web server.

## Filtering network traffic {#network-filter}

On public image-based VMs, only those ports are open which are required for the configuration and operation of the pre-installed software.

You can view a list of open ports for a particular VM when [connecting to it using an SSH key pair](../vm-connect/ssh.md). To open additional ports, use the `iptables` utility.

At the [cloud network](../../../vpc/concepts/network.md#network) level, [security groups](../../../vpc/concepts/security-groups.md) are used to filter the network traffic. To allow specific traffic for a virtual machine at the network level, [configure](../../../vpc/operations/security-group-add-rule.md) a security group and [associate](../vm-control/vm-change-security-groups-set.md) it with the VM.

## Install updates {#updates}

On public image-based VMs, the OS and software are not updated automatically. You can update them on your own.