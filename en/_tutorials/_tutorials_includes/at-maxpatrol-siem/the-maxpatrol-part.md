### Create credentials {#static-key-account}

You can use credentials to store secrets. Create credentials named `static-key-id` and `static-key-private` to host the ID and secret access key for the `maxpatrol-reader-sa` service account:

1. Log in to the MaxPatrol SIEM web interface.
1. Under **Data collection**, click **Credentials**.
1. Click **Add credential** → **Password** and specify the following:
    * **Name**: `static-key-id`.
    * **Password**: Static key ID.
    * **Confirm password**: Reenter static key ID.
1. Click **Save**.

Similarly, create a credential named `static-key-private` containing the secret key.


### Create a data collection task {#create-task}

Create and run a data collection task with the {{ yds-full-name }} profile:
1. Log in to the MaxPatrol SIEM web interface.
1. Under **Data collection**, click **Tasks**.
1. On the **Data collection tasks** page:
    1. In the toolbar, click **Create task**.
    1. Click **Data collection**.
1. On the **Create data collection task** page, specify the following parameters:
    1. **Name**: `YDS-logs-task`.
    1. **Profile**: `{{ yds-full-name }}`.
    1. In the hierarchy list, select **Run script**.
    1. Under **Connection**, specify:
        * **Credentials**: `static-key-id`.
        * **Credentials for privilege elevation**: `static-key-private`.
    1. **Script settings**:
        * **database**: `<maxpatrol-db_ID>`;
        * **folder**: `<cloud_ID_for_example-folder>`;
        * **region_name**: `{{ region-id }}`.
        * **stream_name**: `maxpatrol-stream`.
    1. In the **Data collection targets** panel:
        1. Select the **Include** tab.
        1. In the **Network addresses** field, enter `yandex-cloud`.
    1. Click **Save and run**.

To view logs, go to the events page:
1. Go the to the **Data collection tasks** page.
1. Click `YDS-logs-task`.
1. Click **Collected events** → **Select**.