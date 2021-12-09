---
sourcePath: en/tracker/api-ref/concepts/queues/get-local-fields.md
---
# Get local queue fields

Use this request to get issue [local fields](../../local-fields.md) linked to the specified queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get local queue fields, use an HTTP `GET` request:

```json
GET /{{ ver }}/queues/<queue-id>/localFields
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String |

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code `200 OK`.

    The response body contains information about local queue fields in JSON format.

    ```json
     {
        "self": "https://api.tracker.yandex.net/v2/queues/ORG/localFields/loc_field_key",
        "id": "6054ae3a2b6b2c7f80bb9a93--loc_field_key",
        "name": "loc_field_name",
        "key": "loc_field_key",
        "version": 1,
        "schema": {
            "type": "string",
            "required": false
        },
        "readonly": false,
        "options": false,
        "suggest": false,
        "queryProvider": {
            "type": "StringOptionalQueryProvider"
        },
        "order": 3,
        "category": {
            "self": "https://api.tracker.yandex.net/v2/fields/categories/000000000000000000000001",
            "id": "000000000000000000000001",
            "display": "System"
        }     
     },
     ...
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource with information about the field. | String |
    | id | Unique field ID. | String |
    | name | Field name. | String |
    | key | Field key. | String |
    | version | Field version. Each change to the field increases the version number. | Number |
    | [schema](#schema) | Object with information about the field value's data type. | Object |
    | readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable.</li><li>`false`: Editable.</li></ul> | Boolean |
    | options | Shows if the list of values is restricted:<ul><li>`true`: The list of values is not restricted, you can set any value.</li><li>`false`: The list of values is restricted by the organization's settings.</li></ul> | Boolean |
    | suggest | Enables/disables search suggestions when entering field values:<ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> | Boolean |
    | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You can't change the class using the API. | Object |
    | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
    | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Object |

    **Object fields** `schema` {#schema}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Field value type. Possible data types:<ul><li>`string`: String Available for fields with a single value.</li><li>`array`: Array Available for fields with multiple values.</li></ul> | String |
    | items | Value type. Available for fields with multiple values. | String |
    | required | Shows if the field is required:<ul><li>`true`: Required.</li><li>`false`: Optional.</li></ul> | Boolean |

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

    500
    : Internal service error. Try resending your request in a few minutes.

    503
    : The API service is temporarily unavailable.

{% endlist %}

