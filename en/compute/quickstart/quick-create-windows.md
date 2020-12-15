# Creating a Windows VM

Create a Windows [virtual machine](../concepts/vm.md) using {{ compute-short-name }} from the {{ yandex-cloud }} management console and connect to it.

## Before you start {#before-you-begin}

1. Log in to or register in the [management console](https://console.cloud.yandex.com). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page](https://console.cloud.yandex.com/billing), make sure you linked a [billing account](../../billing/concepts/billing-account.md), and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Creating VMs {#create-vm}

{% include [create-instance-via-console-windows](../_includes_service/create-instance-via-console-windows.md) %}

## Connecting to VMs {#connect-rdp}

{% include [vm-connect-rdp](../../_includes/vm-connect-rdp.md) %}

## Configuring the serial console {#serial-console}

Using the [serial console](../operations/serial-console/index.md), you can connect to a VM regardless of the network or OS state (for example, if there are RDP loading or access issues).

Make sure you configure access to the VM via the serial console in advance.

## Deleting VMs {#delete-vm}

If you no longer plan to use a virtual machine, [delete it](../operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

- Watch [tutorials for creating web services in {{ yandex-cloud }}](../../solutions/web/).
- Learn [how to create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
- Learn [how to use VMs](../operations/).
- Read [answers to frequently asked questions](../qa/general.md).