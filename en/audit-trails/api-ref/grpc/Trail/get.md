---
editable: false
sourcePath: en/_api-ref-grpc/audittrails/v1/api-ref/grpc/Trail/get.md
---

# Audit Trails API, gRPC: TrailService.Get

Returns the specified trail.

To get the list of all available trails, make a [List](/docs/audit-trails/api-ref/grpc/Trail/list#List) request.

## gRPC request

**rpc Get ([GetTrailRequest](#yandex.cloud.audittrails.v1.GetTrailRequest)) returns ([Trail](#yandex.cloud.audittrails.v1.Trail))**

## GetTrailRequest {#yandex.cloud.audittrails.v1.GetTrailRequest}

```json
{
  "trail_id": "string"
}
```

#|
||Field | Description ||
|| trail_id | **string**

Required field. ID of the trail to return.

To get a trail ID make a [List](/docs/audit-trails/api-ref/grpc/Trail/list#List) request. ||
|#

## Trail {#yandex.cloud.audittrails.v1.Trail}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "destination": {
    // Includes only one of the fields `object_storage`, `cloud_logging`, `data_stream`
    "object_storage": {
      "bucket_id": "string",
      "object_prefix": "string"
    },
    "cloud_logging": {
      // Includes only one of the fields `log_group_id`
      "log_group_id": "string"
      // end of the list of possible fields
    },
    "data_stream": {
      "database_id": "string",
      "stream_name": "string"
    }
    // end of the list of possible fields
  },
  "service_account_id": "string",
  "status": "Status",
  "filter": {
    "path_filter": {
      "root": {
        // Includes only one of the fields `any_filter`, `some_filter`
        "any_filter": {
          "resource": {
            "id": "string",
            "type": "string"
          }
        },
        "some_filter": {
          "resource": {
            "id": "string",
            "type": "string"
          },
          "filters": [
            "PathFilterElement"
          ]
        }
        // end of the list of possible fields
      }
    },
    "event_filter": {
      "filters": [
        {
          "service": "string",
          "categories": [
            {
              "plane": "EventCategoryFilter",
              "type": "EventAccessTypeFilter"
            }
          ],
          "path_filter": {
            "root": {
              // Includes only one of the fields `any_filter`, `some_filter`
              "any_filter": {
                "resource": {
                  "id": "string",
                  "type": "string"
                }
              },
              "some_filter": {
                "resource": {
                  "id": "string",
                  "type": "string"
                },
                "filters": [
                  "PathFilterElement"
                ]
              }
              // end of the list of possible fields
            }
          }
        }
      ]
    }
  },
  "status_error_message": "string",
  "cloud_id": "string",
  "filtering_policy": {
    "management_events_filter": {
      "resource_scopes": [
        {
          "id": "string",
          "type": "string"
        }
      ]
    },
    "data_events_filters": [
      {
        "service": "string",
        // Includes only one of the fields `included_events`, `excluded_events`
        "included_events": {
          "event_types": [
            "string"
          ]
        },
        "excluded_events": {
          "event_types": [
            "string"
          ]
        },
        // end of the list of possible fields
        // Includes only one of the fields `dns_filter`
        "dns_filter": {
          "only_recursive_queries": "bool"
        },
        // end of the list of possible fields
        "resource_scopes": [
          {
            "id": "string",
            "type": "string"
          }
        ]
      }
    ]
  }
}
```

Trail describes the filtering and destination configuration of the process of sending Audit events

#|
||Field | Description ||
|| id | **string**

ID of the trail ||
|| folder_id | **string**

Required field. ID of the folder that the trail belongs to ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. The timestamp for the creation operation ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. The timestamp of the last update operation ||
|| name | **string**

Name of the trail ||
|| description | **string**

Description of the trail ||
|| labels | **object** (map<**string**, **string**>)

Custom labels of the trail as `key:value` pairs. Maximum 64 per key ||
|| destination | **[Destination](#yandex.cloud.audittrails.v1.Trail.Destination)**

Required field. Destination configuration of the trail ||
|| service_account_id | **string**

Service account ID of the trail ||
|| status | enum **Status**

Required field. Status of the trail

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The trail is active and Audit events are processed
- `ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events
- `DELETED`: The trail is being deleted ||
|| filter | **[Filter](#yandex.cloud.audittrails.v1.Trail.Filter)**

Filtering configuration of the trail
deprecated: use filtering_policy instead ||
|| status_error_message | **string**

Current error message of the trail. Empty in case if the trail is active ||
|| cloud_id | **string**

Required field. ID of the cloud that the trail belongs to ||
|| filtering_policy | **[FilteringPolicy](#yandex.cloud.audittrails.v1.Trail.FilteringPolicy)**

Event filtering policy
Describes which groups of events will be sent and which resources will be monitored ||
|#

## Destination {#yandex.cloud.audittrails.v1.Trail.Destination}

#|
||Field | Description ||
|| object_storage | **[ObjectStorage](#yandex.cloud.audittrails.v1.Trail.ObjectStorage)**

Configuration for event delivery to Object Storage

Uploaded objects will have prefix <trail_id>/ by default

Includes only one of the fields `object_storage`, `cloud_logging`, `data_stream`. ||
|| cloud_logging | **[CloudLogging](#yandex.cloud.audittrails.v1.Trail.CloudLogging)**

Configuration for event delivery to Cloud Logging

Includes only one of the fields `object_storage`, `cloud_logging`, `data_stream`. ||
|| data_stream | **[DataStream](#yandex.cloud.audittrails.v1.Trail.DataStream)**

Configuration for event delivery to YDS

Includes only one of the fields `object_storage`, `cloud_logging`, `data_stream`. ||
|#

## ObjectStorage {#yandex.cloud.audittrails.v1.Trail.ObjectStorage}

#|
||Field | Description ||
|| bucket_id | **string**

Name of the destination bucket ||
|| object_prefix | **string**

Prefix for exported objects. Optional
If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/ ||
|#

## CloudLogging {#yandex.cloud.audittrails.v1.Trail.CloudLogging}

#|
||Field | Description ||
|| log_group_id | **string**

ID of the Cloud Logging destination group

Includes only one of the fields `log_group_id`. ||
|#

## DataStream {#yandex.cloud.audittrails.v1.Trail.DataStream}

#|
||Field | Description ||
|| database_id | **string**

ID of the database hosting the destination YDS ||
|| stream_name | **string**

Name of the destination YDS ||
|#

## Filter {#yandex.cloud.audittrails.v1.Trail.Filter}

#|
||Field | Description ||
|| path_filter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter)**

Configuration of default events gathering for the trail
If not specified, default events won't be gathered for the trail ||
|| event_filter | **[EventFilter](#yandex.cloud.audittrails.v1.Trail.EventFilter)**

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
|| any_filter | **[PathFilterElementAny](#yandex.cloud.audittrails.v1.Trail.PathFilterElementAny)**

Filter element with ANY type. If used, configures the trail to gather any events from the resource

Includes only one of the fields `any_filter`, `some_filter`. ||
|| some_filter | **[PathFilterElementSome](#yandex.cloud.audittrails.v1.Trail.PathFilterElementSome)**

Filter element with SOME type. If used, configures the trail to gather some of the events from the resource

Includes only one of the fields `any_filter`, `some_filter`. ||
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
|| path_filter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter)**

Required field. Resource path filter for a specified service ||
|#

## EventFilterElementCategory {#yandex.cloud.audittrails.v1.Trail.EventFilterElementCategory}

#|
||Field | Description ||
|| plane | enum **EventCategoryFilter**

Required field. Plane of the gathered category

- `EVENT_CATEGORY_FILTER_UNSPECIFIED`
- `CONTROL_PLANE`: The events that are generated during the interaction with the service's resources
- `DATA_PLANE`: Events that are generated during interaction with data within the service's resources ||
|| type | enum **EventAccessTypeFilter**

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
|| management_events_filter | **[ManagementEventsFiltering](#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering)**

Singular filter describing gathering management events ||
|| data_events_filters[] | **[DataEventsFiltering](#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering)**

List of filters describing gathering data events ||
|#

## ManagementEventsFiltering {#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering}

Policy for gathering management events

#|
||Field | Description ||
|| resource_scopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**

A list of resources which will be monitored by the trail ||
|#

## DataEventsFiltering {#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering}

Policy for gathering data events

#|
||Field | Description ||
|| service | **string**

Required field. Name of the service whose events will be delivered ||
|| included_events | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes)**

Explicitly included events of specified service
New events of the service won't be delivered by default

Includes only one of the fields `included_events`, `excluded_events`. ||
|| excluded_events | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes)**

Explicitly excluded events of specified service
New events of the service will be delivered by default

Includes only one of the fields `included_events`, `excluded_events`. ||
|| dns_filter | **[DnsDataEventsFilter](#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter)**

Filter is allowed only if service = dns

Includes only one of the fields `dns_filter`. ||
|| resource_scopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**

A list of resources which will be monitored by the trail ||
|#

## EventTypes {#yandex.cloud.audittrails.v1.Trail.EventTypes}

Policy with explicitly specified event group

#|
||Field | Description ||
|| event_types[] | **string** ||
|#

## DnsDataEventsFilter {#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter}

#|
||Field | Description ||
|| only_recursive_queries | **bool**

Only recursive queries will be delivered ||
|#