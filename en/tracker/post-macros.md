---
sourcePath: en/tracker/api-ref/post-macros.md
---
# Creating a macro

Use this request to create [macros](manager/create-macroses.md).

## Request format {#section_sw2_w4f_sfb}

Before making the request, [get permission to access the API](concepts/access.md).

To create a macro, use an HTTP `POST` request:

```json
POST /{{ ver }}/queues/<queue_key_or_ID>/macros
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
  "name": "<macro_name>",
  "body": "<comment_text>\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
  "fieldChanges": [
    {
      "field": "<issue_field_ID>",
      "value": "<issue_field_value>"
    },
     ...
  ]
}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<queue_ID_or_key> | Queue ID or key. The queue key is case-sensitive. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Value | Data type |
----- | ----- | -----
| name | Macro name. | String |

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| body | Message to be created when executing the macro. Use a [special format](common-format.md#text-format) for the message text.<br/>To delete a message, use `"body": {"unset":1}` | String |
| [fieldChanges](#fieldChanges) | Array with information about the issue fields that the macro will trigger changes to. | Array of objects |

**fieldChanges** `array objects` {#fieldChanges}

| Parameter | Description | Data type |
-------- | -------- | ----------
| field | Issue field ID.<br/><br/>[Full list of issue fields]({{ link-admin-fields }}) | String |
| value | Issue field value. | String |

{% endcut %}

## Response format {#section_ibd_4yf_sfb}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON object with the parameters of the created macro.

   ```json
     {
       "self": "https://{{ host }}/v2/queues/TEST/macros/3",
       "id": 3,
       "queue": {
         "self": "https://{{ host }}/v2/queues/TEST",
         "id": "1",
         "key": "TEST",
         "display": "Test queue"
          },
       "name": "Test macro",
       "body": "Test comment\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
       "fieldChanges": [
         {
           "field": {
              "self": "https://{{ host }}/v2/fields/tags",
              "id": "tags",
              "display": "Tags"
             },
           "value": [
                   "tag1"
                    ]
         },
          ...
       ]
     }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with macro parameters. | String |
   | id | Macro ID. | Number |
   | [queue](#queue) | Object with information about the queue whose issues that the macro is applied to. | Object |
   | name | Macro name. | String |
   | body | Message to be created when executing the macro. | String |
   | [fieldChanges](#fieldChanges) | Array with information about the issue fields that the macro will trigger changes to. | Array of objects |

   `queue` **object fields** {#queue}

   {% include [queue](../_includes/tracker/api/queue.md) %}

   `fieldChanges` **object fields** {#fieldChanges}

   | Parameter | Description | Data type |
   -------- | -------- | ----------     
   | [field](#field) | Object with information about the issue field. | Object |
   | value | Array of issue field values. | Array of objects |

   `field` **object fields** {#field}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the issue field. | String |
   | id | Issue field ID. | String |
   | display | Issue field name displayed. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-409](../_includes/tracker/api/answer-error-409.md) %}

   {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

   {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}