# Code Review configuration

Path in repository: `.sourcecraft/review.yaml`.

{% note info %}

This template shows the available fields and forms. It is not a valid configuration as written. Choose the fields and forms you need and replace placeholders using the reference tables.

{% endnote %}

```yaml
codereview:
  need_ships: 1
  ignore_self_ship: true
  ignore_non_reviewers_block: true
  auto_assign: true
  disable_trust: true
  disallow_force_merge: true
  rules:
    - patterns:
        - "<pattern>"
      reviewers:
        usernames:
          - "<username>"
        assign: 1
        need_ships: 1
        ignore_self_ship: true
```

#|
|| **Field** | **Description** ||
|| [codereview](#codereview) | Code review configuration.

**Type:** object.

Additional fields are prohibited. ||
|#

**Type:** object.

Additional fields are prohibited.

## codereview {#codereview}

#|
|| **Field** | **Description** ||
|| `need_ships` | Number of approvements expected.

**Type:** integer. ||
|| `ignore_self_ship` | Do not count self approvement.

**Type:** boolean. ||
|| `ignore_non_reviewers_block` | Do not consider block from non-reviewer.

**Type:** boolean. ||
|| `auto_assign` | Assign reviewers automatically.

**Type:** boolean. ||
|| `disable_trust` | Prevent reviewers from setting trust (sticky) approvement.

**Type:** boolean. ||
|| `disallow_force_merge` | Prevent force merging pull requests even for maintainers.

**Type:** boolean. ||
|| [rules](#codereview-rules) | Code review rules.

**Type:** array of objects.

**Items:** Code review rule. Additional fields are prohibited. ||
|#

### rules {#codereview-rules}

#|
|| **Field** | **Description** ||
|| `patterns` | Paths patterns.

**Type:** array of strings.

**Items:** Path pattern. ||
|| [reviewers](#codereview-rules-reviewers) | Reviewers configuration.

**Type:** object.

Additional fields are prohibited. ||
|#

#### reviewers {#codereview-rules-reviewers}

#|
|| **Field** | **Description** ||
|| `usernames` | Reviewers who can approve.

**Type:** array of strings. ||
|| `assign` | Number of reviewers to be assigned.

**Type:** integer. ||
|| `need_ships` | Number of approvements expected.

**Type:** integer. ||
|| `ignore_self_ship` | Do not count self approvement.

**Type:** boolean. ||
|#

## JSON schema {#json-schema}

{% cut "JSON Schema for SourceCraft Code Review configuration" %}

```json
{
  "$schema": "https://json-schema.org/draft-07/schema",
  "title": "Code Review configuration",
  "description": "JSON Schema for SourceCraft Code Review configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "codereview": {
      "title": "Code review",
      "description": "Code review configuration",
      "$ref": "#/$defs/codereview"
    }
  },
  "$defs": {
    "codereview": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "need_ships": {
          "title": "Approvements",
          "description": "Number of approvements expected",
          "type": "integer"
        },
        "ignore_self_ship": {
          "title": "Ignore self approvement",
          "description": "Do not count self approvement",
          "type": "boolean"
        },
        "ignore_non_reviewers_block": {
          "title": "Ignore non-reviewers block",
          "description": "Do not consider block from non-reviewer",
          "type": "boolean"
        },
        "auto_assign": {
          "title": "Auto assign",
          "description": "Assign reviewers automatically",
          "type": "boolean"
        },
        "disable_trust": {
          "title": "Disable trust approvement",
          "description": "Prevent reviewers from setting trust (sticky) approvement",
          "type": "boolean"
        },
        "disallow_force_merge": {
          "title": "Disallow force merge",
          "description": "Prevent force merging pull requests even for maintainers",
          "type": "boolean"
        },
        "rules": {
          "title": "Rules",
          "description": "Code review rules",
          "type": "array",
          "items": {
            "title": "Rule",
            "description": "Code review rule",
            "$ref": "#/$defs/codereviewrule"
          }
        }
      }
    },
    "codereviewrule": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "patterns": {
          "title": "Patterns",
          "description": "Paths patterns",
          "type": "array",
          "items": {
            "title": "Pattern",
            "description": "Path pattern",
            "type": "string"
          }
        },
        "reviewers": {
          "title": "Reviewers",
          "description": "Reviewers configuration",
          "$ref": "#/$defs/codereviewreviewers"
        }
      }
    },
    "codereviewreviewers": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "usernames": {
          "title": "Usernames",
          "description": "Reviewers who can approve",
          "type": "array",
          "items": {
            "title": "Username",
            "type": "string"
          }
        },
        "assign": {
          "title": "Assign",
          "description": "Number of reviewers to be assigned",
          "type": "integer"
        },
        "need_ships": {
          "title": "Approvements",
          "description": "Number of approvements expected",
          "type": "integer"
        },
        "ignore_self_ship": {
          "title": "Ignore self approvement",
          "description": "Do not count self approvement",
          "type": "boolean"
        }
      }
    }
  }
}
```

{% endcut %}
