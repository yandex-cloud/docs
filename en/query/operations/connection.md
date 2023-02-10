# Working with connections

Connections in {{ yq-full-name }} let you interact with data sources of the following types:
* [{{ objstorage-full-name }}](../../storage/concepts/index.md).
* [{{ yds-full-name }}](../../data-streams/concepts/index.md).
* [{{ monitoring-name }}](../../monitoring/concepts/index.md).

## Creating a connection {#create}

To create a connection:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Connections**.
1. Click ![info](../../_assets/plus.svg) **Create**.
1. Enter a name and description for the connection. Naming requirements:

   {% include [name-format](../_includes/connection-name-format.md) %}

1. Select the source type and specify the **Connection type parameters**:

   {% list tabs %}

   - {{ objstorage-full-name }}

      * **Bucket auth**: `Public` or `Private`.
      * For a public bucket, enter a name in the **Bucket** field.
         For a private bucket, select:
         * **Cloud and folder** where the data source is located.
         * Select a bucket or create a new one.
         * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to access the data.

   - {{ yds-full-name }}

      * Select the **Cloud and folder** where the data source is located.
      * Select or create a [serverless {{ ydb-name }} database](../../ydb/) with a {{ yds-full-name }} [stream](../../data-streams/concepts/index.md).
      * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to access the data.

   - {{ monitoring-name }}

      * Select the **Cloud and folder** where the data source is located.
      * Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be used to log metrics.

   {% endlist %}

1. Click **Create**.

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
1. Set new parameters for the connection. You can't change the connection type.
1. Click **Edit**.

## Deleting a connection {#delete}

To delete a connection:

1. In the [management console]({{ link-console-main }}), select the folder where the connection is created.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Connections**.
1. Click ![delete](../../_assets/query/delete.svg) next to the name of the appropriate connection.
1. Confirm connection deletion.
