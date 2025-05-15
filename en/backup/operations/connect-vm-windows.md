---
title: How to connect a Windows Server VM to {{ backup-full-name }}
description: Follow this guide to connect a Windows Server VM to {{ backup-name }}.
---

# Connecting an existing Windows Server VM to {{ backup-name }}

You can back up your {{ compute-name }} [VMs](../../compute/concepts/vm.md) with [supported Windows-based operating systems](../concepts/vm-connection.md#windows).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

If you have [deleted](delete-vm.md) a VM from {{ backup-name }} and want to reconnect it, follow the steps below.

To connect a Windows VM to {{ backup-name }}:

1. [{#T}](#create-sa).
1. [{#T}](#connect-sa-to-vm).
1. [{#T}](#configure-network-access).
1. [{#T}](#connect-vm).


## Create a service account {#create-sa}

{% include [create-sa-backup-editor](../../_includes/backup/operations/create-sa-backup-editor.md) %}


## Link a service account to the VM {#connect-sa-to-vm}

{% include [connect-sa-to-vm](../../_includes/backup/operations/connect-sa-to-vm.md) %}


## Set up network access for the VM {#configure-network-access}

### Create a security group {#create-sg}

{% include [create-sg](../../_includes/backup/operations/create-sg.md) %}


### Configure the VM network interface {#configure-vm}

{% include [configure-vm](../../_includes/backup/operations/configure-vm.md) %}


## Install the {{ backup-name }} agent {#connect-vm}

1. [Connect to the VM via RDP](../../compute/operations/vm-connect/rdp.md).
1. Run Windows PowerShell.

    {% include [ps-note](../../_includes/backup/ps-note.md) %}

1. Run the following command:

    ```powershell
    . { iwr -useb https://{{ s3-storage-host }}/backup-distributions/agent_installer.ps1 } | iex
    ```

    Result:

    ```text
    ...
    Backup agent installation complete after 190 s!
    ```

After that, you can link your VM to [backup policies](../concepts/policy.md).


#### See also {#see-also}

* [{#T}](create-vm.md)
* [Linking a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
