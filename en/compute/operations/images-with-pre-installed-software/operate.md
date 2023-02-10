---
title: "Working with a virtual machine"
description: "The article describes how to work with a virtual machine based on a public image in Yandex Cloud. Let's consider such operations as connecting to a virtual machine using SSH, creating a key pair via SSH in Linux/MacOS, Windows 7,8,10, using SSL certificates, filtering network traffic, and installing updates."
---

# Working with a VM based on a public image

## Connecting via SSH {#connect}

{% include [vm-connect-ssh](../../../_includes/vm-connect-ssh.md) %}

## Connecting using your login and password {#logins-passwords}

You can connect to a VM with your login and password when it is started.

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

To get logins and passwords for VMs based on public images, use the following command:

```
sudo cat /root/default_passwords.txt
```

If password authentication is not supported, there won't be a file with passwords.

## Using SSL {#ssl}

To use SSL, generate an SSL certificate yourself and configure the web server to work with it.

## Filtering network traffic {#network-filter}

On public image-based VMs, only those ports are open which are required for the configuration and operation of the pre-installed software.

You can view a list of open ports for a particular VM when [connecting to it over SSH](../vm-connect/ssh.md). To open additional ports, use the `iptables` utility.

## Install updates {#updates}

On public image-based VMs, the OS and software are not updated automatically. You can update them on your own.

