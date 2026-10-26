---
title: issue_comment.delete
description: |-
  IssueCommentDelete event - represents deletion of an issue comment

  **CI execution_ref:** Default branch.
editable: false
---

# issue_comment.delete

IssueCommentDelete event - represents deletion of an issue comment

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true`

<a id="payload"></a>

REQUEST BODY SCHEMA: **application/json**
required

#|
|| **Field** | **Description** ||
|| [header](#header) | _object (Common header included in all public events)_ ||
|| [repository](#repository) | _object (Repository)_ ||
|| [issue](#issue) | _object (Issue)_ ||
|| [comment](#comment) | _object (IssueComment)_ ||
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
|| `name` | _string_
Deprecated: obsolete, prefer using slug. Will be removed in future API iterations. ||
|| `default_branch` | _string_ ||
|| [organization](#repository-organization) | _object (OrganizationEmbedded)_ ||
|| `slug` | _string_ ||
|| `template_type` | _string (RepoTemplate)_

Enum: `"not_a_template"` `"organizational"` `"system"` ||
|| `is_empty` | _boolean_ ||
|| `description` | _string_ ||
|| `visibility` | _string (Repository.Visibility)_

Enum: `"public"` `"internal"` `"private"` ||
|| [logo](#repository-logo) | _object (Image)_ ||
|| [clone_url](#repository-clone-url) | _object (CloneURL)_ ||
|| `web_url` | _string_ ||
|| [links](#repository-links) | _Array of objects (Link)_ ||
|| [counters](#repository-counters) | _object (RepositoryCounters)_ ||
|| `last_updated` | _string &lt;date-time&gt;_ ||
|| [language](#repository-language) | _object (Language)_ ||
|| [parent](#repository-parent) | _object (RepositoryEmbedded)_ ||
|| [migration_source](#repository-migration-source) | _object (MigrationSource)_ ||
|| [project](#repository-project) | _object (ProjectEmbedded)_ ||
|| [rating](#repository-rating) | _object (RepositoryRating)_
Aggregated rating information for a repository. ||
|| [settings](#repository-settings) | _object (RepositorySettings)_ ||
|#

### repository.organization {#repository-organization}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

### repository.logo {#repository-logo}

#|
|| **Field** | **Description** ||
|| `url` | _string_ ||
|#

### repository.clone_url {#repository-clone-url}

#|
|| **Field** | **Description** ||
|| `https` | _string_ ||
|| `ssh` | _string_ ||
|#

### repository.links {#repository-links}

#|
|| **Field** | **Description** ||
|| `link` | _string_ ||
|| `type` | _string (Link.LinkType)_

Enum: `"default"` `"social_network"` `"homepage"` `"email"` `"telegram"` ||
|#

### repository.counters {#repository-counters}

#|
|| **Field** | **Description** ||
|| `forks` | _string &lt;uint64&gt;_ ||
|| `pull_requests` | _string &lt;uint64&gt;_ ||
|| `issues` | _string &lt;uint64&gt;_ ||
|| `tags` | _string &lt;uint64&gt;_ ||
|| `branches` | _string &lt;uint64&gt;_ ||
|#

### repository.language {#repository-language}

#|
|| **Field** | **Description** ||
|| `name` | _string_ ||
|| `color` | _string_ ||
|#

### repository.parent {#repository-parent}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| [organization](#repository-parent-organization) | _object (OrganizationEmbedded)_ ||
|#

#### repository.parent.organization {#repository-parent-organization}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

### repository.migration_source {#repository-migration-source}

#|
|| **Field** | **Description** ||
|| `url` | _string_ ||
|| `domain` | _string_ ||
|#

### repository.project {#repository-project}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

### repository.rating {#repository-rating}

#|
|| **Field** | **Description** ||
|| `value` | _number &lt;double&gt;_
Current repository rating value. ||
|| `percentile` | _number &lt;double&gt;_
Repository percentile among rated repositories. Omitted while percentile data is unavailable. ||
|| [reaction_counts](#repository-rating-reaction-counts) | _Array of objects (RepositoryRatingReactionCount)_
Reaction counters grouped by reaction type. ||
|#

#### repository.rating.reaction_counts {#repository-rating-reaction-counts}

#|
|| **Field** | **Description** ||
|| `type` | _string (RepositoryRatingReaction.Type)_
 - none: Remove the current user's rating reaction.
 - positive_low: A low positive rating reaction. Corresponds to Like in the SourceCraft interface.
 - positive_medium: A medium positive rating reaction. Corresponds to Heart in the SourceCraft interface.
 - positive_high: A high positive rating reaction. Corresponds to Diamond in the SourceCraft interface.

Enum: `"none"` `"positive_low"` `"positive_medium"` `"positive_high"` ||
|| `count` | _string &lt;uint64&gt;_ ||
|#

### repository.settings {#repository-settings}

#|
|| **Field** | **Description** ||
|| `allow_external_contributions` | _boolean_
Whether authenticated users without organization or repository access can contribute to a public repository.
Has no effect on non-public repositories. ||
|#

## issue {#issue}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| `title` | _string_ ||
|| `description` | _string_ ||
|| [status](#issue-status) | _object (IssueStatus)_ ||
|| [author](#issue-author) | _object (UserEmbedded)_ ||
|| [updated_by](#issue-updated-by) | _object (UserEmbedded)_ ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|| [assignee](#issue-assignee) | _object (UserEmbedded)_ ||
|| [labels](#issue-labels) | _Array of objects (LabelEmbedded)_ ||
|| [linked_prs](#issue-linked-prs) | _Array of objects (PullRequestEmbedded)_ ||
|| `priority` | _string (mapping is done by const name, except for the unspecified)_

Enum: `"trivial"` `"minor"` `"normal"` `"critical"` `"blocker"` ||
|| `visibility` | _string (Issue.Visibility)_

Enum: `"public"` `"private"` ||
|| [milestone](#issue-milestone) | _object (MilestoneEmbedded)_ ||
|| `deadline` | _string &lt;date-time&gt; (User-defined deadline for the issue)_ ||
|| `started_at` | _string &lt;date-time&gt; (Set on creation in progress or first entry into in\_progress; preserved on reentry)_ ||
|| `completed_at` | _string &lt;date-time&gt; (Set on entry into a terminal status; cleared when leaving terminal statuses)_ ||
|| [repository](#issue-repository) | _object (RepositoryEmbedded)_ ||
|#

### issue.status {#issue-status}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| `name` | _string_ ||
|| `status_type` | _string (StatusType)_

Enum: `"initial"` `"in_progress"` `"paused"` `"completed"` `"cancelled"` ||
|#

### issue.author {#issue-author}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### issue.updated_by {#issue-updated-by}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### issue.assignee {#issue-assignee}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### issue.labels {#issue-labels}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| `name` | _string_ ||
|| `color` | _string_ ||
|#

### issue.linked_prs {#issue-linked-prs}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

### issue.milestone {#issue-milestone}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

### issue.repository {#issue-repository}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| [organization](#issue-repository-organization) | _object (OrganizationEmbedded)_ ||
|#

#### issue.repository.organization {#issue-repository-organization}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

## comment {#comment}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `body` | _string_ ||
|| [parent](#comment-parent) | _object (IssueCommentEmbedded)_ ||
|| [author](#comment-author) | _object (UserEmbedded)_ ||
|| [updated_by](#comment-updated-by) | _object (UserEmbedded)_ ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|| [reactions](#comment-reactions) | _object (key is one of Reactions)_ ||
|| [attachments](#comment-attachments) | _Array of objects (AttachmentEmbedded)_ ||
|#

### comment.parent {#comment-parent}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|#

### comment.author {#comment-author}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### comment.updated_by {#comment-updated-by}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### comment.reactions {#comment-reactions}

#|
|| **Field** | **Description** ||
|| [property name*](#comment-reactions-additional-property)
additional property | _object (ReactionCount)_ ||
|#

#### comment.reactions.additional-property {#comment-reactions-additional-property}

#|
|| **Field** | **Description** ||
|| `count` | _integer &lt;int32&gt;_ ||
|| `self_react` | _boolean_ ||
|#

### comment.attachments {#comment-attachments}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|#

{% cut "Request samples" %}

```json
{
  "$ref": "#/components/schemas/IssueCommentDelete",
  "components": {
    "schemas": {
      "IssueCommentDelete": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/EventHeader"
          },
          "repository": {
            "$ref": "#/components/schemas/Repository"
          },
          "issue": {
            "$ref": "#/components/schemas/Issue"
          },
          "comment": {
            "$ref": "#/components/schemas/IssueComment"
          }
        },
        "title": "IssueCommentDelete event - represents deletion of an issue comment"
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
      "Repository": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string",
            "description": "Deprecated: obsolete, prefer using slug. Will be removed in future API iterations."
          },
          "default_branch": {
            "type": "string"
          },
          "organization": {
            "$ref": "#/components/schemas/OrganizationEmbedded"
          },
          "slug": {
            "type": "string"
          },
          "template_type": {
            "$ref": "#/components/schemas/RepoTemplate"
          },
          "is_empty": {
            "type": "boolean"
          },
          "description": {
            "type": "string"
          },
          "visibility": {
            "$ref": "#/components/schemas/Repository.Visibility"
          },
          "logo": {
            "$ref": "#/components/schemas/Image"
          },
          "clone_url": {
            "$ref": "#/components/schemas/CloneURL"
          },
          "web_url": {
            "type": "string"
          },
          "links": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Link"
            }
          },
          "counters": {
            "$ref": "#/components/schemas/RepositoryCounters"
          },
          "last_updated": {
            "type": "string",
            "format": "date-time"
          },
          "language": {
            "$ref": "#/components/schemas/Language"
          },
          "parent": {
            "$ref": "#/components/schemas/RepositoryEmbedded"
          },
          "migration_source": {
            "$ref": "#/components/schemas/MigrationSource"
          },
          "project": {
            "$ref": "#/components/schemas/ProjectEmbedded"
          },
          "rating": {
            "$ref": "#/components/schemas/RepositoryRating"
          },
          "settings": {
            "$ref": "#/components/schemas/RepositorySettings"
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
      "RepoTemplate": {
        "type": "string",
        "enum": [
          "not_a_template",
          "organizational",
          "system"
        ]
      },
      "Repository.Visibility": {
        "type": "string",
        "enum": [
          "public",
          "internal",
          "private"
        ]
      },
      "Image": {
        "type": "object",
        "properties": {
          "url": {
            "type": "string"
          }
        }
      },
      "CloneURL": {
        "type": "object",
        "properties": {
          "https": {
            "type": "string"
          },
          "ssh": {
            "type": "string"
          }
        }
      },
      "Link": {
        "type": "object",
        "properties": {
          "link": {
            "type": "string"
          },
          "type": {
            "$ref": "#/components/schemas/Link.LinkType"
          }
        }
      },
      "Link.LinkType": {
        "type": "string",
        "enum": [
          "default",
          "social_network",
          "homepage",
          "email",
          "telegram"
        ]
      },
      "RepositoryCounters": {
        "type": "object",
        "properties": {
          "forks": {
            "type": "string",
            "format": "uint64"
          },
          "pull_requests": {
            "type": "string",
            "format": "uint64"
          },
          "issues": {
            "type": "string",
            "format": "uint64"
          },
          "tags": {
            "type": "string",
            "format": "uint64"
          },
          "branches": {
            "type": "string",
            "format": "uint64"
          }
        }
      },
      "Language": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "color": {
            "type": "string"
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
      "MigrationSource": {
        "type": "object",
        "properties": {
          "url": {
            "type": "string"
          },
          "domain": {
            "type": "string"
          }
        }
      },
      "ProjectEmbedded": {
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
      "RepositoryRating": {
        "type": "object",
        "properties": {
          "value": {
            "type": "number",
            "format": "double",
            "description": "Current repository rating value."
          },
          "percentile": {
            "type": "number",
            "format": "double",
            "description": "Repository percentile among rated repositories. Omitted while percentile data is unavailable."
          },
          "reaction_counts": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/RepositoryRatingReactionCount"
            },
            "description": "Reaction counters grouped by reaction type."
          }
        },
        "description": "Aggregated rating information for a repository."
      },
      "RepositoryRatingReactionCount": {
        "type": "object",
        "properties": {
          "type": {
            "$ref": "#/components/schemas/RepositoryRatingReaction.Type"
          },
          "count": {
            "type": "string",
            "format": "uint64"
          }
        },
        "description": "Number of rating reactions of a particular type."
      },
      "RepositoryRatingReaction.Type": {
        "type": "string",
        "enum": [
          "none",
          "positive_low",
          "positive_medium",
          "positive_high"
        ],
        "description": " - none: Remove the current user's rating reaction.\n - positive_low: A low positive rating reaction. Corresponds to Like in the SourceCraft interface.\n - positive_medium: A medium positive rating reaction. Corresponds to Heart in the SourceCraft interface.\n - positive_high: A high positive rating reaction. Corresponds to Diamond in the SourceCraft interface."
      },
      "RepositorySettings": {
        "type": "object",
        "properties": {
          "allow_external_contributions": {
            "type": "boolean",
            "description": "Whether authenticated users without organization or repository access can contribute to a public repository.\nHas no effect on non-public repositories."
          }
        }
      },
      "Issue": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "slug": {
            "type": "string"
          },
          "title": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/IssueStatus"
          },
          "author": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "updated_by": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "created_at": {
            "type": "string",
            "format": "date-time"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time"
          },
          "assignee": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "labels": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/LabelEmbedded"
            }
          },
          "linked_prs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PullRequestEmbedded"
            }
          },
          "priority": {
            "$ref": "#/components/schemas/Priority"
          },
          "visibility": {
            "$ref": "#/components/schemas/Issue.Visibility"
          },
          "milestone": {
            "$ref": "#/components/schemas/MilestoneEmbedded"
          },
          "deadline": {
            "type": "string",
            "format": "date-time",
            "title": "User-defined deadline for the issue"
          },
          "started_at": {
            "type": "string",
            "format": "date-time",
            "title": "Set on creation in progress or first entry into in_progress; preserved on reentry"
          },
          "completed_at": {
            "type": "string",
            "format": "date-time",
            "title": "Set on entry into a terminal status; cleared when leaving terminal statuses"
          },
          "repository": {
            "$ref": "#/components/schemas/RepositoryEmbedded"
          }
        }
      },
      "IssueStatus": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "slug": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "status_type": {
            "$ref": "#/components/schemas/StatusType"
          }
        }
      },
      "StatusType": {
        "type": "string",
        "enum": [
          "initial",
          "in_progress",
          "paused",
          "completed",
          "cancelled"
        ]
      },
      "LabelEmbedded": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "slug": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "color": {
            "type": "string"
          }
        }
      },
      "PullRequestEmbedded": {
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
      "Priority": {
        "type": "string",
        "enum": [
          "trivial",
          "minor",
          "normal",
          "critical",
          "blocker"
        ],
        "title": "mapping is done by const name, except for the unspecified"
      },
      "Issue.Visibility": {
        "type": "string",
        "enum": [
          "public",
          "private"
        ]
      },
      "MilestoneEmbedded": {
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
      "IssueComment": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "body": {
            "type": "string"
          },
          "parent": {
            "$ref": "#/components/schemas/IssueCommentEmbedded"
          },
          "author": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "updated_by": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "created_at": {
            "type": "string",
            "format": "date-time"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time"
          },
          "reactions": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ReactionCount"
            },
            "title": "key is one of Reactions"
          },
          "attachments": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AttachmentEmbedded"
            }
          }
        }
      },
      "IssueCommentEmbedded": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          }
        }
      },
      "ReactionCount": {
        "type": "object",
        "properties": {
          "count": {
            "type": "integer",
            "format": "int32"
          },
          "self_react": {
            "type": "boolean"
          }
        }
      },
      "AttachmentEmbedded": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          }
        }
      }
    }
  }
}
```

{% endcut %}
