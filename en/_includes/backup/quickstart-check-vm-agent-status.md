Make sure the {{ backup-name }} agent has been installed:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Select the VM.
  1. Check that the value of the **{{ ui-key.yacloud.backup.title_backup }}** field in the **{{ ui-key.yacloud.backup.field_vm-instances }}** section is `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}`.

{% endlist %}