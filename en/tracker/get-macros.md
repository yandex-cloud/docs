---
sourcePath: en/tracker/api-ref/get-macros.md
---
# Get a macro

Use this request to get macro parameters.

## Request format {#section_wls_kl2_sfb}

To get macro parameters, use an HTTP `GET` request:

```json
GET /{{ ver }}/queues/<queue-id>/macros/<macros-id>
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
```

#### Resource

- **\<queue-id\>**
Queue ID or key. Queue key is case-sensitive.

- **\<macros-id\>**
Macro ID.

#### Headers

- **Host**
Address of the node that provides the API:

   ```
   {{ host }}
   ```

- **Authorization**
OAuth token in `OAuth <token value>` format, such as:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**
Organization ID.

## Response format {#section_bhn_lv2_sfb}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code 200. The response body contains a JSON object with macro parameters.

    ```json
    {
        "self": "https://api.tracker.yandex.net/v2/queues/TEST/macros/3",
        "id": 3,
        "queue": {
          "self": "https://api.tracker.yandex.net/v2/queues/TEST", 
          "id": "1",
          "key": "TEST",
          "display": "Test queue"
           },
        "name": "Test macro",
        "body": "Test comment\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
        "fieldChanges": [
          {
            "field": {
               "self": "https://api.tracker.yandex.net/v2/fields/tags", 
               "id": "tags",
               "display": "Tags"
              },
            "value": [
                    "tag1", "tag2"
                     ]
          },
           ...
        ]
      }
    ```

  #### Response parameters {#answer-params}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with macro parameters. | String |
  | id | Macro ID. | Number |
  | [queue](#queue) | Object with information about the queue whose issues that the macro is applied to. | Object |
  | name | Macro name. | String |
  | body | [Message](manager/create-macroses.md#section_inq_5b1_x2b) to be created when executing the macro. Format: ``` <Message text>\n<variable> ```<br/>where:<ul><li> `<Message text>`: Text to be created in the **Comment** field when executing the macro.</li><li> ``\n``: Line break symbol.</li><li> Variable that may contain:<br/>`not_var{{currentUser}}`: Name of the user who ran the macro.<br/> `not_var{{currentDateTime.date}}`: Macro execution date. <br/>`not_var{{currentDateTime}}`: Macro execution date and time.<br/>`{{issue.<field_key>}}`: Key of the issue field whose value will be displayed in the message. Full list of issue fields: [https://tracker.yandex.ru/admin/fields]({{ link-admin-fields }})</li></ul>To delete the message, use the construction `"body": {"unset":1}` | String |
  | [fieldChanges](#fieldChanges) | Array with information about the issue fields that the macro will trigger changes to. | Array of objects |

  **Object fields** `queue` {#queue}

  Parameter | Description | Data type
  -------- | -------- | ----------
  self| Address of the API resource with information about the queue. | String
  id | Queue ID. | String
  key | Queue key. | String
  display | Queue name displayed. | String

  **Array objects** `fieldChanges` {#fieldChanges}

  Parameter | Description | Data type
  -------- | -------- | ----------
  [field](#field) | Object with information about the issue field. | Object
  value | Array with issue field values. | Array of objects

  **Object fields** `field` {#field}

  Parameter | Description | Data type
  -------- | -------- | ----------
  self | Address of the API resource with information about the issue field. | String
  id | Issue field ID. | String
  display | Issue field name displayed. | String

- Request failed

  If the request is processed incorrectly, the response contains error details:

  HTTP error code | Error description
  ----- | -----
  `400 Bad Request` | One of the request parameters has an invalid value or data format.
  `403 Forbidden` | The user or application has no access rights to the resource, the request is rejected.
  `404 Not Found` | The requested resource was not found.
  `500 Internal Server Error` | Internal service error. Try again later.
  `503 Service Unavailable` | The API service is temporarily unavailable.

{% endlist %}

