# Updating a VM connection to {{ backup-name }}

After [restoring a VM from a backup of another VM](./backup-vm/non-native-recovery.md), the source VM the backup was created from becomes outdated.

To avoid conflicts between the two VMs when making backups, update the outdated VM's connection to {{ backup-name }}:

1. Reconnect to {{ backup-name }} from the outdated VM:

   {% list tabs group=operating_system %}

   - Linux {#linux}

      1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
      1. Install the [jq](https://jqlang.github.io/jq/), [awk](http://awklang.org/), [curl](https://curl.se/), and [uuidgen](https://uuidgen.org/) utilities on the VM:

          {% note info %}

          If you use a distribution other than Ubuntu, install the specified utilities using your package manager commands.

          {% endnote %}

          ```bash
          sudo apt install jq
          sudo apt install gawk
          sudo apt install curl
          sudo apt install uuid-dev
          ```

          If you use the Astra Linux distribution, you also need to install the uuid-runtime package:

          ```bash
          sudo apt install uuid-runtime
          ```

      1. Run this command:

          ```bash
          curl 'https://storage.yandexcloud.net/backup-distributions/agent_reinit.sh' | sudo bash
          ```

          Result:

          ```text
          ...
          Deleting old resource bound for instance_id epdoe4g6dbq4******** and resource_id: F07543A1-BDC1-415A-A143-C18E********
          Updating ids in {{ backup-name }}
          Finished
          ```

   - Windows {#windows}

      1. [Connect](../../compute/operations/vm-connect/rdp.md) to the VM via RDP.
      1. Run Windows PowerShell.

         {% include [ps-note](../../_includes/backup/ps-note.md) %}

      1. Run this command:

         ```powershell
         . { iwr -useb https://storage.yandexcloud.net/backup-distributions/agent_reinit.ps1 } | iex
         ```

         Result:

         ```text
         ...
         Backup agent reinit completed after 204 s!
         ```

   {% endlist %}

1. Disconnect from the VM.
1. Make sure the outdated VM is no longer on the list of VMs connected to {{ backup-name }}:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where {{ backup-name }} is connected.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
      1. In the ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}** tab, check that the list does not contain the outdated VM marked as ![irrelevant](../../_assets/console-icons/circle-info-fill.svg).

         If the outdated VM is still there, click ![image](../../_assets/console-icons/ellipsis.svg) next to it, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   {% endlist %}

1. [Link](./policy-vm/update.md#update-vm-list) your VM to a backup policy.
