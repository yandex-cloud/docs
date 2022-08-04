---
sourcePath: en/tracker/api-ref/concepts/queues/create-local-field.md
---
# Create a local queue field

Use this request to create an issue [local field](../../local-fields.md) linked to a given queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create a local field, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/queues/<queue-id>/localFields
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "name":
    {
        "en": "Name in English",
        "ru": "Name in Russian"
    },
    "id": "loc_field_key",
    "category": "000000000000000000000003",
    "type": "ru.yandex.startrek.core.fields.StringFieldType"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Local field name:<ul><li>`en`: In English.</li><li>`ru`: In Russian.</li></ul> | String |
| id | Local field ID. | String |
| category | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | String |
| type | Local field type:<ul><li>`ru.yandex.startrek.core.fields.DateFieldType`: Date.</li><li>`ru.yandex.startrek.core.fields.DateTimeFieldType`: Date/Time.</li><li>`ru.yandex.startrek.core.fields.StringFieldType`: Single-line text field.</li><li>`ru.yandex.startrek.core.fields.TextFieldType`: Multi-line text field.</li><li>`ru.yandex.startrek.core.fields.FloatFieldType`: Fractional number.</li><li>`ru.yandex.startrek.core.fields.IntegerFieldType`: Integer</li><li>`ru.yandex.startrek.core.fields.UserFieldType`: User's name.</li><li>`ru.yandex.startrek.core.fields.UriFieldType`: Link.</li> | String |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| [optionsProvider](#optionsProvider1) | Object with information about the list items. | Object |
| order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}). | Number |
| description | Local field description. | String |
| readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable.</li><li>`false`: Editable.</li></ul> | Boolean |
| visible | Indicates if the field is visible in the interface:<ul><li>`true`: Always visible.</li><li>`false`: Not visible.</li></ul> | Boolean |
| hidden | Indicates if the field should be hidden in the interface:<ul><li>`true`: Hide the field even if it isn't empty.</li><li>`false`: Don't hide the field.</li></ul> | Boolean |
| container | Indicates if you can specify multiple values in the field (like in the **Tags** field):<ul><li>`true`: You can specify multiple values in the field.</li><li>`false`: You can only specify one value in the field.</li></ul>This parameter can be used for the following types of fields:<ul><li>`ru.yandex.startrek.core.fields.StringFieldType`: One-line text field.</li><li>`ru.yandex.startrek.core.fields.UserFieldType`: User's name.</li><li>drop-down list (see the `optionsProvider` description).</li></ul> | Boolean |

**Object fields** `optionsProvider` {#optionsProvider1}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| type | Type of drop-down list: <ul><li>`FixedListOptionsProvider`: List of strings or numbers (for the `ru.yandex.startrek.core.fields.StringFieldType` or `ru.yandex.startrek.core.fields.IntegerFieldType` field types).</li><li>`FixedUserListOptionsProvider`: List of users (for the `ru.yandex.startrek.core.fields.UserFieldType` field type).</li></ul> | String |
| values | Drop-down list values. | Array of strings |

{% endcut %}

> Example: Create a local field of the <q>Drop-down list</q> type with a fixed set of string values:
>
>- An HTTP POST method is used.
>- A local field is created for the DESIGN queue.
>- Field type: `FixedListOptionsProvider`.
>- Drop-down list values: <q>the first list item</q>, <q>the second list item</q>, <q>the third list item</q>.
>
>```json
>POST /v2/queues/DESIGN/localFields
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>
>{
>"name":
>{
>   "en": "Name in English",
>   "ru": "Name in Russian"
>},
>"id": "loc_field_key",
>"category": "000000000000000000000003",
>"type": "ru.yandex.startrek.core.fields.StringFieldType",
>"optionsProvider": {
>   "type": "FixedListOptionsProvider",
>   "values": [
>       "the first list item",
>       "the second list item",
>       "the third list item"
>   ]
>},
>}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the local queue field in JSON format.

    ```json
     {
        "type": "local",
        "self": "{{ host }}/v2/queues/ORG/localFields/loc_field_key",
        "id": "6054ae3a2b6b2c7f80bb9a93--loc_field_key",
        "name": "Field name in Russian",
        "description": "Local field description",
        "key": "loc_field_key",
        "version": 1,
        "schema": {
            "type": "string",
            "required": false
        },
        "readonly": true,
        "options": false,
        "suggest": false,
       "queryProvider": {
         "type": "StringOptionalQueryProvider"
        },
        "order": 100, 
        "category": {
            "self": "{{ host }}/v2/fields/categories/000000000000000000000003",
            "id": "000000000000000000000003",
            "display": "category_name"
        }    
     }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | type | Field type. | String |
    | self | Address of the API resource with information about the field. | String |
    | id | Unique field ID. | String |
    | name | Field name. | String |
    | description | Field description. | String |
    | key | Field key. | String |
    | version | Field version. Each change to the field increases the version number. | Number |
    | [schema](#schema) | Object with information about the field value's data type. | Object |
    | readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable.</li><li>`false`: Editable.</li></ul> | Boolean |
    | options | Shows if the list of values is restricted:<ul><li>`true`: The list of values is not restricted, you can set any value.</li><li>`false`: The list of values is restricted by the organization's settings.</li></ul> | Boolean |
    | suggest | Enables/disables search suggestions when entering field values:<ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> | Boolean |
    | [optionsProvider](#optionsProvider) | Object with information about the drop-down list items. | Object |
    | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You can't change the class using the API. | Object |
    | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
    | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Object |

    **Object fields** `schema` {#schema}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Field value type. Possible data types:<ul><li>`string`: String. Available for fields with a single value.</li><li>`array`: Array. Available for fields with multiple values.</li></ul> | String |
    | items | Value type. Available for fields with multiple values. | String |
    | required | Shows if the field is required:<ul><li>`true`: Required.</li><li>`false`: Optional.</li></ul> | Boolean |

     **Object fields** `optionsProvider` {#optionsProvider}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Type of drop-down list. | String |
    | needValidation | Indicates if a list value requires validation:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> | Boolean |
    | values | List items | Array of strings |

    **Object fields** `queryProvider` {#queryProvider}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Query language type. | String |

    **Object fields** `category` {#category}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the field category. | String |
    | id | Field category ID. | String |
    | display | Category name displayed. | String |

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

