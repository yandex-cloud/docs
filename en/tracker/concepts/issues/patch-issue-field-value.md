---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Edit possible values of issue fields

## Request format {#section_kty_1vh_4gb}

To edit possible values of an issue field, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/fields/<field-id>?version=<field-version>
Host: {{ host }}
Authorization: OAuth <token> 
X-Org-ID: <organization ID>

{"optionsProvider":
      {"type": "FixedListOptionsProvider",
       "values": 
          ["value 1", "value 2"]
      }
}
```

#### Resource {#req-resource}

- **\<field-id\>**

    Issue field ID.

- **\<field-version\>**

    Issue field version.

#### Headers {#req-headers}

- **Host**

    Address of the node that provides the API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Organization ID.

#### Request body {#req-body-params}

The request body contains parameters for new field values.

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| optionsProvider | Object with information about allowed field values. | Object |

**Object fields** `optionsProvider`

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| type | Type of field values. | String |
| values | Array of field values. | Array |

## Response format {#section_dcj_mx3_4gb}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 200. The response body contains a JSON object with all issue field parameters.

    ```json
    {
        "self": "https://api.tracker.yandex.net/v2/fields/ruName",
        "id": "ruName",
        "name": "ru_name",
        "description": "description text",
        "version": 3,
        "schema": {
            "type": "array",
            "items": "string",
            "required": false
        },
        "readonly": false,
        "options": true,
        "suggest": true,
        "suggestProvider": {
            "type": "UserSuggestProvider"
        },
        "optionsProvider": {
            "type": "FixedListOptionsProvider",
            "values": [
                "value 1",
                "value 2"
            ]
        },
        "queryProvider": {
            "type": "StringOptionalQueryProvider"
        },
        "order": 14,
        "category": {
            "self": "https://api.tracker.yandex.net/v2/fields/categories/58bc3b921d9c7d68164e",
            "id": "58bc3b921d9c7d68164e",
            "display": "System"
        }
    }
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the issue field. | String |
    | id | Field ID. | String |
    | name | Field name. | String |
    | description | Field description. | String |
    | version | Field version. Each change to the field increases the version number. | Number |
    | [schema](#schema) | Object with information about the field value's data type. | Object |
    | readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable.</li><li>`false`: Editable.</li></ul> | Boolean |
    | options | Shows if the list of values is restricted:<ul><li>`true`: The list of values is not restricted, you can set any value.</li><li>`false`: The list of values is restricted by the organization's settings.</li></ul> | Boolean |
    | suggest | Enables/disables search suggestions when entering field values:<ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> | Boolean |
    | [suggestProvider](#suggestProvider) | Object with information about the search suggestion class.<br/>You can't change the class using the API. | Object |
    | [optionsProvider](#optionsProvider) | Object with information about allowed field values. | Object |
    | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You can't change the class using the API. | Object |
    | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
    | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Object |

    **Object fields** `schema` {#schema}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Field value type. Possible data types:<ul><li>`string`: String Available for fields with a single value.</li><li>`array`: Array Available for fields with multiple values.</li></ul> | String |
    | items | Value type. Available for fields with multiple values. | String |
    | required | Shows if the field is required:<ul><li>`true`: Required.</li><li>`false`: Optional.</li></ul> | Boolean |

    **Object fields** `suggestProvider` {#suggestProvider}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Search suggestion class. | String |

    **Object fields** `optionsProvider` {#optionsProvider}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Type of field values. | String |
    | values | Array of field values. | Array |

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

    If the request is processed incorrectly, the API returns a message with error details:

    | HTTP error code | Error description |
    | --------------- | --------------- |
    | 400 Bad Request | One of the request parameters has an invalid value or data format. |
    | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
    | 404 Not Found | The requested resource not found. |
    | 412 Precondition Failed | Invalid header value. |
    | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
    | 428 Precondition Required | A header is required. |
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

