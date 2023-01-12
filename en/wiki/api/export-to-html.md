# Exporting a page in HTML

A request enables you to export the text of a page in HTML format.

Use the request to retrieve the text of a page and place it on another web resource. For example, the service instruction is written in {{ wiki-name }} and can be displayed on the service page.

## API access {#access}

Before making the request, get permission to access the {{ wiki-name }} API. To do this, follow the [link](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b) and copy the OAuth token for authorization.

## Request format {#query}

To export the text of a page in HTML format, use the HTTP request with the `GET` method:

```json
GET /.html?page=/<section-name>/<page-name>/
Host: https://wiki.yandex-team.ru
Authorization: OAuth <your OAuth token>
```

{% cut "Resource" %}

| Parameter | Description | Data type |
----- | ----- | -----
| \<page-name\> | Page address relative to the {{ wiki-name }} root section. For example: `/mySection/myPage/` | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Successful execution of the request

   {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

   The response body contains a page in HTML format with loaded dynamic blocks.

- The request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

   {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}