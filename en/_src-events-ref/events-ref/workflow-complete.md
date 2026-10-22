---
title: workflow.complete
description: CI workflow completed - emitted when a single CI workflow completes (terminal status)
editable: false
---

# workflow.complete

CI workflow completed - emitted when a single CI workflow completes (terminal status)

**can-trigger-ci:** `false`

<a id="payload"></a>

REQUEST BODY SCHEMA: **application/json**
required

#|
|| **Field** | **Description** ||
|| [header](#header) | _object (Common header included in all public events)_ ||
|| [repository](#repository) | _object (Repository)_ ||
|| [workflow](#workflow) | _object (Workflow)_ ||
|| [run](#run) | _object (RunEmbedded)_ ||
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

## workflow {#workflow}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `slug` | _string (A name of the workflow as defined in the config)_ ||
|| `description` | _string_ ||
|| [dates](#workflow-dates) | _object (DatesByStage)_ ||
|| `status` | _string (Run.Status)_
 - prepared: Status `prepared` may only appear as a Run status.
It's a stage between creation and startup during which the Run is populated with workflows.

Enum: `"created"` `"prepared"` `"processing"` `"success"` `"failed"` `"canceled"` `"timeout"` `"skipped"` `"awaiting_approval"` `"rejected"` ||
|| [tasks](#workflow-tasks) | _Array of objects (Task)_ ||
|| [progress](#workflow-progress) | _object (Progress)_ ||
|| `environment_id` | _string_ ||
|#

### workflow.dates {#workflow-dates}

#|
|| **Field** | **Description** ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `started_at` | _string &lt;date-time&gt;_ ||
|| `finished_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

### workflow.tasks {#workflow-tasks}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `slug` | _string (A name of the task as defined in the config)_ ||
|| `description` | _string_ ||
|| [dates](#workflow-tasks-dates) | _object (DatesByStage)_ ||
|| `status` | _string (Run.Status)_
 - prepared: Status `prepared` may only appear as a Run status.
It's a stage between creation and startup during which the Run is populated with workflows.

Enum: `"created"` `"prepared"` `"processing"` `"success"` `"failed"` `"canceled"` `"timeout"` `"skipped"` `"awaiting_approval"` `"rejected"` ||
|| [cubes](#workflow-tasks-cubes) | _Array of objects (Cube)_ ||
|| [progress](#workflow-tasks-progress) | _object (Progress)_ ||
|| [relations](#workflow-tasks-relations) | _object (Relations)_ ||
|#

#### workflow.tasks.dates {#workflow-tasks-dates}

#|
|| **Field** | **Description** ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `started_at` | _string &lt;date-time&gt;_ ||
|| `finished_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

#### workflow.tasks.cubes {#workflow-tasks-cubes}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `slug` | _string (A name of the cube as defined in the config)_ ||
|| [dates](#workflow-tasks-cubes-dates) | _object (DatesByStage)_ ||
|| `status` | _string (Run.Status)_
 - prepared: Status `prepared` may only appear as a Run status.
It's a stage between creation and startup during which the Run is populated with workflows.

Enum: `"created"` `"prepared"` `"processing"` `"success"` `"failed"` `"canceled"` `"timeout"` `"skipped"` `"awaiting_approval"` `"rejected"` ||
|| [artifacts](#workflow-tasks-cubes-artifacts) | _Array of objects (Artifact)_ ||
|| [relations](#workflow-tasks-cubes-relations) | _object (Relations)_ ||
|#

##### workflow.tasks.cubes.dates {#workflow-tasks-cubes-dates}

#|
|| **Field** | **Description** ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `started_at` | _string &lt;date-time&gt;_ ||
|| `finished_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

##### workflow.tasks.cubes.artifacts {#workflow-tasks-cubes-artifacts}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `local_path` | _string_
Artifacts do not have a slug as we define it.
Instead they are differentiated by context (workflow, task, cube) and `local_path`.
This is a local path for the artifact as defined in the CI configuration file. ||
|| [dates](#workflow-tasks-cubes-artifacts-dates) | _object (ArtifactDates)_ ||
|| `status` | _string (ArtifactStatus)_

Enum: `"registered"` `"success"` `"failed"` `"missing"` ||
|| `download_url` | _string_
A temporary download URL, will be valid for a short period of time after acquisition. ||
|#

###### workflow.tasks.cubes.artifacts.dates {#workflow-tasks-cubes-artifacts-dates}

#|
|| **Field** | **Description** ||
|| `registered_at` | _string &lt;date-time&gt;_ ||
|| `obtained_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

##### workflow.tasks.cubes.relations {#workflow-tasks-cubes-relations}

#|
|| **Field** | **Description** ||
|| [needs](#workflow-tasks-cubes-relations-needs) | _Array of objects (Dependency)_ ||
|#

###### workflow.tasks.cubes.relations.needs {#workflow-tasks-cubes-relations-needs}

#|
|| **Field** | **Description** ||
|| `name` | _string_ ||
|#

#### workflow.tasks.progress {#workflow-tasks-progress}

#|
|| **Field** | **Description** ||
|| `percent` | _number &lt;float&gt;_ ||
|| [current_cube](#workflow-tasks-progress-current-cube) | _object (Cube)_ ||
|#

##### workflow.tasks.progress.current_cube {#workflow-tasks-progress-current-cube}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `slug` | _string (A name of the cube as defined in the config)_ ||
|| [dates](#workflow-tasks-progress-current-cube-dates) | _object (DatesByStage)_ ||
|| `status` | _string (Run.Status)_
 - prepared: Status `prepared` may only appear as a Run status.
It's a stage between creation and startup during which the Run is populated with workflows.

Enum: `"created"` `"prepared"` `"processing"` `"success"` `"failed"` `"canceled"` `"timeout"` `"skipped"` `"awaiting_approval"` `"rejected"` ||
|| [artifacts](#workflow-tasks-progress-current-cube-artifacts) | _Array of objects (Artifact)_ ||
|| [relations](#workflow-tasks-progress-current-cube-relations) | _object (Relations)_ ||
|#

###### workflow.tasks.progress.current_cube.dates {#workflow-tasks-progress-current-cube-dates}

#|
|| **Field** | **Description** ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `started_at` | _string &lt;date-time&gt;_ ||
|| `finished_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

###### workflow.tasks.progress.current_cube.artifacts {#workflow-tasks-progress-current-cube-artifacts}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `local_path` | _string_
Artifacts do not have a slug as we define it.
Instead they are differentiated by context (workflow, task, cube) and `local_path`.
This is a local path for the artifact as defined in the CI configuration file. ||
|| [dates](#workflow-tasks-progress-current-cube-artifacts-dates) | _object (ArtifactDates)_ ||
|| `status` | _string (ArtifactStatus)_

Enum: `"registered"` `"success"` `"failed"` `"missing"` ||
|| `download_url` | _string_
A temporary download URL, will be valid for a short period of time after acquisition. ||
|#

###### workflow.tasks.progress.current_cube.artifacts.dates {#workflow-tasks-progress-current-cube-artifacts-dates}

#|
|| **Field** | **Description** ||
|| `registered_at` | _string &lt;date-time&gt;_ ||
|| `obtained_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

###### workflow.tasks.progress.current_cube.relations {#workflow-tasks-progress-current-cube-relations}

#|
|| **Field** | **Description** ||
|| [needs](#workflow-tasks-progress-current-cube-relations-needs) | _Array of objects (Dependency)_ ||
|#

###### workflow.tasks.progress.current_cube.relations.needs {#workflow-tasks-progress-current-cube-relations-needs}

#|
|| **Field** | **Description** ||
|| `name` | _string_ ||
|#

#### workflow.tasks.relations {#workflow-tasks-relations}

#|
|| **Field** | **Description** ||
|| [needs](#workflow-tasks-relations-needs) | _Array of objects (Dependency)_ ||
|#

##### workflow.tasks.relations.needs {#workflow-tasks-relations-needs}

#|
|| **Field** | **Description** ||
|| `name` | _string_ ||
|#

### workflow.progress {#workflow-progress}

#|
|| **Field** | **Description** ||
|| `percent` | _number &lt;float&gt;_ ||
|| [current_cube](#workflow-progress-current-cube) | _object (Cube)_ ||
|#

#### workflow.progress.current_cube {#workflow-progress-current-cube}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `slug` | _string (A name of the cube as defined in the config)_ ||
|| [dates](#workflow-progress-current-cube-dates) | _object (DatesByStage)_ ||
|| `status` | _string (Run.Status)_
 - prepared: Status `prepared` may only appear as a Run status.
It's a stage between creation and startup during which the Run is populated with workflows.

Enum: `"created"` `"prepared"` `"processing"` `"success"` `"failed"` `"canceled"` `"timeout"` `"skipped"` `"awaiting_approval"` `"rejected"` ||
|| [artifacts](#workflow-progress-current-cube-artifacts) | _Array of objects (Artifact)_ ||
|| [relations](#workflow-progress-current-cube-relations) | _object (Relations)_ ||
|#

##### workflow.progress.current_cube.dates {#workflow-progress-current-cube-dates}

#|
|| **Field** | **Description** ||
|| `created_at` | _string &lt;date-time&gt;_ ||
|| `started_at` | _string &lt;date-time&gt;_ ||
|| `finished_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

##### workflow.progress.current_cube.artifacts {#workflow-progress-current-cube-artifacts}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `local_path` | _string_
Artifacts do not have a slug as we define it.
Instead they are differentiated by context (workflow, task, cube) and `local_path`.
This is a local path for the artifact as defined in the CI configuration file. ||
|| [dates](#workflow-progress-current-cube-artifacts-dates) | _object (ArtifactDates)_ ||
|| `status` | _string (ArtifactStatus)_

Enum: `"registered"` `"success"` `"failed"` `"missing"` ||
|| `download_url` | _string_
A temporary download URL, will be valid for a short period of time after acquisition. ||
|#

###### workflow.progress.current_cube.artifacts.dates {#workflow-progress-current-cube-artifacts-dates}

#|
|| **Field** | **Description** ||
|| `registered_at` | _string &lt;date-time&gt;_ ||
|| `obtained_at` | _string &lt;date-time&gt;_ ||
|| `updated_at` | _string &lt;date-time&gt;_ ||
|#

##### workflow.progress.current_cube.relations {#workflow-progress-current-cube-relations}

#|
|| **Field** | **Description** ||
|| [needs](#workflow-progress-current-cube-relations-needs) | _Array of objects (Dependency)_ ||
|#

###### workflow.progress.current_cube.relations.needs {#workflow-progress-current-cube-relations-needs}

#|
|| **Field** | **Description** ||
|| `name` | _string_ ||
|#

## run {#run}

#|
|| **Field** | **Description** ||
|| `id` | _string (CI/CD entities don't have public IDs at this stage; they will be added later)_ ||
|| `slug` | _string (Run counter serves as a slug)_ ||
|#

{% cut "Request samples" %}

```json
{
  "$ref": "#/components/schemas/CIWorkflowComplete",
  "components": {
    "schemas": {
      "CIWorkflowComplete": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/EventHeader"
          },
          "repository": {
            "$ref": "#/components/schemas/Repository"
          },
          "workflow": {
            "$ref": "#/components/schemas/Workflow"
          },
          "run": {
            "$ref": "#/components/schemas/RunEmbedded"
          }
        },
        "title": "CI workflow completed - emitted when a single CI workflow completes (terminal status)"
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
      "Workflow": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "title": "CI/CD entities don't have public IDs at this stage; they will be added later"
          },
          "slug": {
            "type": "string",
            "title": "A name of the workflow as defined in the config"
          },
          "description": {
            "type": "string"
          },
          "dates": {
            "$ref": "#/components/schemas/DatesByStage"
          },
          "status": {
            "$ref": "#/components/schemas/Run.Status"
          },
          "tasks": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Task"
            }
          },
          "progress": {
            "$ref": "#/components/schemas/Progress"
          },
          "environment_id": {
            "type": "string"
          }
        }
      },
      "DatesByStage": {
        "type": "object",
        "properties": {
          "created_at": {
            "type": "string",
            "format": "date-time"
          },
          "started_at": {
            "type": "string",
            "format": "date-time"
          },
          "finished_at": {
            "type": "string",
            "format": "date-time"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "Run.Status": {
        "type": "string",
        "enum": [
          "created",
          "prepared",
          "processing",
          "success",
          "failed",
          "canceled",
          "timeout",
          "skipped",
          "awaiting_approval",
          "rejected"
        ],
        "description": " - prepared: Status `prepared` may only appear as a Run status.\nIt's a stage between creation and startup during which the Run is populated with workflows."
      },
      "Task": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "title": "CI/CD entities don't have public IDs at this stage; they will be added later"
          },
          "slug": {
            "type": "string",
            "title": "A name of the task as defined in the config"
          },
          "description": {
            "type": "string"
          },
          "dates": {
            "$ref": "#/components/schemas/DatesByStage"
          },
          "status": {
            "$ref": "#/components/schemas/Run.Status"
          },
          "cubes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Cube"
            }
          },
          "progress": {
            "$ref": "#/components/schemas/Progress"
          },
          "relations": {
            "$ref": "#/components/schemas/Relations"
          }
        }
      },
      "Cube": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "title": "CI/CD entities don't have public IDs at this stage; they will be added later"
          },
          "slug": {
            "type": "string",
            "title": "A name of the cube as defined in the config"
          },
          "dates": {
            "$ref": "#/components/schemas/DatesByStage"
          },
          "status": {
            "$ref": "#/components/schemas/Run.Status"
          },
          "artifacts": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Artifact"
            }
          },
          "relations": {
            "$ref": "#/components/schemas/Relations"
          }
        }
      },
      "Artifact": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "title": "CI/CD entities don't have public IDs at this stage; they will be added later"
          },
          "local_path": {
            "type": "string",
            "description": "Artifacts do not have a slug as we define it.\nInstead they are differentiated by context (workflow, task, cube) and `local_path`.\nThis is a local path for the artifact as defined in the CI configuration file."
          },
          "dates": {
            "$ref": "#/components/schemas/ArtifactDates"
          },
          "status": {
            "$ref": "#/components/schemas/ArtifactStatus"
          },
          "download_url": {
            "type": "string",
            "description": "A temporary download URL, will be valid for a short period of time after acquisition."
          }
        }
      },
      "ArtifactDates": {
        "type": "object",
        "properties": {
          "registered_at": {
            "type": "string",
            "format": "date-time"
          },
          "obtained_at": {
            "type": "string",
            "format": "date-time"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "ArtifactStatus": {
        "type": "string",
        "enum": [
          "registered",
          "success",
          "failed",
          "missing"
        ]
      },
      "Relations": {
        "type": "object",
        "properties": {
          "needs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Dependency"
            }
          }
        }
      },
      "Dependency": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          }
        }
      },
      "Progress": {
        "type": "object",
        "properties": {
          "percent": {
            "type": "number",
            "format": "float"
          },
          "current_cube": {
            "$ref": "#/components/schemas/Cube"
          }
        }
      },
      "RunEmbedded": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "title": "CI/CD entities don't have public IDs at this stage; they will be added later"
          },
          "slug": {
            "type": "string",
            "title": "Run counter serves as a slug"
          }
        }
      }
    }
  }
}
```

{% endcut %}
