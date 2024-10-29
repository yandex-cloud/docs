---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Job/listLog.md
---

# Data Proc API, gRPC: JobService.ListLog {#ListLog}

Returns a log for specified job.

## gRPC request

**rpc ListLog ([ListJobLogRequest](#yandex.cloud.dataproc.v1.ListJobLogRequest)) returns ([ListJobLogResponse](#yandex.cloud.dataproc.v1.ListJobLogResponse))**

## ListJobLogRequest {#yandex.cloud.dataproc.v1.ListJobLogRequest}

```json
{
  "clusterId": "string",
  "jobId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the job is being created for. ||
|| jobId | **string**

ID of the job being created. ||
|| pageSize | **int64**

The maximum bytes of job log per response to return. If the number of available
bytes is larger than `pageSize`, the service returns a [ListJobLogResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListJobLogResponse)
that can be used to get the next page of output in subsequent list requests.
Default value: 1048576. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListJobLogResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListJobLogResponse) returned by a previous list request. ||
|#

## ListJobLogResponse {#yandex.cloud.dataproc.v1.ListJobLogResponse}

```json
{
  "content": "string",
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| content | **string**

Requested part of Data Proc Job log. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListLog requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListLog request. Subsequent ListLog
requests will have their own `next_page_token` to continue paging through the results. ||
|#