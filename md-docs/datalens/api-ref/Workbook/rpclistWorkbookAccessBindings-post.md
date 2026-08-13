[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Workbook](index.md) > List workbook access bindings

<div class="openapi">

# List workbook access bindings

<!-- markdownlint-disable-file -->

Lists access bindings for the specified workbook.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listWorkbookAccessBindings
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
  "getInheritedBindings": true,
  "pageSize": 0.5,
  "pageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook whose access bindings to retrieve.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_getInheritedBindings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include access bindings inherited from parent resources.
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Maximum number of subjects to return.
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for retrieving the next page of results.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

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
  "subjectsWithBindings": [
    {
      "subjectClaims": {
        "sub": "example",
        "subType": "SUBJECT_TYPE_UNSPECIFIED",
        "email": "example"
      },
      "accessBindings": [
        {
          "roleId": "example",
          "inheritedFrom": {}
        }
      ],
      "inheritedAccessBindings": [
        null
      ]
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_nextPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token for retrieving the next page of results.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subjectsWithBindings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [IamSubjectWithBindings](#entity-IamSubjectWithBindings)[]

Subjects and their access bindings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "subjectClaims": {
      "sub": "example",
      "subType": "SUBJECT_TYPE_UNSPECIFIED",
      "email": "example"
    },
    "accessBindings": [
      {
        "roleId": "example",
        "inheritedFrom": {
          "id": "example",
          "type": "example"
        }
      }
    ],
    "inheritedAccessBindings": [
      null
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### IamAccessBinding {#entity-IamAccessBinding}

#|
|| **Name** | **Description** ||
||

_inheritedFrom_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Resource from which the access binding is inherited.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "type": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_roleId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the role assigned to the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "roleId": "example",
  "inheritedFrom": {
    "id": "example",
    "type": "example"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### IamSubjectWithBindings {#entity-IamSubjectWithBindings}

#|
|| **Name** | **Description** ||
||

_accessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [IamAccessBinding](#entity-IamAccessBinding)[]

Access bindings assigned directly to the subject.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "roleId": "example",
    "inheritedFrom": {
      "id": "example",
      "type": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_inheritedAccessBindings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [IamAccessBinding](#entity-IamAccessBinding)[]

Access bindings inherited by the subject.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "roleId": "example",
    "inheritedFrom": {
      "id": "example",
      "type": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_subjectClaims_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_email_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Email address of the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sub_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the subject.

_Enum:_{.json-schema-reset .json-schema-value} `SUBJECT_TYPE_UNSPECIFIED`, `USER_ACCOUNT`, `SERVICE_ACCOUNT`, `GROUP`, `INVITEE`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subject details.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "sub": "example",
  "subType": "SUBJECT_TYPE_UNSPECIFIED",
  "email": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subjectClaims": {
    "sub": "example",
    "subType": "SUBJECT_TYPE_UNSPECIFIED",
    "email": "example"
  },
  "accessBindings": [
    {
      "roleId": "example",
      "inheritedFrom": {
        "id": "example",
        "type": "example"
      }
    }
  ],
  "inheritedAccessBindings": [
    null
  ]
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.