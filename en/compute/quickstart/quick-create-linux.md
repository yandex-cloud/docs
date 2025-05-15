---
title: Creating a Linux VM
description: Create a Linux VM in Yandex Cloud using {{ compute-name }}. You can access a Linux VM over SSH using the console or PuTTY. To connect to a Linux VM, specify its public address.
keywords:
  - linux
  - linux vm
  - linux instance
  - linux virtual machine
  - virtual machine
  - vm
---

# Creating a Linux VM

Create a Linux [VM](../concepts/vm.md) in the {{ yandex-cloud }} management console using {{ compute-name }} and connect to it.

{% include [role-note](../../_includes/compute/role-note.md) %}

## Getting started {#before-you-begin}

{% include [before-you-begin-linux](../../_includes/compute/before-you-begin-linux.md) %}

## Create a VM {#create-vm}

{% include [create-instance-via-console-linux](../_includes_service/create-instance-via-console-linux.md) %}

## Connect to the VM {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Configure the serial console {#serial-console}

A [serial console](../operations/serial-console/index.md), enables accessing a VM regardless of the [network](../../vpc/concepts/network.md#network) or OS state, when experiencing boot or SSH access issues.

Make sure you configure access to the VM via the serial console in advance.

## Delete the VM {#delete-vm}

If you no longer plan to use the VM, [delete it](../operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

* Check out [tutorials for creating web services in {{ yandex-cloud }}](../../tutorials/applied/index.md#web).
* Learn [how to use VMs](../operations/index.md).
* Learn [how to create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
* Read [answers to frequently asked questions](../qa/general.md).