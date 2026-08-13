<div class="openapi">

# Update workbook access bindings

<!-- markdownlint-disable-file -->

Updates access bindings for the specified workbook.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateWorkbookAccessBindings
```

</div>

</div>

</div>

### Headers

#|
|| **Name** | **Description** ||
||

_x-dl-api-version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

API version header.

_Const:_{.json-schema-reset .json-schema-value} `2`

_Example:_{.json-schema-reset .json-schema-example} `2`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "workbookId": "example",
  "deltas": [
    {
      "action": "ADD",
      "accessBinding": {
        "roleId": "example",
        "subject": {
          "id": "example",
          "type": "system"
        }
      }
    }
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_deltas_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [USAccessBindingDelta](#entity-USAccessBindingDelta)[]

Access binding changes to apply.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "action": "ADD",
    "accessBinding": {
      "roleId": "example",
      "subject": {
        "id": "example",
        "type": "system"
      }
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook whose access bindings to update.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### USAccessBindingDelta {#entity-USAccessBindingDelta}

#|
|| **Name** | **Description** ||
||

_accessBinding_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_roleId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the role assigned to the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the subject.

_Enum:_{.json-schema-reset .json-schema-value} `system`, `userAccount`, `federatedUser`, `serviceAccount`, `group`, `invitee`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subject to which the role is assigned.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "type": "system"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Access binding to add or remove.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "roleId": "example",
  "subject": {
    "id": "example",
    "type": "system"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_action_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Action to perform on the access binding.

_Enum:_{.json-schema-reset .json-schema-value} `ADD`, `REMOVE`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "action": "ADD",
  "accessBinding": {
    "roleId": "example",
    "subject": {
      "id": "example",
      "type": "system"
    }
  }
}
```

{% endcut %}

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "id": "example",
  "description": "example",
  "createdBy": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "modifiedAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "metadata": {},
  "done": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_seconds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Number of seconds since the Unix epoch.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nanos_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Fractional seconds in nanoseconds.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Operation creation timestamp.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Description of the operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_done_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if the operation has completed.
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_metadata_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
|#{.json-schema-properties}

{% endcut %}

Metadata associated with the operation.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_modifiedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_seconds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Number of seconds since the Unix epoch.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nanos_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Fractional seconds in nanoseconds.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Operation last modification timestamp.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.