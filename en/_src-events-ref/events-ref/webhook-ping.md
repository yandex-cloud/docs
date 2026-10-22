---
title: webhook.ping
description: Ping event - sent when a webhook is tested
editable: false
---

# webhook.ping

Ping event - sent when a webhook is tested

**can-trigger-ci:** `false`

<a id="payload"></a>

REQUEST BODY SCHEMA: **application/json**
required

#|
|| **Field** | **Description** ||
|| [header](#header) | _object (Common header included in all public events)_ ||
|| [repository](#repository) | _object (RepositoryEmbedded)_ ||
|| `webhook_slug` | _string (Webhook slug identifier)_ ||
|| `pinged_at` | _string &lt;date-time&gt; (When the ping was sent)_ ||
|| [organization](#organization) | _object (OrganizationEmbedded)_ ||
|#

## header {#header}

#|
|| **Field** | **Description** ||
|| `id` | _string (Unique identifier for this event instance)_ ||
|| `type` | _string (Event type)_ ||
|| `occurred_at` | _string &lt;date-time&gt; (When the event occurred)_ ||
|| `aggregate_id` | _string (ID of the primary entity this event is about)_ ||
|| `aggregate_type` | _string (Type of the primary entity (derived from event\_type))_ ||
|| [metadata](#header-metadata) | _object (Public metadata)_ ||
|| `organization_id` | _string (Organization context)_ ||
|| `repository_id` | _string (Repository context)_ ||
|| [triggered_by](#header-triggered-by) | _object (UserEmbedded)_ ||
|| `correlation_id` | _string_
Correlation ID for tracking event chains back to the original request.
Uses request_id from the originating gRPC/HTTP request when available,
falls back to trace_id or the root event's ID. ||
|| `causation_id` | _string_
Causation ID is the ID of the event that directly caused this event.
Empty for root events (events triggered directly by user actions).
Used to reconstruct the event tree within a correlation chain. ||
|#

### header.metadata {#header-metadata}

#|
|| **Field** | **Description** ||
|| `property name*`
additional property | _string_ ||
|#

### header.triggered_by {#header-triggered-by}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

## repository {#repository}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| [organization](#repository-organization) | _object (OrganizationEmbedded)_ ||
|#

### repository.organization {#repository-organization}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

## organization {#organization}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

{% cut "Request samples" %}

```json
{
  "$ref": "#/components/schemas/Ping",
  "components": {
    "schemas": {
      "Ping": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/EventHeader"
          },
          "repository": {
            "$ref": "#/components/schemas/RepositoryEmbedded"
          },
          "webhook_slug": {
            "type": "string",
            "title": "Webhook slug identifier"
          },
          "pinged_at": {
            "type": "string",
            "format": "date-time",
            "title": "When the ping was sent"
          },
          "organization": {
            "$ref": "#/components/schemas/OrganizationEmbedded"
          }
        },
        "title": "Ping event - sent when a webhook is tested"
      },
      "EventHeader": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "title": "Unique identifier for this event instance"
          },
          "type": {
            "type": "string",
            "title": "Event type"
          },
          "occurred_at": {
            "type": "string",
            "format": "date-time",
            "title": "When the event occurred"
          },
          "aggregate_id": {
            "type": "string",
            "title": "ID of the primary entity this event is about"
          },
          "aggregate_type": {
            "type": "string",
            "title": "Type of the primary entity (derived from event_type)"
          },
          "metadata": {
            "type": "object",
            "additionalProperties": {
              "type": "string"
            },
            "title": "Public metadata"
          },
          "organization_id": {
            "type": "string",
            "title": "Organization context"
          },
          "repository_id": {
            "type": "string",
            "title": "Repository context"
          },
          "triggered_by": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "correlation_id": {
            "type": "string",
            "description": "Correlation ID for tracking event chains back to the original request.\nUses request_id from the originating gRPC/HTTP request when available,\nfalls back to trace_id or the root event's ID."
          },
          "causation_id": {
            "type": "string",
            "description": "Causation ID is the ID of the event that directly caused this event.\nEmpty for root events (events triggered directly by user actions).\nUsed to reconstruct the event tree within a correlation chain."
          }
        },
        "title": "Common header included in all public events"
      },
      "UserEmbedded": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "title": "Id will contain \"<external-user>\" if user is external"
          },
          "slug": {
            "type": "string",
            "title": "Slug will contain \"<external-user>\" if user is external"
          }
        }
      },
      "RepositoryEmbedded": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "slug": {
            "type": "string"
          },
          "organization": {
            "$ref": "#/components/schemas/OrganizationEmbedded"
          }
        }
      },
      "OrganizationEmbedded": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "slug": {
            "type": "string"
          }
        }
      }
    }
  }
}
```

{% endcut %}
