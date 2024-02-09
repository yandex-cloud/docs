---
sourcePath: en/tracker/api-ref/concepts/entities/comments/delete-comment.md
---
# Deleting a comment

The request allows you to delete an [entity](../about-entities.md) comment.

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To delete a comment, use an HTTP `DELETE` request.

```json
DELETE /{{ ver }}/entities/<entityType>/<id>/comments/<commentId>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-comment.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| notify | Notify the users specified in the **Author**, **Responsible**, **Participants**, **Customers**, and **Followers** fields. The default value is `true`. | Boolean |
| notifyAuthor | Notify the author of the changes. The default value is `false`. | Boolean |

{% endcut %}

> Example: Delete a comment
>
> - An HTTP DELETE method is used.
>
> ```
> DELETE /v2/entities/project/6586d6fee2b9ef74********/comments/16
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-204](../../../../_includes/tracker/api/answer-204.md) %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
