# General query format

General {{ api-name }} query format:

```
<method> /{{ ver }}/<resources>/<resource_id>/?<param>=<value>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
{
   Request body in JSON format
} 
```

{% note info %}

{{ api-name }} sends and receives date and time parameters in the UTC±00:00 time zone. Therefore, the time and date received may differ from the time zone of the client that the request is made from.

{% endnote %}

## Methods {#methods}

{{ api-short-name }} queries use one of the following HTTP methods:

`GET`: Get information about an object or list of objects.

`POST`: Create an object.

`PATCH`: Change the parameters of an existing object. Requests sent via the PATCH method only change the parameters explicitly specified in the request body.

`DELETE`: Delete an object.

## Headers {#headings}

In requests to the {{ api-short-name }} API, specify the following headers:

- `Host: {{ host }}`

- `Authorization: OAuth <your OAuth token>`{% if audience == "external" %}: If the [OAuth 2.0 protocol](concepts/access.md#section_about_OAauth) is used.

   `Authorization: Bearer <your IAM token>`: If an [IAM token](concepts/access.md#iam-token) is used.

- `X-Org-ID: <organization ID>`

   To find out the organization ID, go to the [{{ tracker-name }} settings]({{ link-settings }}). The ID is shown in **Organization ID for API**.

{% endif %}

## Request body format {#body}

The request body passes a JSON object with the IDs of updated fields and their values.

- To add or remove an array value, use the `add` or `remove` command:
  - ```json
    {
        "followers": { "add": ["<id user1>", "<id user2>"] }
    }
    ```

  The `add` command adds new values to the array. To overwrite the array (delete the old values and add new ones), use the `set` command.

- To reset the field value, set it to `null`. TTo reset the array, use an empty array `[]`. You can change individual values in the array using the `target` and `replacement` commands:
  - `{"followers": null}`
  - ```json
    {
      "followers": {
        "replace": [
            {"target": "<ID1>", "replacement": "<ID2>"},
            {"target": "<ID3>", "replacement": "<ID4>"}]
      }
    }
    ```

- For example, to change the issue type to <q>Bug</q>, use one of these methods:
  - `{"type": 1}`
  - `{"type": "bug"}`
  - ```json
      {
        "type": { "id": "1" }
      }
      ```
  - ```json
      {
        "type": { "name": "Bug" }
      }
      ```
  - ```json
      {
        "type": {"set": "bug"}
      }
      ```

## Text formatting and variables {#text-format}

When handling requests for adding or editing [comments](concepts/issues/add-comment.md), [macros](post-macros.md), [triggers](concepts/queues/create-trigger.md), and [auto actions](concepts/queues/create-autoaction.md), use special text formatting:

* To format text, use the dedicated [markup {{ yfm }}](user/markup.md).
* To add a line break, enter ``\n``.
* To add values from issue fields, use [variables](user/vars.md#variable-type).

## Paginated result output {#displaying-results}

If you request an object list and the response contains more than 50 lines, the request returns a page with the specified number of results. You can make multiple requests to view subsequent pages. To do this, use paginated display.

With paginated display, the request results are calculated each time a new page is displayed. So if changes occur in the request results when viewing a certain page, this may affect the output of the following pages. For example, the request found 11 issues, 10 of which are displayed. While viewing the results of the first page, one of the issues was changed and no longer meets the requirements of the search query. In this case, when requesting the second page with the results, an empty array is returned, since the remaining 10 issues are on the first page.

To enable paginated display, use the following parameters in the request:

- **perPage (optional)**

    The number of objects (issues, queues, and so on) on the page. Default: 50.

- **page (optional)**

    Response page number The default value is 1.

The response will contain the following headers:

- **X-Total-Pages**

    Total number of pages with entries.

- **X-Total-Count**

    Total number of entries in the response.

## Examples of requests {#examples}

{% cut "Example 1: Change summary, description, type and priority of the issue." %}

- An HTTP PATCH method is used.
- We're editing the TEST-1 issue.
- New issue type: <q>Bug</q>.
- New issue priority: <q>Low</q>.

```
PATCH /v2/issues/TEST-1
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
  "summary": "New issue name",
  "description": "New issue description",
  "type": {
      "id": "1",
      "key": "bug"
      },
  "priority": {
      "id": "2",
      "key": "minor"
      }
}
```

{% endcut %}

{% cut "Example 2: Request issue data with specified fields." %}

- Use the HTTP GET method.
- The response will display attachments.

```
GET /v2/issues/JUNE-3?expand=attachments
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% endcut %}

{% cut "Example 3: Create issue." %}

- An HTTP POST method is used.
- We're creating an issue named <q>Test Issue</q> in the queue with the [key](manager/create-queue.md#key) <q>TREK</q>.
- The new issue is a sub-issue of <q>JUNE-2</q>.
- Type of the new issue: <q>Bug</q>.
- Assignee: <user_login>

```
POST /v2/issues/ HTTP/1.1
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
  "queue": "TREK",
  "summary": "Test Issue",
  "parent":"JUNE-2",
  "type": "bug",
  "assignee": "<user_login>",
  "attachmentIds": [55, 56]
}
```

{% endcut %}

{% cut "Example 4: Find users's issues from the specified queue. Response is displayed paginated." %}

- An HTTP POST method is used.
- Queue key: <q>TREK</q>.
- Assignee: <user_login>.

```
POST /v2/issues/_search?perPage=15
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
  "filter": {
    "queue": "TREK",
    "assignee": "<user_login>"
  }
}
```

{% endcut %}

