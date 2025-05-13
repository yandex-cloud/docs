---
title: How to connect a Linux VM with {{ oslogin }} to {{ backup-full-name }}
description: Follow this guide to connect a Linux VM with {{ oslogin }} to {{ backup-name }}.
---

# Connecting a Linux VM with {{ oslogin }} to {{ backup-name }}

You can back up {{ compute-name }} [VMs](../../compute/concepts/vm.md) with [supported Linux-based operating systems with {{ oslogin }}](../concepts/vm-connection.md#linux).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

If you have [deleted](delete-vm.md) a VM with {{ oslogin }} from {{ backup-name }} and want to reconnect it, follow the steps below.

To connect a Linux VM with {{ oslogin }} to {{ backup-name }}:

1. [Create](../../iam/operations/sa/create.md) a service account with the `backup.editor` [role](../security/index.md#backup-editor).
1. [Connect](../../compute/operations/vm-control/vm-connect-sa.md) the previously created service account to the VM.
1. [Set up](../concepts/vm-connection.md#vm-network-access) network access for your VM.
1. Install the {{ backup-name }} agent:

   {% list tabs group=instructions %}

   - {{ yandex-cloud }} CLI {#cli}

     1. {% include [cli-install](../../_includes/cli-install.md) %}
     1. See the description of the CLI command to install the {{ backup-name }} agent:

        ```bash
        yc backup agent install --help
        ```

     1. Run this command:

        ```bash
        yc backup agent install \
          --id <VM_ID> \
          --policy-ids <policy1_ID>[,<policy2_ID>]
        ```

        Where:

        * `id`: VM unique ID. This is a required setting.
        * `policy-ids`: IDs of the [backup policies](../concepts/policy.md) for attaching to the VM after installing the {{ backup-name }} agent. This is an optional parameter. Attaching a policy to a VM is an asynchronous operation which may take several minutes.

        Once you execute the command, you will get the {{ backup-name }} agent installation warning: `This command will launch commands on specified instance to install backup agent via oslogin. Do you confirm this actions to be executed? [Yes/no][y/N]`. Confirm the installation: in the terminal, type `yes` and press `Enter`. The {{ backup-name }} agent installation will start. It will take some time.

        Result:

        ```text
        ...
        Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
        ```

     1. (Optional) To view the {{ backup-name }} agent installation logs, run this command:

         ```bash
         yc backup agent debug-info \
           --id <VM_ID>
         ```

   {% endlist %}

To connect an existing VM to {{ backup-name }}, you can also [take](../../compute/operations/disk-control/create-snapshot.md) snapshots of the VM disks and [create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM based on those snapshots by selecting the backup option.

#### See also {#see-also}

* [{#T}](create-vm.md)
* [Linking a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./policy-vm/create.md)
* [{#T}](./backup-vm/recover.md)
