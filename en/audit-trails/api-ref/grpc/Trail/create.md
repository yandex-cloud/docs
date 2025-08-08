---
editable: false
sourcePath: en/_api-ref-grpc/audittrails/v1/api-ref/grpc/Trail/create.md
---

# Audit Trails API, gRPC: TrailService.Create

Creates a trail in the specified folder.

## gRPC request

**rpc Create ([CreateTrailRequest](#yandex.cloud.audittrails.v1.CreateTrailRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateTrailRequest {#yandex.cloud.audittrails.v1.CreateTrailRequest}

```json
{
  "folder_id": "string",
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
          "only_recursive_queries": "bool",
          "include_nonrecursive_queries": "bool"
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

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a trail in. ||
|| name | **string**

Name of the trail. ||
|| description | **string**

Description of the trail. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the secret as `key:value` pairs. Maximum 64 per key.
For example, `"type": "critical"` or `"source": "dictionary"`. ||
|| destination | **[Destination](#yandex.cloud.audittrails.v1.Trail.Destination)**

Required field. Destination configuration for the trail ||
|| service_account_id | **string**

Required field. Service account ID of the trail ||
|| filter | **[Filter](#yandex.cloud.audittrails.v1.Trail.Filter)**

Event filtering configuration of the trail
deprecated: use filtering_policy instead ||
|| filtering_policy | **[FilteringPolicy](#yandex.cloud.audittrails.v1.Trail.FilteringPolicy)**

Event filtering policy of the trail ||
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

deprecated: use all_dns_queries instead ||
|| include_nonrecursive_queries | **bool**

Not only recursive queries will be delivered ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "trail_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
            "only_recursive_queries": "bool",
            "include_nonrecursive_queries": "bool"
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateTrailMetadata](#yandex.cloud.audittrails.v1.CreateTrailMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Trail](#yandex.cloud.audittrails.v1.Trail)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateTrailMetadata {#yandex.cloud.audittrails.v1.CreateTrailMetadata}

#|
||Field | Description ||
|| trail_id | **string**

ID of the trail that is being created ||
|#

## Trail {#yandex.cloud.audittrails.v1.Trail}

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
|| destination | **[Destination](#yandex.cloud.audittrails.v1.Trail.Destination2)**

Required field. Destination configuration of the trail ||
|| service_account_id | **string**

Service account ID of the trail ||
|| status | enum **Status**

Required field. Status of the trail

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The trail is active and Audit events are processed
- `ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events
- `DELETED`: The trail is being deleted ||
|| filter | **[Filter](#yandex.cloud.audittrails.v1.Trail.Filter2)**

Filtering configuration of the trail
deprecated: use filtering_policy instead ||
|| status_error_message | **string**

Current error message of the trail. Empty in case if the trail is active ||
|| cloud_id | **string**

Required field. ID of the cloud that the trail belongs to ||
|| filtering_policy | **[FilteringPolicy](#yandex.cloud.audittrails.v1.Trail.FilteringPolicy2)**

Event filtering policy
Describes which groups of events will be sent and which resources will be monitored ||
|#

## Destination {#yandex.cloud.audittrails.v1.Trail.Destination2}

#|
||Field | Description ||
|| object_storage | **[ObjectStorage](#yandex.cloud.audittrails.v1.Trail.ObjectStorage2)**

Configuration for event delivery to Object Storage

Uploaded objects will have prefix <trail_id>/ by default

Includes only one of the fields `object_storage`, `cloud_logging`, `data_stream`. ||
|| cloud_logging | **[CloudLogging](#yandex.cloud.audittrails.v1.Trail.CloudLogging2)**

Configuration for event delivery to Cloud Logging

Includes only one of the fields `object_storage`, `cloud_logging`, `data_stream`. ||
|| data_stream | **[DataStream](#yandex.cloud.audittrails.v1.Trail.DataStream2)**

Configuration for event delivery to YDS

Includes only one of the fields `object_storage`, `cloud_logging`, `data_stream`. ||
|#

## ObjectStorage {#yandex.cloud.audittrails.v1.Trail.ObjectStorage2}

#|
||Field | Description ||
|| bucket_id | **string**

Name of the destination bucket ||
|| object_prefix | **string**

Prefix for exported objects. Optional
If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/ ||
|#

## CloudLogging {#yandex.cloud.audittrails.v1.Trail.CloudLogging2}

#|
||Field | Description ||
|| log_group_id | **string**

ID of the Cloud Logging destination group

Includes only one of the fields `log_group_id`. ||
|#

## DataStream {#yandex.cloud.audittrails.v1.Trail.DataStream2}

#|
||Field | Description ||
|| database_id | **string**

ID of the database hosting the destination YDS ||
|| stream_name | **string**

Name of the destination YDS ||
|#

## Filter {#yandex.cloud.audittrails.v1.Trail.Filter2}

#|
||Field | Description ||
|| path_filter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter2)**

Configuration of default events gathering for the trail
If not specified, default events won't be gathered for the trail ||
|| event_filter | **[EventFilter](#yandex.cloud.audittrails.v1.Trail.EventFilter2)**

Required field. Configuration of additional events gathering from specific services ||
|#

## PathFilter {#yandex.cloud.audittrails.v1.Trail.PathFilter2}

#|
||Field | Description ||
|| root | **[PathFilterElement](#yandex.cloud.audittrails.v1.Trail.PathFilterElement2)**

Required field. Root element of the resource path filter for the trail
Resource described in that filter node must contain the trail itself ||
|#

## PathFilterElement {#yandex.cloud.audittrails.v1.Trail.PathFilterElement2}

#|
||Field | Description ||
|| any_filter | **[PathFilterElementAny](#yandex.cloud.audittrails.v1.Trail.PathFilterElementAny2)**

Filter element with ANY type. If used, configures the trail to gather any events from the resource

Includes only one of the fields `any_filter`, `some_filter`. ||
|| some_filter | **[PathFilterElementSome](#yandex.cloud.audittrails.v1.Trail.PathFilterElementSome2)**

Filter element with SOME type. If used, configures the trail to gather some of the events from the resource

Includes only one of the fields `any_filter`, `some_filter`. ||
|#

## PathFilterElementAny {#yandex.cloud.audittrails.v1.Trail.PathFilterElementAny2}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource2)**

Required field. Resource definition ||
|#

## Resource {#yandex.cloud.audittrails.v1.Trail.Resource2}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource ||
|| type | **string**

Required field. Type of the resource ||
|#

## PathFilterElementSome {#yandex.cloud.audittrails.v1.Trail.PathFilterElementSome2}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource2)**

Required field. Definition of the resource that contains nested resources ||
|| filters[] | **[PathFilterElement](#yandex.cloud.audittrails.v1.Trail.PathFilterElement2)**

Filters for the resources contained in the parent resource ||
|#

## EventFilter {#yandex.cloud.audittrails.v1.Trail.EventFilter2}

#|
||Field | Description ||
|| filters[] | **[EventFilterElement](#yandex.cloud.audittrails.v1.Trail.EventFilterElement2)**

List of filters for services ||
|#

## EventFilterElement {#yandex.cloud.audittrails.v1.Trail.EventFilterElement2}

#|
||Field | Description ||
|| service | **string**

Required field. Service ID of the gathered events ||
|| categories[] | **[EventFilterElementCategory](#yandex.cloud.audittrails.v1.Trail.EventFilterElementCategory2)**

List of the event categories gathered for a specified service ||
|| path_filter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter2)**

Required field. Resource path filter for a specified service ||
|#

## EventFilterElementCategory {#yandex.cloud.audittrails.v1.Trail.EventFilterElementCategory2}

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

## FilteringPolicy {#yandex.cloud.audittrails.v1.Trail.FilteringPolicy2}

Combination of policies describing event filtering process of the trail
At least one filed must be filled

#|
||Field | Description ||
|| management_events_filter | **[ManagementEventsFiltering](#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering2)**

Singular filter describing gathering management events ||
|| data_events_filters[] | **[DataEventsFiltering](#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering2)**

List of filters describing gathering data events ||
|#

## ManagementEventsFiltering {#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering2}

Policy for gathering management events

#|
||Field | Description ||
|| resource_scopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource2)**

A list of resources which will be monitored by the trail ||
|#

## DataEventsFiltering {#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering2}

Policy for gathering data events

#|
||Field | Description ||
|| service | **string**

Required field. Name of the service whose events will be delivered ||
|| included_events | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes2)**

Explicitly included events of specified service
New events of the service won't be delivered by default

Includes only one of the fields `included_events`, `excluded_events`. ||
|| excluded_events | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes2)**

Explicitly excluded events of specified service
New events of the service will be delivered by default

Includes only one of the fields `included_events`, `excluded_events`. ||
|| dns_filter | **[DnsDataEventsFilter](#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter2)**

Filter is allowed only if service = dns

Includes only one of the fields `dns_filter`. ||
|| resource_scopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource2)**

A list of resources which will be monitored by the trail ||
|#

## EventTypes {#yandex.cloud.audittrails.v1.Trail.EventTypes2}

Policy with explicitly specified event group

#|
||Field | Description ||
|| event_types[] | **string** ||
|#

## DnsDataEventsFilter {#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter2}

#|
||Field | Description ||
|| only_recursive_queries | **bool**

deprecated: use all_dns_queries instead ||
|| include_nonrecursive_queries | **bool**

Not only recursive queries will be delivered ||
|#