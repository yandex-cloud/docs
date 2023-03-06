#### Quotas {#monitoring-quotas}
| Type of limit | Value |
----- | -----
| Number of alerts per cloud | 10 |
| Number of metrics per service in the folder | 1000000 |

#### General limits {#monitoring-common-limits}
| Type of limit | Value |
----- | -----
| Number of labels per metric<br/>(including mandatory ones) | 16 |
| Number of values for a single label | 1000 |

#### API limits {#monitoring-api-limits}
| Type of limit | Value |
----- | -----
| Maximum number of metrics returned in the data export API request | 500 |
| Maximum number of metrics sent in the data import API request | 10000 |
| Minimum number of points returned in the data export API request | 10 |
| Maximum number of points returned in the data export API request | 10000 |
| Minimum possible interval for exporting metrics | 1 second |

#### Alerting limits {#monitoring-alerting-limits}
| Type of limit | Value |
----- | -----
| Number of metrics per alert | 100 |
| {% if product == "yandex-cloud" %}Number of SMS per number per day | 50{% endif %} |