---
title: "General request format in {{ tracker-full-name }}"
description: "In this tutorial, you will learn about the general format of {{ api-name }} requests, their methods and headings, as well as the format of request body, text, and variables."
sourcePath: en/tracker/api-ref/common-format.md
---

# General request format

General {{ api-name }} request format:

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

Requests made to {{ api-short-name }} use one of the following HTTP methods:

`GET`: Getting information about an object or list of objects.

`POST`: Creating an object.

`PATCH`: Editing the parameters of an existing object. Requests executed by the PATCH method only change the parameters that are explicitly specified in the request body.

`DELETE`: Deleting an object.

## Headers {#headings}

In requests to the {{ api-short-name }} API, specify the following headers:

- `Host: {{ host }}`

- `Authorization: OAuth <your OAuth token>`: If [OAuth 2.0 protocol](concepts/access.md#section_about_OAuth) is used.

   `Authorization: Bearer <your IAM token>`: If an [IAM token](concepts/access.md#iam-token) is used.

- `X-Org-ID: <organization ID>` or `X-Cloud-Org-ID: <organization ID>`

   If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`. To find out the organization ID, go to the [settings page {{ tracker-name }}]({{ link-settings }}). The ID is shown in **Organization ID for API**.


## Request body format {#body}

The request body includes a JSON object with the IDs of updated fields and their values.

- To add or remove an array value, use the `add` or `remove` command:

   - ```json
        {
            "followers": { "add": ["<1employee ID>", "<2employee ID>"] }
        }
    ```

  The `add` command adds new values to the array. To overwrite the array (delete the old values and add new ones), use the `set` command.

- To reset the field value, set it to `null`. To reset the array, use an empty array `[]`. You can change individual values in the array using the `target` and `replacement` commands:

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
    ```json
      {
        "type": { "name": "Error" }
      }
      ```
  - ```json
      {
        "type": {"set": "bug"}
      }
      ```

## Text formats and variables {#text-format}

When making requests for the creation or update of [comments](concepts/issues/add-comment.md), [macros](post-macros.md), [triggers](concepts/queues/create-trigger.md), and [auto actions](concepts/queues/create-autoaction.md), use the following formatting for the message text:
* To format the text, use the [{{ yfm }} markup](user/markup.md).
* To add a line break, use ``\n``.
* To add values from the issue fields, use [variables](user/vars.md#variable-type).

## Paginated result output {#displaying-results}

If you request a list of objects, and the number of rows in the response exceeds 50, the response returns a page with the specified number of results. You can run more requests to view the next pages. This is where request pagination helps.

With the paginated output, the request results are calculated each time a new page is returned. So if changes occur in the request results when viewing a certain page, this may affect the output of the following pages. For example, the request found 11 issues, 10 of which are displayed. While viewing the results of the first page, one of the issues was changed and no longer meets the requirements of the search query. In this case, when requesting the second page with the results, an empty array is returned, since the remaining 10 issues are on the first page.

For paginated results, use these parameters in the request:

- **perPage (optional)**

   Number of objects (issues, queues, and so on) on the page. The default value is 50.

- **page (optional)**

   Response page number. The default value is 1.

The response will contain the following headers:

- **X-Total-Pages**

   Total number of pages with entries.

- **X-Total-Count**

   Total number of entries in the response.

## Request examples {#examples}

{% cut "Example 1: Change the name, description, type, and priority of an issue." %}

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

{% cut "Example 2: Request for a single issue with the required fields specified." %}

- An HTTP GET method is used.
- The response will display attachments.

```
GET /v2/issues/JUNE-3?expand=attachments
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```
{% endcut %}

{% cut "Example 3: Create an issue." %}

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

{% cut "Example 4: Find the issues in the queue that were assigned to a given employee. Paginate the results." %}

- An HTTP POST method is used.
- Key of the queue: <q>TREK</q>.
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