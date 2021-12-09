---
sourcePath: en/tracker/api-ref/concepts/queues/create-local-field.md
---
# Create a local queue field

Use this request to create an issue [local field](../../local-fields.md) linked to the specified queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create a local field, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/queues/<queue-id>/localFields
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

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

**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String |

### Request body parameters {#req-body-params}

The request body contains the information needed to create a local field:

#### Required parameters

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Name of a local field:<ul><li>`en` — In English.</li><li>`ru` — In Russian.</li></ul> | String |
| id | Local field ID. | String |
| category | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | String |
| type | Type of a local field:<ul><li>`ru.yandex.startrek.core.fields.DateFieldType`: Date.</li><li>`ru.yandex.startrek.core.fields.DateTimeFieldType`: Date/time.</li><li>`ru.yandex.startrek.core.fields.StringFieldType`: Single-line text field.</li><li>`ru.yandex.startrek.core.fields.TextFieldType`: Multi-line text field.</li><li>`ru.yandex.startrek.core.fields.FloatFieldType`: Fraction.</li><li>`ru.yandex.startrek.core.fields.IntegerFieldType`: Integer.</li><li>`ru.yandex.startrek.core.fields.UserFieldType`: User name.</li><li>`ru.yandex.startrek.core.fields.UriFieldType`: Link.</li> | String |

#### Advanced settings

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| [optionsProvider](#optionsProvider1) | Object with information about list items. | Objects |
| order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}). | Number |
| description | Description of the local field. | String|
| readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable.</li><li>`false`: Editable.</li></ul> | Boolean|
| visible | Flag that indicates if the field is shown in the interface:<ul><li>`true`: Always show the field in the interface.</li><li>`false`: Don't show the field in the interface.</li></ul> | Boolean|
| hidden | Flag that indicates if the field is visible in the interface:<ul><li>`true`: Hide the field even if it's filled in.</li><li>`false`: Don't hide the field.</li></ul> | Boolean|
| container | Flag that indicates whether it's possible to specify multiple values in the field at the same time (for example, as in the **Tags** field):<ul><li>`true`: multiple values can be specified in the field.</li><li>`false`: Only one value can be specified in the field.</li></ul>This parameter can be used for the following types of fields:<ul><li>`ru.yandex.startrek.core.fields.StringFieldType`: Single-line text field.</li><li>`ru.yandex.startrek.core.fields.UserFieldType`: Username.</li><li>Drop-down list (see the description for `optionsProvider`).</li></ul> | Boolean |

**Object fields** `optionsProvider` {#optionsProvider1}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| type | Drop-down list type: <ul><li>`FixedListOptionsProvider`: List of string or numeric values (for `ru.yandex.startrek.core.fields.StringFieldType` or `ru.yandex.startrek.core.fields.IntegerFieldType` type fields).</li><li>`FixedUserListOptionsProvider`: List of users (for `ru.yandex.startrek.core.fields.UserFieldType` type fields).</li></ul> | String |
| values | Values for the drop-down list. | Array of strings |

> Example: Let's create a <q>Drop-down list</q> type local field with a fixed set of string values.
>- An HTTP POST method is used.
>- A local field for the QUEUE-TEST queue is created.
>- Field type: `FixedListOptionsProvider`.
>- Values in the drop-down list: <q>list item 1</q>, <q>list item 2</q>, <q>list item 3</q>.
>```json
>POST /v2/queues/QUEUE-TEST/localFields
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>X-Org-Id: <organization ID>
>
>{
>   "name":
>   {
>       "en": "Name in English",
>       "ru": "Name in Russian"
>   },
>   "id": "loc_field_key",
>   "category": "000000000000000000000003",
>   "type": "ru.yandex.startrek.core.fields.StringFieldType",
>   "optionsProvider": {
>       "type": "FixedListOptionsProvider",
>       "values": [
>           "list item 1",
>           "list item 2",
>           "list item 3"
>       ]
>   },
>}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code `200 OK`.

    The response body contains information about the local queue field in JSON format.

    ```json
     {
        "type": "local",
        "self": "https://api.tracker.yandex.net/v2/queues/ORG/localFields/loc_field_key",
        "id": "6054ae3a2b6b2c7f80bb9a93--loc_field_key",
        "name": "Field name in Russian",
        "description": "Description of the local field",
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
            "self": "https://api.tracker.yandex.net/v2/fields/categories/000000000000000000000003",
            "id": "000000000000000000000003",
            "display": "category_name"
        }    
     }
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | type | Field type. | String |
    | self | Address of the API resource with information about the field. | String |
    | id | Unique field ID. | String |
    | name | Field name. | String |
    | description | Field description. | String |
    | key | Field key. | String |
    | version | Field version. Each change to the field increases the version number. | Number |
    | [schema](#schema) | Object with information about the field value's data type. | Objects |
    | readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable.</li><li>`false`: Editable.</li></ul> | Boolean |
    | options | Shows if the list of values is restricted:<ul><li>`true`: The list of values is not restricted, you can set any value.</li><li>`false`: The list of values is restricted by the organization's settings.</li></ul> | Boolean |
    | suggest | Enables/disables search suggestions when entering field values:<ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> | Boolean |
    | [optionsProvider](#optionsProvider) | Object with information about drop-down list items. | Objects |
    | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You can't change the class using the API. | Objects |
    | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
    | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Objects |

    **Object fields** `schema` {#schema}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Field value type. Possible data types:<ul><li>`string`: String Available for fields with a single value.</li><li>`array`: Array Available for fields with multiple values.</li></ul> | String |
    | items | Value type. Available for fields with multiple values. | String |
    | required | Shows if the field is required:<ul><li>`true`: Required.</li><li>`false`: Optional.</li></ul> | Boolean |

     **Object fields** `optionsProvider` {#optionsProvider}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Type of the drop-down list. | String |
    | needValidation | Checking values for validity:<ul><li>`true`: Check a list value for validity.</li><li>`false`: Don't check a list value for validity.</li></ul> | Boolean |
    | values | List items. | Array of strings |

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

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    400
    : One or more request parameters have an invalid value.

    401
    : The user isn't authorized. Make sure that actions described in the [API access](../access.md) section are performed.

    403
    : The user or application doesn't have permission to access the resource, the request is rejected.

    404
    : The requested object is not found. You may have specified an invalid object ID or key.

    422
    : Validation error. The request body may contain an invalid or non-existent parameter.

    500
    : Internal service error. Try resending your request in a few minutes.

    503
    : The API service is temporarily unavailable.

{% endlist %}

