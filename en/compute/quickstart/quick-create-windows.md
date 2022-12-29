---
title: "Creating a Windows VM"
description: "Create a Windows instance in the cloud using {{ compute-short-name }}. You can connect to a Windows instance using the Remote Desktop Protocol (RDP) built into the OS image. Before connecting to a Windows instance, make sure that NLA is enabled in your desktop settings."
keywords:
  - windows
  - windows vm
  - windows instance
  - windows virtual machine
  - virtual machine instance
  - vm
---

# Creating a Windows VM

Create a Windows [VM](../concepts/vm.md) using {{ compute-short-name }} from the {{ yandex-cloud }} management console and connect to it.

{% include [ms-licensing-personal-data](../../_includes/ms-licensing-personal-data.md) %}

## Before you begin {#before-you-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
   {% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
   {% endif %}
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Create a VM {#create-vm}

{% include [create-instance-via-console-windows](../_includes_service/create-instance-via-console-windows.md) %}

## Reset the administrator password {#reset-admin-password}

The administrator password specified at the time of VM creation is saved as clear-text metadata, which is why we recommend replacing it with a newly generated password.

To reset a password:

{% include [vm-reset-password-windows-console](../../_includes/compute/vm-reset-password-windows-console.md) %}

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
