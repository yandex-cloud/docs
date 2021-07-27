---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Edit a local queue field

Use this request to edit an issue [local field](../../local-fields.md) linked to the specified queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To edit a local field, use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format:

```json
PATCH /{{ ver }}/queues/<queue-id>/localFields/<field-key>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

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

**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String |
| \<field-key\> | Local field key.<br/>To get the key, use this HTTP [request](get-local-fields.md):<br/>`GET /v2/queues/<queue-id>/localFields`. | String |

### Request body parameters {#req-body-params}

The request body contains the information needed to edit the local field. There are no required parameters.

#### Advanced settings

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Name of a local field:<ul><li>`en` — In English.</li><li>`ru` — In Russian.</li></ul> | String |
| category | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | String |
| order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}). | Number |
| description | Description of the local field. | String |
| readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable.</li><li>`false`: Editable.</li></ul> | Boolean |
| visible | Flag that indicates if the field is shown in the interface:<ul><li>`true`: Always show the field in the interface.</li><li>`false`: Don't show the field in the interface.</li></ul> | Boolean |
| hidden | Flag that indicates if the field is visible in the interface:<ul><li>`true`: Hide the field even if it's filled in.</li><li>`false`: Don't hide the field.</li></ul> | Boolean |

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
        "description": "Field description",
        "key": "loc_field_key",
        "version": 2,
        "schema": {
            "type": "date",
            "required": false
        },
        "readonly": true,
        "options": false,
        "suggest": false,
        "queryProvider": {
             "type": "DateOptionalQueryProvider"
        },
        "order": 102, 
        "category": {
            "self": "https://api.tracker.yandex.net/v2/fields/categories/000000000000000000000002",
            "id": "000000000000000000000002",
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

    422
    : Validation error. The request body may contain an invalid or non-existent parameter.

    500
    : Internal service error. Try resending your request in a few minutes.

    503
    : The API service is temporarily unavailable.

{% endlist %}