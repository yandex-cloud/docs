[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Subscriptions](index.md) > Update subscription

<div class="openapi">

# Update subscription

<!-- markdownlint-disable-file -->

Updates the specified subscription.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateSubscription
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

_Const:_{.json-schema-reset .json-schema-value} `3`

_Example:_{.json-schema-reset .json-schema-example} `3`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "title": "example",
  "description": "example",
  "content": {
    "type": "dash",
    "entryId": "example",
    "options": {
      "states": [
        {}
      ],
      "aiSummary": {
        "enabled": true,
        "prompt": "example"
      }
    }
  },
  "trigger": {
    "type": "cron",
    "entryId": "example",
    "options": {
      "expression": "example",
      "timezone": "example"
    }
  },
  "artifact": {
    "type": "png",
    "options": {
      "size": [
        null
      ],
      "fullPage": true
    }
  },
  "recipients": [
    {
      "subjectId": "example",
      "subjectType": "userAccount"
    }
  ],
  "selfSubscribeEnabled": true,
  "status": "active",
  "tenantId": "example",
  "workbookId": "example",
  "meta": {},
  "subscriptionId": "7lieexzx4kxs0"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_artifact_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _options_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _fullPage_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean
  {.table-cell}
  ||
  ||

  _size_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: array &#124; null

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    null
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "size": [
      null
    ],
    "fullPage": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `png`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "png",
    "options": {
      "size": [
        null
      ],
      "fullPage": true
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _options_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `pdf`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "pdf",
    "options": {}
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "png",
  "options": {
    "size": [
      null
    ],
    "fullPage": true
  }
}
```

{% endcut %}
{.table-cell}
||
||

_content_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _entryId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _options_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _states_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _state_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _tab_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _parameters_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: unknown

  _Example:_{.json-schema-reset .json-schema-example} `null`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _stateTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  _Min items:_{.json-schema-reset .json-schema-assertion} `1`

  _Max items:_{.json-schema-reset .json-schema-assertion} `10`

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "tab": "example",
      "state": "example",
      "stateTitle": "example",
      "parameters": {}
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _aiSummary_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: object &#124; null

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "enabled": true,
    "prompt": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "states": [
      {
        "tab": "example",
        "state": "example",
        "stateTitle": "example",
        "parameters": {}
      }
    ],
    "aiSummary": {
      "enabled": true,
      "prompt": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `dash`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "dash",
    "entryId": "example",
    "options": {
      "states": [
        {
          "tab": "example",
          "state": "example",
          "stateTitle": "example",
          "parameters": {}
        }
      ],
      "aiSummary": {
        "enabled": true,
        "prompt": "example"
      }
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _entryId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _options_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _states_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _parameters_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: unknown

  _Example:_{.json-schema-reset .json-schema-example} `null`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _stateTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  _Min items:_{.json-schema-reset .json-schema-assertion} `1`

  _Max items:_{.json-schema-reset .json-schema-assertion} `10`

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "stateTitle": "example",
      "parameters": {}
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "states": [
      {
        "stateTitle": "example",
        "parameters": {}
      }
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `report`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "report",
    "entryId": "example",
    "options": {
      "states": [
        {
          "stateTitle": "example",
          "parameters": {}
        }
      ]
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "dash",
  "entryId": "example",
  "options": {
    "states": [
      {
        "tab": "example",
        "state": "example",
        "stateTitle": "example",
        "parameters": {}
      }
    ],
    "aiSummary": {
      "enabled": true,
      "prompt": "example"
    }
  }
}
```

{% endcut %}
{.table-cell}
||
||

_recipients_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [SubscriptionRecipient](#entity-SubscriptionRecipient)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "subjectId": "example",
    "subjectType": "userAccount"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_selfSubscribeEnabled_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `active`, `stopped`
{.table-cell}
||
||

_subscriptionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Pattern:_{.json-schema-reset .json-schema-assertion} `^[a-zA-Z0-9._:-]+$`

_Example:_{.json-schema-reset .json-schema-example} `7lieexzx4kxs0`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_trigger_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _options_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _expression_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _timezone_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "expression": "example",
    "timezone": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `cron`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _entryId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "cron",
    "entryId": "example",
    "options": {
      "expression": "example",
      "timezone": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _entryId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _options_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _query_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `100000`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _timezone_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "query": "example",
    "timezone": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `sql`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "sql",
    "entryId": "example",
    "options": {
      "query": "example",
      "timezone": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "cron",
  "entryId": "example",
  "options": {
    "expression": "example",
    "timezone": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### SubscriptionRecipient {#entity-SubscriptionRecipient}

#|
|| **Name** | **Description** ||
||

_subjectId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the recipient user account.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subjectType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Recipient subject type. Only user accounts are supported.

_Const:_{.json-schema-reset .json-schema-value} `userAccount`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subjectId": "example",
  "subjectType": "userAccount"
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
  "title": "example",
  "description": "example",
  "content": {
    "type": "example",
    "entryId": "example",
    "options": {}
  },
  "trigger": {
    "type": "example",
    "entryId": "example",
    "options": {}
  },
  "artifact": {
    "type": "example",
    "options": {}
  },
  "recipients": [
    {
      "subjectId": "example",
      "subjectType": "userAccount"
    }
  ],
  "selfSubscribeEnabled": true,
  "status": "active",
  "tenantId": "example",
  "workbookId": "example",
  "meta": {},
  "subscriptionId": "example",
  "createdAt": "example",
  "updatedAt": "example",
  "suspendedAt": "example",
  "createdBy": "example",
  "updatedBy": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_artifact_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_options_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "example",
  "options": {}
}
```

{% endcut %}
{.table-cell}
||
||

_content_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_options_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "example",
  "entryId": "example",
  "options": {}
}
```

{% endcut %}
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_recipients_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [SubscriptionRecipient](#entity-SubscriptionRecipient)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "subjectId": "example",
    "subjectType": "userAccount"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_selfSubscribeEnabled_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `active`, `stopped`, `suspended`
{.table-cell}
||
||

_subscriptionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_suspendedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_trigger_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_options_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "example",
  "entryId": "example",
  "options": {}
}
```

{% endcut %}
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.