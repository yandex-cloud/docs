# Webhooks configuration

Path in repository: `.sourcecraft/webhooks.yaml`.

{% note info %}

This template shows the available fields and forms. It is not a valid configuration as written. Choose the fields and forms you need and replace placeholders using the reference tables.

{% endnote %}

```yaml
webhooks:
  hooks:
    - slug: "<slug>"
      name: "<name>"
      description: "<description>"
      url: "<url>"
      auth_header: "<auth-header>"
      ssl_verification: true
      active: true
  on:
    all:
      - hooks:
          - "<hook-slug>"
    "*":
      - hooks:
          - "<hook-slug>"
    push:
      - hooks:
          - "<hook-slug>"
    issue:
      - hooks:
          - "<hook-slug>"
    repository.create:
      - hooks:
          - "<hook-slug>"
    repository.push:
      - hooks:
          - "<hook-slug>"
    repository.refs_update:
      - hooks:
          - "<hook-slug>"
    run:
      - hooks:
          - "<hook-slug>"
    run.complete:
      - hooks:
          - "<hook-slug>"
    issue.create:
      - hooks:
          - "<hook-slug>"
    issue.update:
      - hooks:
          - "<hook-slug>"
    issue.delete:
      - hooks:
          - "<hook-slug>"
    issue_comment.create:
      - hooks:
          - "<hook-slug>"
    issue_comment.update:
      - hooks:
          - "<hook-slug>"
    issue_comment.delete:
      - hooks:
          - "<hook-slug>"
    issue_comment.reactions_update:
      - hooks:
          - "<hook-slug>"
    issue_comment:
      - hooks:
          - "<hook-slug>"
    pull_request:
      - hooks:
          - "<hook-slug>"
    pull_request.create:
      - hooks:
          - "<hook-slug>"
    pull_request.publish:
      - hooks:
          - "<hook-slug>"
    pull_request.refresh:
      - hooks:
          - "<hook-slug>"
    pull_request.update:
      - hooks:
          - "<hook-slug>"
    pull_request.new_iteration:
      - hooks:
          - "<hook-slug>"
    pull_request.review_assignment:
      - hooks:
          - "<hook-slug>"
    pull_request.review_decision:
      - hooks:
          - "<hook-slug>"
    pull_request.merge:
      - hooks:
          - "<hook-slug>"
    pull_request.merge_failure:
      - hooks:
          - "<hook-slug>"
    pull_request_comment.create:
      - hooks:
          - "<hook-slug>"
    pull_request_comment.create_bulk:
      - hooks:
          - "<hook-slug>"
    pull_request_comment.publish:
      - hooks:
          - "<hook-slug>"
    pull_request_comment.reactions_update:
      - hooks:
          - "<hook-slug>"
    pull_request_comment:
      - hooks:
          - "<hook-slug>"
    repository:
      - hooks:
          - "<hook-slug>"
    webhook:
      - hooks:
          - "<hook-slug>"
    webhook.ping:
      - hooks:
          - "<hook-slug>"
    workflow:
      - hooks:
          - "<hook-slug>"
    workflow.complete:
      - hooks:
          - "<hook-slug>"
```

