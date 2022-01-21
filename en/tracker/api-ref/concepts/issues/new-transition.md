# Make a status transition

Use this request to switch an issue to a new status.

## Request format {#section_rkq_bhl_dfb}

Before making the request, [get permission to access the API](../access.md).

To change an issue's status, use an HTTP `POST` request. If the transition settings let you change the issue parameters, specify them in the request body in JSON format:

```json
POST /{{ ver }}/issues/<issue-id>/transitions/<transition-id>/_execute
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
"<key1>":"<value1>",
"<key2>":"<value2>",
...
"comment":"<comment text>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<issue-id> | ID or key of the current issue. | String |
| \<transition-id> | Transition ID. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| \<key\> | Issue field that can be edited during the transition. List of keys: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Depends on the parameter type. |
| comment | Comment on the issue. | String |

{% endcut %}

## Response format {#section_rcd_ysf_2fb}

{% list tabs %}

- Successful execution of the request

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON array with a list of transitions available for the issue in the new status.

    ```json
    [ 
    {
      "self" : "{{ host }}/v2/issues/DESIGN-1/transitions/close",
      "id" : "close",
      "to" : {
      "self" : "{{ host }}/v2/statuses/3",
        "id" : "3",
        "key" : "closed",
        "display" : "Closed"
      },
      "screen" : {
        "self" : "{{ host }}/v2/screens/50c85b17e4b04b38ef31a522",
        "id" : "50c85b17e4b04b38ef31a522"
      }
     },
     ...
    ]
    ```

  {% cut "Response parameters" %}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the transition. | String |
  | id | Transition ID. | String |
  | [to](#to) | Block with information about the status that the issue can transition to. | Object |
  | [screen](#screen) | Block with information about the transition screen. | Object |

  **Object fields** `to` {#to}

  {% include [status](../../../_includes/tracker/api/status.md) %}

  **Object fields** `screen` {#screen}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the transition screen. | String |
  | id | Transition screen ID. | String |

  {% endcut %}

- The request failed

  If the request is processed incorrectly, the API returns a response with an error code:

  {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

  {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

  {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

  {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

  {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

  {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

