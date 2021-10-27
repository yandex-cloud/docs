# Working with data via the management console

After [creating a database](../create-db.md), perform basic YQL queries using the {{ yandex-cloud }} management console.

{% note tip %}

For more information about the YQL syntax, see the [YQL reference](../../yql/reference/overview.md).

{% endnote %}

## Create a table {#create-table}

Create a table in the DB using the [CREATE TABLE](../../yql/reference/syntax/create_table.md) instruction:

{% list tabs %}

- Management console

  {% include [create-schema-via-console](../../_includes/create-new-table-via-console.md) %}

{% endlist %}

## Add data {#replace-data}

Add data to the table using the [REPLACE INTO](../../yql/reference/syntax/replace_into.md) instruction:

{% list tabs %}

- Management console

  {% include [replace-data-via-console](../../_includes/replace-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Table preview](../../_assets/db_ui_table_preview.png)

{% endif %}

## Update data {#update-data}

Update the existing data in the table using the [UPDATE](../../yql/reference/syntax/update.md) instruction:

{% list tabs %}

- Management console

  {% include [update-data-via-console](../../_includes/update-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Update preview](../../_assets/db_ui_run_update.png)

{% endif %}

## Delete data {#delete-data}

Delete data from the table using the [DELETE](../../yql/reference/syntax/delete.md) instruction:

{% list tabs %}

- Management console

  {% include [delete-data-via-console](../../_includes/delete-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Delete preview](../../_assets/db_ui_run_delete.png)

{% endif %}

## Query data {#select-data}

Query data from the table using the [SELECT](../../yql/reference/syntax/select.md) instruction:

{% list tabs %}

- Management console

  {% include [select-data-via-console](../../_includes/select-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Select from table](../../_assets/db_ui_run_select.png)

{% endif %}

## Delete a table {#drop-table}

Delete a table using the [DROP TABLE](../../yql/reference/syntax/drop_table.md) instruction:

{% list tabs %}

- Management console

  {% include [drop-table-via-console](../../_includes/drop-table-via-console.md) %}

{% endlist %}
