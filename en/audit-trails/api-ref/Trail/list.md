---
editable: false
sourcePath: en/_api-ref/audittrails/v1/api-ref/Trail/list.md
---

# Audit Trails API, REST: Trail.List {#List}

Retrieves the list of trails in the specified folder.

## HTTP request

```
GET https://audittrails.{{ api-host }}/audit-trails/v1/trails
```

## Query parameters {#yandex.cloud.audittrails.v1.ListTrailsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list trails in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListTrailsResponse.nextPageToken](#yandex.cloud.audittrails.v1.ListTrailsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListTrailsRequest.next_page_token] returned by a previous list request. ||
|| filter | **string**

A filter expression that filters subscription locks listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering on [Trail.name, Trail.created_at] fields.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-name"`. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction.
format is "<field> desc\|acs" ||
|#

## Response {#yandex.cloud.audittrails.v1.ListTrailsResponse}

**HTTP Code: 200 - OK**

```json
{
  "trails": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "destination": {
        // Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`
        "objectStorage": {
          "bucketId": "string",
          "objectPrefix": "string"
        },
        "cloudLogging": {
          // Includes only one of the fields `logGroupId`
          "logGroupId": "string"
          // end of the list of possible fields
        },
        "dataStream": {
          "databaseId": "string",
          "streamName": "string"
        }
        // end of the list of possible fields
      },
      "serviceAccountId": "string",
      "status": "string",
      "filter": {
        "pathFilter": {
          "root": {
            // Includes only one of the fields `anyFilter`, `someFilter`
            "anyFilter": {
              "resource": {
                "id": "string",
                "type": "string"
              }
            },
            "someFilter": {
              "resource": {
                "id": "string",
                "type": "string"
              },
              "filters": [
                "object"
              ]
            }
            // end of the list of possible fields
          }
        },
        "eventFilter": {
          "filters": [
            {
              "service": "string",
              "categories": [
                {
                  "plane": "string",
                  "type": "string"
                }
              ],
              "pathFilter": {
                "root": {
                  // Includes only one of the fields `anyFilter`, `someFilter`
                  "anyFilter": {
                    "resource": {
                      "id": "string",
                      "type": "string"
                    }
                  },
                  "someFilter": {
                    "resource": {
                      "id": "string",
                      "type": "string"
                    },
                    "filters": [
                      "object"
                    ]
                  }
                  // end of the list of possible fields
                }
              }
            }
          ]
        }
      },
      "statusErrorMessage": "string",
      "cloudId": "string",
      "filteringPolicy": {
        "managementEventsFilter": {
          "resourceScopes": [
            {
              "id": "string",
              "type": "string"
            }
          ]
        },
        "dataEventsFilters": [
          {
            "service": "string",
            // Includes only one of the fields `includedEvents`, `excludedEvents`
            "includedEvents": {
              "eventTypes": [
                "string"
              ]
            },
            "excludedEvents": {
              "eventTypes": [
                "string"
              ]
            },
            // end of the list of possible fields
            "resourceScopes": [
              {
                "id": "string",
                "type": "string"
              }
            ]
          }
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| trails[] | **[Trail](#yandex.cloud.audittrails.v1.Trail)**

List of trails in the specified folder. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListTrailsRequest.pageSize](#yandex.cloud.audittrails.v1.ListTrailsRequest), use
the `next_page_token` as the value for the [ListTrailsRequest.pageToken](#yandex.cloud.audittrails.v1.ListTrailsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Trail {#yandex.cloud.audittrails.v1.Trail}

Trail describes the filtering and destination configuration of the process of sending Audit events

#|
||Field | Description ||
|| id | **string**

ID of the trail ||
|| folderId | **string**

Required field. ID of the folder that the trail belongs to ||
|| createdAt | **string** (date-time)

Required field. The timestamp for the creation operation

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Required field. The timestamp of the last update operation

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the trail ||
|| description | **string**

Description of the trail ||
|| labels | **string**

Custom labels of the trail as `key:value` pairs. Maximum 64 per key ||
|| destination | **[Destination](#yandex.cloud.audittrails.v1.Trail.Destination)**

Required field. Destination configuration of the trail ||
|| serviceAccountId | **string**

Service account ID of the trail ||
|| status | **enum** (Status)

Required field. Status of the trail

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The trail is active and Audit events are processed
- `ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events
- `DELETED`: The trail is being deleted ||
|| filter | **[Filter](#yandex.cloud.audittrails.v1.Trail.Filter)**

Filtering configuration of the trail
deprecated: use filtering_policy instead ||
|| statusErrorMessage | **string**

Current error message of the trail. Empty in case if the trail is active ||
|| cloudId | **string**

Required field. ID of the cloud that the trail belongs to ||
|| filteringPolicy | **[FilteringPolicy](#yandex.cloud.audittrails.v1.Trail.FilteringPolicy)**

Event filtering policy
Describes which groups of events will be sent and which resources will be monitored ||
|#

## Destination {#yandex.cloud.audittrails.v1.Trail.Destination}

#|
||Field | Description ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.audittrails.v1.Trail.ObjectStorage)**

Configuration for event delivery to Object Storage

Uploaded objects will have prefix <trail_id>/ by default

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`. ||
|| cloudLogging | **[CloudLogging](#yandex.cloud.audittrails.v1.Trail.CloudLogging)**

Configuration for event delivery to Cloud Logging

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`. ||
|| dataStream | **[DataStream](#yandex.cloud.audittrails.v1.Trail.DataStream)**

Configuration for event delivery to YDS

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`. ||
|#

## ObjectStorage {#yandex.cloud.audittrails.v1.Trail.ObjectStorage}

#|
||Field | Description ||
|| bucketId | **string**

Name of the destination bucket ||
|| objectPrefix | **string**

Prefix for exported objects. Optional
If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/ ||
|#

## CloudLogging {#yandex.cloud.audittrails.v1.Trail.CloudLogging}

#|
||Field | Description ||
|| logGroupId | **string**

ID of the Cloud Logging destination group

Includes only one of the fields `logGroupId`. ||
|#

## DataStream {#yandex.cloud.audittrails.v1.Trail.DataStream}

#|
||Field | Description ||
|| databaseId | **string**

ID of the database hosting the destination YDS ||
|| streamName | **string**

Name of the destination YDS ||
|#

## Filter {#yandex.cloud.audittrails.v1.Trail.Filter}

#|
||Field | Description ||
|| pathFilter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter)**

Configuration of default events gathering for the trail
If not specified, default events won't be gathered for the trail ||
|| eventFilter | **[EventFilter](#yandex.cloud.audittrails.v1.Trail.EventFilter)**

Required field. Configuration of additional events gathering from specific services ||
|#

## PathFilter {#yandex.cloud.audittrails.v1.Trail.PathFilter}

#|
||Field | Description ||
|| root | **[PathFilterElement](#yandex.cloud.audittrails.v1.Trail.PathFilterElement)**

Required field. Root element of the resource path filter for the trail
Resource described in that filter node must contain the trail itself ||
|#

## PathFilterElement {#yandex.cloud.audittrails.v1.Trail.PathFilterElement}

#|
||Field | Description ||
|| anyFilter | **[PathFilterElementAny](#yandex.cloud.audittrails.v1.Trail.PathFilterElementAny)**

Filter element with ANY type. If used, configures the trail to gather any events from the resource

Includes only one of the fields `anyFilter`, `someFilter`. ||
|| someFilter | **[PathFilterElementSome](#yandex.cloud.audittrails.v1.Trail.PathFilterElementSome)**

Filter element with SOME type. If used, configures the trail to gather some of the events from the resource

Includes only one of the fields `anyFilter`, `someFilter`. ||
|#

## PathFilterElementAny {#yandex.cloud.audittrails.v1.Trail.PathFilterElementAny}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**

Required field. Resource definition ||
|#

## Resource {#yandex.cloud.audittrails.v1.Trail.Resource}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource ||
|| type | **string**

Required field. Type of the resource ||
|#

## PathFilterElementSome {#yandex.cloud.audittrails.v1.Trail.PathFilterElementSome}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**

Required field. Definition of the resource that contains nested resources ||
|| filters[] | **[PathFilterElement](#yandex.cloud.audittrails.v1.Trail.PathFilterElement)**

Filters for the resources contained in the parent resource ||
|#

## EventFilter {#yandex.cloud.audittrails.v1.Trail.EventFilter}

#|
||Field | Description ||
|| filters[] | **[EventFilterElement](#yandex.cloud.audittrails.v1.Trail.EventFilterElement)**

List of filters for services ||
|#

## EventFilterElement {#yandex.cloud.audittrails.v1.Trail.EventFilterElement}

#|
||Field | Description ||
|| service | **string**

Required field. Service ID of the gathered events ||
|| categories[] | **[EventFilterElementCategory](#yandex.cloud.audittrails.v1.Trail.EventFilterElementCategory)**

List of the event categories gathered for a specified service ||
|| pathFilter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter)**

Required field. Resource path filter for a specified service ||
|#

## EventFilterElementCategory {#yandex.cloud.audittrails.v1.Trail.EventFilterElementCategory}

#|
||Field | Description ||
|| plane | **enum** (EventCategoryFilter)

Required field. Plane of the gathered category

- `EVENT_CATEGORY_FILTER_UNSPECIFIED`
- `CONTROL_PLANE`: The events that are generated during the interaction with the service's resources
- `DATA_PLANE`: Events that are generated during interaction with data within the service's resources ||
|| type | **enum** (EventAccessTypeFilter)

Required field. Type of the gathered category

- `EVENT_ACCESS_TYPE_FILTER_UNSPECIFIED`
- `WRITE`: Events for operations that do perform some modification
- `READ`: Events for operations that do not perform any modifications ||
|#

## FilteringPolicy {#yandex.cloud.audittrails.v1.Trail.FilteringPolicy}

Combination of policies describing event filtering process of the trail
At least one filed must be filled

#|
||Field | Description ||
|| managementEventsFilter | **[ManagementEventsFiltering](#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering)**

Singular filter describing gathering management events ||
|| dataEventsFilters[] | **[DataEventsFiltering](#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering)**

List of filters describing gathering data events ||
|#

## ManagementEventsFiltering {#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering}

Policy for gathering management events

#|
||Field | Description ||
|| resourceScopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**

A list of resources which will be monitored by the trail ||
|#

## DataEventsFiltering {#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering}

Policy for gathering data events

#|
||Field | Description ||
|| service | **string**

Required field. Name of the service whose events will be delivered ||
|| includedEvents | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes)**

Explicitly included events of specified service
New events of the service won't be delivered by default

Includes only one of the fields `includedEvents`, `excludedEvents`. ||
|| excludedEvents | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes)**

Explicitly excluded events of specified service
New events of the service will be delivered by default

Includes only one of the fields `includedEvents`, `excludedEvents`. ||
|| resourceScopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**

A list of resources which will be monitored by the trail ||
|#

## EventTypes {#yandex.cloud.audittrails.v1.Trail.EventTypes}

Policy with explicitly specified event group

#|
||Field | Description ||
|| eventTypes[] | **string** ||
|#