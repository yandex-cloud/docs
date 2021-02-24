#### Quotas {#datalens-quotas}

| Type of limit | Value |
| ----- | ----- |
| Geocoding* (number of unique records per day) in the Free plan | 0 |
| Geocoding* (number of unique records per day) in the Standard plan | 25,000 |

\* Geocoding functions: [GEOCODE](../../datalens/function-ref/GEOCODE.md) and [GEOINFO](../../datalens/function-ref/GEOINFO.md).

#### General limits {#datalens-common-limits}

| Type of limit | Value |
| ----- | ----- |
| Number of DataLens instances per cloud | 1 |
| Maximum CSV file size | 200 MB |
| Maximum number of rows of persisted data<br>per dataset | 100,000,000 |
| Maximum number of tables per dataset | 32 |

#### Chart data limits {#datalens-chart-data-limits}

Each chart has a limit on the amount of data it can display.

Every time {{ datalens-short-name }} tries to visualize a chart, it makes a request to a dataset.
If the number of rows in the response exceeds the limit, {{ datalens-short-name }} doesn't display the chart.

You can change the number of data rows per response in request parameters, for example, by filtering.

| Chart type | Number of data rows from a dataset<br/>that the chart can display |
| ----- | ----- |
| **Charts** |
| Line chart | 75,000 |
| Area chart<br/>Normalized area chart | 75,000 |
| Column chart<br/>Normalized column chart | 75,000 |
| Bar chart<br/>Normalized bar chart | 75,000 |
| Scatter chart | 75,000 |
| Pie chart | 1000 |
| Tree chart | 1000 |
| **Tables** |
| Table | 100,000 |
| Pivot table | 50,000 |
| **Geomaps** |
| Point map | 40,000 |
| Choropleth map | 40,000 |
| Heat map | 60,000 |

