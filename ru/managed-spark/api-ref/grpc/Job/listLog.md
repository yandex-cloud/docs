---
editable: false
sourcePath: en/_api-ref-grpc/spark/v1/api-ref/grpc/Job/listLog.md
---

# Managed Spark API, gRPC: JobService.ListLog

Returns a log for Spark job.

## gRPC request

**rpc ListLog ([ListJobLogRequest](#yandex.cloud.spark.v1.ListJobLogRequest)) returns ([ListJobLogResponse](#yandex.cloud.spark.v1.ListJobLogResponse))**

## ListJobLogRequest {#yandex.cloud.spark.v1.ListJobLogRequest}

```json
{
  "cluster_id": "string",
  "job_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Spark cluster. ||
|| job_id | **string**

Required field. ID of the Spark job to return. ||
|| page_size | **int64**

The maximum length of job output per papge that should be returned.
If the number of available output is larger tha `page_size`, the service returns
a `next_page_token` that can be used to get the next page of job output in subsequent ListLog requests.
Acceptable values are 0 to 1048576. Default value: 1048576. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListLog
request to get the next page of results. ||
|#

## ListJobLogResponse {#yandex.cloud.spark.v1.ListJobLogResponse}

```json
{
  "content": "string",
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| content | **string**

Requested part of Spark Job log. ||
|| next_page_token | **string**

This token allows you to get the next page of results for ListLog requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListLog request. Subsequent ListLog
requests will have their own `next_page_token` to continue paging through the results. ||
|#