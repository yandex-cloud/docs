---
title: Working with a database schema and datasets in {{ ycdr-full-name }}
description: Follow this guide to learn how to work with a database schema and datasets in {{ ycdr-name }}.
---

# Working with a database schema and datasets

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

## Working with a database schema {#database-schema}

The **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-schema_sChm1 }}** tab contains a hierarchical structure of all available fields in a database.

### Viewing fields {#view-fields}

To view fields:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.title_xK9v2 }}** panel. 
  1. Navigate to the **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-schema_sChm1 }}** tab.
  1. Expand the sections by clicking the arrows.

  For each field the following is displayed:
  * Name
  * Data type

{% endlist %}

### Searching by field {#search-fields}

To find a field:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-schema_sChm1 }}** tab.
  1. Enter a name in the **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.schema-search-placeholder_sSrch }}** field.
  1. The results will be displayed automatically.

{% endlist %}

### Inserting a field into a query {#insert-field}

To insert a field into a query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Click the field in the database schema.
  1. Select **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.schema-insert-action_iNs1A }}**.

  The field name will be added to the query editor at the cursor position.

{% endlist %}

## Working with datasets {#datasets}

The **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-datasets_dSt4K }}** tab contains a list of available datasets and lookup tables.

### Viewing datasets {#view-datasets}

To view datasets:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the data panel.
  1. Navigate to the **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-datasets_dSt4K }}** tab.
  1. Select a dataset from the list.

  For each dataset the following is displayed:
  * Name.
  * Description.
  * List of fields with data types.

{% endlist %}

### Lookup tables {#lookup-tables}

**{{ ui-key.yacloud_org.security.ycdr.query-data-panel.datasets-type-lookup_dTpLk }}** are lookup tables used to enrich data. They are displayed in a separate section on the datasets tab.

To view {{ ui-key.yacloud_org.security.ycdr.query-data-panel.datasets-type-lookup_dTpLk }}:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-datasets_dSt4K }}** tab.
  1. Go to **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.datasets-type-lookup_dTpLk }}**.
  1. Select a table from the list.

{% endlist %}

### Inserting a dataset into a query {#insert-dataset}

To insert a dataset into a query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Find the required dataset.
  1. Click the dataset.
  1. Select **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.schema-insert-action_iNs1A }}**.

  The dataset name will be added to the query editor.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/investigations.md)
* [{#T}](../../concepts/queries.md)
* [{#T}](manage-queries.md)
* [{#T}](work-with-templates.md)