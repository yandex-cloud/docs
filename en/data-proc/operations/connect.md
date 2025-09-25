---
title: How to connect to a {{ dataproc-full-name }} cluster
description: Follow this guide to connect to a {{ dataproc-name }} cluster.
---

# Connecting to a {{ dataproc-name }} cluster

After creating a {{ dataproc-name }} cluster, you can connect to subcluster hosts:

* Over the internet, if you have public access configured for your subcluster.
* From a {{ yandex-cloud }} [virtual machine](../../compute/operations/vm-create/create-linux-vm.md) located on the same cloud network.

To connect to your cluster:

1. [Configure security groups](security-groups.md).
1. [Get the host FQDN](fqdn.md).
1. Connect to the host using one of these methods:
    * [Over SSH](connect-ssh.md).
    * Via {{ oslogin }} using a [standard SSH client](connect-oslogin.md#os-login-ssh) or [{{ yandex-cloud }} CLI](connect-oslogin.md#os-login-cli).
    * [From graphical IDEs](connect-ide.md).
