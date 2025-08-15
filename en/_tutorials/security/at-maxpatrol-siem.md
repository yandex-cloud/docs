# Exporting audit logs to MaxPatrol SIEM


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) can read {{ yandex-cloud }} [audit logs](../../audit-trails/concepts/events.md) from a data stream in [{{ yds-full-name }}](../../data-streams/). To complete this tutorial, you need access to a MaxPatrol SIEM instance.

To set up audit log export:

1. [Get your cloud ready](#before-begin).
1. [Set up your environment](#environment-preparing).
1. [Create a trail to send logs to the stream in {{ yds-name }}](#create-trail).
1. [In MaxPatrol SIEM, set up a task to collect data from the stream in {{ yds-name }}](#configure-maxpatrol).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Using a data stream (see [{{ yds-name }} pricing](../../data-streams/pricing.md)).
* Using {{ ydb-full-name }} in serverless mode (see [{{ ydb-name }} pricing](../../ydb/pricing/serverless.md)).


## Set up your environment {#environment-preparing}


### Create a service account and assign the required roles {#create-sa}

The trail will use this service account to collect logs for all your organization's resources and upload them to the specified data stream in {{ yds-name }}.

Create a service account in the same folder where you are going to create the trail, e.g., in `example-folder`:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Specify the service account name: `maxpatrol-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

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

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

{% endlist %}

Assign the `audit-trails.viewer` and `yds.editor` roles to the `maxpatrol-sa` service account:

{% list tabs group=instructions %}

- CLI {#cli}
  
  1. The `audit-trails.viewer` role for your organization:

      ```bash
      yc organization-manager organization add-access-binding \
      --role audit-trails.viewer \
      --id <organization_ID> \
      --service-account-id <service_account_ID>
      ```

      Where:

      * `--role`: Role being assigned.
      * `--id`: [ID](../../organization/operations/organization-get-id.md) of the organization the service account belongs to.
      * `--service-account-id`: `maxpatrol-sa` service account ID.

      Result:

      ```text
      done (1s)
      ```

      For more information about the `yc organization-manager organization add-access-binding` command, see the [CLI reference](../../cli/cli-ref/organization-manager/cli-ref/organization/add-access-binding.md).

  1. The `yds.editor` role for `example-folder`:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --role yds.editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:

      * `--role`: Role being assigned.
      * `--subject`: `maxpatrol-sa` service account ID.

      Result:

      ```text
      done (1s)
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

{% endlist %}


### Create static access keys {#create-static-keys}

MaxPatrol SIEM uses [static access keys](../../iam/concepts/authorization/access-key.md) to authorize {{ yds-name }} queries.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the `maxpatrol-sa` service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Enter a description for the key and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.

  {% note alert %}

  Save the ID and secret key. After you close this dialog, the key value will no longer be available.

  {% endnote %}

- CLI {#cli}

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

  Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the key value again.

  {% endnote %}

  For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

{% endlist %}


### Create a {{ ydb-short-name }} serverless database {#serverless}

The database is required for the stream in `{{ yds-name }}`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_ydb }}**.
  1. Set **{{ ui-key.yacloud.ydb.forms.label_field_name }}** to `maxpatrol-db`.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Leave other parameters at their defaults.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Wait for the database status to change to `Running`.

- CLI {#cli}

  1. Create a database:

      ```bash
      yc ydb database create --name maxpatrol-db --serverless --folder-name example-folder
      ```

      Where:
      * `--name`: Database name.
      * `--serverless`: Serverless type.
      * `--folder-name`: Folder name.

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

      For more information about the `yc ydb database create` command, see the [CLI reference](../../cli/cli-ref/ydb/cli-ref/database/create.md).

  1. Check the status of the created database:

      ```bash
      yc ydb database get maxpatrol-db
      ```

      Wait for the database status to change to `RUNNING`.

{% endlist %}


### Create a data stream {#create-stream}

This is the data stream to which the trail will upload organization resource logs.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_data-streams }}**.
  1. In the **{{ ui-key.yacloud.data-streams.label_database }}** field, select `maxpatrol-db`.
  1. Set **{{ ui-key.yacloud.common.name }}** to `maxpatrol-stream`.
  1. Leave other parameters at their defaults.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Wait for the data stream status to change to `Running`.

{% endlist %}


## Create a trail {#create-trail}

The trail will collect management audit logs for all your organization's resources and upload them to the `maxpatrol-stream` data stream.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_audit-trails }}**.
  1. **{{ ui-key.yacloud.common.name }}** the new trail: `maxpatrol-trail`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}**: Select `maxpatrol-stream`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select `maxpatrol-sa`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Automatically populated field (shows the name of the organization that will host the trail).
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, select `{{ ui-key.yacloud.common.disabled }}` in the **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** field.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

For more information about creating a trail, see [this guide](../../audit-trails/operations/create-trail.md).

## Configure MaxPatrol SIEM {#configure-maxpatrol}


### Create accounts {#static-key-account}

You can use accounts to store secrets. Create accounts named `static-key-id` and `static-key-private` for your ID and [secret access key](#create-static-keys):

1. Log in to the MaxPatrol SIEM web interface.
1. Under **Data collection**, click **Accounts**.
1. Click **Add account** → **Password** and specify the following parameters:
    * **Name**: `static-key-id`.
    * **Password**: [Static key](#create-static-keys) ID.
    * **Confirm password**: Reenter static key ID.
1. Click **Save**.

Similarly, create an account named `static-key-private` containing the secret key.


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
    1. In the hierarchy list, select **Run scenario**.
    1. Under **Connection**, specify:
        * **Account**: `static-key-id`.
        * **Access upgrade account**: `static-key-private`.
    1. **Scenario execution parameters**:
        * **database**: `<maxpatrol-db_ID>`
        * **folder**: `<cloud_ID_for_example-folder>`
        * **region_name**: `{{ region-id }}`.
        * **stream_name**: `<maxpatrol-stream_name>`.
    1. In the **Data collection objectives** panel:
        1. Select the **Enable** tab.
        1. In the **Network addresses** field, enter `yandex-cloud`.
    1. Click **Save and run**.

To view the logs, go to the event review page:
1. Go the to the **Data collection tasks** page.
1. Click `YDS-logs-task`.
1. Click **Events collected** → **Select**.

## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete](../../data-streams/operations/manage-streams.md#delete-data-stream) `maxpatrol-stream`.
* [Delete](../../ydb/operations/manage-databases.md#delete-db) `maxpatrol-db`.
