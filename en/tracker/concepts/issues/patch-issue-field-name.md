---
title: How to edit an issue field name in {{ tracker-full-name }}
description: In this tutorial, you will learn how to edit an issue field name in {{ tracker-name }}.
sourcePath: en/tracker/api-ref/concepts/issues/patch-issue-field-name.md
---

# Editing an issue field name

## Request format {#section_v3n_hbv_ngb}

To change an issue field name, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/fields/<field_ID>?version=<field_version>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
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
--- | --- | ---
| \<field_ID\> | Issue field ID. | String |
| \<field_version\> | Issue field version. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| name | Object with information about the issue field name. | Object |

`name` **object fields**

| Parameter | Description | Data type |
-------- | -------- | ----------
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
       "self": "https://{{ host }}/v2/fields/ruName",
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
           "self": "https://{{ host }}/v2/fields/categories/58bc3b921d9c********",
           "id": "58bc3b921d9c********",
           "display": "System"
       }
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the issue field. | String |
   | id | Field ID | String |
   | name | Field name | String |
   | description | Field description | String |
   | version | Field version; each change to the field increases the version number | Number |
   | [schema](#schema) | Object with information about the field value's data type | Object |
   | readonly | Shows if the field value is editable:<ul><li>`true`: Non-editable</li><li>`false`: Editable</li></ul> | Logical |
   | options | Shows if the list of values is restricted:<ul><li>`true`: The list of values is not restricted, you can set any value</li><li>`false`: The list of values is restricted by the organization's settings</li></ul> | Logical |
   | suggest | Enables/disables search suggestions when entering field values:<ul><li>`true`: Enabled</li><li>`false`: Disabled</li></ul> | Logical |
   | [suggestProvider](#suggestProvider) | Object with information about the search suggestion class.<br/>You cannot change the class using the API. | Object |
   | [optionsProvider](#optionsProvider) | Object with information about allowed field values. | Object |
   | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You cannot change the class using the API. | Object |
   | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
   | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Object |

   `schema` **object fields** {#schema}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | type | Field value type Possible data types:<ul><li>`string`: String; available for fields with a single value</li><li>`array`: Array; available for fields with multiple values</li></ul> | String |
   | items | Value type; available for fields with multiple values | String |
   | required | Shows if the field is required:<ul><li>`true`: Required</li><li>`false`: Optional</li></ul> | Logical |

   `suggestProvider` **object fields** {#suggestProvider}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | type | Search suggestion class. | String |

   `optionsProvider` **object fields** {#optionsProvider}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | type | Type of field values. | String |
   | values | Array of field values. | Array |

   `queryProvider` **object fields** {#queryProvider}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | type | Query language type | String |

   `category` **object fields** {#category}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
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
