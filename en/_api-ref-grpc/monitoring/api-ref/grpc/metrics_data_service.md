---
editable: false
---

# MetricsDataService

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
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. false The maximum string length in characters is 50.
query | **[DataQuery](#DataQuery)**<br>Query parameters. 


### DataQuery {#DataQuery}

Field | Description
--- | ---
query | **string**<br>Required. Query text. false
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The beginning of the time interval, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. false
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The end of the time interval, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. false
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling parameters. false


### Downsampling {#Downsampling}

Field | Description
--- | ---
mode | **oneof:** `max_points`, `grid_interval` or `disabled`<br>
&nbsp;&nbsp;max_points | **int64**<br>Maximum number of points to be returned. Value must be greater than 10.
&nbsp;&nbsp;grid_interval | **int64**<br>Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point. Value must be greater than 0.
&nbsp;&nbsp;disabled | **bool**<br>Disable downsampling. 
grid_aggregation | enum **GridAggregation**<br>Function that is used for downsampling. <ul><li>`MAX`: Max value.</li><li>`MIN`: Min value.</li><li>`SUM`: Sum of values.</li><li>`AVG`: Average value.</li><li>`LAST`: Last value.</li><li>`COUNT`: Total count of points.</li><ul/>
gap_filling | enum **GapFilling**<br>Parameters for filling gaps in data. <ul><li>`NULL`: Returns `null` as a metric value and `timestamp` as a time series value.</li><li>`NONE`: Returns no value and no timestamp.</li><li>`PREVIOUS`: Returns the value from the previous time interval.</li><ul/>


### ReadMetricsDataResponse {#ReadMetricsDataResponse}

Field | Description
--- | ---
metrics[] | **[MetricData](#MetricData)**<br>List of metrics with timeseries. 


### MetricData {#MetricData}

Field | Description
--- | ---
name | **string**<br>Name of the metric. 
labels | **map<string,string>**<br>List of metric labels as `key:value` pairs. 
type | enum **[MetricType](./#MetricType)**<br>Type of the metric. <ul><li>`DGAUGE`: Gauge with fractional values.</li><li>`IGAUGE`: Gauge with integer values.</li><li>`COUNTER`: Counter.</li><li>`RATE`: Rate.</li><ul/>
timeseries | **[Timeseries](#Timeseries)**<br>Metric values. 


### Timeseries {#Timeseries}

Field | Description
--- | ---
timestamps[] | **int64**<br>List of timestamps as unix-time milliseconds. 
double_values[] | **double**<br>List of double values. 
int64_values[] | **int64**<br>List of int64 values. Only for `IGAUGE` metric type. 


## Write {#Write}

Writes metric data to Monitoring.

**rpc Write ([WriteMetricsDataRequest](#WriteMetricsDataRequest)) returns ([WriteMetricsDataResponse](#WriteMetricsDataResponse))**

### WriteMetricsDataRequest {#WriteMetricsDataRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. false The maximum string length in characters is 50.
service | **string**<br>Required. ID of the service that the metric belongs to. Use `service=custom` for custom metrics. false The maximum string length in characters is 50.
data | **oneof:** `raw_data` or `typed_data`<br>
&nbsp;&nbsp;raw_data | **RawData**<br>Raw metrics data. 
&nbsp;&nbsp;typed_data | **TypedData**<br>Typed metrics data. 


### RawData {#RawData}

Field | Description
--- | ---
content_type | **string**<br>Required. Query content type. Use "application/json". false
content | **bytes**<br>Required. Query content. false


### TypedData {#TypedData}

Field | Description
--- | ---
metrics[] | **[MetricData](#MetricData1)**<br>List of metrics with timeseries. 


### WriteMetricsDataResponse {#WriteMetricsDataResponse}

Field | Description
--- | ---
written_metrics_count | **int64**<br>Number of successfully written metrics. 
partial_failure_error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Error message if the writing failed. 


