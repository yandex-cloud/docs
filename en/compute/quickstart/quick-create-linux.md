---
title: "Creating a Linux VM"
description: "Create a Linux instance in the cloud using {{ compute-name }}. You can connect to a Linux instance over SSH\_using the console or\_the PuTTY program. To connect to the Linux instance, specify its public address."
keywords:
  - linux
  - linux vm
  - linux instance
  - linux virtual machine
  - virtual machine instance
  - vm
---

# Creating a Linux VM

Create a Linux [VM](../concepts/vm.md) using {{ compute-name }} from the {{ yandex-cloud }} management console and connect to it.

## Getting started {#before-you-begin}

{% include [before-you-begin-linux](../../_includes/compute/before-you-begin-linux.md) %}

## Create a VM {#create-vm}

{% include [create-instance-via-console-linux](../_includes_service/create-instance-via-console-linux.md) %}

## Connect to the VM {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Configure the serial console {#serial-console}

Using the [serial console](../operations/serial-console/index.md), you can connect to a VM regardless of the [network](../../vpc/concepts/network.md#network) or OS state (for example, if there are loading or SSH access issues).

Make sure you configure access to the VM via the serial console in advance.

## Delete the VM {#delete-vm}

If you no longer plan to use a virtual machine, [delete it](../operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

* Watch [tutorials for creating web services in {{ yandex-cloud }}](../../tutorials/web/index.md).
* Learn [how to use VMs](../operations/index.md).
* Learn [how to create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
* Read [answers to frequently asked questions](../qa/general.md).