---
sourcePath: en/tracker/api-ref/concepts/queues/get-info-local-field.md
---
# Getting information about a local queue field

Use this request to get information about a [local issue field](../../local-fields.md) linked to a given queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get information about a local queue field, use an HTTP `GET` request:

```json
GET /{{ ver }}/queues/<queue_ID_or_key>/localFields/<filed_key>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<queue_ID_or_key\> | Queue ID or key. The queue key is case-sensitive. | String |
| \<field_key> | Local field key. <br/>To get the key, use this HTTP [request](get-local-fields.md):<br/>`GET /v2/queues/<queue_ID_or_key>/localFields` | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the local queue field in JSON format.

   ```json
    {
       "type": "local",
       "self": "https://{{ host }}/v2/queues/ORG/localFields/loc_field_key",
       "id": "6054ae3a2b6b2c7f********--loc_field_key",
       "name": "loc_field_name",
       "description": "local field description",
       "key": "loc_field_key",
       "version": 1,
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
             "List item 1",
             "List item 2",
             "List item 3"
            ]
         },
       "queryProvider": {
           "type": "StringOptionalQueryProvider"
       },
       "order": 3,
       "category": {
           "self": "https://{{ host }}/v2/fields/categories/0000000000000001********",
           "id": "0000000000000001********",
           "display": "System"
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
   ----- | ----- | -----
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
   | [queryProvider](#queryProvider) | Object with information about the query language class.<br/>You cannot change the class using the API. | Object |
   | order | Sequence number in the list of organization fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Number |
   | [category](#category) | Object with information about the field category.<br/>To get a list of all categories, use the HTTP request:<br/>`GET /v2/fields/categories` | Object |
   | [queue](#queue) | Object with information about the issue queue. | Object |


   `schema` **object fields** {#schema}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | type | Field value type Possible data types:<ul><li>`string`: String; available for fields with a single value</li><li>`array`: Array; available for fields with multiple values</li></ul> | String |
   | items | Value type; available for fields with multiple values | String |
   | required | Shows if the field is required:<ul><li>`true`: Required</li><li>`false`: Optional</li></ul> | Logical |

   `optionsProvider` **object fields** {#optionsProvider}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | type | Type of drop-down list | String |
   | needValidation | Indicates if a list value requires validation:<ul><li>`true`: Yes</li><li>`false`: Do not validate the field value</li></ul> | Logical |
   | values | Drop-down list values | Array of strings |


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

   `queue` **object fields** {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   {% endcut %}


- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}