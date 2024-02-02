---
sourcePath: en/tracker/api-ref/concepts/queues/get-queue.md
---
# Getting queue parameters

Use this request to get information about a queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get queue information, use an HTTP `GET` request.

```
GET /v2/queues/<queue-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| expand | Additional fields to include in the response. The possible values include:<ul><li>`all`: All additional fields of the queue will be included in the response.</li><li>`projects`: Queue projects.</li><li>`components`: Queue components.</li><li>`versions`: Queue versions.</li><li>`types`: Issue types.</li><li>`team`: List of queue team members.</li><li>`workflows`: List of workflows.</li><li>`fields`: Required queue fields.</li><li>`issueTypesConfig`: Settings of queue issue types.</li></ul> | String |

{% endcut %}

> Example: Get queue information.
>
> - An HTTP `GET` method is used.
> - All additional fields are displayed in the response.
>
> ```
> GET /v2/queues/TEST?expand=all HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   ```json
   {
       "self": "https://{{ host }}/v2/queues/TEST",
       "id": "3",
       "key": "TEST",
       "version": 5,
       "name": "Test",
       "description": "Queue created for testing purposes",
       "lead": {
              "self": "https://{{ host }}/v2/users/1120000000016876",
              "id": "<employee ID>",
              "display": "<displayed employee name>"
       },
       "assignAuto": false,
       "defaultType": {
              "self": "https://{{ host }}/v2/issuetypes/1",
              "id": "1",
              "key": "bug",
              "display": "Error"
       },
       "defaultPriority": {
              "self": "https://{{ host }}/v2/priorities/3",
              "id": "3",
              "key": "normal",
              "display": "Normal"
       },
       "teamUsers": [
              {
                  "self": "https://{{ host }}/v2/users/1120000000016876",
                  "id": "<employee ID>",
                  "display": "<displayed employee name>"
              },
              ...
       ],
       "issueTypes": [
              {
                  "self": "https://{{ host }}/v2/issuetypes/1",
                  "id": "1",
                  "key": "bug",
                  "display": "Error"
              },
              ...
       ],
       "versions": [
              {
                  "self": "https://{{ host }}/v2/versions/4",
                  "id": "4",
                  "display": "Peek-a-boo"
           }
       ],
       "workflows": {
              "dev": [
                  {
                       "self": "https://{{ host }}/v2/issuetypes/1",
                       "id": "1",
                       "key": "bug",
                       "display": "Error"
                   },
                   ...
              ]
       },
       "denyVoting": false,
       "issueTypesConfig": [
              {
                  "issueType": {
                         "self": "https://{{ host }}/v2/issuetypes/1",
                         "id": "1",
                         "key": "bug",
                         "display": "Error"
               },
               "workflow": {
                         "self": "https://{{ host }}/v2/workflows/dev",
                         "id": "dev",
                         "display": "dev"
               },
               "resolutions": [
                      {
                         "self": "https://{{ host }}/v2/resolutions/2",
                         "id": "2",
                         "key": "wontFix",
                         "display": "Won't fix"
                      },
                   ...
               ]
           },
           ...
       ]
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
   | description | Text description of the queue | String |
   | [lead](#lead) | Block with information about the queue owner | Object |
   | assignAuto | Automatically assign new issues in the queue:<ul><li>`true`: Assign</li><li>`false`: Do not assign</li></ul> | Logical |
   | [defaultType](#default-type) | Block with information about the default issue type | Object |
   | [defaultPriority](#default-priority) | Block with information about the default issue priority | Object |
   | [teamUsers](#team-users) | Array with information about queue team members | Array of objects |
   | [issueTypes](#issue-types) | Array with information about queue issue types | Array of objects |
   | [versions](#versions) | Array with information about queue versions | Array of objects |
   | [workflows](#workflows) | List of queue workflows and their issue types | Array |
   | denyVoting | Flag that indicates if voting for issues is enabled | Logical |
   | [issueTypesConfig](#issue-types-config) | Array with queue issue settings | Array of objects |

   {% include [user](../../../_includes/tracker/api/user.md) %}

    **Object fields** `defaultType` {#default-type}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue type | String |
   | id | ID of the issue type | String |
   | key | Key of the issue type | String |
   | display | Issue type name displayed | String |

    **Object fields** `defaultPriority` {#default-priority}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the priority type | String |
   | id | Priority ID | String |
   | key | Priority key | String |
   | display | Priority name displayed | String |

    **Array object fields** `teamUsers` {#team-users}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the user | String |
   | id | User ID | String |
   | display | User name displayed | String |

    **Array object fields** `issueTypes` {#issue-types}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue type | String |
   | id | ID of the issue type | String |
   | key | Key of the issue type | String |
   | display | Issue type name displayed | String |

    **Array object fields** `versions` {#versions}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the queue version | String |
   | id | Version ID | String |
   | display | Version name displayed | String |

    **Array object fields** `workflows` {#workflows}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue type | String |
   | id | ID of the issue type | String |
   | key | Key of the issue type | String |
   | display | Issue type name displayed | String |

   `issueTypesConfig` **array object fields** {#issue-types-config}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | [issueType](#issue-type) | Block with information about the issue type | Object |
   | [workflow](#workflow) | Block with information about the issue type workflow | Object |
   | [resolutions](#resolutions) | Array with possible issue type resolutions | Array of objects |

    **Object fields** `issueType` {#issue-type}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue type | String |
   | id | ID of the issue type | String |
   | key | Key of the issue type | String |
   | display | Issue type name displayed | String |

    **Object fields** `workflow` {#workflow}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the workflow object | String |
   | id | Workflow ID | String |
   | display | Workflow name displayed | String |

    **Array object fields** `resolutions` {#resolutions}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the resolution object | String |
   | id | Resolution ID | String |
   | key | Resolution ID | String |
   | display | Resolution name displayed | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}