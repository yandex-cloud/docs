# Get information about the current user

Use this request to get information about the account of the user on whose behalf the API is being accessed.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To get information about the current user, use an HTTP `GET` request:

```json
GET /v2/myself
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON array with the current user's parameters.

    {% if audience == "external" %}

    ```json
       [
          {
          "self": "{{ host }}/v2/users/1234567890",
          "uid": 1234567890,
          "login": "<user_login>",
          "trackerUid": 1234567890>,
          "passportUid": 1234567890,
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

    {% else %}

    ```json
       [
          {
          "self": "{{ host }}/v2/users/1234567890",
          "uid": 1234567890,
          "login": "<user_login>",
          "trackerUid": 1234567890,
          "passportUid": 1234567890,
          "firstName": "<First name>",
          "lastName": "<Last name>",
          "display": "<First and Last name>",
          "email": "<login@yandex-team.ru>",
          "office": {
             "self": "{{ host }}/v2/offices/1",
             "id": "1",
             "display": "Moscow, Morozov Business Center"
          },
          "external": false,
          "hasLicense": true,
          "dismissed": false,
          "useNewFilters": true,
          "disableNotifications": false,
          "activeExperiments": [
             <list of experiments>
          ]
          }
       ]
    ```

    {% endif %}

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user account. | String |
    | uid | Unique ID of the user account. | Number |
    | login | Username of the user. | String |
    | trackerUid | Unique ID of the user's {{ tracker-name }} account. | Number |
    | passportUid | Unique ID of the user's Yandex account. | Number |
    | firstName | User's first name. | String |
    | lastName | Last name of the user. | String |
    | display | User's name displayed. | String |
    | email | User's email address. | String |
    | external | Service parameter. | Boolean |
    | hasLicense | Flag indicating whether the user has full access to {{ tracker-name }}:<ul><li>`true`: Full access.</li><li>`false`: Read-only access.</li></ul> | Boolean |
    | dismissed | User status in the organization:<ul><li>`true`: The user was dismissed.</li><li>`false`: The user is a current employee.</li></ul> | Boolean |
    | useNewFilters | Service parameter. | Boolean |
    | disableNotifications | Flag indicating whether user notifications are forced disabled:<ul><li>`true`: Disabled.</li><li>`false`: Enabled.</li></ul> | Boolean |

    {% endcut %}

- Request failed

    {% include [answer-error-401](../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

