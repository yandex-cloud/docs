---
sourcePath: en/tracker/api-ref/concepts/entities/links/get-links.md
---
# Getting entity links

The request allows you to get information about an [entity's](../about-entities.md) links with other entities.

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To get entity links, use an HTTP `GET` request.

```json
GET /{{ ver }}/entities/<entity_type>/<entity_ID>/links
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| [fields](../about-entities.md#query-params) | Additional entity fields to be included into the response. | String |

{% endcut %}

> Example: Getting links between entities
>
> - An HTTP GET method is used.
>
> ```
> GET /v2/entities/project/<project_ID>/links?fields=id,summary
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the entity links in JSON format.

   ```json
   [
       {
           "type": "is dependent by",
           "linkFieldValues": {
               "summary": "First project",
               "id": "6582874de6db7f5f********"
           }
       },
       {
           "type": "relates",
           "linkFieldValues": {
               "summary": "Second project",
               "id": "65868f3fe2b9ef74********"
           }
       }
   ]
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | type | Link type: <ul><li>`is dependent by`: Current entity is a blocker.</li><li>`depends on`: Current entity depends on the linked one.</li><li>`relates`: Simple link.</li></ul> | String |
   | linkFieldValues | List of fields and their values in linked entities. List of fields is specified in the `fields` parameter of the request. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
