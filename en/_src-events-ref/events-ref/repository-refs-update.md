---
title: repository.refs_update
description: RefsUpdate event - represents git refs update operation to a repository
editable: false
---

# repository.refs_update

RefsUpdate event - represents git refs update operation to a repository

**can-trigger-ci:** `false`

<a id="payload"></a>

REQUEST BODY SCHEMA: **application/json**
required

#|
|| **Field** | **Description** ||
|| [header](#header) | _object (Common header included in all public events)_ ||
|| [repository](#repository) | _object (RepositoryEmbedded)_ ||
|| [ref_updates](#ref-updates) | _Array of objects (Push details - supports multiple ref updates in a single push)_ ||
|| [pusher](#pusher) | _object (UserEmbedded)_ ||
|| `pushed_at` | _string &lt;date-time&gt;_ ||
|| `is_default_branch_updated` | _boolean (Whether the default branch was updated in this push)_ ||
|| `default_branch` | _string (The default branch reference name (e.g., "refs/heads/main"))_ ||
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

## ref_updates {#ref-updates}

#|
|| **Field** | **Description** ||
|| `ref` | _string (The git reference being updated (e.g., "refs/heads/main"))_ ||
|| `operation` | _string (Type of ref update operation)_

Enum: `"create"` `"update"` `"delete"` ||
|| `before_sha` | _string (Commit SHA before the update (zeros for new ref))_ ||
|| `after_sha` | _string (Commit SHA after the update (zeros for deleted ref))_ ||
|| `checkout_sha` | _string (For annotated tags: the peeled SHA (commit the tag points to))_ ||
|| `before_checkout_sha` | _string (For annotated tags: the peeled commit SHA before the update)_ ||
|#

## pusher {#pusher}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

{% cut "Request samples" %}

```json
{
  "$ref": "#/components/schemas/RefsUpdate",
  "components": {
    "schemas": {
      "RefsUpdate": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/EventHeader"
          },
          "repository": {
            "$ref": "#/components/schemas/RepositoryEmbedded"
          },
          "ref_updates": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/RefUpdate"
            },
            "title": "Push details - supports multiple ref updates in a single push"
          },
          "pusher": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "pushed_at": {
            "type": "string",
            "format": "date-time"
          },
          "is_default_branch_updated": {
            "type": "boolean",
            "title": "Whether the default branch was updated in this push"
          },
          "default_branch": {
            "type": "string",
            "title": "The default branch reference name (e.g., \"refs/heads/main\")"
          }
        },
        "title": "RefsUpdate event - represents git refs update operation to a repository"
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
      },
      "RefUpdate": {
        "type": "object",
        "properties": {
          "ref": {
            "type": "string",
            "title": "The git reference being updated (e.g., \"refs/heads/main\")"
          },
          "operation": {
            "$ref": "#/components/schemas/RefUpdateOperation"
          },
          "before_sha": {
            "type": "string",
            "title": "Commit SHA before the update (zeros for new ref)"
          },
          "after_sha": {
            "type": "string",
            "title": "Commit SHA after the update (zeros for deleted ref)"
          },
          "checkout_sha": {
            "type": "string",
            "title": "For annotated tags: the peeled SHA (commit the tag points to)"
          },
          "before_checkout_sha": {
            "type": "string",
            "title": "For annotated tags: the peeled commit SHA before the update"
          }
        },
        "title": "Represents a single ref update within a push"
      },
      "RefUpdateOperation": {
        "type": "string",
        "enum": [
          "create",
          "update",
          "delete"
        ],
        "title": "Type of ref update operation",
        "x-ogen-name": "RefUpdateOperationResponse"
      }
    }
  }
}
```

{% endcut %}
