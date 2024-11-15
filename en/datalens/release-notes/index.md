---
title: '{{ datalens-full-name }} release notes: September 2024'
description: Check out {{ datalens-full-name }} release notes for September 2024.
---

# {{ datalens-full-name }} release notes: September 2024


* [Changes in basic features](#base)
* [Changes available with the _Business_ service plan](#business)

## Changes in basic features {#base}




### Special FQDNs in connections {#special-fqdns}

In connections to [{{ CH }}](../operations/connection/create-clickhouse.md), [{{ PG }}](../operations/connection/create-postgresql.md), [{{ MY }}](../operations/connection/create-mysql.md), or [{{ GP }}](../operations/connection/create-greenplum.md), now you can select a special FQDN that points to the current master host or the latest replica.

For standard FQDNs, now you can specify multiple hosts for connection.

### Integration with {{ connection-manager-name }} {#dash-link-settings}

Now, there is integration with [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) for connections:

* [{{ CH }}](../operations/connection/create-clickhouse.md)
* [{{ PG }}](../operations/connection/create-postgresql.md)
* [{{ MY }}](../operations/connection/create-mysql.md)


### Pinning widgets {#widget-fixation}

Now, you can [pin (i.e. lock the position of) a widget](../dashboard/settings.md#widget-fixation) in dedicated lock areas at the top of the dashboard. These areas stay locked as you scroll the page, and the widgets pinned on them keep their position.

### Freezing table columns {#column-fixation}

For [regular](../visualization-ref/table-chart.md#column-fixation) and [pivot](../visualization-ref/pivot-table-chart.md#column-fixation) tables, now you can freeze one or more columns. Once frozen, these columns stay in place as you scroll horizontally.

### New bulk operations with fields {#bulk-changes}

In the [dataset](../dataset/index.md), new bulk operations with marked fields. Now, you can change their types or aggregation.

![screenshot](../../_assets/datalens/dataset/dataset-fields-bulk-changes-2.png)

### Support for markup functions in charts {#markup-support}

In charts, you now can employ [markup functions](../function-ref/markup-functions.md) in labels, e.g., under **Labels**, you can add a field with the formula:

```markdown
MARKUP(
    COLOR(STR([OrderCount]), IF ([OrderCount] < 7000) THEN 'red' ELSE 'green' END),
    BR(),
    IF(LEN([ProductSubcategory]) > 15) THEN LEFT([ProductSubcategory],15) +'...' ELSE [ProductSubcategory] END
)
```

![image](../../_assets/datalens/release-notes/markup-chart.png)

### Using _markdown_ to sign charts and map tooltip {#markdown-sign-map-tooltips}

Now, in [signatures](../concepts/chart/settings.md#sign) for charts and [map tooltips](../concepts/chart/settings.md#map-settings), you can configure formatting for fields with the `String` type, using the basic [_markdown_](../dashboard/markdown.md) syntax. To do this, click the icon before the field name and enable **Markdown**.

{% cut "Markdown in chart signatures" %}

![image](../../_assets/datalens/release-notes/markdown-chart.png)

{% endcut %}

{% cut "Markdown in map tooltips" %}

![image](../../_assets/datalens/release-notes/markdown-chart-map.png)

{% endcut %}

### Configuring RLS for user groups {#group-rls}

In the dataset, now, you can configure [RLS for user groups](../security/row-level-security.md#group-rls).

### Filtering charts by other charts for maps {#chart-chart-map-filtration}

Now, you can [filter charts by charts](../dashboard/chart-chart-filtration.md) for [maps](../visualization-ref/map-chart.md). Clicking a map element applies filtering by all the dimensions used in the chart except the coordinates themselves.


### Field hints in a chart {#hint-fields}

We fixed the bug that caused field hints to disappear after changing a dataset in a chart.

### Dataset access error {#dataset-access-error}

We fixed the issue where a different type of error was displayed instead of the message about no access permissions to the dataset.

### Displaying charts as tables {#chart-as-table}

We fixed the bug with displaying charts as tables. To open your chart as a table, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/layout-cells.svg) **Open as a table** in the top-right corner of the chart.

### Fixing tables {#table-fix}

We fixed these table related errors:

* Incorrect display of old dates.
* Wrong colors in a table after updating filters.
* Incorrect display of the **Totals** row.
* In a table with hierarchy, when pagination was enabled, only the first rows were displayed and there was no navigator to move through the pages.

### **Heat map** chart display {#heat-map-fix}

Fixed the display of [Heat map](../visualization-ref/heat-map-chart.md) chart in the wizard.


### Dashboard link settings {#dash-link-settings}

In dashboards, when setting up a link for access, now you can save the state of your selectors and share the link with the federation:

1. At the top of your dashboard, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) **Share**.
1. In the window that opens, set up:

   * The menu language, theme, and appearance.
   * (Optional) Save the selector values.
   * (Optional) If you have an [identity federation](../../organization/concepts/add-federation.md), save the federation to share your link with the federation users.

1. Copy the link with the set design parameters by clicking **Copy and close**.

## Changes available with the _Business_ service plan {#business}

### Reports {#reports}

Now, {{ datalens-short-name }} support [reports](../reports/index.md), i.e., multi-page documents that you can export to PDF and print. You can add charts, text blocks, headers, and images to report pages.

### Restrictions on embedding private objects {#private-embedded-connections}

Now, you cannot create a [private embedding](../security/private-embedded-objects.md) for an object if it has dependent objects that are built based on the following connections:

* [Snowflake](../operations/connection/create-snowflake.md)
* [Metrica](../operations/connection/create-metrica-api.md)
* [AppMetrica](../operations/connection/create-appmetrica.md)
* [{{ yandex-cloud }} Billing](../operations/connection/create-cloud-billing.md)
* [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md)

### Embedding settings {#private-embedded-setings}

Now, you can edit embeddings for private objects. In the object row in your workbook, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **Embedding settings**.

