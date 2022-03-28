---
title: Creating a Windows virtual machine (VM)
description: Create a Windows virtual machine using {{ compute-short-name }} from the {{ yandex-cloud }} management console. You can connect to a Windows virtual machine (VM) using the Remote Desktop Protocol (RDP) built into the OS image. Before connecting to a Windows virtual machine (VM_, make sure that NLA is enabled in your computer's settings.
keywords:
  - windows
  - windows vm
  - windows virtual machine
---

# Creating a Windows VM

Create a Windows [VM](../concepts/vm.md) using {{ compute-short-name }} from the {{ yandex-cloud }} management console and connect to it.

{% include [ms-licensing-personal-data](../../_includes/ms-licensing-personal-data.md) %}

## Before you start {#before-you-begin}

1. Log in to [management console]({{ link-console-main }}) or sign up. If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}) make sure that you have enabled a [billing account](../../billing/concepts/billing-account.md) and that it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Create a VM {#create-vm}

{% include [create-instance-via-console-windows](../_includes_service/create-instance-via-console-windows.md) %}

## Connect to the VM {#connect-rdp}

{% include [vm-connect-rdp](../../_includes/vm-connect-rdp.md) %}

## Configure the serial console {#serial-console}

Using the [serial console](../operations/serial-console/index.md), you can connect to a VM regardless of the network or OS state (for example, if there are RDP loading or access issues).

Make sure you configure access to the VM via the serial console in advance.

## Delete the VM {#delete-vm}

If you no longer plan to use a virtual machine, [delete it](../operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

* Watch [tutorials for creating web services in {{ yandex-cloud }}](../../tutorials/web/index.md).
* Learn [how to create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
* Learn [how to use VMs](../operations/index.md).
* Read [answers to frequently asked questions](../qa/all.md).

