---
sourcePath: en/tracker/api-ref/concepts/queues/create-version.md
---
# Creating a queue version

Use this request to create a [queue version](../../manager/versions.md).

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To create a queue version, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```
POST /{{ ver }}/versions/
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
   "queue": "<queue_key>",
   "name": "version_name>
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

The request body contains the information required to create a new queue version:

**Required parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| queue | Queue key | String |
| name | Version name | String |

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| description | Version description | String |
| startDate | Version start date in `YYYY-MM-DD` format | String |
| dueDate | Version end date in `YYYY-MM-DD` format | String |

{% endcut %}

> Example: Creating a queue version named `Test Queue`.
>
> - An HTTP `POST` method is used.
> - Create a queue version with the `TESTQUEUE` key.
> - Set the version name: `version 0.1`.
> - Set the version description: `Test version 1`.
> - Set the version start date: `2023.10.03`.
> - Set the version end date: `2024.06.03`.
>
> ```
> POST /v2/queues/TEST/versions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
> {
>   "queue": "TESTQUEUE",
>   "name": "version 0.1",
>   "description": "Test version 1",
>   "startDate": "2023-10-03",
>   "dueDate": "2024-06-03"
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   ```json
   [
       {
           "self": "https://{{ host }}/v2/versions/1",
           "id": 1,
           "version": 1,
           "queue": {
               "self": "https://{{ host }}/v2/queues/TESTQUEUE",
               "id": "6",
               "key": "TESTQUEUE",
               "display": "Test Queue"
           },
           "name": "version 0.1",
           "description": "Test version 1",
           "startDate": "2023-10-03",
           "dueDate": "2024-06-03",
           "released": false,
           "archived": false
       }
   ]
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the version object | String |
   | id | Version ID | Number |
   | version | Version number | Number |
   | [queue](#queue) | Object with information about the queue | Object |
   | name | Version name | String |
   | description | Text description of the version | String |
   | startDate | Version start date | String |
   | dueDate | Version end date | String |
   | released | Flag of the released version | Logical |
   | archived | Flag of the archived version | Logical |

   `queue` **object fields** {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}