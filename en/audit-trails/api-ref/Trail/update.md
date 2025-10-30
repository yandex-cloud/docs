---
editable: false
apiPlayground:
  - url: https://audittrails.{{ api-host }}/audit-trails/v1/trails/{trailId}
    method: patch
    path:
      type: object
      properties:
        trailId:
          description: |-
            **string**
            Required field. ID of the trail to update.
          type: string
      required:
        - trailId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name of the trail.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            New description of the trail.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            New custom labels for the secret as `key:value` pairs. Maximum 64 per key.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
          maxProperties: 64
        destination:
          description: |-
            **[Destination](#yandex.cloud.audittrails.v1.Trail.Destination)**
            New destination configuration for the trail
          $ref: '#/definitions/Destination'
        serviceAccountId:
          description: |-
            **string**
            New service account ID of the trail
          type: string
        filter:
          description: |-
            **[Filter](#yandex.cloud.audittrails.v1.Trail.Filter)**
            Updated filtering configuration of the trail
            deprecated: use filtering_policy instead
          deprecated: true
          $ref: '#/definitions/Filter'
        filteringPolicy:
          description: |-
            **[FilteringPolicy](#yandex.cloud.audittrails.v1.Trail.FilteringPolicy)**
            Updated event filtering policy
          $ref: '#/definitions/FilteringPolicy'
      additionalProperties: false
    definitions:
      ObjectStorage:
        type: object
        properties:
          bucketId:
            description: |-
              **string**
              Name of the destination bucket
            type: string
          objectPrefix:
            description: |-
              **string**
              Prefix for exported objects. Optional
              If specified, uploaded objects will have prefix &lt;object_prefix&gt;/&lt;trail_id&gt;/
            type: string
      CloudLogging:
        type: object
        properties:
          logGroupId:
            description: |-
              **string**
              ID of the Cloud Logging destination group
              Includes only one of the fields `logGroupId`.
            type: string
        oneOf:
          - required:
              - logGroupId
      DataStream:
        type: object
        properties:
          databaseId:
            description: |-
              **string**
              ID of the database hosting the destination YDS
            type: string
          streamName:
            description: |-
              **string**
              Name of the destination YDS
            type: string
      EventRouter:
        type: object
        properties:
          eventrouterConnectorId:
            description: |-
              **string**
              ID of the EventRouter Connector
            type: string
      Destination:
        type: object
        properties:
          objectStorage:
            description: |-
              **[ObjectStorage](#yandex.cloud.audittrails.v1.Trail.ObjectStorage)**
              Configuration for event delivery to Object Storage
              Uploaded objects will have prefix &lt;trail_id&gt;/ by default
              Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`.
            $ref: '#/definitions/ObjectStorage'
          cloudLogging:
            description: |-
              **[CloudLogging](#yandex.cloud.audittrails.v1.Trail.CloudLogging)**
              Configuration for event delivery to Cloud Logging
              Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`.
            $ref: '#/definitions/CloudLogging'
          dataStream:
            description: |-
              **[DataStream](#yandex.cloud.audittrails.v1.Trail.DataStream)**
              Configuration for event delivery to YDS
              Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`.
            $ref: '#/definitions/DataStream'
          eventrouter:
            description: |-
              **[EventRouter](#yandex.cloud.audittrails.v1.Trail.EventRouter)**
              Configuration for event delivery to EventRouter
              Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`.
            $ref: '#/definitions/EventRouter'
        oneOf:
          - required:
              - objectStorage
          - required:
              - cloudLogging
          - required:
              - dataStream
          - required:
              - eventrouter
      Resource:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. ID of the resource
            type: string
          type:
            description: |-
              **string**
              Required field. Type of the resource
            type: string
        required:
          - id
          - type
      PathFilterElementAny:
        type: object
        properties:
          resource:
            description: |-
              **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**
              Required field. Resource definition
            $ref: '#/definitions/Resource'
        required:
          - resource
      PathFilterElementSome:
        type: object
        properties:
          resource:
            description: |-
              **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**
              Required field. Definition of the resource that contains nested resources
            $ref: '#/definitions/Resource'
          filters:
            description: |-
              **[PathFilterElement](#yandex.cloud.audittrails.v1.Trail.PathFilterElement)**
              Filters for the resources contained in the parent resource
            type: array
            items:
              $ref: '#/definitions/PathFilterElement'
        required:
          - resource
      PathFilterElement:
        type: object
        properties:
          anyFilter:
            description: |-
              **[PathFilterElementAny](#yandex.cloud.audittrails.v1.Trail.PathFilterElementAny)**
              Filter element with ANY type. If used, configures the trail to gather any events from the resource
              Includes only one of the fields `anyFilter`, `someFilter`.
            $ref: '#/definitions/PathFilterElementAny'
          someFilter:
            description: |-
              **[PathFilterElementSome](#yandex.cloud.audittrails.v1.Trail.PathFilterElementSome)**
              Filter element with SOME type. If used, configures the trail to gather some of the events from the resource
              Includes only one of the fields `anyFilter`, `someFilter`.
            $ref: '#/definitions/PathFilterElementSome'
        oneOf:
          - required:
              - anyFilter
          - required:
              - someFilter
      PathFilter:
        type: object
        properties:
          root:
            description: |-
              **[PathFilterElement](#yandex.cloud.audittrails.v1.Trail.PathFilterElement)**
              Required field. Root element of the resource path filter for the trail
              Resource described in that filter node must contain the trail itself
            $ref: '#/definitions/PathFilterElement'
        required:
          - root
      EventFilterElementCategory:
        type: object
        properties:
          plane:
            description: |-
              **enum** (EventCategoryFilter)
              Required field. Plane of the gathered category
              - `EVENT_CATEGORY_FILTER_UNSPECIFIED`
              - `CONTROL_PLANE`: The events that are generated during the interaction with the service's resources
              - `DATA_PLANE`: Events that are generated during interaction with data within the service's resources
            type: string
            enum:
              - EVENT_CATEGORY_FILTER_UNSPECIFIED
              - CONTROL_PLANE
              - DATA_PLANE
          type:
            description: |-
              **enum** (EventAccessTypeFilter)
              Required field. Type of the gathered category
              - `EVENT_ACCESS_TYPE_FILTER_UNSPECIFIED`
              - `WRITE`: Events for operations that do perform some modification
              - `READ`: Events for operations that do not perform any modifications
            type: string
            enum:
              - EVENT_ACCESS_TYPE_FILTER_UNSPECIFIED
              - WRITE
              - READ
        required:
          - plane
          - type
      EventFilterElement:
        type: object
        properties:
          service:
            description: |-
              **string**
              Required field. Service ID of the gathered events
            type: string
          categories:
            description: |-
              **[EventFilterElementCategory](#yandex.cloud.audittrails.v1.Trail.EventFilterElementCategory)**
              List of the event categories gathered for a specified service
            type: array
            items:
              $ref: '#/definitions/EventFilterElementCategory'
          pathFilter:
            description: |-
              **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter)**
              Required field. Resource path filter for a specified service
            $ref: '#/definitions/PathFilter'
        required:
          - service
          - pathFilter
      EventFilter:
        type: object
        properties:
          filters:
            description: |-
              **[EventFilterElement](#yandex.cloud.audittrails.v1.Trail.EventFilterElement)**
              List of filters for services
            type: array
            items:
              $ref: '#/definitions/EventFilterElement'
      Filter:
        type: object
        properties:
          pathFilter:
            description: |-
              **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter)**
              Configuration of default events gathering for the trail
              If not specified, default events won't be gathered for the trail
            $ref: '#/definitions/PathFilter'
          eventFilter:
            description: |-
              **[EventFilter](#yandex.cloud.audittrails.v1.Trail.EventFilter)**
              Required field. Configuration of additional events gathering from specific services
            $ref: '#/definitions/EventFilter'
        required:
          - eventFilter
      ManagementEventsFiltering:
        type: object
        properties:
          resourceScopes:
            description: |-
              **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**
              A list of resources which will be monitored by the trail
            type: array
            items:
              $ref: '#/definitions/Resource'
      EventTypes:
        type: object
        properties:
          eventTypes:
            description: '**string**'
            type: array
            items:
              type: string
      DnsDataEventsFilter:
        type: object
        properties:
          includeNonrecursiveQueries:
            description: |-
              **boolean**
              Not only recursive queries will be delivered
            type: boolean
      DataEventsFiltering:
        type: object
        properties:
          service:
            description: |-
              **string**
              Required field. Name of the service whose events will be delivered
            type: string
          includedEvents:
            description: |-
              **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes)**
              Explicitly included events of specified service
              New events of the service won't be delivered by default
              Includes only one of the fields `includedEvents`, `excludedEvents`.
            $ref: '#/definitions/EventTypes'
          excludedEvents:
            description: |-
              **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes)**
              Explicitly excluded events of specified service
              New events of the service will be delivered by default
              Includes only one of the fields `includedEvents`, `excludedEvents`.
            $ref: '#/definitions/EventTypes'
          dnsFilter:
            description: |-
              **[DnsDataEventsFilter](#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter)**
              Filter is allowed only if service = dns
              Includes only one of the fields `dnsFilter`.
            $ref: '#/definitions/DnsDataEventsFilter'
          resourceScopes:
            description: |-
              **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**
              A list of resources which will be monitored by the trail
            type: array
            items:
              $ref: '#/definitions/Resource'
        required:
          - service
        allOf:
          - oneOf:
              - required:
                  - includedEvents
              - required:
                  - excludedEvents
          - oneOf:
              - required:
                  - dnsFilter
      FilteringPolicy:
        type: object
        properties:
          managementEventsFilter:
            description: |-
              **[ManagementEventsFiltering](#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering)**
              Singular filter describing gathering management events
            $ref: '#/definitions/ManagementEventsFiltering'
          dataEventsFilters:
            description: |-
              **[DataEventsFiltering](#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering)**
              List of filters describing gathering data events
            type: array
            items:
              $ref: '#/definitions/DataEventsFiltering'
sourcePath: en/_api-ref/audittrails/v1/api-ref/Trail/update.md
---

# Audit Trails API, REST: Trail.Update

Updates the specified trail.

## HTTP request

```
PATCH https://audittrails.{{ api-host }}/audit-trails/v1/trails/{trailId}
```

## Path parameters

#|
||Field | Description ||
|| trailId | **string**

Required field. ID of the trail to update. ||
|#

## Body parameters {#yandex.cloud.audittrails.v1.UpdateTrailRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "destination": {
    // Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`
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
    },
    "eventrouter": {
      "eventrouterConnectorId": "string"
    }
    // end of the list of possible fields
  },
  "serviceAccountId": "string",
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
        // Includes only one of the fields `dnsFilter`
        "dnsFilter": {
          "includeNonrecursiveQueries": "boolean"
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
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the trail. ||
|| description | **string**

New description of the trail. ||
|| labels | **object** (map<**string**, **string**>)

New custom labels for the secret as `key:value` pairs. Maximum 64 per key. ||
|| destination | **[Destination](#yandex.cloud.audittrails.v1.Trail.Destination)**

New destination configuration for the trail ||
|| serviceAccountId | **string**

New service account ID of the trail ||
|| filter | **[Filter](#yandex.cloud.audittrails.v1.Trail.Filter)**

Updated filtering configuration of the trail
deprecated: use filtering_policy instead ||
|| filteringPolicy | **[FilteringPolicy](#yandex.cloud.audittrails.v1.Trail.FilteringPolicy)**

Updated event filtering policy ||
|#

## Destination {#yandex.cloud.audittrails.v1.Trail.Destination}

#|
||Field | Description ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.audittrails.v1.Trail.ObjectStorage)**

Configuration for event delivery to Object Storage

Uploaded objects will have prefix &lt;trail_id&gt;/ by default

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| cloudLogging | **[CloudLogging](#yandex.cloud.audittrails.v1.Trail.CloudLogging)**

Configuration for event delivery to Cloud Logging

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| dataStream | **[DataStream](#yandex.cloud.audittrails.v1.Trail.DataStream)**

Configuration for event delivery to YDS

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| eventrouter | **[EventRouter](#yandex.cloud.audittrails.v1.Trail.EventRouter)**

Configuration for event delivery to EventRouter

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|#

## ObjectStorage {#yandex.cloud.audittrails.v1.Trail.ObjectStorage}

#|
||Field | Description ||
|| bucketId | **string**

Name of the destination bucket ||
|| objectPrefix | **string**

Prefix for exported objects. Optional
If specified, uploaded objects will have prefix &lt;object_prefix&gt;/&lt;trail_id&gt;/ ||
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

## EventRouter {#yandex.cloud.audittrails.v1.Trail.EventRouter}

#|
||Field | Description ||
|| eventrouterConnectorId | **string**

ID of the EventRouter Connector ||
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
|| dnsFilter | **[DnsDataEventsFilter](#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter)**

Filter is allowed only if service = dns

Includes only one of the fields `dnsFilter`. ||
|| resourceScopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource)**

A list of resources which will be monitored by the trail ||
|#

## EventTypes {#yandex.cloud.audittrails.v1.Trail.EventTypes}

Policy with explicitly specified event group

#|
||Field | Description ||
|| eventTypes[] | **string** ||
|#

## DnsDataEventsFilter {#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter}

#|
||Field | Description ||
|| includeNonrecursiveQueries | **boolean**

Not only recursive queries will be delivered ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "trailId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "destination": {
      // Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`
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
      },
      "eventrouter": {
        "eventrouterConnectorId": "string"
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
          // Includes only one of the fields `dnsFilter`
          "dnsFilter": {
            "includeNonrecursiveQueries": "boolean"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateTrailMetadata](#yandex.cloud.audittrails.v1.UpdateTrailMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## UpdateTrailMetadata {#yandex.cloud.audittrails.v1.UpdateTrailMetadata}

#|
||Field | Description ||
|| trailId | **string**

ID of the trail that is being updated ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| labels | **object** (map<**string**, **string**>)

Custom labels of the trail as `key:value` pairs. Maximum 64 per key ||
|| destination | **[Destination](#yandex.cloud.audittrails.v1.Trail.Destination2)**

Required field. Destination configuration of the trail ||
|| serviceAccountId | **string**

Service account ID of the trail ||
|| status | **enum** (Status)

Required field. Status of the trail

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The trail is active and Audit events are processed
- `ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events
- `DELETED`: The trail is being deleted ||
|| filter | **[Filter](#yandex.cloud.audittrails.v1.Trail.Filter2)**

Filtering configuration of the trail
deprecated: use filtering_policy instead ||
|| statusErrorMessage | **string**

Current error message of the trail. Empty in case if the trail is active ||
|| cloudId | **string**

Required field. ID of the cloud that the trail belongs to ||
|| filteringPolicy | **[FilteringPolicy](#yandex.cloud.audittrails.v1.Trail.FilteringPolicy2)**

Event filtering policy
Describes which groups of events will be sent and which resources will be monitored ||
|#

## Destination {#yandex.cloud.audittrails.v1.Trail.Destination2}

#|
||Field | Description ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.audittrails.v1.Trail.ObjectStorage2)**

Configuration for event delivery to Object Storage

Uploaded objects will have prefix &lt;trail_id&gt;/ by default

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| cloudLogging | **[CloudLogging](#yandex.cloud.audittrails.v1.Trail.CloudLogging2)**

Configuration for event delivery to Cloud Logging

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| dataStream | **[DataStream](#yandex.cloud.audittrails.v1.Trail.DataStream2)**

Configuration for event delivery to YDS

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| eventrouter | **[EventRouter](#yandex.cloud.audittrails.v1.Trail.EventRouter2)**

Configuration for event delivery to EventRouter

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|#

## ObjectStorage {#yandex.cloud.audittrails.v1.Trail.ObjectStorage2}

#|
||Field | Description ||
|| bucketId | **string**

Name of the destination bucket ||
|| objectPrefix | **string**

Prefix for exported objects. Optional
If specified, uploaded objects will have prefix &lt;object_prefix&gt;/&lt;trail_id&gt;/ ||
|#

## CloudLogging {#yandex.cloud.audittrails.v1.Trail.CloudLogging2}

#|
||Field | Description ||
|| logGroupId | **string**

ID of the Cloud Logging destination group

Includes only one of the fields `logGroupId`. ||
|#

## DataStream {#yandex.cloud.audittrails.v1.Trail.DataStream2}

#|
||Field | Description ||
|| databaseId | **string**

ID of the database hosting the destination YDS ||
|| streamName | **string**

Name of the destination YDS ||
|#

## EventRouter {#yandex.cloud.audittrails.v1.Trail.EventRouter2}

#|
||Field | Description ||
|| eventrouterConnectorId | **string**

ID of the EventRouter Connector ||
|#

## Filter {#yandex.cloud.audittrails.v1.Trail.Filter2}

#|
||Field | Description ||
|| pathFilter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter2)**

Configuration of default events gathering for the trail
If not specified, default events won't be gathered for the trail ||
|| eventFilter | **[EventFilter](#yandex.cloud.audittrails.v1.Trail.EventFilter2)**

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
|| anyFilter | **[PathFilterElementAny](#yandex.cloud.audittrails.v1.Trail.PathFilterElementAny2)**

Filter element with ANY type. If used, configures the trail to gather any events from the resource

Includes only one of the fields `anyFilter`, `someFilter`. ||
|| someFilter | **[PathFilterElementSome](#yandex.cloud.audittrails.v1.Trail.PathFilterElementSome2)**

Filter element with SOME type. If used, configures the trail to gather some of the events from the resource

Includes only one of the fields `anyFilter`, `someFilter`. ||
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
|| pathFilter | **[PathFilter](#yandex.cloud.audittrails.v1.Trail.PathFilter2)**

Required field. Resource path filter for a specified service ||
|#

## EventFilterElementCategory {#yandex.cloud.audittrails.v1.Trail.EventFilterElementCategory2}

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

## FilteringPolicy {#yandex.cloud.audittrails.v1.Trail.FilteringPolicy2}

Combination of policies describing event filtering process of the trail
At least one filed must be filled

#|
||Field | Description ||
|| managementEventsFilter | **[ManagementEventsFiltering](#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering2)**

Singular filter describing gathering management events ||
|| dataEventsFilters[] | **[DataEventsFiltering](#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering2)**

List of filters describing gathering data events ||
|#

## ManagementEventsFiltering {#yandex.cloud.audittrails.v1.Trail.ManagementEventsFiltering2}

Policy for gathering management events

#|
||Field | Description ||
|| resourceScopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource2)**

A list of resources which will be monitored by the trail ||
|#

## DataEventsFiltering {#yandex.cloud.audittrails.v1.Trail.DataEventsFiltering2}

Policy for gathering data events

#|
||Field | Description ||
|| service | **string**

Required field. Name of the service whose events will be delivered ||
|| includedEvents | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes2)**

Explicitly included events of specified service
New events of the service won't be delivered by default

Includes only one of the fields `includedEvents`, `excludedEvents`. ||
|| excludedEvents | **[EventTypes](#yandex.cloud.audittrails.v1.Trail.EventTypes2)**

Explicitly excluded events of specified service
New events of the service will be delivered by default

Includes only one of the fields `includedEvents`, `excludedEvents`. ||
|| dnsFilter | **[DnsDataEventsFilter](#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter2)**

Filter is allowed only if service = dns

Includes only one of the fields `dnsFilter`. ||
|| resourceScopes[] | **[Resource](#yandex.cloud.audittrails.v1.Trail.Resource2)**

A list of resources which will be monitored by the trail ||
|#

## EventTypes {#yandex.cloud.audittrails.v1.Trail.EventTypes2}

Policy with explicitly specified event group

#|
||Field | Description ||
|| eventTypes[] | **string** ||
|#

## DnsDataEventsFilter {#yandex.cloud.audittrails.v1.Trail.DnsDataEventsFilter2}

#|
||Field | Description ||
|| includeNonrecursiveQueries | **boolean**

Not only recursive queries will be delivered ||
|#