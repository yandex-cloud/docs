---
editable: false
---

# Monitoring API, gRPC: MetricsDataService

A set of methods for managing metric data.

| Call | Description |
| --- | --- |
| [Read](#Read) | Returns metric data from Monitoring. |
| [Write](#Write) | Writes metric data to Monitoring. |

## Calls MetricsDataService {#calls}

## Read {#Read}

Returns metric data from Monitoring.

**rpc Read ([ReadMetricsDataRequest](#ReadMetricsDataRequest)) returns ([ReadMetricsDataResponse](#ReadMetricsDataResponse))**

### ReadMetricsDataRequest {#ReadMetricsDataRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. The maximum string length in characters is 50.
query | **string**<br>Required. Query text. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The beginning of the time interval, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The end of the time interval, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling parameters. 


### Downsampling {#Downsampling}

Field | Description
--- | ---
mode | **oneof:** `max_points`, `grid_interval` or `disabled`<br>List of available gap filling policy for downsampling.
&nbsp;&nbsp;max_points | **int64**<br>Maximum number of points to be returned. 
&nbsp;&nbsp;grid_interval | **int64**<br>Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point. 
&nbsp;&nbsp;disabled | **bool**<br>Disable downsampling. 
grid_aggregation | enum **GridAggregation**<br>Function that is used for downsampling. <ul><li>`GRID_AGGREGATION_MAX`: Max value.</li><li>`GRID_AGGREGATION_MIN`: Min value.</li><li>`GRID_AGGREGATION_SUM`: Sum of values.</li><li>`GRID_AGGREGATION_AVG`: Average value.</li><li>`GRID_AGGREGATION_LAST`: Last value.</li><li>`GRID_AGGREGATION_COUNT`: Total count of points.</li></ul>
gap_filling | enum **GapFilling**<br>Parameters for filling gaps in data. <ul><li>`GAP_FILLING_NULL`: Returns `null` as a metric value and `timestamp` as a time series value.</li><li>`GAP_FILLING_NONE`: Returns no value and no timestamp.</li><li>`GAP_FILLING_PREVIOUS`: Returns the value from the previous time interval.</li></ul>


### ReadMetricsDataResponse {#ReadMetricsDataResponse}

Field | Description
--- | ---
metrics[] | **[ReadMetricData](#ReadMetricData)**<br>List of metrics with timeseries. 


### ReadMetricData {#ReadMetricData}

Field | Description
--- | ---
alias | **string**<br>Alias. 
name | **string**<br>Name of the metric. 
labels | **map<string,string>**<br>List of metric labels as `key:value` pairs. 
type | enum **[MetricType](./#MetricType)**<br>Type of the metric. <ul><li>`DGAUGE`: Gauge with fractional values.</li><li>`IGAUGE`: Gauge with integer values.</li><li>`COUNTER`: Counter.</li><li>`RATE`: Rate.</li></ul>
timeseries | **[Timeseries](#Timeseries)**<br>Metric timeseries. 


### Timeseries {#Timeseries}

Field | Description
--- | ---
timestamps[] | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>List of timestamps. 
values | **oneof:** `double_values` or `int64_values`<br>
&nbsp;&nbsp;double_values | **DoubleValues**<br>List of double values. 
&nbsp;&nbsp;int64_values | **Int64Values**<br>List of int64 values. Only for `IGAUGE` or 'COUNTER' metric type. 


### DoubleValues {#DoubleValues}

Field | Description
--- | ---
values[] | **double**<br> 


### Int64Values {#Int64Values}

Field | Description
--- | ---
values[] | **int64**<br> 


## Write {#Write}

Writes metric data to Monitoring.

**rpc Write ([WriteMetricsDataRequest](#WriteMetricsDataRequest)) returns ([WriteMetricsDataResponse](#WriteMetricsDataResponse))**

### WriteMetricsDataRequest {#WriteMetricsDataRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. The maximum string length in characters is 50.
service | **string**<br>Required. ID of the service that the metric belongs to. Use `service=custom` for custom metrics. The maximum string length in characters is 50.
data | **oneof:** `raw_data`<br>
&nbsp;&nbsp;raw_data | **RawData**<br>Raw metrics data. 


### RawData {#RawData}

Field | Description
--- | ---
content_type | **string**<br>Required. Query content type. Use "application/json". 
content | **bytes**<br>Required. Query content. 


### WriteMetricsDataResponse {#WriteMetricsDataResponse}

Field | Description
--- | ---
written_metrics_count | **int64**<br>Number of successfully written metrics. 


