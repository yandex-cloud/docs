---
sourcePath: en/tracker/api-ref/get-user.md
---
# Getting information about the user

The request enables you to get information about the account of an organization's user.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To get information about the user, use an HTTP `GET` request:

```json
GET /v2/users/<uid/login>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<uid/login\> | Unique ID of the account or the user login | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON array with the user parameters.

   
   ```json
      [
         {
         "self": "https://{{ host }}/v2/users/1234567890",
         "uid": 1234567890,
         "login": "<user_login>",
         "trackerUid": 1234567890,
         "passportUid": 1234567890,
         "cloudUid": "bfbdrb1aa248v8n5vkcq",
         "firstName": "<First name>",
         "lastName": "<Last name>",
         "display": "<Full name>",
         "email": "<login@yandex.ru>",
         "external": false,
         "hasLicense": true,
         "dismissed": false,
         "useNewFilters": true,
         "disableNotifications": false,
         "firstLoginDate": "2020-10-27T13:06:21.787+0000",
         "lastLoginDate": "2022-07-25T17:12:33.787+0000",
         "welcomeMailSent": true
         }
      ]
   ```


   {% cut "Response parameters" %}

   {% include [new-default-id-type](../_includes/tracker/api/new-default-id-type.md) %}

   Parameter | Description | Data type
   -------- | -------- | ----------
   self | Address of the API resource with information about the user account | String
   uid | Unique ID of the user {{ tracker-name }} account | Number
   login | User's login | String
   trackerUid | Unique ID of the user {{ tracker-name }} account | Number
   passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID | Number
   cloudUid | User unique ID in {{ org-full-name }} | String
   firstName | User's first name | String
   lastName | User's last name | String
   display | Displayed user name | String
   email | User email address | String
   external | Service parameter | Logical
   hasLicense | Flag indicating whether the user has full access to {{ tracker-name }}:<ul><li>`true`: Full access</li><li>`false`: Read-only access</li></ul> | Logical
   dismissed | User status in the organization:<ul><li>`true`: User is dismissed</li><li>`false`: User is a current employee</li></ul> | Logical
   useNewFilters | Service parameter | Logical
   disableNotifications | Flag indicating whether user notifications are forced disabled:<ul><li>`true`: Disabled</li><li>`false`: Enabled</li></ul> | Logical
   firstLoginDate | Date and time of the user's first authentication, in the `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String
   lastLoginDate | Date and time of the user's last authentication, in the `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String
   welcomeMailSent | Method of adding a user: <ul><li>`true`: By sending an invitation by email</li><li>`false`: By other means</li></ul> | Logical

   {% endcut %}

- Request failed

   {% include [answer-error-401](../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}