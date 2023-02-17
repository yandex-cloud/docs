# About {{ datalens-full-name }}

[{{ datalens-full-name }}](https://datalens.yandex-team.ru) is a service for visualization and {% if lang == "ru" and audience != "internal" %}[analytics](../glossary/data-analytics){% else %}analytics{% endif %} that enables you to build advanced charts and dashboards based on data from multiple sources.

DataLens has three tools for creating charts (graphs, tables, maps): **Wizard**, **QL charts**, and **ChartEditor**.

A [**Wizard**](concepts/index.md) is a tool well-known to the Tableau and PowerBI community that enables you to create datasets and visualize their data in the GUI by dragging fields between sections and adding formulas.

[**QL charts**](concepts/chart/index.md#sql-charts) is a method of creating a chart using a query language. You build a QL query against the source, and the query result is shown in the chart. QL charts can use databases, as well as Prometheus or Monitoring, as their sources. User-defined SQL queries are used to access the database, and to access Prometheus or Monitoring, the user builds a query in the Prometheus or Monitoring native query languages.

[**ChartEditor**](editor/architecture.md) is an editor that enables you to create widgets for data visualization by writing JavaScript code. ChartEditor enables you to use data from a [a multitude of sources](editor/sources/index.md) and process them as you like. This makes it a very flexible tool.

{% if audience == "internal" %}

Access to СhartEditor is [restricted](editor/index.md) for external employees.

{% endif %}

Charts can be easily added to [dashboards](concepts/dashboard.md), enhanced by control elements (such as selectors or tooltips), and distributed automatically as reports across your email addresses.

In addition to user tools, we provide you with [APIs](api/index.md) for: [data](api/dashboards/data.md), [screenshots](api/dashboards/scr.md), [comments](api/dashboards/comments/index.md), [dashboards](api/dashboards/dash/index.md), [charts](api/dashboards/charts.md), [workbooks](api/workbooks/index.md), and provide an option to embed charts to other our services, both using iframe and our [ChartKit](chartkit/index.md) React component.
