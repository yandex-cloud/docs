# Get a list of issue external links

Use this request to get a list of issue links to [external application objects](../../external-links.md).

## Request format {#rec-format}

Before making the request, [get permission to access the API](../access.md).

To get a list of issue external links, use an HTTP `GET` request.

```
GET /{{ ver }}/issues/<issue-id>/remotelinks
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about issue external links in JSON format.

    ```json
    [ 
    
     {
        "self": "{{ host }}/{{ ver }}/issues/<issue-id>/remotelinks/51299313",
        "id": 51299313,
        "type": {
            "self": "{{ host }}/{{ ver }}/linktypes/relates",
            "id": "relates",
            "inward": "Linked",
            "outward": "Linked"
        },
        "direction": "outward",
        "object": {
            "self": "{{ host }}/{{ ver }}/applications/ru.yandex.bitbucket/objects/<object-id>",
            "id": "<object-id>",
            "key": "<object-key>",
            "application": {
                "self": "{{ host }}/{{ ver }}/applications/<application-id>",
                "id": "<application-id>",
                "type": "<application-type>",
                "name": "<application-name>"
            }
        },
        "createdBy": {
            "self": "{{ host }}/{{ ver }}/users/1120000000044110",
            "id": "user-name",
            "display": "display-user-name"
        },
        "updatedBy": {
            "self": "{{ host }}/{{ ver }}/users/1120000000044110",
            "id": "user-name",
            "display": "display-user-name"
        },
        "createdAt": "2021-07-14T18:59:54.552+0000",
        "updatedAt": "2021-07-14T18:59:54.552+0000"
     },
     ...
    ] 
    ```

  {% cut "Response parameters" %}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the external link. | String |
  | id | Link ID. | String |
  | [type](#type) | Block with information about the link type. | Object |
  | direction {#direction} | <q>Link</q> direction. The parameter is relevant for non-symmetric link types, such as <q>Parent issue</q> — <q>Sub-issue</q>. Possible values:<ul><li>`outward`: A conditional link direction from an issue to a linked object.</li><li>`inward`: A conditional link direction from a linked object to an issue.</li></ul> | String |
  | [object](#object){#object-param} | Block with information about an external application object. | Object |
  | [createdBy](#createdBy) | Block with information about the user who created the link. | Object |
  | [updatedBy](#updatedBy) | Block with information about the employee who updated the link last. | Object |
  | createdAt | Link creation date and time. | String |
  | updatedAt | Date and time when the link was last updated. | String |

  **Object fields** `type` {#type}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Address of the API resource with information about the link type. | String |
   | id | ID of the link type. | String |
   | inward | Link type name depending on the [<q>direction</q>](#direction). | String |
   | outward | Link type name depending on the [<q>direction</q>](#direction). | String |

  **Object fields** `object` {#object}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the external application object. | String |
  | id | Object ID. | String |
  | key | Object key. | String |
  | [application](#application) | Block with information about the external application. | Object |

  **Object fields** `application` {#application}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the external application. | String |
  | id | Application ID. | String |
  | type | Application type. | String |
  | name | Application name displayed. | String |

  **Object fields** `createdBy` {#createdBy}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Object fields** `updatedBy` {#updatedBy}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  {% endcut %}

- Request failed

  If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

