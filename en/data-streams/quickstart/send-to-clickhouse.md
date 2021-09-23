# Saving data to {{ CH }}

To save data from {{ yds-full-name }} to {{ CH }}, create:

* [A {{ mch-full-name }} cluster](../../managed-clickhouse/operations/cluster-create.md).
* [A source endpoint](#source).
* [A target endpoint](#destination).
* [A transfer](#transfer).

## Creating a source endpoint {#source}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the stream is located.

  1. Select **{{ yds-full-name }}**.

  1. Select the stream.

  1. Click **Actions** and select **Create data transfer**.

  1. On the **Create endpoint** page, in the **Direction** field, select **Source**.

  1. Enter a name and description for the source. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Select the **YDS** database type.

  1. Select the {{ ydb-short-name }} database where you created the stream.

  1. Enter the name of the stream to read the data from.

  1. Specify the service account to use for data reads.

  1. Under **Conversion rules**, set up the data schema:
      * Specify the **JSON** data format.
      * Select the **List of fields** data schema.
      * Add the `user_id` and `score` fields. Set the field type to `UINT32`.

  1. Click **Create**.

{% endlist %}

## Creating a target endpoint {#destination}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the stream is located.

  1. Select **{{ yds-full-name }}**.

  1. Select the stream.

  1. Click **Actions** and select **Create data transfer**.

  1. On the **Create endpoint** page, in the **Direction** field, select **Target**.

  1. Enter a name and description for the target. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Select the **{{ CH }}** database type.

  1. Select the **MDB cluster** connection type.

  1. Enter the {{ CH }} cluster name, user, password, and database.

  1. Click **Create**.

{% endlist %}

## Creating a transfer {#transfer}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the stream is located.

  1. Select **{{ data-transfer-full-name }}**.

  1. Go to the **Transfers** tab.

  1. Click **Create transfer**.

  1. Enter a name and description for the transfer. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Select the source endpoint and the target endpoint.

  1. Click **Create**.

  In the list of transfers, to the right of the transfer name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Activate**. The transfer status changes to `Creating`.

{% endlist %}

After a while, its status will change to `Replicating`. In the {{ CH }} database, a table with the same name as the {{ yds-name }} stream will appear. It will contain the transferred data.

