You can view info on the status of a VM connection to {{ backup-name }} using the [management console]({{ link-console-main }}), on the VM list page in **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**. The following statuses are available:

* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-ok }}`: {{ backup-name }} is connected to the VM, backups are being created as per the specified policies, the {{ backup-name }} agent is online.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}`: {{ backup-name }} is connected, but no policy has been assigned, no backups are being created.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-failed }}`: The agent is offline or failed to register.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-not-connected }}`: {{ backup-name }} is not connected to the VM.

You can [view](../../backup/operations/get-journal.md) the VM connection status and [learn](../../backup/operations/get-connection-status.md) more about the VM backup in the backup log.