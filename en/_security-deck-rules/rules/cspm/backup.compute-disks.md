### Cloud Backup or scheduled snapshots are used {#compute-disks}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | backup.compute-disks ||
|#

#### Description

Backups for VM disks are the only practical way to recover from data loss or corruption — accidental deletion, ransomware, a failed update, hardware failure. Without backups, an incident on the VM directly turns into permanent data loss and downtime.

Yandex Cloud offers two ways to back up VM disks:

* [Cloud Backup](https://yandex.cloud/en/docs/backup/) — a managed backup service with policies, retention rules, and the ability to restore on a different VM.
* [Scheduled disk snapshots](https://yandex.cloud/en/docs/compute/concepts/snapshot-schedule) — a Compute Cloud feature that periodically creates [snapshots](https://yandex.cloud/en/docs/compute/concepts/snapshot) of the disks.

**Risks if the rule is not followed:** Without backups, any data loss event — accidental deletion, ransomware, hardware failure, or a failed update — results in permanent, unrecoverable data loss and extended downtime with no way to restore the previous state.

#### Instructions and solutions

Configure backups for the VM:

* For production workloads, [activate Cloud Backup](https://yandex.cloud/en/docs/backup/operations/activate-service) and [attach the VM to a backup policy](https://yandex.cloud/en/docs/backup/operations/policy-vm/attach-and-detach-vm) with a retention period that matches your recovery requirements.
* For other VMs, [create a snapshot schedule](https://yandex.cloud/en/docs/compute/operations/snapshot-schedule/create) for the disks and pick a frequency and retention period that match how often the data changes.
* Periodically verify that backups can actually be restored — an unverified backup is not a backup.
