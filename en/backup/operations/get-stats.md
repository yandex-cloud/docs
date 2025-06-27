# Viewing backup statistics

{{ backup-name }} automatically delivers metrics on the number of protected VMs and {{ baremetal-full-name }} servers, as well as storage space used by backups, to [{{ monitoring-full-name }}](../../monitoring/).

To view the statistics:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the backup [policy](../concepts/policy.md) was created in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Select the dashboard: **{{ backup-name }}**.
  1. In the **Resource name** field, select the VM or {{ baremetal-name }} server you want to view the statistics for.

     If you select `*` for this field, the dashboard will display the aggregate statistics for all VMs and {{ baremetal-name }} servers in the folder.

  1. Select the statistics time interval.
  1. To refresh the dashboard, click ![](../../_assets/console-icons/arrows-rotate-right.svg). You can also set the auto refresh rate next to this button.

{% endlist %}

#### See also {#see-also}

* [{#T}](../metrics.md)
