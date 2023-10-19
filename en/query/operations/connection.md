# Managing connections

A [connection](../concepts/glossary.md#connection) is required for connecting {{ yq-full-name }} to a data source and target.

## Creating a connection {#create}

To create a connection:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Connections**.
1. Click ![info](../../_assets/plus.svg) **Create**.
1. Enter a name and description for the connection. The naming requirements are as follows:

   {% include [name-format](../_includes/connection-name-format.md) %}

1. Select the connection type and specify the **Connection type parameters**:

   {% list tabs %}

   - {{ objstorage-short-name }}

      * **Bucket auth**: `Public` or `Private`.
      * For a public bucket, enter a name in the **Bucket** field.
         For a private bucket, select:
         * **Cloud and folder** where the data source is located.
         * Select a bucket or create a new one.
         * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to access the data.

   - {{ yds-short-name }}

      * Select the **Cloud and folder** where the data source is located.
      * Select or create a [serverless {{ ydb-name }} database](../../ydb/) with a {{ yds-full-name }} [stream](../../data-streams/concepts/index.md).
      * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to access the data.

   - {{ mpg-name }}

      * **Cluster**: Select an existing {{ mpg-name }} cluster or create a new one.
      * **Service account**: Select an existing [service account](../../iam/concepts/users/service-accounts.md) in {{ mpg-name }}, or create a new service account with the [`{{ roles.mpg.viewer }}`](../../managed-postgresql/security/index.md#mpg-viewer) role, and use it to connect to `{{ mpg-name }}` clusters.
      * **Login**: Username to be used to connect to {{ PG }} databases.
      * **Password**: User password that will be used to connect to {{ PG }} databases.


   - {{ mch-name }}

      * **Cluster**: Select an existing {{ mch-name }} cluster or create a new one.
      * **Service account**: Select an existing [service account](../../iam/concepts/users/service-accounts.md) in {{ mch-name }}, or create a new service account with the [`{{ roles.mch.viewer }}`](../../managed-clickhouse/security/index.md#mch-viewer) role, and use it to connect to `{{ mch-name }}` clusters.
      * **Login**: Username that will be used to connect to ClickHouse databases.
      * **Password**: User password that will be used to connect to ClickHouse databases.


   - {{ monitoring-short-name }}

      * Select the **Cloud and folder** where the data source is located.
      * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to log metrics.

   {% endlist %}

1. Click **Create**.

Next, you can [create a binding](binding.md#create).

## Getting information about a connection {#get-info}

To view information about a connection:

1. In the [management console]({{ link-console-main }}), select the folder where the connection is created.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Connections**.
1. Click ![info](../../_assets/query/info.svg) next to the name of the desired connection. You can find information about the source and service account under **General**. Look up the connection ID, creation timestamp, and author under **Meta**.

## Changing connection parameters {#update}

To edit connection parameters:

1. In the [management console]({{ link-console-main }}), select the folder where the connection is created.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Connections**.
1. Click ![pencil](../../_assets/query/pensil.svg) next to the name of the desired connection.
1. Set new parameters for the connection. You cannot change the connection type.
1. Click **Edit**.

## Deleting a connection {#delete}

To delete a connection:

1. In the [management console]({{ link-console-main }}), select the folder where the connection is created.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Connections**.
1. Click ![delete](../../_assets/query/delete.svg) next to the name of the appropriate connection.
1. Confirm connection deletion.
