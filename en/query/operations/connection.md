---
title: Managing {{ yq-full-name }} data source and sink connections
description: '{{ yq-name }} connections are necessary to access data sources and sinks.'
---

# Managing connections

{{ yq-full-name }} [connections](../concepts/glossary.md#connection) are necessary to access data sources and sinks.

## Creating a connection {#create}

To create a connection:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection name and description. The naming requirements are as follows:

    {% include [name-format](../_includes/connection-name-format.md) %}

1. Select the connection type and specify the **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

   {% list tabs %}

   - {{ objstorage-short-name }}

     * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}**: `{{ ui-key.yql.yq-connection-form.public.button-text }}` or `{{ ui-key.yql.yq-connection-form.private.button-text }}`.
     * For a public bucket, specify a name in the **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** field.
       For a private bucket:
       * Select **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
       * Select an existing bucket or create a new one.
       * Select an existing or create a new [service account](../../iam/concepts/users/service-accounts.md). You will use it to access the data.

   - {{ yds-short-name }}

     * Select the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
     * Select or create a new [serverless {{ ydb-name }} database](../../ydb/) with a {{ yds-full-name }} [stream](../../data-streams/concepts/index.md).
     * Select an existing or create a new [service account](../../iam/concepts/users/service-accounts.md). You will use it to access the data.

   - {{ mch-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mch-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mch-name }} [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`{{ roles.mch.viewer }}` role](../../managed-clickhouse/security.md#managed-clickhouse-viewer) allowing it to connect to `{{ mch-name }}` clusters.
      * **{{ ui-key.yql.yq-connection-info.database.label }}**: Select the database you will use to work with the {{ CH }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username you will use to connect to {{ CH }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: Password you will use to connect to {{ CH }} databases.

   - {{ mgp-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mgp-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mgp-name }} [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`{{ roles.mgp.viewer }}` role](../../managed-greenplum/security/index.md#mgp-viewer) allowing it to connect to `{{ mgp-name }}` clusters.
      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: Select the database you will use to work with the {{ GP }} cluster.
      * **{{ ui-key.yql.yq-connection-form.schema.input-label }}**: Specify the [namespace](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/admin_guide-ddl-ddl-schema.html) you will use when working with the {{ GP }} database.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username you will use to connect to {{ GP }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: Password you will use to connect to {{ GP }} databases.

   - {{ mmy-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mmy-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mmy-name }} [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`{{ roles.mmy.viewer }}`](../../managed-mysql/security/index.md#managed-mysql-viewer) role allowing it to connect to `{{ mmy-name }}` clusters.
      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: Select the database you will use to work with the {{ MY }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username you will use to connect to {{ MY }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: Password you will use to connect to {{ MY }} databases.

   - {{ mpg-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mpg-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mpg-name }} [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`{{ roles.mpg.viewer }}` role](../../managed-postgresql/security/index.md#managed-postgresql-viewer) allowing it to connect to `{{ mpg-name }}` clusters.
      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: Select the database you will use to work with the {{ PG }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username you will use to connect to {{ PG }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: Password you will use to connect to {{ PG }} databases.

   - {{ ydb-name }}
     
      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ ydb-name }} database or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select the {{ ydb-name }} [service account](../../iam/concepts/users/service-accounts.md) you will use for `{{ ydb-name }}` cluster connections and database authentication.

   - {{ monitoring-short-name }}

     * Select the **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** where the data source is located.
     * Select or create a new [service account](../../iam/concepts/users/service-accounts.md) that will be used for writing metrics.

   {% endlist %}

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

To use a connection with this service account, you need the `iam.serviceAccounts.user` [role](../../iam/security/index.md#iam-serviceAccounts-user).

Now, you can [create a binding](binding.md#create).

## Getting connection details {#get-info}

To view connection details:

1. In the [management console]({{ link-console-main }}), select the folder where you have created the connection.
1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Find the connection you need in the list and click ![info](../../_assets/console-icons/circle-info.svg) in its row. The source and service account details will appear under **{{ ui-key.yql.yq-connection-info.general.section-header }}**. The connection ID, creation timestamp, and creator will appear under **{{ ui-key.yql.yq-common-meta-section.meta.section-header }}**.

## Modifying connection settings {#update}

To edit connection settings:

1. In the [management console]({{ link-console-main }}), select the folder where you have created the connection.
1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Find the connection you need in the list, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yql.yq-connection-actions.edit-connection.menu-item-text }}**.
1. Update the connection settings. Note that the connection type is read-only.
1. Click **{{ ui-key.yql.yq-connection-form.modify.button-text }}**.

## Deleting a connection {#delete}

To delete a connection:

1. In the [management console]({{ link-console-main }}), select the folder where you have created the connection.
1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Find the connection you need in the list, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yql.yq-connection-actions.delete-connection.menu-item-text }}**.
1. Confirm connection deletion.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
