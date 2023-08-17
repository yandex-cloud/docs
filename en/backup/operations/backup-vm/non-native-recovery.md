# Restoring a VM from a backup of another VM

If a folder contains multiple VMs connected to {{ backup-name }}, you can restore a VM from a backup of another VM. This is required, for example, if the source VM is down.

{% note info %}

The target VM's operating system must match that of the source VM the backup was created from. The boot disk of the target VM must be at least equal to that of the source VM.

{% endnote %}

To restore a VM from a backup of another VM:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
   1. Select **{{ backup-name }}**.
   1. Go to the ![backups](../../../_assets/backup/backups.svg) **Backups** tab.
   1. Next to the backup to restore the VM from, click ![image](../../../_assets/options.svg) and select **Restore VM**.
   1. In the **Target VM** field, select the VM to restore the backup to or [create](../#connect-vm) a new VM with a connection to {{ backup-name }}. To create a new VM for recovery, click **Create**:
      1. On the page that opens, specify the parameters of the new VM and click **Create VM**.
         Wait until the VM [connects](../../concepts/vm-connection.md) to {{ backup-name }}.
      1. Return to the VM recovery page.
      1. To update the list of VMs, click ![refresh](../../../_assets/backup/refresh.svg).
      1. Select the previously created VM.
   1. To avoid a conflict between the restored and source VMs, select **Delete outdated VM**.

      If you do not select this option, once the source VM you created the backup from is restored, it will become outdated. To continue creating backups of this VM, [refresh](../refresh-connection.md) its connection to {{ backup-name }}.
   1. Click **Restore**.

- CLI

   1. {% include [cli-install](../../../_includes/cli-install.md) %}

   1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to restore a VM from a backup:

      ```bash
      yc backup backups recover --help
      ```

   1. Get the IDs of the target VM to restore the backup to and the source VM whose backup you want to use:

      ```bash
      yc compute instance list
      ```

      Result:

      ```bash
      +----------------------+---------+---------------+---------+--------------+-------------+
      |          ID          |  NAME   |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
      +----------------------+---------+---------------+---------+--------------+-------------+
      | epdhmn8mdqmt******** | my-vm-1 | {{ region-id }}-b | RUNNING | 51.250.**.** | 192.168.*.* |
      | epdis3p9paoe******** | my-vm-2 | {{ region-id }}-b | RUNNING | 84.201.**.** | 192.168.*.* |
      +----------------------+---------+---------------+---------+--------------+-------------+
      ```

   1. Get the ID of the source VM's backup:

      ```bash
      yc backup backups list \
        --instance-id <source_VM_ID>
      ```

      Where `--instance-id` is the ID of the source VM whose backup you want to use.

      Result:

      ```bash
      +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
      |                  ID                  |              ARCHIVE ID              | COMPUTE INSTANCE ID  |             RESOURCE ID              |      POLICY ID       | TYPE |      DISKS       |  SIZE  |     CREATED AT      |
      +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
      | 9cba836d-869c-41d2-8f25-0dac******** | 8a5b6d59-f7ce-0cb9-6cbf-151c******** | epdhmn8mdqmt******** | 7AF6A532-D1DC-4945-9D0C-E101******** | cdgiqu6ouch3******** | FULL | Disk 1 (13.0 GB) | 1.4 GB | 2023-07-11 05:10:09 |
      | 05e964ca-6a8f-481a-b83e-44c5******** | 8a5b6d59-f7ce-0cb9-6cbf-151c******** | epdhmn8mdqmt******** | 7AF6A532-D1DC-4945-9D0C-E101******** | cdgiqu6ouch3******** | FULL | Disk 1 (15.0 GB) | 1.4 GB | 2023-07-11 05:00:07 |
      +--------------------------------------+--------------------------------------+----------------------+--------------------------------------+----------------------+------+------------------+--------+---------------------+
      ```

   1. Restore the VM from the backup:

      ```bash
      yc backup backups recover \
        --source-backup-id <идентификатор_резервной копии> \
        --destination-instance-id <идентификатор_целевой_ВМ>
      ```

      Where:

      * `--source-backup-id`: Backup ID.
      * `--destination-instance-id`: ID of the target VM to restore the backup to.

      Result:

      ```bash
      ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
      ```

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/backup/recover.md).

   Once the source VM you created the backup from is restored, it becomes outdated. To avoid conflicts between the two VMs when making backups, [delete](../../../compute/operations/vm-control/vm-delete.md) the outdated VM or [refresh](../refresh-connection.md) its connection to {{ backup-name }}:

{% endlist %}

#### See also {#see-also}

* [{#T}](delete.md)