---
title: How to update a connection of a Linux VM with OS Login to {{ backup-full-name }}
description: Follow this guide to update a connection of a Linux VM with OS Login to {{ backup-full-name }}.
---

# Updating a connection of a Linux VM with OS Login to {{ backup-name }}

{% note info %}

If you have [deleted](delete-vm.md) a VM from {{ backup-name }} and want to reconnect it to the service, use this guide:

* [Connecting a Linux VM](connect-vm-linux.md)
* [Connecting a Linux VM with OS Login](connect-vm-oslogin-linux.md)

{% endnote %}

After [restoring a VM from a backup of another VM](./backup-vm/non-native-recovery.md), the source VM the backup was created from becomes outdated.

To avoid conflicts between the two VMs when making backups, update the outdated VM's connection to {{ backup-name }}:

1. Reconnect to {{ backup-name }} from the outdated VM:

   {% list tabs group=instructions %}

   - {{ yandex-cloud }} CLI {#cli}

     1. {% include [cli-install](../../_includes/cli-install.md) %}
     1. See the description of the CLI command to reinstall the {{ backup-name }} agent:

        ```bash
        yc backup agent reinstall --help
        ```

     1. Run this command:

        ```bash
        yc backup agent reinstall \
          --id <VM_ID>
        ```

        Where `id` is the unique ID of the VM. This is a required parameter.

        After running the command, you will get a warning about backup agent reinstallation: `This command will launch commands on specified instance to reinstall backup agent via oslogin. Do you confirm this actions to be executed? [Yes/no][y/N]`. Confirm the reinstallation: in the terminal, type `yes` and press `Enter`. The agent reinstallation will start. It will take some time.

        Result:

        ```text
        ...
        Deleting old resource bound for instance_id epdoe4g6dbq4******** and resource_id: F07543A1-BDC1-415A-A143-C18E********
        Updating ids in {{ backup-name }}
        Finished
        ```

     1. (Optional) To view the {{ backup-name }} agent installation logs, run this command:

        ```bash
        yc backup agent debug-info \
          --id <VM_ID>
        ```

   {% endlist %}

1. Make sure the outdated VM is no longer on the list of VMs connected to {{ backup-name }}:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where {{ backup-name }} is connected.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
     1. On ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}** tab, check that the outdated VM is not listed with the ![irrelevant](../../_assets/console-icons/circle-info-fill.svg) label.

        If the VM is still there, click ![image](../../_assets/console-icons/ellipsis.svg), select **{{ ui-key.yacloud.common.delete }}** and confirm deletion.

   {% endlist %}

1. [Link](./policy-vm/update.md#update-vm-list) your VM to a backup policy.
