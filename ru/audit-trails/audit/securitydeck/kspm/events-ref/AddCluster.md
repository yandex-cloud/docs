---
editable: false
---

# Security Deck KSPM Audit Trails Events: AddCluster

## Event JSON schema {#yandex.cloud.audit.securitydeck.kspm.AddCluster2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "eventStatus": "string",
  "details": {
    "clusterId": "string",
    "projectId": "string"
  }
}
```

## Field description {#yandex.cloud.audit.securitydeck.kspm.AddCluster2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| details | **[ClusterEventDetails](#yandex.cloud.audit.securitydeck.kspm.ClusterEventDetails)** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## ClusterEventDetails {#yandex.cloud.audit.securitydeck.kspm.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| projectId | **string** ||
|#