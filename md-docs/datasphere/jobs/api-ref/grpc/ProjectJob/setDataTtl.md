[Документация Yandex Cloud](../../../../../index.md) > [Yandex DataSphere](../../../../index.md) > Справочник API > gRPC (англ.) > [DataSphere Jobs API v2](../index.md) > [ProjectJob](index.md) > SetDataTtl

# DataSphere Jobs API v2, gRPC: ProjectJobService.SetDataTtl

Update job data ttl.

## gRPC request

**rpc SetDataTtl ([SetProjectJobDataTtlRequest](#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlRequest)) returns ([SetProjectJobDataTtlResponse](#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlResponse))**

## SetProjectJobDataTtlRequest {#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlRequest}

```json
{
  "job_id": "string",
  "ttl": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| job_id | **string** ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|#

## SetProjectJobDataTtlResponse {#yandex.cloud.datasphere.v2.jobs.SetProjectJobDataTtlResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#