---
editable: false
apiPlayground:
  - url: https://gitlab.{{ api-host }}/gitlab/v1/instances/{instanceId}/backups
    method: get
    path:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            Required field. ID of the GitLab instance to list backups for.
            The maximum string length in characters is 50.
          type: string
      required:
        - instanceId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            Maximum number of results per page. If unspecified, the service uses its default page size.
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token returned by a previous ListBackups request for the same instance.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
alternate:
  - href: en/managed-gitlab/api-ref/Instance/listBackups.md
    type: text/markdown
    title: Markdown version
---

# Managed Service for Gitlab API, REST: Instance.ListBackups

Retrieves the list of backups for the specified GitLab instance.

## HTTP request

```
GET https://gitlab.{{ api-host }}/gitlab/v1/instances/{instanceId}/backups
```

## Path parameters

Request message for InstanceService.ListBackups.

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the GitLab instance to list backups for.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.gitlab.v1.ListInstanceBackupsRequest}

Request message for InstanceService.ListBackups.

#|
||Field | Description ||
|| pageSize | **string** (int64)

Maximum number of results per page. If unspecified, the service uses its default page size.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token returned by a previous ListBackups request for the same instance.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.gitlab.v1.ListInstanceBackupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "instanceId": "string",
      "createdAt": "string",
      "size": "string",
      "startedAt": "string",
      "status": "string",
      "creationType": "string",
      "gitlabVersion": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for InstanceService.ListBackups.

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.gitlab.v1.Backup)**

Backups of the specified GitLab instance. ||
|| nextPageToken | **string**

Token to retrieve the next page. Empty when there are no more results. ||
|#

## Backup {#yandex.cloud.gitlab.v1.Backup}

A backup of a GitLab instance.

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| folderId | **string**

ID of the folder that owns the backup. ||
|| instanceId | **string**

ID of the GitLab instance that owns the backup. ||
|| createdAt | **string** (date-time)

Time when backup creation completed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| size | **string** (int64)

Size of the backup in bytes. ||
|| startedAt | **string** (date-time)

Time when backup creation started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Current status of the backup.

- `COMPLETED`: Backup creation completed successfully.
- `FAILED`: Backup creation failed.
- `CREATING`: Backup creation is in progress. ||
|| creationType | **enum** (CreationType)

How the backup was created.

- `AUTOMATED`: Backup created on a schedule.
- `MANUAL`: Backup created or uploaded manually. ||
|| gitlabVersion | **string**

GitLab version of the source instance when the backup was created. ||
|#