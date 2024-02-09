{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| notify | Notify the users specified in the **Author**, **Responsible**, **Participants**, **Customers**, and **Followers** fields. The default value is `true`. | Boolean |
| notifyAuthor | Notify the author of the changes. The default value is `false`. | Boolean |
| [fields](../../../tracker/concepts/entities/about-entities.md#query-params) | Additional entity fields to be included into the response. | String |
| expand | Additional information to be included into the response: <ul><li>`attachments`: Attached files</li></ul> | String |

{% endcut %}
