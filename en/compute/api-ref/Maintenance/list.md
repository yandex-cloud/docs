---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/maintenances
    method: get
    path: null
    query:
      type: object
      properties:
        cloudId:
          description: |-
            **string**
            Cloud ID for the resources.
            Includes only one of the fields `cloudId`, `folderId`, `resourceId`.
            Container specifies the resources for which to list maintenances. (Required)
          type: string
        folderId:
          description: |-
            **string**
            Folder ID for the resources.
            Includes only one of the fields `cloudId`, `folderId`, `resourceId`.
            Container specifies the resources for which to list maintenances. (Required)
          type: string
        resourceId:
          description: |-
            **string**
            Resource ID of the target resource.
            Includes only one of the fields `cloudId`, `folderId`, `resourceId`.
            Container specifies the resources for which to list maintenances. (Required)
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of maintenances to return per response.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token to retrieve the next page of results. Omitted on the first request.
          type: string
        orderBy:
          description: |-
            **string**
            By which field the listing should be ordered and in which direction,
            format is "created_at desc". The default sorting order is ascending.
            Supported fields: ["created_at", "start_scheduled_at", "started_at"].
          type: string
        filter:
          description: |-
            **string**
            Filter list by various fields.
            Supported fields: ["status", "resource_type", "resource_id"]
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/Maintenance/list.md
---

# Compute Cloud API, REST: Maintenance.List

Lists maintenances by conditions, specified in request.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/maintenances
```

## Query parameters {#yandex.cloud.maintenance.v2.ListMaintenancesRequest}

ListMaintenancesRequest allows listing maintenances by cloud ID, folder ID, resource type or resource ID.

#|
||Field | Description ||
|| cloudId | **string**

Cloud ID for the resources.

Includes only one of the fields `cloudId`, `folderId`, `resourceId`.

Container specifies the resources for which to list maintenances. (Required) ||
|| folderId | **string**

Folder ID for the resources.

Includes only one of the fields `cloudId`, `folderId`, `resourceId`.

Container specifies the resources for which to list maintenances. (Required) ||
|| resourceId | **string**

Resource ID of the target resource.

Includes only one of the fields `cloudId`, `folderId`, `resourceId`.

Container specifies the resources for which to list maintenances. (Required) ||
|| pageSize | **string** (int64)

The maximum number of maintenances to return per response. ||
|| pageToken | **string**

Token to retrieve the next page of results. Omitted on the first request. ||
|| orderBy | **string**

By which field the listing should be ordered and in which direction,
format is "created_at desc". The default sorting order is ascending.
Supported fields: ["created_at", "start_scheduled_at", "started_at"]. ||
|| filter | **string**

Filter list by various fields.
Supported fields: ["status", "resource_type", "resource_id"] ||
|#

## Response {#yandex.cloud.maintenance.v2.ListMaintenancesResponse}

**HTTP Code: 200 - OK**

```json
{
  "maintenances": [
    {
      "id": "string",
      "resourcePath": [
        {
          "id": "string",
          "type": "string"
        }
      ],
      "description": "string",
      "details": [
        {
          "key": "string",
          "value": "string"
        }
      ],
      "status": "string",
      "createdAt": "string",
      "startScheduledAt": "string",
      "completionScheduledAt": "string",
      "maxStartScheduledAt": "string",
      "startedAt": "string",
      "succeededAt": "string",
      "cancelledAt": "string",
      "userControllable": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| maintenances[] | **[Maintenance](#yandex.cloud.maintenance.v2.Maintenance)**

List of maintenances. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## Maintenance {#yandex.cloud.maintenance.v2.Maintenance}

#|
||Field | Description ||
|| id | **string**

ID of the maintenance. ||
|| resourcePath[] | **[Resource](#yandex.cloud.maintenance.v2.Maintenance.Resource)**

Full path to the resource affected by maintenance,
represented as a hierarchy from specific resource to top-level container.
Example for a Compute instance with ID "I" in folder "F" and cloud "C":
resource_path = [
{ "compute.instance", "I" },
{ "resource-manager.folder", "F" },
{ "resource-manager.cloud", "C" }
] ||
|| description | **string**

Describes action to be performed. ||
|| details[] | **[Detail](#yandex.cloud.maintenance.v2.Maintenance.Detail)**

Service-specific details. ||
|| status | **enum** (Status)

Status of the maintenance.

- `STATUS_UNSPECIFIED`: Not set.
- `SCHEDULED`: Maintenance is scheduled for a future time.
- `RUNNING`: Maintenance is currently running.
- `SUCCEEDED`: Maintenance completed successfully.
- `CANCELLED`: Maintenance is cancelled and will not run. ||
|| createdAt | **string** (date-time)

The creation time of the maintenance.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| startScheduledAt | **string** (date-time)

The time when the maintenance was scheduled to start.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| completionScheduledAt | **string** (date-time)

The time when the maintenance is estimated to complete. Optional.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| maxStartScheduledAt | **string** (date-time)

Latest time the maintenance can be postponed to.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| startedAt | **string** (date-time)

The time time when the maintenance has actually started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| succeededAt | **string** (date-time)

The time time when the maintenance has actually completed successfully.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cancelledAt | **string** (date-time)

The time time when the maintenance has actually been cancelled.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| userControllable | **boolean**

Indicates whether the user can control (reschedule) the maintenance. ||
|#

## Resource {#yandex.cloud.maintenance.v2.Maintenance.Resource}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#

## Detail {#yandex.cloud.maintenance.v2.Maintenance.Detail}

#|
||Field | Description ||
|| key | **string**

Unique key (service-specific). ||
|| value | **string**

Description (service-specific). ||
|#