# Get a list of components

This request returns a list of all [components](manager/components.md) created by the organization's users.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To get all components, use an HTTP `GET` request.

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
        "self": "{{ host }}/v2/components/1",
        "id": 1,
        "version": 3,
        "name": "Test",
        "queue": {
            "self": "{{ host }}/v2/queues/ORG",
            "id": "1",
            "key": "ORG",
            "display": "Organization"
        },
        "description": "<Component description>",
        "lead": {
               "self": "{{ host }}/v2/users/1120000000016876",
               "id": "<employee ID>",
               "display": "<Employee display name>"
            },
        "assignAuto": false
      },
    ...
    ]  
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Component link. | String |
    | id | Component ID. | Number |
    | version | Component version. Each change to the component increases the version number. | Number |
    | name | Component name. | String |
    | [queue](#queue) | Object with information about the component's queue. | Object |
    | description | Text description of the component. | String |
    | [lead](#lead) | Block with information about the component owner. | Object |
    | assignAuto | Automatically assign the component owner as the assignee for all subsequent issues containing the component:<ul><li>`true`— assign</li><li>`false`— don't assign.</li></ul> | Boolean |

    **Object fields** `queue` {#queue}

    {% include [queue](../_includes/tracker/api/queue.md) %}

    **Object fields** `lead` {#lead}

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

