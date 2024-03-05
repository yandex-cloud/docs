---
sourcePath: en/tracker/api-ref/get-components.md
---
# Getting a list of components

The request enables you to get a list of all the [components](manager/components.md) created by the organization users.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To get all the components, use an HTTP `GET` request:

```
GET /v2/components
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON array with parameters for all components created by the organization's users.

   ```json
   [
     {
       "self": "https://{{ host }}/v2/components/1",
       "id": 1,
       "version": 3,
       "name": "Test",
       "queue": {
           "self": "https://{{ host }}/v2/queues/ORG",
           "id": "1",
           "key": "ORG",
           "display": "Organization"
       },
       "description": "<component_description>",
       "lead": {
              "self": "https://{{ host }}/v2/users/11********",
              "id": "11********",
              "display": "Ivan Ivanov"
           },
       "assignAuto": false
     },
   ...
   ]  
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Links to component | String |
   | id | Component ID. | Number |
   | version | Component version. Each change to the component increases the version number. | Number |
   | name | Component name. | String |
   | [queue](#queue) | Object with information about the queue component. | Object |
   | description | Text description of the component. | String |
   | [lead](#lead) | Block with information about the component owner. | Object |
   | assignAuto | Assign all the new issues with this component to the component's owner automatically:<ul><li>`true`: Assign</li><li>`false`: Do not assign</li></ul> | Logical |

   `queue` **object fields** {#queue}

   {% include [queue](../_includes/tracker/api/queue.md) %}

   `lead` **object fields** {#lead}

   {% include [user](../_includes/tracker/api/user.md) %}

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error](../_includes/tracker/api/answer-error-400.md) %}

   {% include [error](../_includes/tracker/api/answer-error-401.md) %}

   {% include [error](../_includes/tracker/api/answer-error-403.md) %}

   {% include [error](../_includes/tracker/api/answer-error-500.md) %}

   {% include [error](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}