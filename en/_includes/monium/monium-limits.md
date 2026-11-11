**General limits**

Type of limit | Value
----- | -----
Number of labels per metric (including required ones) | {{ labels_per_mtetric_limit }}
Number of values per label | 1,000
Number of metrics that can be read and processed per graph | 40,000

**API limits**

Type of limit | Value
----- | -----
Maximum number of metrics returned in the data export API request | 2,000
Maximum number of time series per `match[]` selector in a `/api/v1/series` request | 20,000
Maximum number of time series that can be read per `/api/v1/query` or `/api/v1/query_range` request | 300,000
Maximum number of metrics sent in the data import API request | 10,000
Minimum number of samples returned in the data export API request | 10
Maximum number of samples returned in the data export API request | 10,000
Minimum time interval for exporting metrics | 1 second

**Alerting limits**

Type of limit | Value
----- | -----
Number of metrics per basic alert or subalert | {{ alerting-metrics-limit }}
Number of SMS per number per day | 100
Number of concurrent escalations | 100
Number of concurrent calls | 10
Number of calls per month | 10,000
