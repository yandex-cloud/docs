---
sourcePath: en/tracker/api-ref/concepts/queues/edit-local-field.md
---
# Editing a local queue field

Use this request to edit a [local issue field](../../local-fields.md) linked to a given queue.


## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To edit a local field, use an HTTP `PATCH` request. Request parameters are provided in the request body in JSON format:

```json
PATCH /{{ ver }}/queues/<queue-id>/localFields/<field-key>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "name":
    {
        "en": "Field name in English",
        "ru": "Field name in Russian"
    },
    "category": "000000000000000000000002",
    "order": 102,
    "description": "Field description",
    "readonly": true,
    "visible": false,
    "hidden": false
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String |
| \<field-key\> | Local field key.<br/>To get the key, use an HTTP [request](get-local-fields.md):<br/>`GET /v2/queues/<queue-id>/localFields` | String |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Local field name:<ul><li>`en`: In English.</li><li>`ru`: In Russian.</li></ul> | String |
| category | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | String |
| order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
| description | Local field description. | String |
| [optionsProvider](#optionsProvider1) | Object with information about the list items | Object |
| readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable</li><li>`false`: Editable</li></ul> | Logical |
| visible | Indicates if the field is visible in the interface:<ul><li>`true`: Always visible</li><li>`false`: Not visible</li></ul> | Logical |
| hidden | Indicates if the field should be hidden in the interface:<ul><li>`true`: Hide the field even if it is not empty</li><li>`false`: Do not hide the field</li></ul> | Logical |

`optionsProvider` **object fields** {#optionsProvider1}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| type | Type of drop-down list: <ul><li>`FixedListOptionsProvider`: List of strings or numbers (for the `ru.yandex.startrek.core.fields.StringFieldType` or `ru.yandex.startrek.core.fields.IntegerFieldType` field types)</li><li>`FixedUserListOptionsProvider`: List of users (for the `ru.yandex.startrek.core.fields.UserFieldType` field type)</li></ul> | String |
| values | Drop-down list values | Array of strings |

{% endcut %}

> Example: Edit a fixed set of string values of a local field of the "Drop-down list" type.
>
> - An HTTP PATCH method is used.
> - Field type: `FixedListOptionsProvider`.
> - Drop-down list values: "The first list item", "The second list item", "The third list item".
>
> ```json
> PATCH /{{ ver }}/queues/<queue-id>/localFields/<field-key>
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>     "optionsProvider": {
>     "type": "FixedListOptionsProvider",
>     "values": [
>          "First list item",
>          "Second list item",
>          "Third list item"
>        ]
>    }
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the local queue field in JSON format.

    ```json
     {
        "type": "local",
        "self": "https://{{ host }}/v2/queues/ORG/localFields/loc_field_key",
        "id": "6054ae3a2b6b2c7f80bb9a93--loc_field_key",
        "name": "Field name in Russian",
        "description": "Field description",
        "key": "loc_field_key",
        "version": 2,
        "schema": {
            "type": "string",
            "required": false
        },
        "readonly": true,
        "options": true,
        "suggest": false,
        "optionsProvider": {
           "type": "FixedListOptionsProvider",
           "needValidation": true,
           "values": [
              "First list item",
              "Second list item",
              "Third list item"
             ]
          },
        "queryProvider": {
             "type": "StringOptionalQueryProvider"
        },
        "order": 102,
        "category": {
            "self": "https://{{ host }}/v2/fields/categories/000000000000000000000002",
            "id": "000000000000000000000002",
            "display": "category_name"
        },
        "queue": {
            "self": "https://{{ host }}/v2/queues/ORG",
            "id": "1",
            "key": "ORG",
            "display": "Organization"
        }
     }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | type | Field type | String |
    | self | Address of the API resource with information about the field | String |
    | id | Unique field ID | String |
    | name | Field name | String |
    | description | Field description | String |
    | key | Field key | String |
    | version | Field version; each change to the field increases the version number | Number |
    | [schema](#schema) | Object with information about the field value's data type | Object |
    | readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable</li><li>`false`: Editable</li></ul> | Logical |
    | options | Shows if the list of values is restricted:<ul><li>`true`: The list of values is not restricted, you can set any value</li><li>`false`: The list of values is restricted by the organization's settings</li></ul> | Logical |
    | suggest | Enables/disables search suggestions when entering field values:<ul><li>`true`: Enabled</li><li>`false`: Disabled</li></ul> | Logical |
    | [optionsProvider](#optionsProvider) | Object with information about allowed field values. | Object |
    | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You cannot change the class using the API | Object |
    | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
    | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Object |
    | [queue](#queue) | Object with information about the issue queue. | Object |

    `schema` **object fields** {#schema}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Field value type Possible data types:<ul><li>`string`: String; available for fields with a single value</li><li>`array`: Array; available for fields with multiple values</li></ul> | String |
    | items | Value type; available for fields with multiple values | String |
    | required | Shows if the field is required:<ul><li>`true`: Required</li><li>`false`: Optional</li></ul> | Logical |

    `optionsProvider` **object fields** {#optionsProvider}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Type of drop-down list | String |
    | needValidation | Indicates if a list value requires validation:<ul><li>`true`: Yes</li><li>`false`: Do not validate the field value</li></ul> | Logical |
    | values | Drop-down list values | Array of strings |

    `queryProvider` **object fields** {#queryProvider}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Query language type | String |

    `category` **object fields** {#category}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the field category | String |
    | id | Field category ID | String |
    | display | Category name displayed | String |

    `queue` **object fields** {#queue}

    {% include [queue](../../../_includes/tracker/api/queue.md) %}

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}