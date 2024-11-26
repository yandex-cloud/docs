---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/jobs/api-ref/grpc/ProjectJob/downloadJobFiles.md
---

# DataSphere Jobs API v2, gRPC: ProjectJobService.DownloadJobFiles

Returns download urls for job files.

## gRPC request

**rpc DownloadJobFiles ([DownloadProjectJobFilesRequest](#yandex.cloud.datasphere.v2.jobs.DownloadProjectJobFilesRequest)) returns ([DownloadProjectJobFilesResponse](#yandex.cloud.datasphere.v2.jobs.DownloadProjectJobFilesResponse))**

## DownloadProjectJobFilesRequest {#yandex.cloud.datasphere.v2.jobs.DownloadProjectJobFilesRequest}

```json
{
  "job_id": "string",
  "files": [
    {
      "desc": {
        "path": "string",
        "var": "string"
      },
      "sha256": "string",
      "size_bytes": "int64",
      "compression_type": "FileCompressionType"
    }
  ]
}
```

#|
||Field | Description ||
|| job_id | **string**

Required field.  ||
|| files[] | **[File](#yandex.cloud.datasphere.v2.jobs.File)** ||
|#

## File {#yandex.cloud.datasphere.v2.jobs.File}

#|
||Field | Description ||
|| desc | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc)** ||
|| sha256 | **string**

SHA256 of the file. ||
|| size_bytes | **int64**

File size in bytes. ||
|| compression_type | enum **FileCompressionType**

File compression info

- `FILE_COMPRESSION_TYPE_UNSPECIFIED`
- `NONE`
- `ZIP` ||
|#

## FileDesc {#yandex.cloud.datasphere.v2.jobs.FileDesc}

#|
||Field | Description ||
|| path | **string**

Path of the file on filesystem. ||
|| var | **string**

Variable to use in cmd substitution. ||
|#

## DownloadProjectJobFilesResponse {#yandex.cloud.datasphere.v2.jobs.DownloadProjectJobFilesResponse}

```json
{
  "download_files": [
    {
      "file": {
        "desc": {
          "path": "string",
          "var": "string"
        },
        "sha256": "string",
        "size_bytes": "int64",
        "compression_type": "FileCompressionType"
      },
      "url": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| download_files[] | **[StorageFile](#yandex.cloud.datasphere.v2.jobs.StorageFile)** ||
|#

## StorageFile {#yandex.cloud.datasphere.v2.jobs.StorageFile}

#|
||Field | Description ||
|| file | **[File](#yandex.cloud.datasphere.v2.jobs.File2)** ||
|| url | **string**

File URL. ||
|#

## File {#yandex.cloud.datasphere.v2.jobs.File2}

#|
||Field | Description ||
|| desc | **[FileDesc](#yandex.cloud.datasphere.v2.jobs.FileDesc2)** ||
|| sha256 | **string**

SHA256 of the file. ||
|| size_bytes | **int64**

File size in bytes. ||
|| compression_type | enum **FileCompressionType**

File compression info

- `FILE_COMPRESSION_TYPE_UNSPECIFIED`
- `NONE`
- `ZIP` ||
|#

## FileDesc {#yandex.cloud.datasphere.v2.jobs.FileDesc2}

#|
||Field | Description ||
|| path | **string**

Path of the file on filesystem. ||
|| var | **string**

Variable to use in cmd substitution. ||
|#