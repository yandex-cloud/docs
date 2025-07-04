#### Quotas {#monitoring-quotas}

#|
|| Type of limitation | Value ||
|| Number of alerts per cloud
`monitoring.alerts.count` | 1,000 ||
|| Number of metrics per service in the folder | 1,000,000 ||
|#

#### General limits {#monitoring-common-limits}
Type of limitation | Value
----- | -----
Number of labels per metric<br/>(including required ones) | 16
Number of values per label | 1,000

#### API limits {#monitoring-api-limits}
Type of limitation | Value
----- | -----
Maximum number of metrics returned in the data export API request | 500
Maximum number of metrics sent in the data import API request | 10,000
Minimum number of samples returned in the data export API request | 10
Maximum number of samples returned in the data export API request | 10,000
Minimum time interval for exporting metrics | 1 second

#### Alerting limits {#monitoring-alerting-limits}
Type of limitation | Value
----- | -----
Number of metrics per alert | 100
Number of SMS per number per day | 100