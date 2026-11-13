# Organisation policies configuration

Path in repository: `.sourcecraft/policies.yaml`.

The template shows the structure and available fields. Replace placeholders and use the reference tables to select the fields and forms for your configuration.

```yaml
version: 1
policies:
  admin_only_repository_creation: false
  anonymous_public_access_disabled: false
  public_visibility_changes_disabled: false
  non_federative_invitations_disabled: false
  ip_allowlist:
    - "<ip_allowlist>"
```

#|
|| **Field** | **Description** ||
|| `version` | Organization policies format version.

**Type:** integer.

**Default:** `1`.

**Allowed values:** `1`. ||
|| [policies](#policies) | Restrictions applied to the entire organisation.

**Type:** object.

Additional fields are prohibited. ||
|#

**Type:** object.

Additional fields are prohibited.

## policies {#policies}

#|
|| **Field** | **Description** ||
|| `admin_only_repository_creation` | Allow only organization administrators to create repositories.

**Type:** boolean.

**Default:** `false`. ||
|| `anonymous_public_access_disabled` | Require authentication to access public resources in this organization.

**Type:** boolean.

**Default:** `false`. ||
|| `public_visibility_changes_disabled` | Prevent creating public repositories or changing repository visibility to public.

**Type:** boolean.

**Default:** `false`. ||
|| `non_federative_invitations_disabled` | Allow inviting only federated users to this organization.

**Type:** boolean.

**Default:** `false`. ||
|| `ip_allowlist` | Allowed client networks in IPv4 or IPv6 CIDR notation. An absent or empty list disables IP filtering.

**Type:** array of strings.

**Default:** `[]`.

**Examples:** `["192.0.2.0/24", "2001:db8::/32"]`.

Items must be unique. ||
|#

## JSON schema {#json-schema}

{% cut "JSON Schema for SourceCraft organisation policy restrictions" %}

```json
{
  "$schema": "https://json-schema.org/draft-07/schema",
  "title": "Organisation policies configuration",
  "description": "JSON Schema for SourceCraft organisation policy restrictions",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "version": {
      "type": "integer",
      "enum": [1],
      "default": 1,
      "description": "Organization policies format version."
    },
    "policies": {
      "title": "Policies",
      "description": "Restrictions applied to the entire organisation",
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "admin_only_repository_creation": {
          "type": "boolean",
          "default": false,
          "description": "Allow only organization administrators to create repositories."
        },
        "anonymous_public_access_disabled": {
          "type": "boolean",
          "default": false,
          "description": "Require authentication to access public resources in this organization."
        },
        "public_visibility_changes_disabled": {
          "type": "boolean",
          "default": false,
          "description": "Prevent creating public repositories or changing repository visibility to public."
        },
        "non_federative_invitations_disabled": {
          "type": "boolean",
          "default": false,
          "description": "Allow inviting only federated users to this organization."
        },
        "ip_allowlist": {
          "description": "Allowed client networks in IPv4 or IPv6 CIDR notation. An absent or empty list disables IP filtering.",
          "type": "array",
          "default": [],
          "uniqueItems": true,
          "items": {
            "type": "string"
          },
          "examples": [["192.0.2.0/24", "2001:db8::/32"]]
        }
      }
    }
  }
}
```

{% endcut %}
