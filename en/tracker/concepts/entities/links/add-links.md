---
sourcePath: en/tracker/api-ref/concepts/entities/links/add-links.md
---
# Linking entities

The request allows you to create links between multiple [entities](../about-entities.md).

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To create links, use an HTTP `POST` request. Information about the links is transmitted in its body in JSON format. The link is created between the current entity (specified in the request `<entity_ID>`) and the entities whose IDs are specified in the `entity` fields of the request body.

```json
POST /{{ ver }}/entities/<entity_type>/<entity_ID>/links
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
  "relationship": "<link_type>",
  "entity": "<linked_entity_ID>"
}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| relationship | Link type: <ul><li>`is dependent by`: Current entity is a blocker.</li><li>`depends on`: Current entity depends on the linked one.</li><li>`relates`: Simple link.</li></ul> | String |
| entity | ID of the entity you are establishing a link with. | String |

{% endcut %}

> Example: Creating a link between entities
>
> - An HTTP POST method is used.
>
> ```
> POST /v2/entities/project/<project_ID>/links
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> [
>   {
>      "relationship":"is dependent by",
>      "entity": "6582874de6db7f5f********"
>   },
>   {
>      "relationship":"relates",
>      "entity": "65868f3fe2b9ef74********"
>   }
> ]
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
