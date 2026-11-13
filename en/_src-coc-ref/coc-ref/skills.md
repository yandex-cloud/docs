# Skills configuration

Path in repository: `.sourcecraft/ai.yaml`.

{% note info %}

This template shows the available fields and forms. It is not a valid configuration as written. Choose the fields and forms you need and replace placeholders using the reference tables.

{% endnote %}

```yaml
skills:
  - source:
      name: "<name>"
    settings:
      instructions: "<general-instructions>"
      inputs:
        "<key>": "<key>"
  - source:
      path: "<path>"
    settings:
      instructions: "<general-instructions>"
      inputs:
        "<key>": "<key>"
  - source:
      path: "<path>"
      repo: "<repository>"
      ref: "<reference>"
    settings:
      instructions: "<general-instructions>"
      inputs:
        "<key>": "<key>"
```

#|
|| **Field** | **Description** ||
|| [skills](#skills) | List of skill references to import.

**Type:** array or null.

**Items:** **Type:** object. **Required fields:** `source`. Additional fields are prohibited. ||
|#

**Type:** object.

Additional fields are prohibited.

## skills {#skills}

#|
|| **Field** | **Description** ||
|| [source](#skills-source) | Specify `name` for an existing skill, `path` for a local skill, or `repo` and `path` for a skill in another repository. Use `ref` only with an external repository.

**Type:** object.

Additional fields are prohibited.

Required. ||
|| [settings](#skills-settings) | Configuration for the imported skill.

**Type:** object.

Additional fields are prohibited. ||
|#

### source {#skills-source}

#|
|| **Field** | **Description** ||
|| `path` | Path to the skill directory in the current or external repository.

**Type:** string. ||
|| `name` | Existing skill identifier by name.

**Type:** string. ||
|| `repo` | External repository (org/repo).

**Type:** string. ||
|| `ref` | Branch, commit SHA, or tag if prefixed with 'tag:'. If empty, the default branch is used.

**Type:** string. ||
|#

### settings {#skills-settings}

#|
|| **Field** | **Description** ||
|| `instructions` | Custom instructions to append to the skill prompt.

**Type:** string.

**Format:** `long_text`. ||
|| [inputs](#skills-settings-inputs) | Input values for the skill.

**Type:** object. ||
|#

#### inputs {#skills-settings-inputs}

#|
|| **Field** | **Description** ||
|| `<input_name>` | **Type:** string. ||
|#

## JSON schema {#json-schema}

{% cut "JSON Schema for SourceCraft AI Skills configuration" %}

```json
{
    "$schema": "https://json-schema.org/draft-07/schema",
    "title": "Skills configuration",
    "description": "JSON Schema for SourceCraft AI Skills configuration",
    "type": "object",
    "additionalProperties": false,
    "properties": {
        "skills": {
            "title": "Skills",
            "description": "List of skill references to import",
            "type": ["array", "null"],
            "items": {
                "$ref": "#/$defs/skillRef"
            }
        }
    },
    "$defs": {
        "skillRef": {
            "title": "Skill",
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "source": {
                    "title": "Source",
                    "description": "Where to import the skill from",
                    "$ref": "#/$defs/skillSource"
                },
                "settings": {
                    "title": "Settings",
                    "description": "Configuration for the imported skill",
                    "$ref": "#/$defs/skillSettings"
                }
            },
            "required": ["source"]
        },
        "skillSource": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "path": {
                    "title": "Path",
                    "description": "Local path in current repository",
                    "type": "string"
                },
                "name": {
                    "title": "Name",
                    "description": "Existing skill identifier by name",
                    "type": "string"
                },
                "repo": {
                    "title": "Repository",
                    "description": "External repository (org/repo)",
                    "type": "string"
                },
                "ref": {
                    "title": "Reference",
                    "description": "Branch, commit SHA, or tag if prefixed with 'tag:'. If empty, the default branch is used.",
                    "type": "string"
                }
            }
        },
        "skillSettings": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "instructions": {
                    "title": "General Instructions",
                    "description": "Custom instructions to append to the skill prompt",
                    "type": "string",
                    "format": "long_text"
                },
                "inputs": {
                    "title": "Inputs",
                    "description": "Input values for the skill",
                    "type": "object",
                    "additionalProperties": {
                        "type": "string"
                    }
                }
            }
        }
    }
}
```

{% endcut %}
