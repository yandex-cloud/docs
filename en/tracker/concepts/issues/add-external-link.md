---
sourcePath: en/tracker/api-ref/concepts/issues/add-external-link.md
---
# Add an external link

Use this request to create a link for working with an [external application object](../../external-links.md).

## Request format {#rec-format}

Before making the request, [get permission to access the API](../access.md).

To create an external link, use an HTTP `POST` request.

```
POST /{{ ver }}/issues/<issue-id>/remotelinks?backlink=true
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "relationship": "RELATES",
    "key": "<object key>",
    "origin": "<application ID>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| backlink | Set `true` to execute a [request from {{ tracker-name }}, when adding a link, to create a duplicate link in an external application](../../ext-app-setup.md#create). | Boolean |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| relationship | Link type. We recommend using the value `RELATES`. | String |
| key | Key of the external application object. | String |
| origin | ID of the application whose object you need to create a link to. | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

  The request body contains information about the created link in JSON format.

   ```json
    {
        "self": "{{ host }}/{{ ver }}/issues/<issue-id>/remotelinks/51455195", 
        "id": 51455195,
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
            "self": "{{ host }}/{{ ver }}/users/1120000000232694",
            "id": "user-name",
            "display": "display-user-name"
        },
        "updatedBy": {
            "self": "{{ host }}/{{ ver }}/users/1120000000232694",
            "id": "user-name",
            "display": "display-user-name"
        },
        "createdAt": "2021-07-19T06:18:09.327+0000",
        "updatedAt": "2021-07-19T06:18:09.327+0000"
    }
   ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource with information about the external link. | String |
    | id | Link ID. | String |
    | [type](#type) | Block with information about the link type. | Object |
    | direction {#direction} | <q>Link</q> direction. The parameter is relevant for non-symmetric link types, such as <q>Parent issue</q> — <q>Sub-issue</q>. Possible values:<ul><li>`outward`: The issue specified in the request is the main one for the object.</li><li>`inward`: The object is the main one for the issue specified in the request.</li></ul> | String |
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

