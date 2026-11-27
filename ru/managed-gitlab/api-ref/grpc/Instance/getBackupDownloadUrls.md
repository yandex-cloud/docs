---
editable: false
alternate:
  - href: ru/managed-gitlab/api-ref/grpc/Instance/getBackupDownloadUrls.md
    type: text/markdown
    title: Markdown version
---

# Managed Service for Gitlab API, gRPC: InstanceService.GetBackupDownloadUrls

Returns temporary download URLs for a completed backup and its GitLab secrets file.

## gRPC request

**rpc GetBackupDownloadUrls ([GetBackupDownloadUrlsRequest](#yandex.cloud.gitlab.v1.GetBackupDownloadUrlsRequest)) returns ([GetBackupDownloadUrlsResponse](#yandex.cloud.gitlab.v1.GetBackupDownloadUrlsResponse))**

## GetBackupDownloadUrlsRequest {#yandex.cloud.gitlab.v1.GetBackupDownloadUrlsRequest}

```json
{
  "instance_id": "string",
  "backup_id": "string",
  "ttl": "google.protobuf.Duration"
}
```

Request message for InstanceService.GetBackupDownloadUrls.

#|
||Field | Description ||
|| instance_id | **string**

Required field. ID of the GitLab instance that owns the backup.

The maximum string length in characters is 50. ||
|| backup_id | **string**

Required field. ID of the completed backup to download.

The maximum string length in characters is 50. ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Lifetime of the download URLs, from 1 hour to 7 days. Defaults to 1 hour. ||
|#

## GetBackupDownloadUrlsResponse {#yandex.cloud.gitlab.v1.GetBackupDownloadUrlsResponse}

```json
{
  "backup_presigned_url": "string",
  "secrets_presigned_url": "string"
}
```

Response message for InstanceService.GetBackupDownloadUrls.

#|
||Field | Description ||
|| backup_presigned_url | **string**

Signed URL for downloading the GitLab backup archive. ||
|| secrets_presigned_url | **string**

Signed URL for downloading the gitlab-secrets.json file. ||
|#