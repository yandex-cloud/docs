# SourceCraft Sites configuration

Path in repository: `.sourcecraft/sites.yaml`.

{% note info %}

This template shows the available fields and forms. It is not a valid configuration as written. Choose the fields and forms you need and replace placeholders using the reference tables.

{% endnote %}

```yaml
site:
  root: "<root>"
  ref: "<reference>"
```

#|
|| **Field** | **Description** ||
|| [site](#site) | Sites configuration.

**Type:** object.

Additional fields are prohibited. ||
|#

**Type:** object.

Additional fields are prohibited.

## site {#site}

#|
|| **Field** | **Description** ||
|| `root` | Root of the 'site' (path relative to the repository root). If empty, the repository root is used.

**Type:** string. ||
|| `ref` | Branch, commit SHA, or tag if prefixed with 'tag:'. If empty, the default branch is used.

**Type:** string. ||
|#

## JSON schema {#json-schema}

{% cut "JSON Schema for SourceCraft Sites configuration" %}

```json
{
  "$schema": "https://json-schema.org/draft-07/schema",
  "title": "SourceCraft Sites configuration",
  "description": "JSON Schema for SourceCraft Sites configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "site": {
      "title": "Sites",
      "description": "Sites configuration",
      "$ref": "#/$defs/site"
    }
  },
  "$defs": {
    "site": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "root": {
          "title": "Root",
          "description": "Root of the 'site' (path relative to the repository root). If empty, the repository root is used.",
          "type": "string"
        },
        "ref": {
          "title": "Reference",
          "description": "Branch, commit SHA, or tag if prefixed with 'tag:'. If empty, the default branch is used.",
          "type": "string"
        }
      }
    }
  }
}
```

{% endcut %}
