# Edit issue field names

## Request format {#section_v3n_hbv_ngb}

To change an issue field's name, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/fields/<field-id>?version=<field-version>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
  "name":
      {
       "en":"en_name",
       "ru":"ru_name"
      }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<field-id\> | Issue field ID. | String |
| \<field-version\> | Issue field version. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Object with information about the issue field name. | Object |

**Object fields** `name`

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| en | Field name in English. | String |
| ru | Field name in Russian. | String |

{% endcut %}

## Response format {#section_zfh_25v_ngb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with all issue field parameters.

    ```json
    {
        "self": "{{ host }}/v2/fields/ruName",
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
            "self": "{{ host }}/v2/fields/categories/58bc3b921d9c7d68164e",
            "id": "58bc3b921d9c7d68164e",
            "display": "System"
        }
    }
    ```

    {% cut "Response parameters" %}

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
    | type | Field value type. Possible data types:<ul><li>`string`: String. Available for fields with a single value.</li><li>`array`: Array. Available for fields with multiple values.</li></ul> | String |
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

    {% endcut %}

- Request failed

    If a request fails, the response message contains details of the errors encountered:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-412.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-428.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