#|
|| **Field** | **Description** ||
|| [webhooks](#webhooks) | Webhooks configuration.

**Type:** object.

Additional fields are prohibited. ||
|#

**Type:** object.

Additional fields are prohibited.

## webhooks {#webhooks}

#|
|| **Field** | **Description** ||
|| [hooks](#webhooks-hooks) | Webhook.

**Type:** array of objects.

**Items:** Hooks rules. **Required fields:** `slug`, `url`. Additional fields are prohibited. ||
|| [on](#webhooks-on) | Events on which the webhook will be triggered.

**Type:** object.

Additional fields are prohibited. ||
|#

### hooks {#webhooks-hooks}

#|
|| **Field** | **Description** ||
|| `slug` | Slug of the webhook, required and unique per repository.

**Type:** string.

Required. ||
|| `name` | Name of the webhook.

**Type:** string. ||
|| `description` | Description of the webhook.

**Type:** string. ||
|| `url` | The URL of the webhook endpoint.

**Type:** string.

Required. ||
|| `auth_header` | Auth header name, which will contain auto generated sign key to check webhook delivery.

**Type:** string. ||
|| `ssl_verification` | SSL verification of the webhook.

**Type:** boolean. ||
|| `active` | Whether the webhook is active or not.

**Type:** boolean. ||
|#

### on {#webhooks-on}

#|
|| **Field** | **Description** ||
|| [all](#webhooks-on-event-hooks) | All events.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [\*](#webhooks-on-event-hooks) | All events.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [push](#webhooks-on-event-hooks) | Push event on which the webhook will be triggered.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue](#webhooks-on-event-hooks) | All public events in the `issue` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [repository.create](#webhooks-on-event-hooks) | RepositoryCreated event.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [repository.push](#webhooks-on-event-hooks) | Repository push event on which the webhook will be triggered.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [repository.refs_update](#webhooks-on-event-hooks) | Creating, modifying, or deleting branches and tags in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [run](#webhooks-on-event-hooks) | All public events in the `run` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [run.complete](#webhooks-on-event-hooks) | CI run completed - emitted when a CI run completes (terminal status).

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue.create](#webhooks-on-event-hooks) | Creation of a new issue in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue.update](#webhooks-on-event-hooks) | Update of an issue in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue.delete](#webhooks-on-event-hooks) | Deletion of an issue in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue_comment.create](#webhooks-on-event-hooks) | Creation of an issue comment in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue_comment.update](#webhooks-on-event-hooks) | Update of an issue comment in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue_comment.delete](#webhooks-on-event-hooks) | Deletion of an issue comment in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue_comment.reactions_update](#webhooks-on-event-hooks) | Reaction update for an issue comment in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [issue_comment](#webhooks-on-event-hooks) | All public events in the `issue_comment` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request](#webhooks-on-event-hooks) | All public events in the `pull_request` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.create](#webhooks-on-event-hooks) | Creation of a new pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.publish](#webhooks-on-event-hooks) | Publish of a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.refresh](#webhooks-on-event-hooks) | Refresh of a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.update](#webhooks-on-event-hooks) | Update of a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.new_iteration](#webhooks-on-event-hooks) | New iteration added for a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.review_assignment](#webhooks-on-event-hooks) | Assignment of a reviewer to a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.review_decision](#webhooks-on-event-hooks) | Review decision for a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.merge](#webhooks-on-event-hooks) | Pull request merge in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request.merge_failure](#webhooks-on-event-hooks) | Failure during pull request merge in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request_comment.create](#webhooks-on-event-hooks) | New comment created for a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request_comment.create_bulk](#webhooks-on-event-hooks) | New comments created for a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request_comment.publish](#webhooks-on-event-hooks) | New comment published for a pull request in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request_comment.reactions_update](#webhooks-on-event-hooks) | Reactions update for a pull request comment in a repository.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [pull_request_comment](#webhooks-on-event-hooks) | All public events in the `pull_request_comment` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [repository](#webhooks-on-event-hooks) | All public events in the `repository` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [webhook](#webhooks-on-event-hooks) | All public events in the `webhook` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [webhook.ping](#webhooks-on-event-hooks) | Ping event - sent when a webhook is tested.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [workflow](#webhooks-on-event-hooks) | All public events in the `workflow` group.

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|| [workflow.complete](#webhooks-on-event-hooks) | CI workflow completed - emitted when a single CI workflow completes (terminal status).

**Type:** array of objects.

**Items:** **Required fields:** `hooks`. Additional fields are prohibited. ||
|#

#### Event hooks {#webhooks-on-event-hooks}

#|
|| **Field** | **Description** ||
|| `hooks` | List of webhook slugs defined in `webhooks.hooks`.

**Type:** array of strings.

**Minimum items:** `1`.

Required. ||
|#

## JSON schema {#json-schema}

{% cut "JSON Schema for SourceCraft Webhooks configuration" %}

```json
{
    "$schema": "https://json-schema.org/draft-07/schema",
    "title": "Webhooks configuration",
    "description": "JSON Schema for SourceCraft Webhooks configuration",
    "type": "object",
    "additionalProperties": false,
    "properties": {
        "webhooks": {
            "title": "Webhooks",
            "description": "Webhooks configuration",
            "$ref": "#/$defs/webhooks"
        }
    },
    "$defs": {
        "webhooks": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "hooks": {
                    "title": "Hooks",
                    "description": "Webhook",
                    "type": "array",
                    "items": {
                        "title": "items",
                        "type": "object",
                        "description": "Hooks rules",
                        "additionalProperties": false,
                        "properties": {
                            "slug": {
                                "title": "Slug",
                                "description": "Slug of the webhook, required and unique per repository.",
                                "type": "string"
                            },
                            "name": {
                                "title": "Name",
                                "description": "Name of the webhook.",
                                "type": "string"
                            },
                            "description": {
                                "title": "Description",
                                "description": "Description of the webhook.",
                                "type": "string"
                            },
                            "url": {
                                "title": "URL",
                                "description": "The URL of the webhook endpoint.",
                                "type": "string"
                            },
                            "auth_header": {
                                "title": "Auth Header",
                                "description": "Auth header name, which will contain auto generated sign key to check webhook delivery.",
                                "type": "string"
                            },
                            "ssl_verification": {
                                "title": "SSL Verification",
                                "description": "SSL verification of the webhook.",
                                "type": "boolean"
                            },
                            "active": {
                                "title": "Active",
                                "description": "Whether the webhook is active or not.",
                                "type": "boolean"
                            }
                        },
                        "required": ["slug", "url"]
                    }
                },
                "on": {
                    "title": "On",
                    "description": "Events on which the webhook will be triggered.",
                    "type": "object",
                    "additionalProperties": false,
                    "properties": {
                        "all": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "*": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "push": {
                            "$ref": "#/$defs/eventPush"
                        },
                        "issue": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "repository.create": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "repository.push": {
                            "$ref": "#/$defs/eventRepositoryPush"
                        },
                        "repository.refs_update": {
                            "$ref": "#/$defs/eventRepositoryRefsUpdate"
                        },
                        "run": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "run.complete": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "issue.create": {
                            "$ref": "#/$defs/eventIssueCreate"
                        },
                        "issue.update": {
                            "$ref": "#/$defs/eventIssueUpdate"
                        },
                        "issue.delete": {
                            "$ref": "#/$defs/eventIssueDelete"
                        },
                        "issue_comment.create": {
                            "$ref": "#/$defs/eventIssueCommentCreate"
                        },
                        "issue_comment.update": {
                            "$ref": "#/$defs/eventIssueCommentUpdate"
                        },
                        "issue_comment.delete": {
                            "$ref": "#/$defs/eventIssueCommentDelete"
                        },
                        "issue_comment.reactions_update": {
                            "$ref": "#/$defs/eventIssueCommentReactionsUpdate"
                        },
                        "issue_comment": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "pull_request": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "pull_request.create": {
                            "$ref": "#/$defs/eventPullRequestCreate"
                        },
                        "pull_request.publish": {
                            "$ref": "#/$defs/eventPullRequestPublish"
                        },
                        "pull_request.refresh": {
                            "$ref": "#/$defs/eventPullRequestRefresh"
                        },
                        "pull_request.update": {
                            "$ref": "#/$defs/eventPullRequestUpdate"
                        },
                        "pull_request.new_iteration": {
                            "$ref": "#/$defs/eventPullRequestNewIteration"
                        },
                        "pull_request.review_assignment": {
                            "$ref": "#/$defs/eventPullRequestReviewAssignment"
                        },
                        "pull_request.review_decision": {
                            "$ref": "#/$defs/eventPullRequestReviewDecision"
                        },
                        "pull_request.merge": {
                            "$ref": "#/$defs/eventPullRequestMerge"
                        },
                        "pull_request.merge_failure": {
                            "$ref": "#/$defs/eventPullRequestMergeFailure"
                        },
                        "pull_request_comment.create": {
                            "$ref": "#/$defs/eventPullRequestCommentCreate"
                        },
                        "pull_request_comment.create_bulk": {
                            "$ref": "#/$defs/eventPullRequestCommentCreateBulk"
                        },
                        "pull_request_comment.publish": {
                            "$ref": "#/$defs/eventPullRequestCommentPublish"
                        },
                        "pull_request_comment.reactions_update": {
                            "$ref": "#/$defs/eventPullRequestCommentReactionsUpdate"
                        },
                        "pull_request_comment": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "repository": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "webhook": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "webhook.ping": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "workflow": {
                            "$ref": "#/$defs/allEvents"
                        },
                        "workflow.complete": {
                            "$ref": "#/$defs/allEvents"
                        }
                    }
                }
            }
        },
        "eventHooks": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "hooks": {
                    "title": "Hooks",
                    "description": "Hooks to trigger.",
                    "type": "array",
                    "items": {
                        "title": "Hook slug",
                        "type": "string"
                    }
                }
            }
        },
        "eventPush": {
            "additionalProperties": false,
            "title": "Push",
            "description": "Push event on which the webhook will be triggered.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventRepositoryPush": {
            "additionalProperties": false,
            "title": "Repository Push",
            "description": "Repository push event on which the webhook will be triggered.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventRepositoryRefsUpdate": {
            "additionalProperties": false,
            "title": "Repository Refs Update",
            "description": "Creating, modifying, or deleting branches and tags in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventIssueCreate": {
            "additionalProperties": false,
            "title": "Issue create",
            "description": "Creation of a new issue in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventIssueUpdate": {
            "additionalProperties": false,
            "title": "Issue update",
            "description": "Update of an issue in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventIssueDelete": {
            "additionalProperties": false,
            "title": "Issue delete",
            "description": "Deletion of an issue in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventIssueCommentCreate": {
            "additionalProperties": false,
            "title": "Issue comment create",
            "description": "Creation of an issue comment in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventIssueCommentUpdate": {
            "additionalProperties": false,
            "title": "Issue comment update",
            "description": "Update of an issue comment in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventIssueCommentDelete": {
            "additionalProperties": false,
            "title": "Issue comment delete",
            "description": "Deletion of an issue comment in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventIssueCommentReactionsUpdate": {
            "additionalProperties": false,
            "title": "Issue comment reactions update",
            "description": "Reaction update for an issue comment in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "allEvents": {
            "additionalProperties": false,
            "title": "All events",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestCreate": {
            "additionalProperties": false,
            "title": "Pull request create",
            "description": "Creation of a new pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestPublish": {
            "additionalProperties": false,
            "title": "Pull request publish",
            "description": "Publish of a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestRefresh": {
            "additionalProperties": false,
            "title": "Pull request refresh",
            "description": "Refresh of a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestUpdate": {
            "additionalProperties": false,
            "title": "Pull request update",
            "description": "Update of a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestNewIteration": {
            "additionalProperties": false,
            "title": "Pull request new iteration",
            "description": "New iteration added for a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestReviewAssignment": {
            "additionalProperties": false,
            "title": "Pull request review assignment",
            "description": "Assignment of a reviewer to a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestReviewDecision": {
            "additionalProperties": false,
            "title": "Pull request review decision",
            "description": "Review decision for a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestMerge": {
            "additionalProperties": false,
            "title": "Pull request merge",
            "description": "Pull request merge in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestMergeFailure": {
            "additionalProperties": false,
            "title": "Pull request merge failure",
            "description": "Failure during pull request merge in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestCommentCreate": {
            "additionalProperties": false,
            "title": "Pull request comment create",
            "description": "New comment created for a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestCommentCreateBulk": {
            "additionalProperties": false,
            "title": "Pull request comment create bulk",
            "description": "New comments created for a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestCommentPublish": {
            "additionalProperties": false,
            "title": "Pull request comment publish",
            "description": "New comment published for a pull request in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        },
        "eventPullRequestCommentReactionsUpdate": {
            "additionalProperties": false,
            "title": "Pull request comment reactions update",
            "description": "Reactions update for a pull request comment in a repository.",
            "type": "array",
            "items": {
                "title": "List of triggered hooks",
                "type": "object",
                "$ref": "#/$defs/eventHooks"
            }
        }
    }
}
```

{% endcut %}
