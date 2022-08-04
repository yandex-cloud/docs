# Create a macro

Use this request to create [macros](manager/create-macroses.md).

## Request format {#section_sw2_w4f_sfb}

Before making the request, [get permission to access the API](concepts/access.md).

To create a macro, use an HTTP `POST` request:

```json
POST /{{ ver }}/queues/<queue-id>/macros
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
  "name": "Test macro",
  "body": "Test comment\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
  "fieldChanges": [
    {
      "field": "tags",
      "value": "tag1"
    }, 
     ...
  ]
}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id> | Queue ID or key. The queue key is case-sensitive. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| name | Macro name. | String |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| body | Message to be created when executing the macro. Use [special formatting](common-format.md#text-format) to format your message.<br/>To delete a message, use the `"body": {"unset":1}` string. | String |
| [fieldChanges](#fieldChanges) | Array with information about the issue fields that the macro will trigger changes to. | Array of objects |

**Array objects** `fieldChanges` {#fieldChanges}

Parameter | Description | Data type
-------- | -------- | ----------
field | Issue field ID.<br/><br/>[Full list of issue fields]({{ link-admin-fields }}) | String
value | Issue field value. | String

{% endcut %}

## Response format {#section_ibd_4yf_sfb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with the parameters of the created macro.

    ```json
      {
        "self": "{{ host }}/v2/queues/TEST/macros/3",
        "id": 3,
        "queue": {
          "self": "{{ host }}/v2/queues/TEST", 
          "id": "1",
          "key": "TEST",
          "display": "Test queue"
           },
        "name": "Test macro",
        "body": "Test comment\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
        "fieldChanges": [
          {
            "field": {
               "self": "{{ host }}/v2/fields/tags", 
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
    | ----- | ----- | ----- |
    | self | Address of the API resource with macro parameters. | String |
    | id | Macro ID. | Number |
    | [queue](#queue) | Object with information about the queue whose issues that the macro is applied to. | Object |
    | name | Macro name. | String |
    | body | Message to be created when executing the macro. | String |
    | [fieldChanges](#fieldChanges) | Array with information about the issue fields that the macro will trigger changes to. | Array of objects |

    **Object fields** `queue`{#queue}

    {% include [queue](../_includes/tracker/api/queue.md) %}

    **Object fields** `fieldChanges` {#fieldChanges}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | [field](#field) | Object with information about the issue field. | Object |
    | value | Array of issue field values. | Array of objects |

    **Object fields** `field` {#field}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
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

