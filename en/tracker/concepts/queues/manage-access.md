---
sourcePath: en/tracker/api-ref/concepts/queues/manage-access.md
---
# Granting queue access rights

This request allows you to set up [queue access permissions](../../manager/queue-access.md).

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To set up queue access permissions, use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format.

```json
PATCH /{{ ver }}/queues/<queue-id>/permissions
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
   "create": {
      "groups": [<group_1_ID>, <group_2_ID>]
   },
   "write": {
      "users": {
         "remove": ["<user_1_username>", "<user_2_ID>"]
      },
      "groups": {
         "add":[<group_1_ID>]
       },
      "roles": {
         "add":["author", "assignee"]
      }
   },
   "read": {
      "groups": {
         "add":[<group_3_ID>]
       },
      "roles": {
         "add":["follower"]
      }
   },
   "grant": {
      "users": {
         "remove": ["<user_account_4_ID>",  "<user_2_ID>"]
      },
   },

}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

Parameter | Description | Data type
-------- | -------- | ----------
\<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String

{% endcut %}

{% cut "Request body parameters" %}

The request body contains information required for access management.

**Acceptable request body object fields**

Specify at least one of the following fields in your request:

Parameter | Description | Data type
-------- | -------- | ----------
create | Permissions to create issues in a queue | Objects
write | Permissions to edit issues in a queue | Objects
read | Permissions to read issues in a queue | Objects
grant | Permissions to update queue settings | Objects


**Acceptable object fields that permissions apply to**

Each of the request body fields contains a list of users, groups, and roles that the respective permission action applies to. Specify at least one of the following fields in the list:

Parameter | Description | Data type
-------- | -------- | ----------
users | User list | Object or array of elements
groups | Group list | Object or array of elements
roles | Role list | Object or array of elements

**Acceptable object field values that permissions apply to**

In each field, you can specify either an array of IDs or an object:

- If an array of IDs is set, permissions for the specified resources will be created or overridden as requested.
- If an object is set, permissions will be added or revoked based on the specified key:

Key | Description | Data type
-------- | -------- | ----------
add | Add a permission | Array of elements
remove | Revoke a permission | Array of elements

**Acceptable IDs**

Resource type | ID | Description | Data type
-------- | -------- | ---------- | ----------
**users** | uid | Unique ID of the user {{ tracker-name }} account | Number
&nbsp; | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID | Number
&nbsp; | login | Username of the user | String
&nbsp; | cloudUid | User unique ID in {{ org-full-name }} | String
&nbsp; | trackerUid | Unique ID of the user {{ tracker-name }} account | Number
**groups** | id | Group ID | Number
**roles** | role_id | Role ID | String

{% note info %}

Role IDs include:
* `author`: Author
* `assignee`: Assignee
* `follower`: Follower
* `access`: With the right of access

You can get group IDs using the `{{ host }}/{{ ver }}/groups` request.

{% endnote %}


{% endcut %}

> Example 1: Grant permissions to create and edit issues in a queue with the `TESTQUEUE` key to the user named `user1`.
>
> - The HTTP `PATCH` method is used.
> - The permissions are granted to `user1` in the `TESTQUEUE`.
> - As a result of the request, the user's current queue permissions will be overridden.
> ```
> PATCH /{{ ver }}/queues/TESTQUEUE/permissions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>     "create": {
>        "users": ["user1"]
>     },
>     "write": {
>     "users": ["user1"]
>     }
> }
> ```

> Example 2: Grant permission to set up a queue with the `TESTQUEUE` key to `user1` and revoke the same permission from the user whose unique ID is `1234567890`.
>
> - The HTTP `PATCH` method is used.
> - The `TESTQUEUE` setup permission is granted to `user1`.
> - The `TESTQUEUE` setup permission is revoked from the user with the `1234567890` ID.
> ```
> PATCH /{{ ver }}/queues/TESTQUEUE/permissions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>     "grant": {
>        "users": {
>           "add":["user1"],
>           "remove":['1234567890']
>        }
>     }
> }
> ```


## Response format {#answer}

{% list tabs %}
- The request is executed successfully
   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}
   ```json
   {
       "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions",
       "version": 11,
       "create": {
           "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions/create",
           "users": [
                { "self": "https://api.tracker.yandex.net/v2/users/9876543210", "id": "9876543210", "display": "User 1", "cloudUid": "ajej6h7nffmtaf*****", "passportUid": 9876543210 }
           ],
           "roles": [
               { "self": "https://api.tracker.yandex.net/v2/roles/author", "id": "author", "display": "Author" },
               { "self": "https://api.tracker.yandex.net/v2/roles/queue-lead", "id": "queue-lead", "display": "Queue owner" },
               { "self": "https://api.tracker.yandex.net/v2/roles/assignee", "id": "assignee", "display": "Assignee" }
           ]
       },
       "write": {
           "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions/write",
           "users": [
                { "self": "https://api.tracker.yandex.net/v2/users/9876543210", "id": "9876543210", "display": "User 1", "cloudUid": "ajej6h7nffmtaf*****", "passportUid": 9876543210 }
           ],
           "roles": [
               { "self": "https://api.tracker.yandex.net/v2/roles/author", "id": "author", "display": "Author" },
               { "self": "https://api.tracker.yandex.net/v2/roles/queue-lead", "id": "queue-lead", "display": "Queue owner" },
               { "self": "https://api.tracker.yandex.net/v2/roles/assignee", "id": "assignee", "display": "Assignee" }
           ]
       },
       "grant": {
           "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions/grant",
           "users": [
                { "self": "https://api.tracker.yandex.net/v2/users/9876543210", "id": "9876543210", "display": "User 1", "cloudUid": "ajej6h7nffmtaf*****", "passportUid": 9876543210 }
           ],
           "roles": [
               { "self": "https://api.tracker.yandex.net/v2/roles/author", "id": "author", "display": "Author" },
               { "self": "https://api.tracker.yandex.net/v2/roles/queue-lead", "id": "queue-lead", "display": "Queue owner" },
               { "self": "https://api.tracker.yandex.net/v2/roles/assignee", "id": "assignee", "display": "Assigee" }
           ]
       }
   }

   ```

   {% cut "Response parameters" %}
   Parameter | Description | Data type
   ----- | ----- | -----
   self | Link to the object with granted queue access permissions | String
   version | Version number | Number
   create | Permissions to create issues in a queue | Object
   write | Permissions to edit issues in a queue | Object
   read | Permissions to read issues in a queue | Object
   grant | Permissions to update queue settings | Object

   {% endcut %}

- The request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

