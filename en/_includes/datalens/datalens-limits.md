#### Quotas {#datalens-quotas}

There are no quotas for {{ datalens-short-name }}.

#### General limits {#datalens-common-limits}

| Type of limit | Value |
| ----- | ----- |
| Number of DataLens instances per organization or cloud | 1 |
| Maximum CSV file size | 200 MB |
| Maximum number of rows of persisted data<br>per dataset | 100,000,000 |
| Maximum number of tables in a single dataset | 32 |
| Maximum number of fields in a single dataset | 1,200 |

#### Chart data limits {#datalens-chart-data-limits}

Each chart has a limit on the amount of data it can display.

Every time {{ datalens-short-name }} tries to visualize a chart, it makes a request to a dataset.
If a metric (such as the number of rows returned) is over limit, {{ datalens-short-name }} will not display the chart.

You can modify the amount of data returned. Modify the query parameters to filter out some rows, for example.

| Chart type | Value |
| ----- | ----- |
| **Charts** |
| Line chart | 75,000 rows |
| Stacked area chart<br/>Normalized stacked area chart | 75,000 rows |
| Column chart<br/>Normalized column chart | 75,000 rows |
| Bar chart<br/>Normalized bar chart | 75,000 rows |
| Scatter chart | 75,000 rows |
| Pie chart | 1000 rows |
| Tree chart | 1000 rows |
| **Tables** |
| Table | 100,000 rows |
| Pivot table | 100,000 cells |
| Pivot table | 800 columns |
| **Geomaps** |
| Point map | 40,000 rows |
| Background map | 40,000 rows |
| Heat map | 40,000 rows |
| Polyline map | 40,000 rows |
