---
sourcePath: en/tracker/api-ref/concepts/entities/get-events-relative.md
---
# Getting entity event history

The request allows you to get a paginated [entity](./about-entities.md) event history.

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To get the paginated event history, use an HTTP `GET` request.

```json
GET /{{ ver }}/entities/<entityType>/<id>/events/_relative
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Request parameters" %}

If no parameters are specified, the full list of events is displayed.

**Additional parameters**

#|
|| **Parameter** | **Description** | **Data type** ||
|| perPage | Sets the maximum number of events in the response. The default value is 50. | Number ||
|| from | ID of the event after which the list starts to be generated. The event itself is not included in the list. Not used together with the `selected` parameter. | String ||
|| selected | ID of the event around which the list is generated. Not specified together with the `from` parameter. The list is generated in the following order (for `perPage=5`):
1. Event with the specified ID.
1. Event that precedes the first event.
1. Event that follows the first event.
1. Event that precedes the second event.
1. Event that follows the third event. | String ||
|| newEventsOnTop | Reverses the order of events in the list. The default value is `false`. | Boolean ||
|| direction | Sets the order of events in the list:
* `forward` (default)
* `backward`: Inverts the `newEventsOnTop` parameter value | String ||
|#

{% endcut %}

> Example: Getting a list of events
>
> - An HTTP GET method is used.
> - The response displays information about three events.
> - The list starts with the event following `65a26b254dbe6208********`.
>
> ```
> GET /v2/entities/project/6586d6fee2b9ef74********/events/_relative?perPage=3&from=65a26b254dbe6208********
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the entity events in JSON format.

   ```json
   {
       "events": [
           {
               "id": "65a26b254dbe6212********",
               "author": {
                   "self": "{{ host }}/v2/users/1993********",
                   "id": "employee_ID",
                   "display": "Full_name",
                   "cloudUid": "ajeppa7dgp71********",
                   "passportUid": "16********"
               },
               "date": "2024-01-13T10:51:17.821+0000",
               "transport": "v2",
               "display": "Issue updated",
               "changes": [
                   {
                       "diff": "<added>Full_name</added>",
                       "field": {
                           "id": "teamUsers",
                           "display": "Participants"
                       }
                   }
               ]
           },
           {
               "id": "65a26b264dbe6215********",
               "author": {
                   "self": "{{ host }}/v2/users/1993********",
                   "id": "employee_ID",
                   "display": "Full_name",
                   "cloudUid": "ajeppa7dgp71********",
                   "passportUid": "16********"
               },
               "date": "2024-01-13T10:51:17.954+0000",
               "transport": "v2",
               "display": "Comment added",
               "changes": [
                   {
                       "diff": "<added>First comment added</added>",
                       "field": {
                           "id": "comment.text",
                           "display": "Comment text",
                           "addedSummonees": [
                               {
                                   "self": "{{ host }}/v2/users/1993********",
                                   "id": "employee_ID",
                                   "display": "Full_name",
                                   "cloudUid": "ajeppa7dgp71********",
                                   "passportUid": "16********"
                               }
                           ],
                           "email": None
                       },
                       "commentUrl": ""
                   }
               ]
           },
           {
               "id": "65a26b384dbe6216********",
               "author": {
                   "self": "{{ host }}/v2/users/1993********",
                   "id": "employee_ID",
                   "display": "Full_name",
                   "cloudUid": "ajeppa7dgp71********",
                   "passportUid": "16********"
               },
               "date": "2024-01-13T10:51:36.807+0000",
               "transport": "v2",
               "display": "File added",
               "changes": [
                   {
                       "diff": "<added>Adding file to comments.</added>",
                       "field": {
                           "id": "comment.text",
                           "display": "Comment text",
                           "email": None
                       },
                       "commentUrl": ""
                   },
                   {
                       "diff": "<added>image.jpg</added>",
                       "field": {
                           "id": "issue.attachments",
                           "display": "Attachments"
                       }
                   }
               ]
           }
       ],
       "hasNext": True,
       "hasPrev": True
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | [events](#events) | Array of objects with information about the events | Array of objects |
   | hasNext | Indicates the presence of subsequent entries in the list. | Logical |
   | hasPrev | Indicates the presence of previous entries in the list. | Logical |

   `events` **array object fields** {#events}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | Event ID. | String |
   | [author](#author) | Object with the event author information | Object |
   | date | Event creation date and time in the format:<br/>```YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | String |
   | transport | Service parameter | String |
   | display | Displayed event name | String |
   | changes | Array of objects with information about the changes. Composition and contents of object fields depend on the parameter you change. | Array of objects |

   `author` **object fields** {#author}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |
   | cloudUid | Unique user ID in {{ org-full-name }} | String |
   | passportUid | Unique {{ ya-360 }} organization user account ID and Yandex ID | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
