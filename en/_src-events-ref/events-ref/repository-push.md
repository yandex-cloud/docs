---
title: repository.push
description: |-
  Push event - represents git push operation to a repository

  **CI execution_ref:** Created or updated branch or tag. Default branch when deleted.
editable: false
---

# repository.push

Push event - represents git push operation to a repository

**CI execution_ref:** Created or updated branch or tag. Default branch when deleted.

**can-trigger-ci:** `true`

<a id="payload"></a>

REQUEST BODY SCHEMA: **application/json**
required

#|
|| **Field** | **Description** ||
|| [header](#header) | _object (Common header included in all public events)_ ||
|| [repository](#repository) | _object (Repository)_ ||
|| [ref_update](#ref-update) | _object (Represents a single ref update within a push)_ ||
|| [pusher](#pusher) | _object (UserEmbedded)_ ||
|| `pushed_at` | _string &lt;date-time&gt;_ ||
|| [commits](#commits) | _Array of objects (Commit)_
Commits details for this event, from before_sha to after_sha.
In case of tag push or new branch creation before_sha is zero
and commits contain only single commit. ||
|| `is_default_branch_updated` | _boolean (Whether the default branch was updated in this push)_ ||
|| `default_branch` | _string (The default branch reference name (e.g., "refs/heads/main"))_ ||
|| `has_more_commits` | _boolean (Whether there are more commits (due to commits limit))_ ||
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

## ref_update {#ref-update}

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

## commits {#commits}

#|
|| **Field** | **Description** ||
|| `hash` | _string_ ||
|| `message` | _string_ ||
|| [author](#commits-author) | _object (Signature)_ ||
|| [committer](#commits-committer) | _object (Signature)_ ||
|| `tree_hash` | _string (Hash of the tree object)_ ||
|| `parent_hashes` | _Array of strings (Hashes of parent commits)_ ||
|| `merge_tag` | _string (Embedded merge tag (if present))_ ||
|| [file_changes](#commits-file-changes) | _object (CommitFileChanges)_ ||
|| [author_user](#commits-author-user) | _object (UserEmbedded)_ ||
|| [committer_user](#commits-committer-user) | _object (UserEmbedded)_ ||
|| [signature_verification](#commits-signature-verification) | _object (SignatureVerification)_ ||
|#

### commits.author {#commits-author}

#|
|| **Field** | **Description** ||
|| `name` | _string (Name of the person)_ ||
|| `email` | _string (Email of the person)_ ||
|| `date` | _string &lt;date-time&gt; (Timestamp of the signature)_ ||
|#

### commits.committer {#commits-committer}

#|
|| **Field** | **Description** ||
|| `name` | _string (Name of the person)_ ||
|| `email` | _string (Email of the person)_ ||
|| `date` | _string &lt;date-time&gt; (Timestamp of the signature)_ ||
|#

### commits.file_changes {#commits-file-changes}

#|
|| **Field** | **Description** ||
|| `added` | _Array of strings_
Files that were added in this commit.
Limited to 1000 files maximum. Empty list means no files were added. ||
|| `modified` | _Array of strings_
Files that were modified in this commit.
Limited to 1000 files maximum. Empty list means no files were modified. ||
|| `removed` | _Array of strings_
Files that were removed in this commit.
Limited to 1000 files maximum. Empty list means no files were removed. ||
|#

### commits.author_user {#commits-author-user}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### commits.committer_user {#commits-committer-user}

#|
|| **Field** | **Description** ||
|| `id` | _string (Id will contain "&lt;external-user&gt;" if user is external)_ ||
|| `slug` | _string (Slug will contain "&lt;external-user&gt;" if user is external)_ ||
|#

### commits.signature_verification {#commits-signature-verification}

#|
|| **Field** | **Description** ||
|| `verified` | _boolean_ ||
|| `reason` | _string (SignatureVerificationReason)_

Enum: `"SIGNATURE_VERIFICATION_REASON_VALID"` `"SIGNATURE_VERIFICATION_REASON_INVALID"` `"SIGNATURE_VERIFICATION_REASON_MALFORMED_SIGNATURE"` `"SIGNATURE_VERIFICATION_REASON_UNKNOWN_KEY"` `"SIGNATURE_VERIFICATION_REASON_NO_USER"` `"SIGNATURE_VERIFICATION_REASON_BAD_EMAIL"` `"SIGNATURE_VERIFICATION_REASON_EXPIRED_KEY"` `"SIGNATURE_VERIFICATION_REASON_NOT_SIGNING_KEY"` ||
|| `verified_at` | _string &lt;date-time&gt;_ ||
|#

{% cut "Request samples" %}

```json
{
  "$ref": "#/components/schemas/Push",
  "components": {
    "schemas": {
      "Push": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/EventHeader"
          },
          "repository": {
            "$ref": "#/components/schemas/Repository"
          },
          "ref_update": {
            "$ref": "#/components/schemas/RefUpdate"
          },
          "pusher": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "pushed_at": {
            "type": "string",
            "format": "date-time"
          },
          "commits": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Commit"
            },
            "description": "Commits details for this event, from before_sha to after_sha.\nIn case of tag push or new branch creation before_sha is zero\nand commits contain only single commit."
          },
          "is_default_branch_updated": {
            "type": "boolean",
            "title": "Whether the default branch was updated in this push"
          },
          "default_branch": {
            "type": "string",
            "title": "The default branch reference name (e.g., \"refs/heads/main\")"
          },
          "has_more_commits": {
            "type": "boolean",
            "title": "Whether there are more commits (due to commits limit)"
          }
        },
        "title": "Push event - represents git push operation to a repository"
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
      },
      "Commit": {
        "type": "object",
        "properties": {
          "hash": {
            "type": "string"
          },
          "message": {
            "type": "string"
          },
          "author": {
            "$ref": "#/components/schemas/Signature"
          },
          "committer": {
            "$ref": "#/components/schemas/Signature"
          },
          "tree_hash": {
            "type": "string",
            "title": "Hash of the tree object"
          },
          "parent_hashes": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "title": "Hashes of parent commits"
          },
          "merge_tag": {
            "type": "string",
            "title": "Embedded merge tag (if present)"
          },
          "file_changes": {
            "$ref": "#/components/schemas/CommitFileChanges"
          },
          "author_user": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "committer_user": {
            "$ref": "#/components/schemas/UserEmbedded"
          },
          "signature_verification": {
            "$ref": "#/components/schemas/SignatureVerification"
          }
        }
      },
      "Signature": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "title": "Name of the person"
          },
          "email": {
            "type": "string",
            "title": "Email of the person"
          },
          "date": {
            "type": "string",
            "format": "date-time",
            "title": "Timestamp of the signature"
          }
        }
      },
      "CommitFileChanges": {
        "type": "object",
        "properties": {
          "added": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Files that were added in this commit.\nLimited to 1000 files maximum. Empty list means no files were added."
          },
          "modified": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Files that were modified in this commit.\nLimited to 1000 files maximum. Empty list means no files were modified."
          },
          "removed": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Files that were removed in this commit.\nLimited to 1000 files maximum. Empty list means no files were removed."
          }
        }
      },
      "SignatureVerification": {
        "type": "object",
        "properties": {
          "verified": {
            "type": "boolean"
          },
          "reason": {
            "$ref": "#/components/schemas/SignatureVerificationReason"
          },
          "verified_at": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "SignatureVerificationReason": {
        "type": "string",
        "enum": [
          "SIGNATURE_VERIFICATION_REASON_VALID",
          "SIGNATURE_VERIFICATION_REASON_INVALID",
          "SIGNATURE_VERIFICATION_REASON_MALFORMED_SIGNATURE",
          "SIGNATURE_VERIFICATION_REASON_UNKNOWN_KEY",
          "SIGNATURE_VERIFICATION_REASON_NO_USER",
          "SIGNATURE_VERIFICATION_REASON_BAD_EMAIL",
          "SIGNATURE_VERIFICATION_REASON_EXPIRED_KEY",
          "SIGNATURE_VERIFICATION_REASON_NOT_SIGNING_KEY"
        ]
      }
    }
  }
}
```

{% endcut %}
