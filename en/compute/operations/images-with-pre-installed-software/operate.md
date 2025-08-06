---
title: Working with a VM
description: This article describes how to work with a VM created from a public image in {{ yandex-cloud }}. Let's consider operations like connecting to a VM using an SSH key pair, generating an SSH key pair on Linux/macOS, Windows 7, 8, 10, connecting to a VM via {{ oslogin }}, using SSL certificates, network traffic filtering, and installing updates.
---

# Working with a VM created from a public image

## Connecting to a VM {#ways-to-connect}

You can connect to a [virtual machine](../../concepts/vm.md) via SSH using an SSH key pair, [via {{ oslogin }}](../vm-connect/os-login.md), or via the [serial console](../serial-console/index.md).

### Connecting over SSH {#connect}

This method for connecting to a VM uses an SSH key pair: the public key resides on the VM, while the private one is kept by the user. Connecting with a key pair is more secure than with a username and password.

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

#### Creating an SSH key pair {#creating-ssh-keys}

{% list tabs group=operating_system %}

- Management console {#console}

  {% include [vm-ssh-prepare-key-console](../../../_includes/vm-ssh-prepare-key-console.md) %}

- Linux/macOS {#linux-macos}

  {% include [vm-ssh-prepare-key-linux-macos](../../../_includes/vm-ssh-prepare-key-linux-macos.md) %}

- Windows 10/11 {#windows}

  {% include [vm-ssh-prepare-key-win-10-11](../../../_includes/vm-ssh-prepare-key-win-10-11.md) %}

- Windows 7/8 {#windows7-8}

  {% include [vm-ssh-prepare-key-win-7-8](../../../_includes/vm-ssh-prepare-key-win-7-8.md) %}

{% endlist %}

#### Connecting using an SSH key pair {#vm-connect}

{% include [vm-connect-ssh-keys](../../../_includes/vm-connect-ssh-keys.md) %}

### Connecting via {{ oslogin }} {#os-login-connect}

{% include [vm-connect-ssh-login](../../../_includes/vm-connect-ssh-login.md) %}

## Passwords for pre-installed software {#logins-passwords}

In addition to OS distributions, {{ marketplace-name }} offers public images with pre-installed software. To get passwords to configure the pre-installed software in such images:

1. Connect to the VM.

1. You can find passwords for pre-installed software in the `/root/default_passwords.txt` file. Only a superuser has read and write permissions for the file. Get a list of passwords using this command:

   ```bash
   sudo cat /root/default_passwords.txt
   ```

If a public VM image has no pre-installed software, there will be no password file provided.

## Using SSL {#ssl}

To use SSL, generate an SSL certificate and configure the web server to use it.

To [create](../../../certificate-manager/operations/managed/cert-create.md) an SSL certificate, use [{{ certificate-manager-full-name }}](../../../certificate-manager/). You can [export](../../../certificate-manager/operations/managed/cert-get-content.md) the certificate and use it on the web server.

## Filtering network traffic {#network-filter}

On VMs created from public images, only the ports required for configuring and running pre-installed software are open.

You can view a list of open ports for a particular VM when [connecting to it using an SSH key pair](../vm-connect/ssh.md). To open additional ports, use `iptables`.

At the [cloud network](../../../vpc/concepts/network.md#network) level, [security groups](../../../vpc/concepts/security-groups.md) are used to filter the network traffic. To allow specific traffic for a VM at the network level, [configure](../../../vpc/operations/security-group-add-rule.md) a security group and [link](../vm-control/vm-change-security-groups-set.md) it to the VM.

## Installing updates {#updates}

VMs created from public images do not feature automatic updates for their operating system or software. You can update them manually.