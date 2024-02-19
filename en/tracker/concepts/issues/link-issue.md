---
sourcePath: en/tracker/api-ref/concepts/issues/link-issue.md
---
# Linking issues

Use this request to create links between two issues. A link is created between the current issue (specified in the `issue-id` request parameter) and the linked one (specified in the `issue` field of the request body).

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To create links, use an HTTP `POST` request:

```json
POST /{{ ver }}/issues/<issue_ID_or_key>/links
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
    "relationship": "<link_type>",
    "issue": "<issue>"
}
```
{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Format |
----- | ----- | -----
| relationship | Type of links between issues:<ul><li>`relates`: Simple link.</li><li>`is dependent by`: The current issue blocks the linked one.</li><li>`depends on`: The current issue depends on the linked one.</li><li>`is subtask for`: The current issue is a sub-issue of the linked one.</li><li>`is parent task for`: The current issue is a parent issue of the linked one.</li><li>`duplicates`: The current issue duplicates the linked one.</li><li>`is duplicated by`: The linked issue duplicates the current one.</li><li>`is epic of`: The current issue is an epic of the linked one. You can only set this type of link for Epic-type issues.</li><li>`has epic`: The linked issue is an epic of the current one. You can only set this type of link for Epic-type issues.</li></ul> | String |
| issue {#issue} | ID or key of the issue being linked. | String |

{% endcut %}

> Creating a link:
>
> - An HTTP POST method is used.
>
> ```
> POST /v2/issues/TEST-1/?links HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>     "relationship": "relates",
>     "issue": "TREK-2"
> }
> ```

## Response format {#section_xpm_q1y_51b}

{% list tabs %}

- Request executed successfully

   {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

   The response body contains the results in JSON format.

   ```json
     {
       "self" : "https://{{ host }}/v2/issues/TEST-1/links/10*****",
       "id" : 10*****,
       "type" : {
         "self" : "https://{{ host }}/v2/linktypes/relates",
         "id" : "relates",
         "inward" : "relates",
         "outward" : "relates"
       },
       "direction" : "inward",
       "object" : {
         "self" : "https://{{ host }}/v2/issues/STARTREK-2",
         "id" : "4ff3e8dae4b0e2ac********",
         "key" : "TREK-2",
         "display" : "NEW!!!"
       },
       "createdBy" : {
         "self" : "https://{{ host }}/v2/users/44********",
         "id": "44********",
         "display": "Ivan Ivanov"
       },
       "updatedBy" : {
         "self": "https://{{ host }}/v2/users/44********",
         "id": "44********",
         "display": "Ivan Ivanov"
       },
       "createdAt" : "2014-06-18T12:06:02.401+0000",
       "updatedAt" : "2014-06-18T12:06:02.401+0000"
     }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the link. | String |
   | id | Link ID. | Number |
   | [type](#type) | Block with information about the link type. | Object |
   | direction | Link type of the issue specified in the request in relation to the issue specified in the [object](#object-param) field. Possible values:<ul><li>`outward`: The issue specified in the request is the main one for the issue in the [object](#object-param) field.</li><li>`inward`: The issue specified in the [object](#object-param) field is the main one for the issue in the request.</li></ul> | String |
   | [object](#object) {#object-param} | Block with information about the linked issue. | Object |
   | [createdBy](#created-by) | Block with information about the user who created the link. | Object |
   | [updatedBy](#updated-by) | Block with information about the user who edited the linked issue last. | Object |
   | createdAt | Link creation date and time. | String |
   | updatedAt | Link update date and time. | String |
   | [assignee](#assignee) | Assignee of the linked issue. | Object |
   | [status](#status) | Status of the linked issue. | Object |

   `type` **object fields** {#type}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the link type. | String |
   | id | ID of the link type. | String |
   | inward | Name of the link type of the issue specified in the [object](#object-param) field in relation to the issue specified in the request. | String |
   | outward | Name of the link type of the issue specified in the request in relation to the issue specified in the [object](#object-param) field. | String |

   `object` **object fields** {#object}

   {% include [issue](../../../_includes/tracker/api/issue.md) %}

   `createdBy` **object fields** {#created-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   `updatedBy` **object fields** {#updated-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   `assignee` **object fields** {#assignee}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   `status` **object fields** {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
