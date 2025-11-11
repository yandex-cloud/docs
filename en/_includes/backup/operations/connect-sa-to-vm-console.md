1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to connect a VM to {{ backup-name }}.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** and then a VM from the list that opens.
1. In the top-right corner of the page, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select a service account with the `backup.editor` role.
1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.