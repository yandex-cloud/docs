---
sourcePath: en/tracker/api-ref/concepts/queues/create-queue.md
---
# Creating a queue

Use this request to create queues.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create a queue, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```
POST /{{ ver }}/queues/
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "key": "DESIGN",
    "name": "Design",
    "lead": "artemredkin",
    "defaultType": "task",
    "defaultPriority": "normal",
    "issueTypesConfig":[
                {"issueType":"task",
                  "workflow":"oicn",
                  "resolutions":["wontFix",...]},
  ...
  ]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| key | Queue key | String |
| name | Queue name | String |
| lead | Username or ID of the queue owner | String |
| defaultType | ID or key of the default issue type | String |
| defaultPriority | ID or key of the default issue priority | String |
| [issueTypesConfig](#issue-types-config) | Array with settings of queue issue types | Array of objects |

`issueTypesConfig` **array object fields** {#issue-types-config}

| Parameter | Description | Data type |
----- | ----- | -----
| issueType | Key of the issue type | String |
| workflow | Workflow ID | String |
| resolutions | Array with the IDs or keys of possible resolutions | Array |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

   The request body contains information about the created queue in JSON format.

   ```json
   {
          "self": "https://{{ host }}/v2/queues/DESIGN",
          "id": "111",
          "key": "DESIGN",
          "version": 1400150916068,
          "name": "Design",
          "lead": {
             "self": "https://{{ host }}/v2/users/1120000000004859",
             "id": "artemredkin",
             "display": "Artem Redkin"
       },
          "assignAuto": false,
          "allowExternals" : false,
          "defaultType": {
             "self": "https://{{ host }}/v2/issuetypes/2",
             "id": "2",
             "key": "task",
             "display": "Task"
      },
          "defaultPriority": {
             "self": "https://{{ host }}/v2/priorities/2",
             "id": "2",
             "key": "normal",
             "display": "Normal"
     }
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Queue link | String |
   | id | Queue ID | Number in string format |
   | key | Queue key | String |
   | version | Queue version. Each change to the queue increases its version number. | Number |
   | name | Queue name | String |
   | [lead](#lead) | Block with information about the queue owner | Object |
   | assignAuto | Automatically assign new issues in the queue:<ul><li>`true`: Assign</li><li>`false`: Do not assign</li></ul> | Logical |
   | allowExternals | Allow sending emails to external addresses. Acceptable values include:<ul><li>`true`: Enable.</li><li>`false`: Disable.</li></ul> | Logical |
   | [defaultType](#default-type) | Block with information about the default issue type | Object |
   | [defaultPriority](#default-priority) | Block with information about the default issue priority | Object |

   {% include [user](../../../_includes/tracker/api/user.md) %}

   `defaultType` **object fields** {#default-type}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue type | String |
   | id | ID of the issue type | String |
   | key | Key of the issue type | String |
   | display | Issue type name displayed | String |

   `defaultPriority` **object fields** {#default-priority}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the priority type | String |
   | id | Priority ID | String |
   | key | Priority key | String |
   | display | Priority name displayed | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a message with error details:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

   {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

   {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

   {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}