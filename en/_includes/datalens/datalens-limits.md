
#### Quotas {#datalens-quotas}

There are no quotas for {{ datalens-short-name }}.



#### General limits {#datalens-common-limits}

{% note info %}

{{ datalens-short-name }} has no limitation on the amount of data on the source you are connecting to.

{% endnote %}


Type of limit | Value
----- | -----
Maximum number of {{ datalens-short-name }} instances per organization. | 1
Maximum size of imported CSV file | 200 MB
Maximum number of tables in a single dataset | 32
Maximum number of fields in a single dataset | 1200
Maximum chart export size | 50 MB


#### Chart data limits {#datalens-chart-data-limits}

Charts in {{ datalens-short-name }} can only display a limited amount of data. If the number of rows (columns and cells for pivot tables) in a dataset exceeds the established limit, the chart will not be built. Therefore, to build a chart from data in a large dataset, select a part of the data to display based on the limits below using the [filters](../../datalens/dataset/settings.md#default-setting):

Chart type | I/O
----- | -----
**Charts** |
Line chart | 75,000 rows
Area chart<br/>Normalized area chart | 75,000 rows
Column chart<br/>Normalized column chart | 75,000 rows
Bar chart<br/>Normalized bar chart | 75,000 rows
Scatter chart | 75,000 rows
Pie chart | 1,000 rows
Tree chart | 1,000 rows
**Tables** |
Table | 100,000 rows
Pivot table | 100,000 cells
Pivot table | 800 columns
**Geomaps** |
Point map | 40,000 rows
Point map with clusters | 40,000 points
Choropleth map | 40,000 rows
Heat map | 40,000 rows
Polyline map | 40,000 rows
