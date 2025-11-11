Link your VM to a backup policy:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the activated service and VM you need.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![policies](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Select one of the policies created by default. Click **{{ ui-key.yacloud.backup.button_create-policy }}** to create a new policy, if required.
  1. Under **{{ ui-key.yacloud.backup.title_linked-recourses }}** on the **{{ ui-key.yacloud.backup.value_vm-recourses }}** tab, click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
  1. In the window that opens, select the VM from the list and click **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

{% endlist %}

As a result, the VM will be associated with the backup policy and the system will start taking its backups according to the policy schedule.