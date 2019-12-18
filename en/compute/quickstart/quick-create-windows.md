# Creating a Windows VM

Create a Windows [virtual machine](../concepts/vm.md) using {{ compute-short-name }} from the Yandex.Cloud management console and connect to it.

## Before you start {#before-you-begin}

1. Log in to or register in the [management console](https://console.cloud.yandex.com). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page](https://console.cloud.yandex.com/billing), make sure you linked a [payment account](../../billing/concepts/billing-account.md), and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Creating VMs {#create-vm}

{% include [create-instance-via-console-windows](../_includes_service/create-instance-via-console-windows.md) %}

{% include [initialization-windows-vm](../../_includes/initialization-windows-vm.md) %}

## Connecting to VMs {#connect-rdp}

{% include [vm-connect-rdp](../../_includes/vm-connect-rdp.md) %}

## Delete VMs {#delete-vm}

If you no longer plan to use a virtual machine, [delete it](../operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

- Watch [tutorials for creating web services in Yandex.Cloud](../../solutions/web/).
- Learn [how to create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
- Learn [how to use VMs](../operations/).
- Read [answers to frequently asked questions](../qa/general.md).

