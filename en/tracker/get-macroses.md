---
sourcePath: en/tracker/api-ref/get-macroses.md
---
# Getting queue macros

Use this request to get parameters of all macros in a queue.

## Request format {#section_df4_vmc_rfb}

Before making the request, [get permission to access the API](concepts/access.md).

To get parameters of all macros in a queue, use an HTTP `GET` request:

```json
GET /{{ ver }}/queues/<queue-id>/macros
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id> | Queue ID or key. The queue key is case-sensitive. | String |

{% endcut %}

## Response format {#section_agg_zpc_rfb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON array with the parameters of all queue macros.

    ```json
    [
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
        "body": "Test message\nnot_var{{currentUser}}not_var{{currentDateTime.date}}not_var{{currentDateTime}}\nnot_var{{issue.author}}",
        "fieldChanges": [
          {
            "field": {
               "self": "{{ host }}/v2/fields/tags", 
               "id": "tags",
               "display": "Tags"
              },
            "value": [
                    "tag1", "tag2"
                     ]
          },
           ...
        ]
      },
       ...
    ]
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource with macro parameters. | String |
    | id | Macro ID. | Number |
    | [queue](#queue) | Object with information about the queue whose issues that the macro is applied to. | Object |
    | name | Macro name. | String |
    | body | [Message](manager/create-macroses.md) to be created when executing the macro. Format: `<Message text>\n<variable>`<br/>Where:<ul><li> `<Message text>`: Text to be created in the **Comment** field when executing the macro.</li><li> `\n`: Line break symbol.</li><li> Variable that may contain:<br/>`not_var{{currentUser}}`: Name of the user who ran the macro.<br/>`not_var{{currentDateTime.date}}`: Macro execution date.<br/>`not_var{{currentDateTime}}`: Macro execution date and time.<br/>`{{issue.<field_key>}}`: Key of the issue field to be displayed in the message. Full list of issue fields: [https://tracker.yandex.ru/admin/fields]({{ link-admin-fields }})</li></ul>To delete the message, use the construction `"body": {"unset":1}` | String |

    `queue` **object fields** {#queue}

    {% include [queue](../_includes/tracker/api/queue.md) %}

    `fieldChanges` **array objects** {#fieldChanges}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | [field](#field) | Object with information about the issue field. | Object |
    | value | Array of issue field values. | Array of objects |

    `field` **object fields** {#field}

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

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}