---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Job/listLog.md
---

# Data Proc API, REST: Job.ListLog

Returns a log for specified job.

## HTTP request

```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/jobs/{jobId}:logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the job is being created for. ||
|| jobId | **string**

Required field. ID of the job being created. ||
|#

## Query parameters {#yandex.cloud.dataproc.v1.ListJobLogRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum bytes of job log per response to return. If the number of available
bytes is larger than `pageSize`, the service returns a [ListJobLogResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListJobLogResponse)
that can be used to get the next page of output in subsequent list requests.
Default value: 1048576. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListJobLogResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListJobLogResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.dataproc.v1.ListJobLogResponse}

**HTTP Code: 200 - OK**

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