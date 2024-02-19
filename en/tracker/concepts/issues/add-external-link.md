---
sourcePath: en/tracker/api-ref/concepts/issues/add-external-link.md
---
# Adding an external link

Use this request to create a link for working with an [external application object](../../external-links.md).

## Request format {#rec-format}

Before making the request, [get permission to access the API](../access.md).

To create an external link, use an HTTP `POST` request.

```
POST /{{ ver }}/issues/<issue_ID_or_key>/remotelinks?backlink=true
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
    "relationship": "RELATES",
    "key": "<object_key>",
    "origin": "<application_ID>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| backlink | Set `true` to execute a [request from {{ tracker-name }}, when adding a link, to create a duplicate link in an external application](../../ext-app-setup.md#create). | Logical |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
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
        "self": "https://{{ host }}/{{ ver }}/issues/<issue_ID_or_key>/remotelinks/51******",
        "id": 51******,
        "type": {
            "self": "https://{{ host }}/{{ ver }}/linktypes/relates",
            "id": "relates",
            "inward": "Linked",
            "outward": "Linked"
        },
        "direction": "outward",
        "object": {
            "self": "https://{{ host }}/{{ ver }}/applications/ru.yandex.bitbucket/objects/13570010********",
            "id": "13570010********",
            "key": "TEST-17",
            "application": {
                "self": "https://{{ host }}/{{ ver }}/applications/25811000********",
                "id": "25811000********",
                "type": "app",
                "name": "test-app"
            }
        },
        "createdBy": {
            "self": "https://{{ host }}/{{ ver }}/users/11********",
            "id": "11********",
            "display": "display-user-name"
        },
        "updatedBy": {
            "self": "https://{{ host }}/{{ ver }}/users/11********",
            "id": "11********",
            "display": "display-user-name"
        },
        "createdAt": "2021-07-19T06:18:09.327+0000",
        "updatedAt": "2021-07-19T06:18:09.327+0000"
    }

   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the external link. | String |
   | id | Link ID. | String |
   | [type](#type) | Block with information about the link type. | Object |
   | direction {#direction} | Link direction. This parameter is relevant for non-symmetric link types, e.g., _Parent issue: Sub-issue_. Possible values:<ul><li>`outward`: The issue specified in the request is the main one for the object.</li><li>`inward`: The object is the main one for the issue specified in the request.</li></ul> | String |
   | [object](#object){#object-param} | Block with information about an external application object. | Object |
   | [createdBy](#createdBy) | Block with information about the user who created the link. | Object |
   | [updatedBy](#updatedBy) | Block with information about the employee who updated the link last. | Object |
   | createdAt | Link creation date and time. | String |
   | updatedAt | Date and time when the link was last updated. | String |

   `type` **object fields**

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the link type. | String |
   | id | ID of the link type. | String |
   | inward | Link type name depending on the [direction](#direction). | String |
   | outward | Link type name depending on the [direction](#direction). | String |


   `object` **object fields** {#object}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the external application object. | String |
   | id | Object ID. | String |
   | key | Object key. | String |
   | [application](#application) | Block with information about the external application. | Object |

   `application` **object fields** {#application}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the external application. | String |
   | id | Application ID. | String |
   | type | Application type. | String |
   | name | Application name displayed. | String |


   `createdBy` **object fields** {#createdBy}

   {% include [user](../../../_includes/tracker/api/user.md) %}


   `updatedBy` **object fields** {#updatedBy}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

