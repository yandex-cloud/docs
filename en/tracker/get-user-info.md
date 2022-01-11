---
sourcePath: en/tracker/api-ref/get-user-info.md
---
# Get information about the current user

Use this request to get information about the account of the user on whose behalf the API is being accessed.

## Request format {#query}

To get information about the current user, use an HTTP `GET` request:

```json
GET /v2/myself
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-ID: <organization ID>
```

#### Headers {#req-headers}

- **Host**

    Address of the node that provides the API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Organization ID.

## Response format {#answer}

If the request is successful, the API returns a response with code 200. The response body contains a JSON array with the current user's parameters.

```json
[
   {
   "self": "https://api.tracker.yandex.net/v2/users/<ID>",
   "uid": <ID>,
   "login": "<user_login>",
   "passportUid": <Yandex.Passport ID>,
   "firstName": "<First name>",
   "lastName": "<Last name>",
   "display": "<First and Last name>",
   "email": "<login@yandex.ru>",
   "external": false,
   "hasLicense": true,
   "dismissed": false,
   "useNewFilters": true,
   "disableNotifications": false
   }
]
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| self | Address of the API resource with information about the user account. | String |
| uid | Unique ID of the user account. | Number |
| login | Username of the user. | String |
| passportUid | Unique ID of the user's Yandex account. | Number |
| firstName | Username. | String |
| lastName | Last name of the user. | String |
| display | User's name displayed. | String |
| email | User's email address. | String |
| external | Service parameter. | Boolean |
| hasLicense | Flag indicating whether the user has full access to {{ tracker-name }}:<ul><li>`true`: Full access.</li><li>`false`: Read-only access.</li></ul> | Boolean |
| dismissed | User status in the organization:<ul><li>`true`: The user was dismissed.</li><li>`false`: The user is a current employee.</li></ul> | Boolean |
| useNewFilters | Service parameter. | Boolean |
| disableNotifications | Flag indicating whether user notifications are forced disabled:<ul><li>`true`: Disabled.</li><li>`false`: Enabled.</li></ul> | Boolean |

## Possible response codes {#answer-codes}

200
:   Request executed successfully.

401
:  The user isn't authorized. Make sure that actions described in [{#T}](concepts/access.md) are performed.

403
:  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

