---
editable: false
apiPlayground:
  - url: https://gitlab.{{ api-host }}/gitlab/v1/instances/{instanceId}/backups/{backupId}:getDownloadUrls
    method: get
    path:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            Required field. ID of the GitLab instance that owns the backup.
            The maximum string length in characters is 50.
          type: string
        backupId:
          description: |-
            **string**
            Required field. ID of the completed backup to download.
            The maximum string length in characters is 50.
          type: string
      required:
        - instanceId
        - backupId
      additionalProperties: false
    query:
      type: object
      properties:
        ttl:
          description: |-
            **string** (duration)
            Lifetime of the download URLs, from 1 hour to 7 days. Defaults to 1 hour.
          type: string
          format: duration
      additionalProperties: false
    body: null
    definitions: null
alternate:
  - href: en/managed-gitlab/api-ref/Instance/getBackupDownloadUrls.md
    type: text/markdown
    title: Markdown version
---

# Managed Service for Gitlab API, REST: Instance.GetBackupDownloadUrls

Returns temporary download URLs for a completed backup and its GitLab secrets file.

## HTTP request

```
GET https://gitlab.{{ api-host }}/gitlab/v1/instances/{instanceId}/backups/{backupId}:getDownloadUrls
```

## Path parameters

Request message for InstanceService.GetBackupDownloadUrls.

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the GitLab instance that owns the backup.

The maximum string length in characters is 50. ||
|| backupId | **string**

Required field. ID of the completed backup to download.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.gitlab.v1.GetBackupDownloadUrlsRequest}

Request message for InstanceService.GetBackupDownloadUrls.

#|
||Field | Description ||
|| ttl | **string** (duration)

Lifetime of the download URLs, from 1 hour to 7 days. Defaults to 1 hour. ||
|#

## Response {#yandex.cloud.gitlab.v1.GetBackupDownloadUrlsResponse}

**HTTP Code: 200 - OK**

```json
{
  "backupPresignedUrl": "string",
  "secretsPresignedUrl": "string"
}
```

Response message for InstanceService.GetBackupDownloadUrls.

#|
||Field | Description ||
|| backupPresignedUrl | **string**

Signed URL for downloading the GitLab backup archive. ||
|| secretsPresignedUrl | **string**

Signed URL for downloading the gitlab-secrets.json file. ||
|#