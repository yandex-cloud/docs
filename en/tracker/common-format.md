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

{% cut "Python" %}

```python
import requests;

def my_function():
    session = requests.Session()
    url = "https://{{ host }}/{{ ver }}/<resources>/<resource_id>/?<param>=<value>"
    json = {
        # Request body in JSON format
    }
    head =  {
        "Authorization": "OAuth <token>",
        "X-Org-ID" or "X-Cloud-Org-ID": <organization_ID>
    }
    session.headers.update(head)
    response = session.post(url, json=json) # session.* - get, post, path, delete
    data = response.json()
    print(response)
    print(data)

my_function()
```

{% endcut %}

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

In {{ api-short-name }} requests, specify the following headers:

- `Host: {{ host }}`

- `Authorization: OAuth <your OAuth token>`: If [OAuth 2.0](concepts/access.md#section_about_OAuth) is used.

   `Authorization: Bearer <your IAM token>`: If an [IAM token](concepts/access.md#iam-token) is used.

- `X-Org-ID: <organization ID>` or `X-Cloud-Org-ID: <organization ID>`

   If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`. To find out the organization ID, go to the [settings page {{ tracker-name }}]({{ link-settings }}). The ID is shown in **Organization ID for API**.


- `Accept-Language: <language tag>`: Localization language.

   By default, an HTTP request returns localized fields in Russian. To get localized field values in English, specify a header with the **en** tag.

## Request body format {#body}

The request body includes a JSON object with the IDs of updated fields and their values.

- To add or remove an array value, use the `add` or `remove` command:

   - ```json
        {
            "followers": { "add": ["<employee1 ID>", "<employee2 ID>"] }
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

- For example, to change the issue type to <q>Error</q>, use one of these methods:

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

## Pagination of results {#displaying-results}

If you request a list of objects, and the number of rows in the response exceeds 50, the response returns a page with the specified number of results. You can run more requests to view the next pages. This is where pagination of results helps.

If you use pagination, request results are calculated each time a new page is returned. So if changes occur in the request results when viewing a certain page, this may affect the output of the following pages. For example, the request found 11 issues, 10 of which are displayed. While viewing the results of the first page, one of the issues was changed and no longer meets the requirements of the search request. In this case, when requesting the second page with the results, an empty array is returned, since the remaining 10 issues are on the first page.

The [new API](./concepts/entities/about-entities.md) offers paginated output of request results for [events](./concepts/entities/get-events-relative.md) and [comments](./concepts/entities/comments/get-all-comments.md#pagination) with better customization.

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
- We are editing the TEST-1 issue.
- New issue type: <q>Error</q>.
- New issue priority: <q>Low</q>.

{% list tabs %}

- Request format

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

- Python

   ```python
   import requests;

   def my_function():
       session = requests.Session()
       url = "https://{{ host }}/{{ ver }}/issues/TEST-1"
       json = {
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
       head =  {
           "Authorization": "OAuth <token>",
           "X-Org-ID" or "X-Cloud-Org-ID": <organization_ID>
       }
       session.headers.update(head)
       response = session.patch(url, json=json)
       data = response.json()
       print(response)
       print(data)

   my_function()
   ```

{% endlist %}

{% endcut %}

{% cut "Example 2: Request for a single issue with the required fields specified." %}

- An HTTP GET method is used.
- The response will display attachments.

{% list tabs %}

- Request format

```
GET /v2/issues/JUNE-3?expand=attachments
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

- Python

   ```python
   import requests;

   def my_function():
       session = requests.Session()
       url = "https://{{ host }}/{{ ver }}/issues/JUNE-3?expand=attachments"
       head =  {
           "Authorization": "OAuth <token>",
           "X-Org-ID" or "X-Cloud-Org-ID": <organization_ID>
       }
       session.headers.update(head)
       response = session.get(url)
       data = response.json()
       print(response)
       print(data)

   my_function()
   ```

{% endlist %}

{% endcut %}

{% cut "Example 3: Create an issue." %}

- An HTTP POST method is used.
- We are creating an issue named _Test Issue_ in the queue with the _TREK_ [key](manager/create-queue.md#key).
- The new issue is a sub-issue of <q>JUNE-2</q>.
- New issue type: <q>Error</q>.
- Assignee: <user_login>.

{% list tabs %}

- Request format

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

- Python

   ```python
   import requests;

   def my_function():
       session = requests.Session()
       url = "https://{{ host }}/{{ ver }}/issues/"
       json = {
           "queue": "TREK",
           "summary": "Test Issue",
           "parent":"JUNE-2",
           "type": "bug",
           "assignee": "<user_login>",
           "attachmentIds": [55, 56]
           }
       head =  {
           "Authorization": "OAuth <token>",
           "X-Org-ID" or "X-Cloud-Org-ID": <organization_ID>
       }
       session.headers.update(head)
       response = session.post(url, json=json)
       data = response.json()
       print(response)
       print(data)

   my_function()
   ```

{% endlist %}

{% endcut %}

{% cut "Example 4: Find the issues in the queue that were assigned to a given employee. Paginate the results." %}

- An HTTP POST method is used.
- Key of the queue: <q>TREK</q>.
- Assignee: <user_login>.

{% list tabs %}

- Request format

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

- Python

   ```python
   import requests;

   def my_function():
       session = requests.Session()
       url = "https://{{ host }}/{{ ver }}/issues/_search?perPage=15"
       json = {
           "filter": {
               "queue": "TREK",
               "assignee": "<user_login>"
               }
           }
       head =  {
           "Authorization": "OAuth <token>",
           "X-Org-ID" or "X-Cloud-Org-ID": <organization_ID>
       }
       session.headers.update(head)
       response = session.post(url, json=json)
       data = response.json()
       print(response)
       print(data)

   my_function()
   ```

{% endlist %}

{% endcut %}