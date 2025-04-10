You can view info on the status of a VM connection to {{ backup-name }} using the [management console]({{ link-console-main }}), on the VM list page in {{ compute-name }}. The following statuses are available:

* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-ok }}`: {{ backup-name }} is connected to the VM, backups are being created under the specified policies, the {{ backup-name }} agent is online.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}`: {{ backup-name }} is connected, but no policies are set up, and backups are not being created.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-failed }}`: Agent is offline, or agent registration failed.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-not-connected }}`: {{ backup-name }} is not connected to the VM.

You can [view](../../backup/operations/get-journal.md) the VM connection status and [learn](../../backup/operations/get-connection-status.md) more about the VM backup in the backup log.