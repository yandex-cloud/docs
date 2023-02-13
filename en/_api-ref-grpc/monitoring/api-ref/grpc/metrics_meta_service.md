---
editable: false
---

# Monitoring API, gRPC: MetricsMetaService

A set of methods for managing metric metadata.

| Call | Description |
| --- | --- |
| [ListMetrics](#ListMetrics) | Retrieves the list of metrics. |
| [ListMetricNames](#ListMetricNames) | Retrieves the list of metric names. |
| [ListLabelKeys](#ListLabelKeys) | Retrieves the list of label keys. |
| [ListLabelValues](#ListLabelValues) | Retries the list of values for a given label key. |
| [ListAllLabelValues](#ListAllLabelValues) | Retries the list of values for a given label key. |

## Calls MetricsMetaService {#calls}

## ListMetrics {#ListMetrics}

Retrieves the list of metrics.

**rpc ListMetrics ([ListMetricsRequest](#ListMetricsRequest)) returns ([ListMetricsResponse](#ListMetricsResponse))**

### ListMetricsRequest {#ListMetricsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. The maximum string length in characters is 50.
selectors | **string**<br>Metric selectors. 
page_size | **int64**<br>Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListMetricsResponse.next_page_token](#ListMetricsResponse) returned by a previous list request. (Pagination works in concrete zone ID and concrete shard) 


### ListMetricsResponse {#ListMetricsResponse}

Field | Description
--- | ---
metrics[] | **MetricMeta**<br>List of metrics. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. 


### MetricMeta {#MetricMeta}

Field | Description
--- | ---
name | **string**<br>Name of the metric. 
labels | **map<string,string>**<br>Metric labels as `key:value` pairs. 
type | enum **MetricType**<br>Type of the metric. <ul><li>`DGAUGE`: Gauge with fractional values.</li><li>`IGAUGE`: Gauge with integer values.</li><li>`COUNTER`: Counter.</li><li>`RATE`: Rate.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>When metric was created. 


## ListMetricNames {#ListMetricNames}

Retrieves the list of metric names.

**rpc ListMetricNames ([ListMetricNamesRequest](#ListMetricNamesRequest)) returns ([ListMetricNamesResponse](#ListMetricNamesResponse))**

### ListMetricNamesRequest {#ListMetricNamesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. The maximum string length in characters is 50.
selectors | **string**<br>Metric selectors (for new format of metrics only). 
name_filter | **string**<br>Substring name filter text. 
page_size | **int64**<br>Maximum number of metrics in response. 0 means default page size = 30, maximum page size = 10000. 


### ListMetricNamesResponse {#ListMetricNamesResponse}

Field | Description
--- | ---
names[] | **string**<br>List of metric names. 
truncated | **bool**<br>Flag determining that label values response is truncated. 


## ListLabelKeys {#ListLabelKeys}

Retrieves the list of label keys.

**rpc ListLabelKeys ([ListLabelKeysRequest](#ListLabelKeysRequest)) returns ([ListLabelKeysResponse](#ListLabelKeysResponse))**

### ListLabelKeysRequest {#ListLabelKeysRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. The maximum string length in characters is 50.
selectors | **string**<br>Metric selectors. 


### ListLabelKeysResponse {#ListLabelKeysResponse}

Field | Description
--- | ---
keys[] | **string**<br>Found label keys. 


## ListLabelValues {#ListLabelValues}

Retries the list of values for a given label key.

**rpc ListLabelValues ([ListLabelValuesRequest](#ListLabelValuesRequest)) returns ([ListLabelValuesResponse](#ListLabelValuesResponse))**

### ListLabelValuesRequest {#ListLabelValuesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the metric belongs to. The maximum string length in characters is 50.
label_key | **string**<br>Required. For which label key perform values lookup. 
selectors | **string**<br>Metric selectors. 
value_filter | **string**<br>Substring value filter text. 
page_size | **int64**<br>Maximum number of label values for concrete key in response. 0 means default page size = 30, maximum page size = 10000. 


### ListLabelValuesResponse {#ListLabelValuesResponse}

Field | Description
--- | ---
values[] | **string**<br>List of values by given label key. 
max_metrics_count | **int64**<br>Max metrics count given by selectors. 
absent | **bool**<br>Flag determining that there are has some metrics without the given label. 
truncated | **bool**<br>Flag determining that label values response is truncated. 


## ListAllLabelValues {#ListAllLabelValues}

Retries the list of values for a given label key.

**rpc ListAllLabelValues ([ListAllLabelValuesRequest](#ListAllLabelValuesRequest)) returns ([ListAllLabelValuesResponse](#ListAllLabelValuesResponse))**

### ListAllLabelValuesRequest {#ListAllLabelValuesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the fodler that the metric belongs to. The maximum string length in characters is 50.
labels[] | **string**<br>For which label key perform values lookup. 
selectors | **string**<br>Metric selectors. 
value_filter | **string**<br>Substring value filter text. 
page_size | **int64**<br>Maximum number of label values for concrete key in response. 0 means default page size = 30, maximum page size = 10000. 


### ListAllLabelValuesResponse {#ListAllLabelValuesResponse}

Field | Description
--- | ---
labels[] | **LabelValues**<br>List of labels with values. 
max_metrics_count | **int64**<br>Max metrics count given by selectors. 


### LabelValues {#LabelValues}

Field | Description
--- | ---
key | **string**<br>Label key. 
values[] | **string**<br>List of values by given label key. 
absent | **bool**<br>Flag determining that there are has some metrics without the given label. 
truncated | **bool**<br>Flag determining that label values response is truncated. 


