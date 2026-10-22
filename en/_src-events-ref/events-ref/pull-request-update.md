---
title: pull_request.update
description: |-
  PullRequestUpdate event - represents update of a pull request

  **CI execution_ref:** Pull request source branch.
editable: false
---

# pull_request.update

PullRequestUpdate event - represents update of a pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true`

<a id="payload"></a>

REQUEST BODY SCHEMA: **application/json**
required

#|
|| **Field** | **Description** ||
|| [header](#header) | _object (Common header included in all public events)_ ||
|| [repository](#repository) | _object (Repository)_ ||
|| [pull_request](#pull-request) | _object (PullRequest)_ ||
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

## pull_request {#pull-request}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| [author](#pull-request-author) | _object (UserEmbedded)_ ||
|| [updated_by](#pull-request-updated-by) | _object (UserEmbedded)_ ||
|| `title` | _string_ ||
|| `description` | _string_ ||
|| [repository](#pull-request-repository) | _object (RepositoryEmbedded)_ ||
|| [merge_info](#pull-request-merge-info) | _object (MergeInfo)_ ||
|| `source_branch` | _string (Deprecated, use `source` instead)_ ||
|| `target_branch` | _string (Deprecated, use `target` instead)_ ||
|| `status` | _string (PullRequest.Status)_

Enum: `"draft"` `"open"` `"discarded"` `"merging"` `"merged"` ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|| [labels](#pull-request-labels) | _Array of objects (LabelEmbedded)_ ||
|| [source](#pull-request-source) | _object (PullRequestBranch)_ ||
|| [target](#pull-request-target) | _object (PullRequestBranch)_ ||
|#

### pull_request.author {#pull-request-author}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### pull_request.updated_by {#pull-request-updated-by}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### pull_request.repository {#pull-request-repository}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| [organization](#pull-request-repository-organization) | _object (OrganizationEmbedded)_ ||
|#

#### pull_request.repository.organization {#pull-request-repository-organization}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|#

### pull_request.merge_info {#pull-request-merge-info}

#|
|| **Field** | **Description** ||
|| [merger](#pull-request-merge-info-merger) | _object (UserEmbedded)_ ||
|| [merge_parameters](#pull-request-merge-info-merge-parameters) | _object (MergeParameters)_ ||
|| `target_commit_hash` | _string_ ||
|| `error` | _string (filled after merge)_ ||
|| `merge_commit_hash` | _string (filled after merge)_ ||
|#

#### pull_request.merge_info.merger {#pull-request-merge-info-merger}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

#### pull_request.merge_info.merge_parameters {#pull-request-merge-info-merge-parameters}

#|
|| **Field** | **Description** ||
|| `rebase` | _boolean_ ||
|| `squash` | _boolean_ ||
|#

### pull_request.labels {#pull-request-labels}

#|
|| **Field** | **Description** ||
|| `id` | _string_ ||
|| `slug` | _string_ ||
|| `name` | _string_ ||
|| `color` | _string_ ||
|#

### pull_request.source {#pull-request-source}

#|
|| **Field** | **Description** ||
|| `label` | _string ("org/repo:branch-name")_ ||
|| `ref` | _string (branch name)_ ||
|| `sha` | _string (commit SHA (hex))_ ||
|#

### pull_request.target {#pull-request-target}

#|
|| **Field** | **Description** ||
|| `label` | _string ("org/repo:branch-name")_ ||
|| `ref` | _string (branch name)_ ||
|| `sha` | _string (commit SHA (hex))_ ||
|#

{% cut "Request samples" %}

```json
{
  "$ref": "#/components/schemas/PullRequestUpdate",
  "components": {
    "schemas": {
      "PullRequestUpdate": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/EventHeader"
          },
          "repository": {
            "$ref": "#/components/schemas/Repository"
          },
          "pull_request": {
            "$ref": "#/components/schemas/PullRequest"
          }
        },
        "title": "PullRequestUpdate event - represents update of a pull request"
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
      "PullRequest": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "slug": {
            "type": "string"
          },
          "author": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "updated_by": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "title": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "repository": {
            "$ref": "#/components/schemas/RepositoryEmbedded"
          },
          "merge_info": {
            "$ref": "#/components/schemas/MergeInfo"
          },
          "source_branch": {
            "type": "string",
            "title": "Deprecated, use `source` instead"
          },
          "target_branch": {
            "type": "string",
            "title": "Deprecated, use `target` instead"
          },
          "status": {
            "$ref": "#/components/schemas/PullRequest.Status"
          },
          "created_at": {
            "type": "string",
            "format": "date-time"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time"
          },
          "labels": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/LabelEmbedded"
            }
          },
          "source": {
            "$ref": "#/components/schemas/PullRequestBranch"
          },
          "target": {
            "$ref": "#/components/schemas/PullRequestBranch"
          }
        }
      },
      "MergeInfo": {
        "type": "object",
        "properties": {
          "merger": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "merge_parameters": {
            "$ref": "#/components/schemas/MergeParameters"
          },
          "target_commit_hash": {
            "type": "string"
          },
          "error": {
            "type": "string",
            "title": "filled after merge"
          },
          "merge_commit_hash": {
            "type": "string",
            "title": "filled after merge"
          }
        }
      },
      "MergeParameters": {
        "type": "object",
        "properties": {
          "rebase": {
            "type": "boolean"
          },
          "squash": {
            "type": "boolean"
          }
        }
      },
      "PullRequest.Status": {
        "type": "string",
        "enum": [
          "draft",
          "open",
          "discarded",
          "merging",
          "merged"
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
      "PullRequestBranch": {
        "type": "object",
        "properties": {
          "label": {
            "type": "string",
            "title": "\"org/repo:branch-name\""
          },
          "ref": {
            "type": "string",
            "title": "branch name"
          },
          "sha": {
            "type": "string",
            "title": "commit SHA (hex)"
          }
        }
      }
    }
  }
}
```

{% endcut %}
