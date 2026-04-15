# Exporting audit logs to MaxPatrol SIEM using the management console or {{ yandex-cloud }} CLI


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) allows reading {{ yandex-cloud }} [audit logs](../../audit-trails/concepts/events.md) from a data stream in [{{ yds-full-name }}](../../data-streams/index.yaml). To complete this tutorial, you need access to a MaxPatrol SIEM instance.

To set up audit log export using the management console or {{ yandex-cloud }} CLI:

1. [Get your cloud ready](#before-begin).
1. [Set up your environment](#environment-preparing).
1. [Create a trail to send logs to the stream in {{ yds-name }}](#create-trail).
1. [In MaxPatrol SIEM, set up a task to collect data from the stream in {{ yds-name }}](#configure-maxpatrol).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/at-maxpatrol-siem/paid-resources.md) %}

## Set up your environment {#environment-preparing}

### Create service accounts {#create-sa}

The [trail](../../audit-trails/concepts/trail.md) will use the `maxpatrol-sa` [service account](../../iam/concepts/users/service-accounts.md) to collect logs for all your organization's resources and upload them to the specified [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-name }}. MaxPatrol SIEM will use the `maxpatrol-reader-sa` service account to load audit logs from the data stream.

Create a service account in the same folder where you will be creating the trail, e.g., in `example-folder`:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `maxpatrol-sa`.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_roles }}** field, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_billing.iam.folder.service-account.label_add-role }}** and select the `yds.writer` [role](../../data-streams/security/index.md#yds-writer) for the folder.
  1. Click **{{ ui-key.yacloud_billing.iam.folder.service-account.popup-robot_button_add }}**.

  Repeat these steps to create the `maxpatrol-reader-sa` service account and assign it the `yds.viewer` [role](../../data-streams/security/index.md#yds-viewer) for the folder.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `maxpatrol-sa`:

      ```bash
      yc iam service-account create \
        --name maxpatrol-sa
      ```

      Result:

      ```text
      done (2s)
      id: ajecq2artiv5********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-03-18T18:29:53Z"
      name: maxpatrol-sa
      ```

  1. Repeat these steps to create the `maxpatrol-reader-sa` service account.

  For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

{% endlist %}

### Assign roles to the service accounts {#sa-assign-roles}

Assign the missing roles to the service accounts:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#console}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. Click **{{ ui-key.yacloud_org.cloud-components.AclDashboard.action_assign-roles_41Nj1 }}** in the top-right corner of the page. In the window that opens, select the `maxpatrol-sa` service account. If required, use the search bar.
  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select [`audit-trails.viewer`](../../audit-trails/security/index.md#at-viewer).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Assign the `yds.writer` [role](../../data-streams/security/index.md#yds-writer) for `example-folder` to the `maxpatrol-sa` service account:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --role yds.writer \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:

      * `--role`: Role to assign.
      * `--subject`: `maxpatrol-sa` service account ID.

  1. Repeat these steps to assign the `yds.viewer` [role](../../data-streams/security/index.md#yds-viewer) to the `maxpatrol-reader-sa` service account for `example-folder`.

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  1. Assign the `maxpatrol-sa` service account the `audit-trails.viewer` [role](../../audit-trails/security/index.md#at-viewer) for the organization:

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

      For more information about the `yc organization-manager organization add-access-binding` command, see the [CLI reference](../../cli/cli-ref/organization-manager/cli-ref/organization/add-access-binding.md).

{% endlist %}

### Create a static access key for MaxPatrol SIEM {#create-static-keys}

MaxPatrol SIEM uses [static access keys](../../iam/concepts/authorization/access-key.md) to authorize {{ yds-name }} queries.

Create a static access key for the `maxpatrol-reader-sa` service account:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the `maxpatrol-reader-sa` service account from the list that opens.
  1. In the top panel, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Enter a description for the key and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.

  {% note alert %}

  Save the ID and secret key. After you close this dialog, the key value will no longer be available.

  {% endnote %}

- CLI {#cli}

  Run this command:

  ```bash
  yc iam access-key create \
    --service-account-name maxpatrol-reader-sa
  ```

  Result:

  ```text
  access_key:
  id: aje38c5mjq11********
  service_account_id: ajegtlf2q28a********
  created_at: "2026-03-18T17:39:41.851532824Z"
  key_id: YCAJEnmnfsV8GpAMk********
  secret: YCMVxx-n0t8Y6s48zJDdKw9lWMB1iGU-********
  ```

  {% note alert %}

  Save the ID (`key_id`) and secret key (`secret`). You cannot get the secret key again.

  {% endnote %}

  For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

{% endlist %}


### Create a {{ ydb-short-name }} serverless database {#serverless}

The database is required for the stream in `{{ yds-name }}`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_ydb }}**.
  1. Specify **{{ ui-key.yacloud.ydb.forms.label_field_name }}**: `maxpatrol-db`.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Keep the default values for all other parameters.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Wait for the database status to change to `Running`.

- CLI {#cli}

  1. Create a database:

      ```bash
      yc ydb database create \
        --name maxpatrol-db \
        --serverless \
        --folder-name example-folder
      ```

      Where:
      * `--name`: Database name.
      * `--serverless`: `serverless` database type.
      * `--folder-name`: Folder name.

      Result:

      ```text
      done (36s)
      id: etnubo9ude8e********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-03-18T18:34:31Z"
      name: maxpatrol-db
      status: PROVISIONING
      ...
      ```

      For more information about the `yc ydb database create` command, see the [CLI reference](../../cli/cli-ref/ydb/cli-ref/database/create.md).

  1. Check the status of the new database:

      ```bash
      yc ydb database get maxpatrol-db
      ```

      Wait for the database status to change to `RUNNING`.

{% endlist %}


### Create a data stream {#create-stream}

The trail will upload organization resource logs to this data stream.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_data-streams }}**.
  1. In the **{{ ui-key.yacloud.data-streams.label_database }}** field, select `maxpatrol-db`.
  1. Specify the **{{ ui-key.yacloud.common.name }}**: `maxpatrol-stream`.
  1. Leave the other settings at their defaults.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Wait for the data stream status to change to `Running`.

{% endlist %}


## Create a trail {#create-trail}

The trail will collect management event audit logs for all your organization's resources and upload them to the `maxpatrol-stream` data stream.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_audit-trails }}**.
  1. Specify the **{{ ui-key.yacloud.common.name }}** for the new trail: `maxpatrol-trail`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}**: Select `maxpatrol-stream`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select `maxpatrol-sa`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Automatically populated field displaying the name of the organization to host the trail.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, select `{{ ui-key.yacloud.common.disabled }}` in the **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** field.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Create the `maxpatrol-trail` trail:

  ```bash
  yc audit-trails trail create \
    --name maxpatrol-trail \
    --service-account-id <service_account_ID> \
    --destination-yds-stream maxpatrol-stream \
    --destination-yds-database-id <YDS_database_ID> \
    --filter-all-organisation-id <organization_ID>
  ```

  Where:
  * `--name`: Name of the new trail.
  * `--service-account-id`: `maxpatrol-sa` service account ID.
  * `--destination-yds-stream`: Stream name.
  * `--destination-yds-database-id`: `maxpatrol-db` database ID.
  * `--filter-all-organisation-id`: [ID of the organization](../../organization/operations/organization-get-id.md) to create the trail and store audit logs in.

  Result:

  ```text
  done (1s)
  id: cnpvbmk64136********
  folder_id: b1g5bhjofg7o********
  created_at: "2026-03-18T10:57:33.322Z"
  updated_at: "2026-03-18T10:57:33.322Z"
  name: maxpatrol-trail
  destination:
    data_stream:
      database_id: etn5bfdglcn8********
      stream_name: maxpatrol-stream
      codec: RAW
  service_account_id: aje1jot7q7eh********
  status: ACTIVE
  cloud_id: b1gj9ja2h4ct********
  filtering_policy:
    management_events_filter:
      resource_scopes:
        - id: bpfaidqca8vd********
          type: organization-manager.organization
  ```

  For more information about the `yc audit-trails trail create` command, see the [CLI reference](../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

{% endlist %}

For more information about creating a trail, see [{#T}](../../audit-trails/operations/create-trail.md).

## Configure MaxPatrol SIEM {#configure-maxpatrol}

{% include [the-maxpatrol-part](../_tutorials_includes/at-maxpatrol-siem/the-maxpatrol-part.md) %}

## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete](../../data-streams/operations/manage-streams.md#delete-data-stream) `maxpatrol-stream`.
* [Delete](../../ydb/operations/manage-databases.md#delete-db) `maxpatrol-db`.
# Exporting audit logs to MaxPatrol SIEM using the management console or {{ yandex-cloud }} CLI


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) allows reading {{ yandex-cloud }} [audit logs](../../audit-trails/concepts/events.md) from a data stream in [{{ yds-full-name }}](../../data-streams/index.yaml). To complete this tutorial, you need access to a MaxPatrol SIEM instance.

To set up audit log export using the management console or {{ yandex-cloud }} CLI:

1. [Get your cloud ready](#before-begin).
1. [Set up your environment](#environment-preparing).
1. [Create a trail to send logs to the stream in {{ yds-name }}](#create-trail).
1. [In MaxPatrol SIEM, set up a task to collect data from the stream in {{ yds-name }}](#configure-maxpatrol).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/at-maxpatrol-siem/paid-resources.md) %}

## Set up your environment {#environment-preparing}

### Create service accounts {#create-sa}

The [trail](../../audit-trails/concepts/trail.md) will use the `maxpatrol-sa` [service account](../../iam/concepts/users/service-accounts.md) to collect logs for all your organization's resources and upload them to the specified [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-name }}. MaxPatrol SIEM will use the `maxpatrol-reader-sa` service account to load audit logs from the data stream.

Create a service account in the same folder where you will be creating the trail, e.g., in `example-folder`:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `maxpatrol-sa`.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_roles }}** field, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_billing.iam.folder.service-account.label_add-role }}** and select the `yds.writer` [role](../../data-streams/security/index.md#yds-writer) for the folder.
  1. Click **{{ ui-key.yacloud_billing.iam.folder.service-account.popup-robot_button_add }}**.

  Repeat these steps to create the `maxpatrol-reader-sa` service account and assign it the `yds.viewer` [role](../../data-streams/security/index.md#yds-viewer) for the folder.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `maxpatrol-sa`:

      ```bash
      yc iam service-account create \
        --name maxpatrol-sa
      ```

      Result:

      ```text
      done (2s)
      id: ajecq2artiv5********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-03-18T18:29:53Z"
      name: maxpatrol-sa
      ```

  1. Repeat these steps to create the `maxpatrol-reader-sa` service account.

  For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

{% endlist %}

### Assign roles to the service accounts {#sa-assign-roles}

Assign the missing roles to the service accounts:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#console}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. Click **{{ ui-key.yacloud_org.cloud-components.AclDashboard.action_assign-roles_41Nj1 }}** in the top-right corner of the page. In the window that opens, select the `maxpatrol-sa` service account. If required, use the search bar.
  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select [`audit-trails.viewer`](../../audit-trails/security/index.md#at-viewer).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Assign the `yds.writer` [role](../../data-streams/security/index.md#yds-writer) for `example-folder` to the `maxpatrol-sa` service account:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --role yds.writer \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:

      * `--role`: Role to assign.
      * `--subject`: `maxpatrol-sa` service account ID.

  1. Repeat these steps to assign the `yds.viewer` [role](../../data-streams/security/index.md#yds-viewer) to the `maxpatrol-reader-sa` service account for `example-folder`.

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  1. Assign the `maxpatrol-sa` service account the `audit-trails.viewer` [role](../../audit-trails/security/index.md#at-viewer) for the organization:

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

      For more information about the `yc organization-manager organization add-access-binding` command, see the [CLI reference](../../cli/cli-ref/organization-manager/cli-ref/organization/add-access-binding.md).

{% endlist %}

### Create a static access key for MaxPatrol SIEM {#create-static-keys}

MaxPatrol SIEM uses [static access keys](../../iam/concepts/authorization/access-key.md) to authorize {{ yds-name }} queries.

Create a static access key for the `maxpatrol-reader-sa` service account:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the `maxpatrol-reader-sa` service account from the list that opens.
  1. In the top panel, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Enter a description for the key and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.

  {% note alert %}

  Save the ID and secret key. After you close this dialog, the key value will no longer be available.

  {% endnote %}

- CLI {#cli}

  Run this command:

  ```bash
  yc iam access-key create \
    --service-account-name maxpatrol-reader-sa
  ```

  Result:

  ```text
  access_key:
  id: aje38c5mjq11********
  service_account_id: ajegtlf2q28a********
  created_at: "2026-03-18T17:39:41.851532824Z"
  key_id: YCAJEnmnfsV8GpAMk********
  secret: YCMVxx-n0t8Y6s48zJDdKw9lWMB1iGU-********
  ```

  {% note alert %}

  Save the ID (`key_id`) and secret key (`secret`). You cannot get the secret key again.

  {% endnote %}

  For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

{% endlist %}


### Create a {{ ydb-short-name }} serverless database {#serverless}

The database is required for the stream in `{{ yds-name }}`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_ydb }}**.
  1. Specify **{{ ui-key.yacloud.ydb.forms.label_field_name }}**: `maxpatrol-db`.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Keep the default values for all other parameters.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Wait for the database status to change to `Running`.

- CLI {#cli}

  1. Create a database:

      ```bash
      yc ydb database create \
        --name maxpatrol-db \
        --serverless \
        --folder-name example-folder
      ```

      Where:
      * `--name`: Database name.
      * `--serverless`: `serverless` database type.
      * `--folder-name`: Folder name.

      Result:

      ```text
      done (36s)
      id: etnubo9ude8e********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-03-18T18:34:31Z"
      name: maxpatrol-db
      status: PROVISIONING
      ...
      ```

      For more information about the `yc ydb database create` command, see the [CLI reference](../../cli/cli-ref/ydb/cli-ref/database/create.md).

  1. Check the status of the new database:

      ```bash
      yc ydb database get maxpatrol-db
      ```

      Wait for the database status to change to `RUNNING`.

{% endlist %}


### Create a data stream {#create-stream}

The trail will upload organization resource logs to this data stream.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_data-streams }}**.
  1. In the **{{ ui-key.yacloud.data-streams.label_database }}** field, select `maxpatrol-db`.
  1. Specify the **{{ ui-key.yacloud.common.name }}**: `maxpatrol-stream`.
  1. Leave the other settings at their defaults.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Wait for the data stream status to change to `Running`.

{% endlist %}


## Create a trail {#create-trail}

The trail will collect management event audit logs for all your organization's resources and upload them to the `maxpatrol-stream` data stream.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_audit-trails }}**.
  1. Specify the **{{ ui-key.yacloud.common.name }}** for the new trail: `maxpatrol-trail`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}**: Select `maxpatrol-stream`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select `maxpatrol-sa`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}**: Automatically populated field displaying the name of the organization to host the trail.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}**: Keep the default value, `{{ ui-key.yacloud.common.all }}`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, select `{{ ui-key.yacloud.common.disabled }}` in the **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** field.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Create the `maxpatrol-trail` trail:

  ```bash
  yc audit-trails trail create \
    --name maxpatrol-trail \
    --service-account-id <service_account_ID> \
    --destination-yds-stream maxpatrol-stream \
    --destination-yds-database-id <YDS_database_ID> \
    --filter-all-organisation-id <organization_ID>
  ```

  Where:
  * `--name`: Name of the new trail.
  * `--service-account-id`: `maxpatrol-sa` service account ID.
  * `--destination-yds-stream`: Stream name.
  * `--destination-yds-database-id`: `maxpatrol-db` database ID.
  * `--filter-all-organisation-id`: [ID of the organization](../../organization/operations/organization-get-id.md) to create the trail and store audit logs in.

  Result:

  ```text
  done (1s)
  id: cnpvbmk64136********
  folder_id: b1g5bhjofg7o********
  created_at: "2026-03-18T10:57:33.322Z"
  updated_at: "2026-03-18T10:57:33.322Z"
  name: maxpatrol-trail
  destination:
    data_stream:
      database_id: etn5bfdglcn8********
      stream_name: maxpatrol-stream
      codec: RAW
  service_account_id: aje1jot7q7eh********
  status: ACTIVE
  cloud_id: b1gj9ja2h4ct********
  filtering_policy:
    management_events_filter:
      resource_scopes:
        - id: bpfaidqca8vd********
          type: organization-manager.organization
  ```

  For more information about the `yc audit-trails trail create` command, see the [CLI reference](../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

{% endlist %}

For more information about creating a trail, see [{#T}](../../audit-trails/operations/create-trail.md).

## Configure MaxPatrol SIEM {#configure-maxpatrol}

{% include [the-maxpatrol-part](../_tutorials_includes/at-maxpatrol-siem/the-maxpatrol-part.md) %}

## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete](../../data-streams/operations/manage-streams.md#delete-data-stream) `maxpatrol-stream`.
* [Delete](../../ydb/operations/manage-databases.md#delete-db) `maxpatrol-db`.