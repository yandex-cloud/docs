---
sourcePath: en/tracker/api-ref/concepts/entities/links/delete-link.md
---
# Deleting a link between entities

The request allows you to delete a link between two [entities](../about-entities.md).

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To delete a link, use an HTTP `DELETE` request. The link will be deleted between the current entity (ID specified in the request `<entity_ID>`) and the entity whose ID is specified in the `right` parameter of the request.

```json
DELETE /{{ ver }}/entities/<entity_type>/<entity_ID>/links
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Request parameters" %}

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| right | ID of the entity whose link is deleted. | String |

{% endcut %}

> Example: Deleting a link between entities
>
> - An HTTP DELETE method is used.
>
> ```
> DELETE /v2/entities/project/<project_ID>/links?right=<entity_ID>
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
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
