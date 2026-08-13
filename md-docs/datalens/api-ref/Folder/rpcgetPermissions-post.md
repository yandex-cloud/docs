[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Folder](index.md) > Get permissions

<div class="openapi">

# Get permissions

<!-- markdownlint-disable-file -->

Returns permissions for the specified entry.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getPermissions
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
  "entryId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the entry to get permissions for.

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
  "editable": true,
  "pendingPermissions": {
    "acl_adm": [
      {
        "approver": null,
        "description": "example",
        "extras": null,
        "kind": "user",
        "name": "example",
        "requester": {
          "cloud_icon": "example",
          "cloud_icon_data": "example",
          "cloud_user_id": "example",
          "icon": "example",
          "link": "example",
          "name": "example",
          "title": "example",
          "type": "user",
          "parent": {},
          "__rlsid": "example",
          "__source": "example"
        },
        "subject": {
          "cloud_icon": "example",
          "cloud_icon_data": "example",
          "cloud_user_id": "example",
          "icon": "example",
          "link": "example",
          "name": "example",
          "title": "example",
          "type": "user",
          "parent": {},
          "__rlsid": "example",
          "__source": "example"
        }
      }
    ],
    "acl_edit": [
      null
    ],
    "acl_view": [
      null
    ],
    "acl_execute": [
      null
    ]
  },
  "permissions": {
    "acl_adm": [
      {
        "approver": {
          "cloud_icon": "example",
          "cloud_icon_data": "example",
          "cloud_user_id": "example",
          "icon": "example",
          "link": "example",
          "name": "example",
          "title": "example",
          "type": "user",
          "parent": {},
          "__rlsid": "example",
          "__source": "example"
        },
        "description": "example",
        "extras": null,
        "kind": "user",
        "name": "example",
        "requester": {
          "cloud_icon": "example",
          "cloud_icon_data": "example",
          "cloud_user_id": "example",
          "icon": "example",
          "link": "example",
          "name": "example",
          "title": "example",
          "type": "user",
          "parent": {},
          "__rlsid": "example",
          "__source": "example"
        },
        "subject": {
          "cloud_icon": "example",
          "cloud_icon_data": "example",
          "cloud_user_id": "example",
          "icon": "example",
          "link": "example",
          "name": "example",
          "title": "example",
          "type": "user",
          "parent": {},
          "__rlsid": "example",
          "__source": "example"
        }
      }
    ],
    "acl_edit": [
      null
    ],
    "acl_view": [
      null
    ],
    "acl_execute": [
      null
    ]
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_editable_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the current user can edit permissions for this entry.
{.table-cell}
||
||

_pendingPermissions_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_acl_adm_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DlsPermissionPendingParticipant](#entity-DlsPermissionPendingParticipant)[]

Pending admin access requests.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": null,
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
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
**Type**: [DlsPermissionPendingParticipant](#entity-DlsPermissionPendingParticipant)[]

Pending edit access requests.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": null,
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
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
**Type**: [DlsPermissionPendingParticipant](#entity-DlsPermissionPendingParticipant)[]

Pending execute access requests.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": null,
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
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
**Type**: [DlsPermissionPendingParticipant](#entity-DlsPermissionPendingParticipant)[]

Pending view access requests.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": null,
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Pending permission requests grouped by ACL level.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "acl_adm": [
    {
      "approver": null,
      "description": "example",
      "extras": null,
      "kind": "user",
      "name": "example",
      "requester": {
        "cloud_icon": "example",
        "cloud_icon_data": "example",
        "cloud_user_id": "example",
        "icon": "example",
        "link": "example",
        "name": "example",
        "title": "example",
        "type": "user",
        "parent": {
          "link": "example",
          "title": "example"
        },
        "__rlsid": "example",
        "__source": "example"
      },
      "subject": {
        "cloud_icon": "example",
        "cloud_icon_data": "example",
        "cloud_user_id": "example",
        "icon": "example",
        "link": "example",
        "name": "example",
        "title": "example",
        "type": "user",
        "parent": {
          "link": "example",
          "title": "example"
        },
        "__rlsid": "example",
        "__source": "example"
      }
    }
  ],
  "acl_edit": [
    null
  ],
  "acl_view": [
    null
  ],
  "acl_execute": [
    null
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_permissions_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_acl_adm_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DlsPermissionParticipant](#entity-DlsPermissionParticipant)[]

Participants with admin access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
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
**Type**: [DlsPermissionParticipant](#entity-DlsPermissionParticipant)[]

Participants with edit access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
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
**Type**: [DlsPermissionParticipant](#entity-DlsPermissionParticipant)[]

Participants with execute access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
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
**Type**: [DlsPermissionParticipant](#entity-DlsPermissionParticipant)[]

Participants with view access.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "approver": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "description": "example",
    "extras": null,
    "kind": "user",
    "name": "example",
    "requester": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    },
    "subject": {
      "cloud_icon": "example",
      "cloud_icon_data": "example",
      "cloud_user_id": "example",
      "icon": "example",
      "link": "example",
      "name": "example",
      "title": "example",
      "type": "user",
      "parent": {
        "link": "example",
        "title": "example"
      },
      "__rlsid": "example",
      "__source": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Granted permissions grouped by ACL level.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "acl_adm": [
    {
      "approver": {
        "cloud_icon": "example",
        "cloud_icon_data": "example",
        "cloud_user_id": "example",
        "icon": "example",
        "link": "example",
        "name": "example",
        "title": "example",
        "type": "user",
        "parent": {
          "link": "example",
          "title": "example"
        },
        "__rlsid": "example",
        "__source": "example"
      },
      "description": "example",
      "extras": null,
      "kind": "user",
      "name": "example",
      "requester": {
        "cloud_icon": "example",
        "cloud_icon_data": "example",
        "cloud_user_id": "example",
        "icon": "example",
        "link": "example",
        "name": "example",
        "title": "example",
        "type": "user",
        "parent": {
          "link": "example",
          "title": "example"
        },
        "__rlsid": "example",
        "__source": "example"
      },
      "subject": {
        "cloud_icon": "example",
        "cloud_icon_data": "example",
        "cloud_user_id": "example",
        "icon": "example",
        "link": "example",
        "name": "example",
        "title": "example",
        "type": "user",
        "parent": {
          "link": "example",
          "title": "example"
        },
        "__rlsid": "example",
        "__source": "example"
      }
    }
  ],
  "acl_edit": [
    null
  ],
  "acl_view": [
    null
  ],
  "acl_execute": [
    null
  ]
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### DlsPermissionPendingParticipant {#entity-DlsPermissionPendingParticipant}

#|
|| **Name** | **Description** ||
||

_approver_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: null

Always null for pending permissions.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Human-readable description of the pending permission request.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_extras_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: object

  #|
  ||

  _initial_on_create_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to set this permission on entry creation.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "initial_on_create": true
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Additional configuration for the permission request.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_kind_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Participant kind.

_Enum:_{.json-schema-reset .json-schema-value} `user`, `group`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject id.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_requester_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

User who submitted the permission request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cloud_icon": "example",
  "cloud_icon_data": "example",
  "cloud_user_id": "example",
  "icon": "example",
  "link": "example",
  "name": "example",
  "title": "example",
  "type": "user",
  "parent": {
    "link": "example",
    "title": "example"
  },
  "__rlsid": "example",
  "__source": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_rlsid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Row-level security identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_source_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Source system identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_icon_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud icon URL for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_icon_data_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud icon raw data for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_user_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud platform user ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_icon_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Icon URL for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_link_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Profile link for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subject id.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parent_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_link_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Link to the parent group.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Display title of the parent group.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Parent group information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "link": "example",
  "title": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Display title for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subject type.

_Enum:_{.json-schema-reset .json-schema-value} `user`, `user-staff`, `user-system`, `group-system`, `group-staff-servicerole`, `group-staff-service`, `group-staff-wiki`, `group-staff-department`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subject details.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cloud_icon": "example",
  "cloud_icon_data": "example",
  "cloud_user_id": "example",
  "icon": "example",
  "link": "example",
  "name": "example",
  "title": "example",
  "type": "user",
  "parent": {
    "link": "example",
    "title": "example"
  },
  "__rlsid": "example",
  "__source": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "approver": null,
  "description": "example",
  "extras": null,
  "kind": "user",
  "name": "example",
  "requester": {
    "cloud_icon": "example",
    "cloud_icon_data": "example",
    "cloud_user_id": "example",
    "icon": "example",
    "link": "example",
    "name": "example",
    "title": "example",
    "type": "user",
    "parent": {
      "link": "example",
      "title": "example"
    },
    "__rlsid": "example",
    "__source": "example"
  },
  "subject": {
    "cloud_icon": "example",
    "cloud_icon_data": "example",
    "cloud_user_id": "example",
    "icon": "example",
    "link": "example",
    "name": "example",
    "title": "example",
    "type": "user",
    "parent": {
      "link": "example",
      "title": "example"
    },
    "__rlsid": "example",
    "__source": "example"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DlsPermissionParticipant {#entity-DlsPermissionParticipant}

#|
|| **Name** | **Description** ||
||

_approver_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

User who approved this permission.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cloud_icon": "example",
  "cloud_icon_data": "example",
  "cloud_user_id": "example",
  "icon": "example",
  "link": "example",
  "name": "example",
  "title": "example",
  "type": "user",
  "parent": {
    "link": "example",
    "title": "example"
  },
  "__rlsid": "example",
  "__source": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Human-readable description of the permission.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_extras_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: object

  #|
  ||

  _initial_on_create_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to set this permission on entry creation.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "initial_on_create": true
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Additional configuration for the permission.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_kind_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Participant kind.

_Enum:_{.json-schema-reset .json-schema-value} `user`, `group`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject id.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_requester_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

User who requested this permission.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cloud_icon": "example",
  "cloud_icon_data": "example",
  "cloud_user_id": "example",
  "icon": "example",
  "link": "example",
  "name": "example",
  "title": "example",
  "type": "user",
  "parent": {
    "link": "example",
    "title": "example"
  },
  "__rlsid": "example",
  "__source": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_rlsid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Row-level security identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_source_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Source system identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_icon_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud icon URL for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_icon_data_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud icon raw data for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cloud_user_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Cloud platform user ID.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_icon_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Icon URL for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_link_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Profile link for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subject id.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parent_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_link_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Link to the parent group.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Display title of the parent group.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Parent group information.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "link": "example",
  "title": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Display title for the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subject type.

_Enum:_{.json-schema-reset .json-schema-value} `user`, `user-staff`, `user-system`, `group-system`, `group-staff-servicerole`, `group-staff-service`, `group-staff-wiki`, `group-staff-department`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Subject details.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cloud_icon": "example",
  "cloud_icon_data": "example",
  "cloud_user_id": "example",
  "icon": "example",
  "link": "example",
  "name": "example",
  "title": "example",
  "type": "user",
  "parent": {
    "link": "example",
    "title": "example"
  },
  "__rlsid": "example",
  "__source": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "approver": {
    "cloud_icon": "example",
    "cloud_icon_data": "example",
    "cloud_user_id": "example",
    "icon": "example",
    "link": "example",
    "name": "example",
    "title": "example",
    "type": "user",
    "parent": {
      "link": "example",
      "title": "example"
    },
    "__rlsid": "example",
    "__source": "example"
  },
  "description": "example",
  "extras": null,
  "kind": "user",
  "name": "example",
  "requester": {
    "cloud_icon": "example",
    "cloud_icon_data": "example",
    "cloud_user_id": "example",
    "icon": "example",
    "link": "example",
    "name": "example",
    "title": "example",
    "type": "user",
    "parent": {
      "link": "example",
      "title": "example"
    },
    "__rlsid": "example",
    "__source": "example"
  },
  "subject": {
    "cloud_icon": "example",
    "cloud_icon_data": "example",
    "cloud_user_id": "example",
    "icon": "example",
    "link": "example",
    "name": "example",
    "title": "example",
    "type": "user",
    "parent": {
      "link": "example",
      "title": "example"
    },
    "__rlsid": "example",
    "__source": "example"
  }
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.