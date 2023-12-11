---
title: "How to edit possible issue field values in {{ tracker-full-name }}"
description: "In this tutorial, you will learn how to edit possible issue field values in {{ tracker-name }}."
sourcePath: en/tracker/api-ref/concepts/issues/patch-issue-field-value.md
---

# Editing possible issue field values

## Request format {#section_kty_1vh_4gb}

To edit possible values of an issue field, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/fields/<field-id>?version=<field-version>
Host: {{ host }}
Authorization: OAuth <token>
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
    "hidden": false,
    "visible": false,
    "optionsProvider":
      {
       "type": "FixedListOptionsProvider",
       "values":
          ["value 1", "value 2"]
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

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Local field name<ul><li>`en`: In English.</li><li>`ru`: In Russian</li></ul> | String |
| category | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | String |
| order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
| description | Field description | String |
| readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable</li><li>`false`: Editable</li></ul> | Logical |
| hidden | Indicates if the field should be hidden in the interface:<ul><li>`true`: Hide the field even if it is not empty</li><li>`false`: Do not hide the field</li></ul> | Logical |
| visible | Indicates if the field is visible in the interface:<ul><li>`true`: Always visible</li><li>`false`: Not visible</li></ul> | Logical |
| [optionsProvider](#optionsProviderParam) | Object with information about allowed field values. | Objects |

**Object fields** `optionsProvider` {#optionsProviderParam}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| type | Type of field values. | String |
| values | Array of field values. | Array |

{% endcut %}

## Response format {#section_dcj_mx3_4gb}

{% list tabs %}

- The request is executed successfully

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
    | id | Field ID | String |
    | name | Field name | String |
    | description | Field description | String |
    | version | Field version; each change to the field increases the version number | Number |
    | [schema](#schema) | Object with information about the field value's data type | Objects |
    | readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable</li><li>`false`: Editable</li></ul> | Logical |
    | options | Shows if the list of values is restricted:<ul><li>`true`: The list of values is not restricted, you can set any value</li><li>`false`: The list of values is restricted by the organization's settings</li></ul> | Logical |
    | suggest | Enables/disables search suggestions when entering field values:<ul><li>`true`: Enabled</li><li>`false`: Disabled</li></ul> | Logical |
    | [suggestProvider](#suggestProvider) | Object with information about the search suggestion class.<br/>You cannot change the class using the API. | Objects |
    | [optionsProvider](#optionsProvider) | Object with information about allowed field values. | Objects |
    | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You cannot change the class using the API | Objects |
    | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
    | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Objects |

    **Object fields** `schema` {#schema}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | type | Field value type Possible data types:<ul><li>`string`: String; available for fields with a single value</li><li>`array`: Array; available for fields with multiple values</li></ul> | String |
    | items | Value type; available for fields with multiple values | String |
    | required | Shows if the field is required:<ul><li>`true`: Required</li><li>`false`: Optional</li></ul> | Logical |

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
    | type | Query language type | String |

    **Object fields** `category` {#category}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the field category | String |
    | id | Field category ID | String |
    | display | Category name displayed | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-412.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-428.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
