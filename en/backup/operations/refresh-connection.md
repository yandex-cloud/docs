# Updating a VM connection to {{ backup-name }}

After [restoring a VM from a backup of another VM](./backup-vm/non-native-recovery.md), the source VM the backup was created from becomes outdated.

To avoid conflicts between the two VMs when making backups, update the outdated VM's connection to {{ backup-name }}:

{% list tabs %}

- Linux

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

   1. Disconnect from the VM:

      ```bash
      exit
      ```

   1. [Link](./policy-vm/update.md#update-vm-list) your VM to a backup policy.

- Windows

   1. [Connect](../../compute/operations/vm-connect/rdp.md) to the VM via RDP.

   1. Run Windows PowerShell.

   1. Run this command:

      ```powershell
      . { iwr -useb https://storage.yandexcloud.net/backup-distributions/agent_reinit.ps1 } | iex
      ```

      Result:

      ```text
      ...
      Backup agent reinit completed after 204 s!
      ```

   1. [Link](./policy-vm/update.md#update-vm-list) your VM to a backup policy.

{% endlist %}

#### See also {#see-also}

* [{#T}](connect-vm-windows.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/non-native-recovery.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
