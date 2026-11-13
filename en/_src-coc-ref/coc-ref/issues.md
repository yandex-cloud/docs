# Issues configuration

Path in repository: `.sourcecraft/issues.yaml`.

The template shows the structure and available fields. Replace placeholders and use the reference tables to select the fields and forms for your configuration.

```yaml
issues:
  custom_fields:
    - slug: "<slug>"
      type: "<type>"
      title: "<title>"
      description: "<description>"
      default: "<default>"
      visibility: public
  custom_types:
    - slug: "<slug>"
      title: "<title>"
      description: "<description>"
      kind: enum
      values:
        - slug: "<slug>"
          title: "<title>"
          description: "<description>"
          color: "<color>"
          icon: "<icon>"
  views:
    - slug: "<slug>"
      fields:
        - "<fields>"
```

#|
|| **Field** | **Description** ||
|| [issues](#issues) | Issue-tracker configuration: custom fields, types, and views.

**Type:** object.

Additional fields are prohibited.

Required. ||
|#

**Type:** object.

**Required fields:** `issues`.

Additional fields are prohibited.

## issues {#issues}

#|
|| **Field** | **Description** ||
|| [custom_fields](#issues-custom-fields) | List of user-defined fields that appear on issues.

**Type:** array of objects.

**Items:** **Required fields:** `slug`, `type`. Additional fields are prohibited. ||
|| [custom_types](#issues-custom-types) | Custom data types (e.g. enums) that can be referenced by custom fields.

**Type:** array of objects.

**Items:** **Required fields:** `slug`, `kind`. Additional fields are prohibited. ||
|| [views](#issues-views) | Configures which fields are shown in specific UI contexts.

**Type:** array of objects.

**Items:** **Required fields:** `slug`, `fields`. Additional fields are prohibited. ||
|#

### custom_fields {#issues-custom-fields}

#|
|| **Field** | **Description** ||
|| `slug` | Unique snake_case identifier for this user-defined field. Becomes the key in custom_field_values. System field slugs are reserved and cannot be used.

**Type:** string.

**Pattern:** `^[a-z][a-z0-9_]*$`.

**Prohibited values:** `"and"`, `"false"`, `"in"`, `"or"`, `"true"`, `"title"`, `"description"`, `"visibility"`, `"priority"`, `"status"`, `"status_id"`, `"assignee"`, `"assignee_id"`, `"author"`, `"author_id"`, `"updated_by"`, `"updated_by_id"`, `"votes"`, `"created_at"`, `"started_at"`, `"updated_at"`, `"completed_at"`, `"deadline"`, `"milestone"`, `"milestone_id"`, `"labels"`, `"label_id"`, `"label_ids"`, `"linked_prs"`, `"linked_issues"`.

Required. ||
|| `type` | Built-in scalar type ("string", "number", "date", "datetime"), built-in reference type ("user"), or a custom type name defined in custom_types. "datetime" is a synonym for "date".

**Type:** string.

**Pattern:** `^[a-z][a-z0-9_]*$`.

Required. ||
|| `title` | Human-readable label shown in the UI.

**Type:** string. ||
|| `description` | Human-readable explanation shown as a UI hint.

**Type:** string. ||
|| `default` | Default value for this field. Omit or set to null for no default.

**Type:** string or integer or number or boolean or null. ||
|| `visibility` | Who can see this field. Defaults to "public" when omitted. Supported values are "public" and "private".

**Type:** string.

**Allowed values:** `"public"`, `"private"`. ||
|#

### custom_types {#issues-custom-types}

#|
|| **Field** | **Description** ||
|| `slug` | Unique identifier for this type.

**Type:** string.

**Pattern:** `^[a-z][a-z0-9_]*$`.

Required. ||
|| `title` | Human-readable label for the type.

**Type:** string. ||
|| `description` | Human-readable explanation for the type.

**Type:** string. ||
|| `kind` | Kind of type. Currently only "enum" is supported.

**Type:** string.

**Allowed values:** `"enum"`.

Required. ||
|| [values](#issues-custom-types-values) | Allowed enum values. Only used when kind is "enum".

**Type:** array of objects.

**Items:** **Required fields:** `slug`. Additional fields are prohibited. ||
|#

#### values {#issues-custom-types-values}

#|
|| **Field** | **Description** ||
|| `slug` | Stored value used as the key in custom_field_values.

**Type:** string.

**Pattern:** `^[a-z][a-z0-9_]*$`.

Required. ||
|| `title` | Human-readable label shown in the UI.

**Type:** string. ||
|| `description` | Human-readable explanation shown as a UI hint.

**Type:** string. ||
|| `color` | Optional color hint for the UI (e.g. "red" or "#ff0000").

**Type:** string. ||
|| `icon` | Optional icon hint for the UI (e.g. an emoji).

**Type:** string. ||
|#

### views {#issues-views}

#|
|| **Field** | **Description** ||
|| `slug` | UI context identifier. Known values: "new", "edit", "table", "preview", "list_details", "card", "parameters".

**Type:** string.

**Pattern:** `^[a-z][a-z0-9_]*$`.

Required. ||
|| `fields` | Ordered list of field slugs (system or custom) to display in this view.

**Type:** array of strings.

**Items:** **Pattern:** `^[a-z][a-z0-9_]*$`.

Required. ||
|#

## JSON schema {#json-schema}

{% cut "JSON Schema for SourceCraft issue-tracker custom fields configuration (.sourcecraft/issues.yaml)" %}

```json
{
    "$schema": "https://json-schema.org/draft-07/schema",
    "title": "Issues configuration",
    "description": "JSON Schema for SourceCraft issue-tracker custom fields configuration (.sourcecraft/issues.yaml)",
    "type": "object",
    "additionalProperties": false,
    "properties": {
        "issues": {
            "title": "Issues",
            "description": "Issue-tracker configuration: custom fields, types, and views",
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "custom_fields": {
                    "title": "Custom Fields",
                    "description": "List of user-defined fields that appear on issues",
                    "type": "array",
                    "items": {
                        "$ref": "#/$defs/customField"
                    }
                },
                "custom_types": {
                    "title": "Custom Types",
                    "description": "Custom data types (e.g. enums) that can be referenced by custom fields",
                    "type": "array",
                    "items": {
                        "$ref": "#/$defs/customType"
                    }
                },
                "views": {
                    "title": "Views",
                    "description": "Configures which fields are shown in specific UI contexts",
                    "type": "array",
                    "items": {
                        "$ref": "#/$defs/view"
                    }
                }
            }
        }
    },
    "required": ["issues"],
    "$defs": {
        "customField": {
            "title": "Custom Field",
            "type": "object",
            "additionalProperties": false,
            "required": ["slug", "type"],
            "properties": {
                "slug": {
                    "title": "Slug",
                    "description": "Unique snake_case identifier for this user-defined field. Becomes the key in custom_field_values. System field slugs are reserved and cannot be used.",
                    "type": "string",
                    "pattern": "^[a-z][a-z0-9_]*$",
                    "not": {
                        "enum": [
                            "and",
                            "false",
                            "in",
                            "or",
                            "true",
                            "title",
                            "description",
                            "visibility",
                            "priority",
                            "status",
                            "status_id",
                            "assignee",
                            "assignee_id",
                            "author",
                            "author_id",
                            "updated_by",
                            "updated_by_id",
                            "votes",
                            "created_at",
                            "started_at",
                            "updated_at",
                            "completed_at",
                            "deadline",
                            "milestone",
                            "milestone_id",
                            "labels",
                            "label_id",
                            "label_ids",
                            "linked_prs",
                            "linked_issues"
                        ]
                    }
                },
                "type": {
                    "title": "Type",
                    "description": "Built-in scalar type (\"string\", \"number\", \"date\", \"datetime\"), built-in reference type (\"user\"), or a custom type name defined in custom_types. \"datetime\" is a synonym for \"date\".",
                    "type": "string",
                    "pattern": "^[a-z][a-z0-9_]*$"
                },
                "title": {
                    "title": "Title",
                    "description": "Human-readable label shown in the UI",
                    "type": "string"
                },
                "description": {
                    "title": "Description",
                    "description": "Human-readable explanation shown as a UI hint",
                    "type": "string"
                },
                "default": {
                    "title": "Default",
                    "description": "Default value for this field. Omit or set to null for no default.",
                    "type": ["string", "integer", "number", "boolean", "null"]
                },
                "visibility": {
                    "title": "Visibility",
                    "description": "Who can see this field. Defaults to \"public\" when omitted. Supported values are \"public\" and \"private\".",
                    "type": "string",
                    "enum": ["public", "private"]
                }
            }
        },
        "customType": {
            "title": "Custom Type",
            "type": "object",
            "additionalProperties": false,
            "required": ["slug", "kind"],
            "properties": {
                "slug": {
                    "title": "Slug",
                    "description": "Unique identifier for this type",
                    "type": "string",
                    "pattern": "^[a-z][a-z0-9_]*$"
                },
                "title": {
                    "title": "Title",
                    "description": "Human-readable label for the type",
                    "type": "string"
                },
                "description": {
                    "title": "Description",
                    "description": "Human-readable explanation for the type",
                    "type": "string"
                },
                "kind": {
                    "title": "Kind",
                    "description": "Kind of type. Currently only \"enum\" is supported.",
                    "type": "string",
                    "enum": ["enum"]
                },
                "values": {
                    "title": "Values",
                    "description": "Allowed enum values. Only used when kind is \"enum\".",
                    "type": "array",
                    "items": {
                        "$ref": "#/$defs/enumValue"
                    }
                }
            }
        },
        "enumValue": {
            "title": "Enum Value",
            "type": "object",
            "additionalProperties": false,
            "required": ["slug"],
            "properties": {
                "slug": {
                    "title": "Slug",
                    "description": "Stored value used as the key in custom_field_values",
                    "type": "string",
                    "pattern": "^[a-z][a-z0-9_]*$"
                },
                "title": {
                    "title": "Title",
                    "description": "Human-readable label shown in the UI",
                    "type": "string"
                },
                "description": {
                    "title": "Description",
                    "description": "Human-readable explanation shown as a UI hint",
                    "type": "string"
                },
                "color": {
                    "title": "Color",
                    "description": "Optional color hint for the UI (e.g. \"red\" or \"#ff0000\")",
                    "type": "string"
                },
                "icon": {
                    "title": "Icon",
                    "description": "Optional icon hint for the UI (e.g. an emoji)",
                    "type": "string"
                }
            }
        },
        "view": {
            "title": "View",
            "type": "object",
            "additionalProperties": false,
            "required": ["slug", "fields"],
            "properties": {
                "slug": {
                    "title": "Slug",
                    "description": "UI context identifier. Known values: \"new\", \"edit\", \"table\", \"preview\", \"list_details\", \"card\", \"parameters\"",
                    "type": "string",
                    "pattern": "^[a-z][a-z0-9_]*$"
                },
                "fields": {
                    "title": "Fields",
                    "description": "Ordered list of field slugs (system or custom) to display in this view",
                    "type": "array",
                    "items": {
                        "type": "string",
                        "pattern": "^[a-z][a-z0-9_]*$"
                    }
                }
            }
        }
    }
}
```

{% endcut %}
