---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/threads/api-ref/Thread/get.md
---

# Threads, REST: Thread.Get

Retrieve details of a specific thread by its ID.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/assistants/v1/threads/{threadId}
```

## Path parameters

Request message for retrieving a thread by ID.

#|
||Field | Description ||
|| threadId | **string**

Required field. ID of the thread to retrieve. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.threads.Thread}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "defaultMessageAuthorId": "string",
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "expiresAt": "string",
  "labels": "object"
}
```

#|
||Field | Description ||
|| id | **string**

Unique identifier of the thread. ||
|| folderId | **string**

ID of the folder that the thread belongs to. ||
|| name | **string**

Name of the thread. ||
|| description | **string**

Description of the thread. ||
|| defaultMessageAuthorId | **string**

Default user ID that will be used as the author for thread messages if no other author is specified. ||
|| createdBy | **string**

Identifier of the subject who created this thread. ||
|| createdAt | **string** (date-time)

Timestamp representing when the thread was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this thread. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this thread was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the thread, defining when and how the thread will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the thread will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the thread. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#