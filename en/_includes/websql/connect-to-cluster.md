You can establish connections to managed DB clusters from your {{ yandex-cloud }} [organization's](../../organization/concepts/manage-services.md) clouds and folders. If you [switch to a different organization](../../organization/operations/manage-organizations.md#switch-to-another-org), a set of clusters from other clouds and folders will be available to you. Added connections will be available while you are working in the current {{ yandex-cloud }} organization.

To create a connection to a managed DB cluster:

1. Make sure **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** is enabled in the cluster settings.
1. In {{ websql-full-name }}, go to the **Connection manager** section and click ![image](../../_assets/console-icons/square-plus.svg) in the top-right corner.
1. Specify the connection parameters:
   * **Cloud**: Select a cloud.
   * **Folder**: Select the folder where you created the database cluster.
   * **Cluster**: Select the cluster.
1. Click **Connect** to connect to the selected cluster.


