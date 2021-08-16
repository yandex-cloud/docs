---
title: Creating a Linux virtual machine (VM)
description: Create a Linux virtual machine using {{ compute-name }} from the {{ yandex-cloud }}. You can connect to a Linux virtual machine via ssh tool or PuTTY. Specify Linux virtual machine public address.
keywords:
  - linux
  - linux vm
  - linux virtual machine
---

# Creating a Linux VM

Create a Linux [virtual machine](../concepts/vm.md) using {{ compute-name }} from the {{ yandex-cloud }} management console and connect to it.

## Before you start {#before-you-begin}

{% include [before-you-begin-linux](../../_includes/compute/before-you-begin-linux.md) %}

## Creating VMs {#create-vm}

{% include [create-instance-via-console-linux](../_includes_service/create-instance-via-console-linux.md) %}

## Connecting to VMs {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Configuring the serial console {#serial-console}

Using the [serial console](../operations/serial-console/index.md), you can connect to a VM regardless of the network or OS state (for example, if there are SSH loading or access issues).

Make sure you configure access to the VM via the serial console in advance.

## Deleting VMs {#delete-vm}

If you no longer plan to use a virtual machine, [delete it](../operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

* Watch [tutorials for creating web services in {{ yandex-cloud }}](../../solutions/web/).
* Learn [how to use VMs](../operations/).
* Learn [how to create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
* Read [answers to frequently asked questions](../qa/general.md).