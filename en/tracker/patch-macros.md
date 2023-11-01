---
sourcePath: en/tracker/api-ref/patch-macros.md
---
# Edit a macro

Use this request to edit macro parameters.

## Request format {#section_a32_zrg_sfb}

Before making the request, [get permission to access the API](concepts/access.md).

To edit macro parameters, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/queues/<queue-id>/macros/<macros-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
  "name": "Test macro 1",
  "body": "Test comment\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
  "fieldChanges": <Object or array>
}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<queue-id> | Queue ID or key. The queue key is case-sensitive. | String |
| \<macros-id> | Macro ID. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| name | Macro name. | String |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| body | [Message](manager/create-macroses.md) to be created when executing the macro. Format: ``` <Message text>\n<variable> ```<br/>where:<ul><li> `<Message text>`: Text to be created in the **Comment** field when executing the macro.</li><li>``\n``: Line break symbol.</li><li>Variable that may contain:<br/>`not_var{{currentUser}}`: Name of the user who ran the macro. <br/>`not_var{{currentDateTime.date}}`: Macro execution date.<br/> `not_var{{currentDateTime}}`: Macro execution date and time.<br/> `{{issue.<field_key>}}`: Key of the issue field to be displayed in the message. Full list of issue fields: [https://tracker.yandex.ru/admin/fields]({{ link-admin-fields }})</li></ul>To delete a message, use the construction `"body": {"unset":1}` | String |
| fieldChanges | Object or array with new settings for macro actions. The object structure may vary depending on the type of [changes](#dl_qnp_vhm_5fb). | Object or array |

**Object structure** `fieldChanges` {#fieldChanges}

{% list tabs %}

- Add new action

  Add a macro action. Use the `add` parameter to add a field and its value to the list of available fields.

    ```json
    "fieldChanges": {
          "add": [
                   {
              "field": "tags", 
              "value": "tag2"
                   },
                    ...
                  ]
    ```

  **Request body**

  Parameter | Description | Data type
  ----- | ----- | -----
  [fieldChanges](#fieldChanges) | Object with new settings for macro actions. | Object

  **Array object** `fieldChanges` {#fieldChanges}
  Parameter | Description | Data type
  ----- | ----- | -----
  [add](#add) | Array with new macro action's parameters. | Array

  **Array objects** `add` {#add}
  Parameter | Description | Data type
  ----- | ----- | -----
  field | Issue field ID.<br/><br/>[Full list of issue fields]({{ link-admin-fields }}) | String
  value | Issue field value. | String

- Replace an action

  Replace a macro action with a new one. Use the `replace` parameter to replace a field and its value, which are set using the `target` parameter, with new ones using the `replacement` parameter.

    ```json
    "fieldChanges": {
             "replace": [
                          {
                    "target": {
                        "field": "tags", 
                        "value": "tag2"
                              }, 
                    "replacement": {
                        "field": "originalEstimation", 
                        "value": "PT2H"
                                    }
                            }
                          ]
    }
    ```

  **Request body**

  Parameter | Description | Data type
  ----- | ----- | -----
  [fieldChanges](#fieldChanges) | Object with new settings for macro actions. | Object

  **Object parameters** `fieldChanges` {#fieldChanges}
  Parameter | Description | Data type
  ----- | ----- | -----
  [replace](#replace) | Array with action parameters to be replaced with new ones. | Array

  **Object array** `replace` {#replace}
  Parameter | Description | Data type
  ----- | ----- | -----
  [target](#target-replacement) | Object with action parameters to be replaced. | Object
  [replacement](#target-replacement) | Object with new action parameters. | Object

  **Object parameters** `target` and `replacement` {#target-replacement}
  Parameter | Description | Data type
  ----- | ----- | -----
  field | Issue field ID.<br/><br/>[Full list of issue fields]({{ link-admin-fields }}) | String
  value | Issue field value. | String

- Replace all actions

  Replace all macro actions with new ones. Only the fields and values specified in the array are retained.

    ```json
    "fieldChanges": [
                              {
                 "field": "tags", 
                 "value": "tag2"
                              },
                              ...
    ]
    ```

  **Request body**

  Parameter | Description | Data type
  ----- | ----- | -----
  [fieldChanges](#fieldChanges) | Object or array with new settings for macro actions. | Object or array

  **Array parameters** `fieldChanges`{#fieldChanges}
  Parameter | Description | Data type
  ----- | ----- | -----
  field | Issue field ID.<br/><br/>[Full list of issue fields]({{ link-admin-fields }}) | String
  value | Issue field value. | String

- Remove an action

  Remove a macro action. You can use the `replace` parameter to remove a field and its value.

    ```json
    "fieldChanges": {
             "remove": [ 
                        {
                      "field": "tags", 
                      "value": "tag2"
                         },
                          ...
                        ]
    }
    ```

  **Request body**

  Parameter | Description | Data type
  ----- | ----- | -----
  [fieldChanges](#fieldChanges) | Object with new settings for macro actions. | Object

  **Object field** `fieldChanges`

  Parameter | Description | Data type
  ----- | ----- | -----
  [remove](#remove) | Array with information about the fields and values of the macro action to remove. | Array

  **Array parameters** `remove` {#remove}
  Parameter | Description | Data type
  ----- | ----- | -----
  field | Issue field ID.<br/><br/>[Full list of issue fields]({{ link-admin-fields }}) | String
  value | Issue field value. | String

{% endlist %}

{% endcut %}

## Response format {#section_evq_j5l_sfb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with all macro parameters, including the updated ones.

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
        "name": "Test macro 1",
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
    | body | [Message](manager/create-macroses.md) to be created when executing the macro. Format: ``` <Message text>\n<variable> ```<br/>where:<ul><li> `<Message text>`: Text to be created in the **Comment** field when executing the macro.</li><li> ``\n``: Line break symbol.</li><li> Variable that may contain:<br/>`not_var{{currentUser}}`: Name of the user who ran the macro.<br/> `not_var{{currentDateTime.date}}`: Macro execution date. <br/>`not_var{{currentDateTime}}`: Macro execution date and time.<br/>`{{issue.<field_key>}}`: Key of the issue field to be displayed in the message. Full list of issue fields: [https://tracker.yandex.ru/admin/fields]({{ link-admin-fields }})</li></ul>To delete the message, use the construction `"body": {"unset":1}` | String |
    | [fieldChanges](#fieldChanges) | Array with information about the issue fields that the macro will trigger changes to. | Array of objects |

    **Object fields** `queue` {#queue}

    {% include [queue](../_includes/tracker/api/queue.md) %}

    **Array objects** `fieldChanges` {#fieldChanges}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | [field](#field) | Object with information about the issue field. | Object |
    | value | Array of issue field values. | Array of objects |

    **Object fields** `field` {#field}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource with information about the issue field. | String |
    | id | Issue field ID. | String |
    | display | Issue field name displayed. | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-422](../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

