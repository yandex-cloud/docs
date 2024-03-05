# Managing connections

A [connection](../concepts/glossary.md#connection) is required for connecting {{ yq-full-name }} to a data source and target.

## Creating a connection {#create}

To create a connection:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Enter a name and description for the connection. The naming requirements are as follows:

   {% include [name-format](../_includes/connection-name-format.md) %}

1. Select the connection type and specify the **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

   {% list tabs %}

   - {{ objstorage-short-name }}

      * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}**: `{{ ui-key.yql.yq-connection-form.public.button-text }}` or `{{ ui-key.yql.yq-connection-form.private.button-text }}`.
      * For a public bucket, enter a name in the **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** field.
         For a private bucket, select:
         * **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
         * Select a bucket or create a new one.
         * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to access the data.

   - {{ yds-short-name }}

      * Select the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
      * Select or create a [serverless {{ ydb-name }} database](../../ydb/) with a {{ yds-full-name }} [stream](../../data-streams/concepts/index.md).
      * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to access the data.

   - {{ mpg-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mpg-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mpg-name }} [service account](../../iam/concepts/users/service-accounts.md), or create a new one with the [`{{ roles.mpg.viewer }}`](../../managed-postgresql/security/index.md#mpg-viewer) role, and use it to connect to `{{ mpg-name }}` clusters.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username to use when connecting to {{ PG }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: User password to use when connecting to {{ PG }} databases.


   - {{ mch-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mch-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing [service account](../../iam/concepts/users/service-accounts.md) {{ mch-name }}, or create a new one with the [`{{ roles.mch.viewer }}`](../../managed-clickhouse/security/index.md#mch-viewer) role, and use it to connect to `{{ mch-name }}` clusters.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username to use when connecting to {{ CH }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: User password to use when connecting to {{ CH }} databases.


   - {{ monitoring-short-name }}

      * Select the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
      * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to log metrics.

   {% endlist %}

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

Next, you can [create a binding](binding.md#create).

## Getting information about a connection {#get-info}

To view information about a connection:

1. In the [management console]({{ link-console-main }}), select the folder where the connection is created.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. In the line with the connection name, click ![info](../../_assets/console-icons/circle-info.svg). You can find information about the source and service account under **{{ ui-key.yql.yq-connection-info.general.section-header }}**. In the **{{ ui-key.yql.yq-common-meta-section.meta.section-header }}** section, you can view the connection ID, creation timestamp, and creator.

## Changing connection parameters {#update}

To edit connection parameters:

1. In the [management console]({{ link-console-main }}), select the folder where the connection is created.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. In the line with the connection name, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yql.yq-connection-actions.edit-connection.menu-item-text }}**.
1. Set new parameters for the connection. You cannot change the connection type.
1. Click **{{ ui-key.yql.yq-connection-form.modify.button-text }}**.

## Deleting a connection {#delete}

To delete a connection:

1. In the [management console]({{ link-console-main }}), select the folder where the connection is created.
1. In the list of services, select **{{ yq-full-name }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. In the line with the connection name, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yql.yq-connection-actions.delete-connection.menu-item-text }}**.
1. Confirm connection deletion.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
