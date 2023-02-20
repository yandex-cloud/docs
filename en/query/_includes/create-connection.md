1. Go to the {{ yq-full-name }} interface, open the **Connections** section, and click **Create**.
1. In the window that opens, specify a name for a connection to {{ yds-full-name }} in the **Name** field.
1. In the drop-down list of the **Type** field, select **Data Streams**.
1. Specify the cloud and folder with the data source.
1. In the drop-down list of the **Database** field, select the {{ydb-full-name}} database where the {{yds-full-name}} stream was created.
1. In the **Service account** field, select the service account to use for data reads or create a new one by granting it the [`yds.viewer`](../../data-streams//security/index.md) permissions.
1. Click **Create** to create a connection.