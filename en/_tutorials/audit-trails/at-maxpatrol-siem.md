# Exporting audit logs to MaxPatrol SIEM

[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) is able to read {{ yandex-cloud }} [audit logs](../../audit-trails/concepts/events.md) from a [{{ yds-full-name }}](../../data-streams/) data stream. To go through the entire tutorial, you must have access to an instance of MaxPatrol SIEM.

To configure audit log export:

1. [Prepare your cloud](#before-begin).
1. [Prepare the environment](#environment-preparing).
1. [Create a trail to send logs to a {{ yds-name }} data stream](#create-trail).
1. [In MaxPatrol SIEM, set up a job to collect data from a {{ yds-name }} data stream](#configure-maxpatrol).

If you no longer need these resources, [delete them](#clear-out).


## Before you begin {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Using a data stream (see [{{ yds-name }} pricing](../../data-streams/pricing.md)).
* Using {{ ydb-full-name }} in serverless mode (see [{{ ydb-name }} pricing](../../ydb/pricing/serverless.md)).


## Prepare the environment {#environment-preparing}


### Create a service account and assign roles {#create-sa}

On behalf of a service account, the trail will gather logs from all the organization's resources and upload them to a {{ yds-name }} data stream.

Create a service account in the same folder as the trail, such as `example-folder`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. Enter `maxpatrol-sa` as your service account name.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a service account:

      ```bash
      yc iam service-account create --name maxpatrol-sa
      ```

      Result:

      ```text
      id: aje*****ckg
      folder_id: b1g*****rnj
      created_at: "2022-09-18..."
      name: maxpatrol-sa
      ```

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/create.md).

{% endlist %}

Assign your `maxpatrol-sa` service account the `audit-trails.viewer` and the `yds.editor` roles:

{% list tabs %}

- CLI

   1. The `audit-trails.viewer` role to the organization:

      ```bash
      yc organization-manager organization add-access-binding \
      --role audit-trails.viewer \
      --id <organization_ID> \
      --service-account-id <maxpatrol-sa_service_account_ID>
      ```

      Result:

      ```text
      done (1s)
      ```

      For more information about the `yc resource-manager organization add-access-binding` command, see the [CLI reference](../../cli/cli-ref/managed-services/organization-manager/organization/add-access-binding.md).

   1. The `yds.editor` role to `example-folder`:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --role yds.editor \
        --subject serviceAccount:<maxpatrol-sa_service_account_ID>
      ```

      Result:

      ```text
      done (1s)
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

{% endlist %}


### Create static access keys {#create-static-keys}

MaxPatrol SIEM uses [static access keys](../../iam/concepts/authorization/access-key.md) to authorize {{ yds-name }} data stream queries.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Go to the **Service accounts** tab.
   1. Select the `maxpatrol-sa` service account and click the line containing its name.
   1. Click **Create new key** on the top panel.
   1. Select **Create static access key**.
   1. Enter a description for the key and click **Create**.

   {% note alert %}

   Save the ID and private key. After the dialog is closed, the private key value will be unavailable.

   {% endnote %}

- CLI

   Create a static access key for the `maxpatrol-sa` service account:

   ```bash
   yc iam access-key create --service-account-name maxpatrol-sa
   ```

   Result:

   ```text
   access_key:
   id: YCd*****W7t
   service_account_id: aje*****ckg
   created_at: "2022-09-18..."
   key_id: YCA*****5Ws4
   secret: YCM76*******I3fk
   ```

   {% note alert %}

   Save the ID `key_id` and `secret` key. You cannot retrieve the key value a second time.

   {% endnote %}

   For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/access-key/create.md).

{% endlist %}


### Create a serverless database {{ ydb-short-name }} {#serverless}

The database is required for the `{{ yds-name }}` data stream.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Click **Create resource** and select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter `maxpatrol-db` as the **Name**.
   1. Under **Database type**, select `Serverless`.
   1. Leave the other parameters at their default settings.
   1. Click **Create database**.

   Wait for the database status to change to `Running`.

- CLI

   1. Create a database:

      ```bash
      yc ydb database create --name maxpatrol-db --serverless --folder-name example-folder
      ```

      Where:
      * `name`: Database name.
      * `serverless`: Serverless type.
      * `folder-name`: Folder name.

      Result:

      ```text
      done (7s)
      id: etn*****r5t
      folder_id: b1g*****rnj
      created_at: "2022-09-18..."
      name: maxpatrol-db
      status: PROVISIONING
      ...
      ```

      For more information about the `yc iam database create` command, see the [CLI reference](../../cli/cli-ref/managed-services/ydb/database/create.md).

   1. Check the status of the created database:

      ```bash
      yc ydb database get maxpatrol-db
      ```

      Wait for the database status to change to `Running`.

{% endlist %}


### Create a data stream {#create-stream}

This is the data stream the trail will upload organization resource logs to.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Click **Create resource** and select **{{ yds-name }}**.
   1. In the **Database** field, select `maxpatrol-db`.
   1. Enter `maxpatrol-stream` as the **Name**.
   1. Leave the other parameters at their default settings.
   1. Click **Create**.

   Wait for the data stream status to change to `Running`.

{% endlist %}


## Create a trail {#create-trail}

The trail will gather the audit log of all your organization's resources and [upload](../../audit-trails/operations/export-organization-data-streams.md) them to the `maxpatrol-stream` data stream.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Click **Create resource** and select the **Audit trail** option.
   1. Enter the **Name** of the trail being created as `maxpatrol-trail`.
   1. Under **Filter**, set up the audit log scope:
      * **Resource**: Select `Organization`.
      * **Organization**: Automatically populated field (shows the name of the organization with the trail).
   1. Under **Destination**, set up the destination object:
      * **Destination**: `{{ yds-name }}`.
      * **Data stream**: Select the `maxpatrol-stream` data stream.
   1. Under **Service account**, select the `maxpatrol-sa` service account.
   1. Click **Create**.

{% endlist %}


## Configure MaxPatrol SIEM {#configure-maxpatrol}


### Create accounts {#static-key-account}

You can use the accounts to store secrets. Create accounts named `static-key-id` and `static-key-private` to save the ID and the [private access key](#create-static-keys) in:

1. Log in to the MaxPatrol SIEM web interface.
1. Under **Data collection**, click **Accounts**.
1. Click **Add account** → **Password** and specify the following parameters:
   * **Name**: `static-key-id`.
   * **Password**: [Static key](#create-static-keys) ID.
   * **Confirm password**: Reenter static key ID.
1. Click **Save**.

Similarly, create an account called `static-key-private` which contains the private key.


### Create a data collection job {#create-task}

Create and run a data collection job with the {{ yds-full-name }} profile:
1. Log in to the MaxPatrol SIEM web interface.
1. Under **Data collection**, click **Tasks**.
1. On the **Data collection tasks** page:
   1. On the toolbar, click **Create task**.
   1. Click **Data collection**.
1. On the **Create data collection task** page, specify the parameters below:
   1. **Name**: `YDS-logs-task`.
   1. **Profile**: `{{ yds-full-name }}`.
   1. In the hierarchy list, select **Run script**.
   1. Under **Connection**, specify:
      * **Account**: `static-key-id`.
      * **Access upgrade account**: `static-key-private`.
   1. **Script runtime parameters**:
      * **database**: <maxpatrol-db_DB_ID>.
      * **folder**: <example-folder_folder_ID>.
      * **region_name**: {{ region-id }}.
      * **stream_name**: <maxpatrol-stream_stream_ID>.
   1. On the **Data collection objectives** panel:
      1. Select the **Enable** tab.
      1. In the **Network addresses** field, enter `yandex-cloud`.
   1. Click **Save and run**.

To view the logs, go to the event review page:
1. Go the to the **Data collection tasks** page.
1. Click the `YDS-logs-task` task.
1. Click **Events collected** → **Select**.

## How to delete created resources {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete](../../data-streams/operations/manage-streams.md#delete-data-stream) the `maxpatrol-stream` data stream.
* [Delete](../../ydb/operations/manage-databases.md#delete-db) the `maxpatrol-db` database.
