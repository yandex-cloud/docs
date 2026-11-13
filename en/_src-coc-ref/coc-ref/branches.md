# Branch Protection configuration

Path in repository: `.sourcecraft/branches.yaml`.

{% note info %}

This template shows the available fields and forms. It is not a valid configuration as written. Choose the fields and forms you need and replace placeholders using the reference tables.

{% endnote %}

```yaml
branch_protection:
  bypass:
    usernames:
      - "<usernames>"
  policies:
    - target: "<default_branch, branch or tag>"
      message: "<error-message>"
      rules:
        - "<prevent_force_push, prevent_non_pr_changes, prevent_all_changes, prevent_deletion, prevent_creation, prevent_update or prevent_merge_commits>"
      matches:
        - "<matches>"
      allowed_pr_merges:
        - "<merge, squash or rebase>"
pull_request:
  branch_cleanup:
    matches:
      - "<matches>"
```

#|
|| **Field** | **Description** ||
|| [branch_protection](#branch-protection) | Defines rules branch protection policies.

**Type:** object.

Additional fields are prohibited. ||
|| [pull_request](#pull-request) | Pull request settings.

**Type:** object.

Additional fields are prohibited. ||
|#

**Type:** object.

Additional fields are prohibited.

## branch_protection {#branch-protection}

#|
|| **Field** | **Description** ||
|| [bypass](#branch-protection-bypass) | Usernames permanently exempt from all branch protection policies.

**Type:** object.

Additional fields are prohibited. ||
|| [policies](#branch-protection-policies) | **Type:** array of objects.

**Items:** Branch Protection Policy. **Required fields:** `target`. Additional fields are prohibited. **Required fields:** `rules` or `allowed_pr_merges`. Specify at least one. ||
|#

### bypass {#branch-protection-bypass}

#|
|| **Field** | **Description** ||
|| `usernames` | Users who can bypass all branch protection policies.

**Type:** array of strings. ||
|#

### policies {#branch-protection-policies}

#|
|| **Field** | **Description** ||
|| `target` | Type of target this policy is applied to.

**Type:** string.

**Allowed values:** `"default_branch"`, `"branch"`, `"tag"`.

When `allowed_pr_merges` is present, `target` accepts only `"branch"`, `"default_branch"`.

Required. ||
|| `message` | Custom message that will be displayed if policy is violated.

**Type:** string. ||
|| `rules` | Set of rules.

**Type:** array of strings.

**Items:** **Allowed values:** `"prevent_force_push"`, `"prevent_non_pr_changes"`, `"prevent_all_changes"`, `"prevent_deletion"`, `"prevent_creation"`, `"prevent_update"`, `"prevent_merge_commits"`. **Deprecated:** `"prevent_all_changes"`. Use `prevent_creation` + `prevent_update` instead. ||
|| `matches` | For tag and branch target, pattern matcher. See globstar patterns for the details.

**Type:** string or array of strings. ||
|| `allowed_pr_merges` | **Type:** array of strings.

**Minimum items:** `1`.

Items must be unique.

**Items:** **Allowed values:** `"merge"`, `"squash"`, `"rebase"`. ||
|#

## pull_request {#pull-request}

#|
|| **Field** | **Description** ||
|| [branch_cleanup](#pull-request-branch-cleanup) | Defines which branches are deleted automatically after PR merge.

**Type:** object.

Additional fields are prohibited. ||
|#

### branch_cleanup {#pull-request-branch-cleanup}

#|
|| **Field** | **Description** ||
|| `matches` | Branch name patterns to match for auto-deletion. Use '\*\*' to match slashes (e.g. 'feature/\*\*'), '\*' matches within a single path segment only. Supports negation with '!'.

**Type:** string or array of strings. ||
|#

## JSON schema {#json-schema}

{% cut "JSON Schema for SourceCraft Branch Protection configuration" %}

```json
{
  "$schema": "https://json-schema.org/draft-07/schema",
  "title": "Branch Protection configuration",
  "description": "JSON Schema for SourceCraft Branch Protection configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "branch_protection": {
      "title": "Branch Protection",
      "description": "Defines rules branch protection policies",
      "$ref": "#/$defs/branch_protection"
    },
    "pull_request": {
      "title": "Pull Request",
      "description": "Pull request settings",
      "$ref": "#/$defs/pull_request"
    }
  },
  "$defs": {
    "branch_protection": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "bypass": {
          "title": "Bypass",
          "description": "Usernames permanently exempt from all branch protection policies",
          "$ref": "#/$defs/branch_protection_bypass"
        },
        "policies": {
          "type": "array",
          "items": {
            "title": "Policy",
            "description": "Branch Protection Policy",
            "$ref": "#/$defs/branch_protection_policy"
          }
        }
      }
    },
    "branch_protection_bypass": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "usernames": {
          "title": "Usernames",
          "description": "Users who can bypass all branch protection policies",
          "type": "array",
          "items": {
            "type": "string"
          }
        }
      }
    },
    "pull_request": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "branch_cleanup": {
          "title": "Branch Cleanup",
          "description": "Defines which branches are deleted automatically after PR merge",
          "$ref": "#/$defs/branch_cleanup"
        }
      }
    },
    "branch_cleanup": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "matches": {
          "title": "Glob Patterns",
          "description": "Branch name patterns to match for auto-deletion. Use '**' to match slashes (e.g. 'feature/**'), '*' matches within a single path segment only. Supports negation with '!'",
          "oneOf": [
            {
              "title": "Pattern",
              "type": "string"
            },
            {
              "title": "Patterns",
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          ]
        }
      }
    },
    "branch_protection_policy": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "target": {
          "title": "Policy Target",
          "description": "Type of target this policy is applied to",
          "type": "string",
          "enum": [
            "default_branch",
            "branch",
            "tag"
          ]
        },
        "message": {
          "title": "Error message",
          "description": "Custom message that will be displayed if policy is violated",
          "type": "string"
        },
        "rules": {
          "title": "Rules",
          "description": "Set of rules",
          "type": "array",
          "items": {
            "type": "string",
            "enum": [
              "prevent_force_push",
              "prevent_non_pr_changes",
              "prevent_all_changes",
              "prevent_deletion",
              "prevent_creation",
              "prevent_update",
              "prevent_merge_commits"
            ]
          }
        },
        "matches": {
          "title": "Glob Patterns",
          "description": "For tag and branch target, pattern matcher. See globstar patterns for the details",
          "oneOf": [
            {
              "title": "Pattern",
              "type": "string"
            },
            {
              "title": "Patterns",
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          ]
        },
        "allowed_pr_merges": {
          "type": "array",
          "minItems": 1,
          "uniqueItems": true,
          "items": {
            "type": "string",
            "enum": [
              "merge",
              "squash",
              "rebase"
            ]
          }
        }
      },
      "required": [
        "target"
      ],
      "anyOf": [
        {
          "required": [
            "rules"
          ]
        },
        {
          "required": [
            "allowed_pr_merges"
          ]
        }
      ],
      "allOf": [
        {
          "if": {
            "required": [
              "allowed_pr_merges"
            ]
          },
          "then": {
            "properties": {
              "target": {
                "enum": [
                  "branch",
                  "default_branch"
                ]
              }
            }
          }
        }
      ]
    }
  }
}
```

{% endcut %}
