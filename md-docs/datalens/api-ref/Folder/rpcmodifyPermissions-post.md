[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Folder](index.md) > Modify permissions

<div class="openapi">

# Modify permissions

<!-- markdownlint-disable-file -->

Modifies permissions for the specified entry.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/modifyPermissions
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
  "entryId": "example",
  "body": {
    "diff": {
      "added": {
        "acl_adm": [
          {}
        ],
        "acl_edit": [
          {}
        ],
        "acl_view": [
          {}
        ],
        "acl_execute": [
          {}
        ]
      },
      "removed": {
        "acl_adm": [
          {}
        ],
        "acl_edit": [
          {}
        ],
        "acl_view": [
          {}
        ],
        "acl_execute": [
          {}
        ]
      },
      "modified": {
        "acl_adm": [
          {}
        ],
        "acl_edit": [
          {}
        ],
        "acl_view": [
          {}
        ],
        "acl_execute": [
          {}
        ]
      }
    }
  },
  "checkType": "straight",
  "nested": true,
  "page": 0.5,
  "pageSize": 0.5
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_body_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_diff_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_added_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_acl_adm_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to grant admin access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_edit_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to grant edit access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_execute_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to grant execute access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_view_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to grant view access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Permissions to add.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "acl_adm": [
    {
      "comment": "example",
      "subject": "example"
    }
  ],
  "acl_edit": [
    {
      "comment": "example",
      "subject": "example"
    }
  ],
  "acl_view": [
    {
      "comment": "example",
      "subject": "example"
    }
  ],
  "acl_execute": [
    {
      "comment": "example",
      "subject": "example"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_modified_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_acl_adm_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_new_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_grantType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New ACL level to assign to the subject.

_Enum:_{.json-schema-reset .json-schema-value} `acl_view`, `acl_edit`, `acl_adm`, `acl_execute`
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New subject identifier after modification.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "grantType": "acl_view",
  "subject": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Admin permission modifications.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example",
    "new": {
      "grantType": "acl_view",
      "subject": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_edit_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_new_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_grantType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New ACL level to assign to the subject.

_Enum:_{.json-schema-reset .json-schema-value} `acl_view`, `acl_edit`, `acl_adm`, `acl_execute`
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New subject identifier after modification.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "grantType": "acl_view",
  "subject": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Edit permission modifications.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example",
    "new": {
      "grantType": "acl_view",
      "subject": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_execute_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_new_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_grantType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New ACL level to assign to the subject.

_Enum:_{.json-schema-reset .json-schema-value} `acl_view`, `acl_edit`, `acl_adm`, `acl_execute`
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New subject identifier after modification.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "grantType": "acl_view",
  "subject": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Execute permission modifications.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example",
    "new": {
      "grantType": "acl_view",
      "subject": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_view_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_new_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_grantType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New ACL level to assign to the subject.

_Enum:_{.json-schema-reset .json-schema-value} `acl_view`, `acl_edit`, `acl_adm`, `acl_execute`
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

New subject identifier after modification.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "grantType": "acl_view",
  "subject": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

View permission modifications.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example",
    "new": {
      "grantType": "acl_view",
      "subject": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Permissions to modify.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "acl_adm": [
    {
      "comment": "example",
      "subject": "example",
      "new": {
        "grantType": "acl_view",
        "subject": "example"
      }
    }
  ],
  "acl_edit": [
    {
      "comment": "example",
      "subject": "example",
      "new": {
        "grantType": "acl_view",
        "subject": "example"
      }
    }
  ],
  "acl_view": [
    {
      "comment": "example",
      "subject": "example",
      "new": {
        "grantType": "acl_view",
        "subject": "example"
      }
    }
  ],
  "acl_execute": [
    {
      "comment": "example",
      "subject": "example",
      "new": {
        "grantType": "acl_view",
        "subject": "example"
      }
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_removed_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_acl_adm_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to revoke admin access from.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_edit_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to revoke edit access from.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_execute_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to revoke execute access from.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_acl_view_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_comment_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Comment describing the reason for this permission change.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subjects to revoke view access from.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "comment": "example",
    "subject": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Permissions to remove.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "acl_adm": [
    {
      "comment": "example",
      "subject": "example"
    }
  ],
  "acl_edit": [
    {
      "comment": "example",
      "subject": "example"
    }
  ],
  "acl_view": [
    {
      "comment": "example",
      "subject": "example"
    }
  ],
  "acl_execute": [
    {
      "comment": "example",
      "subject": "example"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Set of permission changes to apply.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "added": {
    "acl_adm": [
      {
        "comment": "example",
        "subject": "example"
      }
    ],
    "acl_edit": [
      {
        "comment": "example",
        "subject": "example"
      }
    ],
    "acl_view": [
      {
        "comment": "example",
        "subject": "example"
      }
    ],
    "acl_execute": [
      {
        "comment": "example",
        "subject": "example"
      }
    ]
  },
  "removed": {
    "acl_adm": [
      {
        "comment": "example",
        "subject": "example"
      }
    ],
    "acl_edit": [
      {
        "comment": "example",
        "subject": "example"
      }
    ],
    "acl_view": [
      {
        "comment": "example",
        "subject": "example"
      }
    ],
    "acl_execute": [
      {
        "comment": "example",
        "subject": "example"
      }
    ]
  },
  "modified": {
    "acl_adm": [
      {
        "comment": "example",
        "subject": "example",
        "new": {
          "grantType": "acl_view",
          "subject": "example"
        }
      }
    ],
    "acl_edit": [
      {
        "comment": "example",
        "subject": "example",
        "new": {
          "grantType": "acl_view",
          "subject": "example"
        }
      }
    ],
    "acl_view": [
      {
        "comment": "example",
        "subject": "example",
        "new": {
          "grantType": "acl_view",
          "subject": "example"
        }
      }
    ],
    "acl_execute": [
      {
        "comment": "example",
        "subject": "example",
        "new": {
          "grantType": "acl_view",
          "subject": "example"
        }
      }
    ]
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Permission changes to apply.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "diff": {
    "added": {
      "acl_adm": [
        {
          "comment": "example",
          "subject": "example"
        }
      ],
      "acl_edit": [
        {
          "comment": "example",
          "subject": "example"
        }
      ],
      "acl_view": [
        {
          "comment": "example",
          "subject": "example"
        }
      ],
      "acl_execute": [
        {
          "comment": "example",
          "subject": "example"
        }
      ]
    },
    "removed": {
      "acl_adm": [
        {
          "comment": "example",
          "subject": "example"
        }
      ],
      "acl_edit": [
        {
          "comment": "example",
          "subject": "example"
        }
      ],
      "acl_view": [
        {
          "comment": "example",
          "subject": "example"
        }
      ],
      "acl_execute": [
        {
          "comment": "example",
          "subject": "example"
        }
      ]
    },
    "modified": {
      "acl_adm": [
        {
          "comment": "example",
          "subject": "example",
          "new": {}
        }
      ],
      "acl_edit": [
        {
          "comment": "example",
          "subject": "example",
          "new": {}
        }
      ],
      "acl_view": [
        {
          "comment": "example",
          "subject": "example",
          "new": {}
        }
      ],
      "acl_execute": [
        {
          "comment": "example",
          "subject": "example",
          "new": {}
        }
      ]
    }
  }
}
```

{% endcut %}
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entry to modify permissions for.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_checkType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Scope of permission check: straight (direct), hierarchical, or root.

_Enum:_{.json-schema-reset .json-schema-value} `straight`, `hierarchical`, `root`
{.table-cell}
||
||

_nested_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Apply changes recursively to all nested entries.
{.table-cell}
||
||

_page_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Page number for paginated results.
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of results per page.
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
  "result": "ok",
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_result_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ok`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for fetching the next page of results.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.