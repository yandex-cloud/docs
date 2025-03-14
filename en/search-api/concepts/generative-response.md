---
title: '{{ search-api-full-name }}''s generative response to a text query'
description: This article describes the format {{ search-api-name }}'s generative response to a text query.
---

# Generative response

You can use {{ search-api-name }} text search together with [{{ yagpt-name }}](../../foundation-models/concepts/yandexgpt/index.md) generative AI to get a comprehensive and concise _generative response_ to a user query. To generate such a response, the model analyzes the relevant text search results retrieved by {{ search-api-name }} from your company's websites.

{% include [note-preview-by-request](../../_includes/note-preview.md) %}

{% note warning %}

Until April 1, 2025, you can get a generative response only to queries submitted via the [API v1](./index.md#api-v1).

From April 1, 2025, the generative response functionality will be available only in the [API v2](./index.md#api-v2) interface. For more information about the cost of getting generative responses, see [{#T}](../pricing.md)

{% endnote %}

## Search query {#request}

Queries to {{ search-api-name }} seeking a generative response are submitted using the POST method to the `{{ link-yandex }}/search/xml/generative` endpoint.

To run queries, you need a [service account](../../iam/concepts/users/service-accounts.md) with the `search-api.executor` [role](../security/index.md#search-api-executor) and an [API key](../../iam/concepts/authorization/api-key.md) created for it. To [authenticate](../operations/auth.md) successfully, provide the [folder ID](../../resource-manager/operations/folder/get-id.md) and API key of the service account in each query.

### Request format {#body}

Each query seeking a generative response must contain the following request body in [JSON](https://en.wikipedia.org/wiki/JSON) format:

```json
{
  "messages": [
    {
      "content": "<message_1_text>",
      "role": "user"
    },
    {
      "content": "<model_1_response>",
      "role": "assistant"
    },
    {
      "content": "<message_2_text>",
      "role": "user"
    },
    {
      "content": "<model_3_response>",
      "role": "assistant"
    },
    ...
    {
      "content": "<message_n_text>",
      "role": "user"
    }
  ],
  "site": "<website_address_for_search>",
  "host": "<host_for_search>",
  "url": "<page_for_search>"
}
```

### Request parameters

* `messages`: Single search query or a search query with context in the form of chat with the model. It is specified as an array of objects, each one containing two elements:
    * `content`: Text of user query or the model's response (depending on the `role` value).
    * `role`: Message sender's role. The possible values are:
        * `user`: Means the message is sent by the user, and the `content` field contains the user's query.
        * `assistant`: Means the message is sent by the model, and the `content` field contains the model's response.

    For more information about the {{ yagpt-name }} chat mode, see [{#T}](../../foundation-models/operations/yandexgpt/create-chat.md).

* `site`: Restricts the search to a specific website, e.g., `yandex.cloud`.

    The search will target all `*.yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
    * `yandex.cloud/`
    * `subdomain.yandex.cloud/`
    * `yandex.cloud/path/`
    * `subdomain.yandex.cloud/path/`

    You can use the `site` field to specify the exact path to the search area, e.g., `{{ link-docs }}`.
 
* `host`: Restricts the search to a specific host, e.g., `yandex.cloud/`.

    The search will target all `yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
    * `yandex.cloud/`
    * `yandex.cloud/path/`

    Unlike `site`-based restrictions, `host`-based restrictions do not apply to subdomains. You also cannot provide a specific path to the search area in the `host` field.

* `url`: Restricts the search to a specific page, e.g., `{{ link-docs }}/search-api/pricing`.

    {% note info %}

    To restrict the search, you simply need to specify one of these fields in your query: `site`, `host`, or `url`.

    The `host` field has priority over the `site` field, and `url` has priority over `host`. If you provide all three parameters in your query, the search will be limited to the `url` value, and the `host` and `site` values will be ignored.

    {% endnote %}

Request body example:

```json
{
  "messages": [
    {
      "content": "How much does {{ search-api-name }} cost?",
      "role": "user"
    }
  ],
  "site": "{{ link-docs }}"
}
```

### Submitting a query {#send-request}

To submit a query, use the [cURL](https://curl.haxx.se) utility or [Python](https://python.org/). Before submitting your query, save the [folder ID](../../resource-manager/operations/folder/get-id.md) and [API key](../../iam/concepts/authorization/api-key.md) of your service account to environment variables:

```bash
export FOLDER_ID=<folder_ID>
export API_KEY=<API_key>
```

{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  curl \
    --request POST \
    --header "Authorization: Api-Key ${API_KEY}" \
    --data "@<path_to_request_body_file>" \
    "{{ link-yandex }}/search/xml/generative?folderid=${FOLDER_ID}"
  ```

- Python 3 {#python}

  ```python
  import requests
  import os

  SEARCH_API_GENERATIVE = f"https://ya.ru/search/xml/generative?folderid={os.getenv('FOLDER_ID')}"


  def main():
      headers = {"Authorization": f"Api-Key {os.getenv('API_KEY')}"}
      data = {
          "messages": [
             {
                  "content": "How much does {{ search-api-name }} cost?",
                  "role": "user"
              }
          ],
          "url": "{{ link-docs }}/search-api/pricing"
      }

      response = requests.post(SEARCH_API_GENERATIVE, headers=headers, json=data)

      if "application/json" in response.headers["Content-Type"]:
          print(response.json()["message"]["content"])
          for i, link in enumerate(response.json()["links"], start=1):
              print(f"[{i}]: {link}")
      elif "text/xml" in response.headers["Content-Type"]:
          print("Error:", response.text)
      else:
          print("Unexpected content type:", response.text)


  if __name__ == "__main__":
      main()
  ```

{% endlist %}

## Generative response {#response}

{{ search-api-name }} returns a JSON format response with the following syntax:

```json
{
  "message": {
    "content": "<response_text>",
    "role": "assistant"
  },
  "links": [
    "<link_to_found_document_1>",
    "<link_to_found_document_2>",
    ...
    "<link_to_found_document_n>"
  ],
  "titles": [
    "<title_of_found_document_1>",
    "<title_of_found_document_2>",
    ...
    "<title_of_found_document_n>"
  ],
  "final_search_query": "<refined_query_text>",
  "is_answer_rejected": false (true),
  "is_bullet_answer": false (true),
  "search_reqid" : "...",
  "reqid" : "..."
}
```

Where:
* `content`: Text of the generative response.
* `links`: Sorted list of links to documents found when processing the query which could be used by {{ yagpt-name }} to generate the response.
* `titles`: Sorted list of document titles.
* `final_search_query`: Final text of the search query, refined by the {{ yagpt-name }} model and used for the generative response. May be different from the original user query.
* `is_answer_rejected`: Indicates the model's refusal to provide a response for ethical reasons:

    * `false`: Model has returned a response.
    * `true`: Model has refused to return a response.

* `is_bullet_answer`: Indicates a bullet answer where the model cannot give a proper response and returns a set of bullets with various data.
* `search_reqid`: Unique query ID in Yandex Search.
* `reqid`: {{ search-api-name }} unique query ID.

Here is an example of a generative response with website limitation:

```json
{
  "message": {
      "content": "The cost of {{ search-api-name }} **is calculated based on the number of search queries initiated within a calendar month**. [1]\n\n**Price per 1,000 queries**, including VAT: [1]\n- Night-time queries, first 1,000 queries per month: free of charge. [1]\n- Night-time queries, over 1,000 requests per month: ₽360. [1]\n- Daytime queries: ₽480. [1]\n\nThe service has a quota of 30,000 queries per month (1,000 queries per day) for all new users. [1]\n\nPrices may differ from region to region, and payment currency depends on the legal entity the user signed the agreement with. [1]",
      "role": "assistant"
  },
  "links": [
      "{{ link-docs }}/search-api/pricing",
      "{{ link-docs }}/search-api/concepts/generative-response",
      "{{ link-docs }}/api-gateway/pricing",
      "{{ link-docs }}/functions/pricing",
      "{{ link-docs }}/ydb/pricing/ru-docapi"
  ],
  "titles": [
      "{{ search-api-full-name }} pricing policy | {{ yandex-cloud }} documentation",
      "Generative response | {{ yandex-cloud }} documentation",
      "{{ api-gw-full-name }} pricing policy | {{ yandex-cloud }} documentation",
      "{{ sf-name }} pricing policy | {{ yandex-cloud }} documentation",
      "Rules for estimating the cost of queries to {{ ydb-short-name }} via Document API | {{ yandex-cloud }} documentation"
  ],
  "final_search_query": "{{ search-api-name }} cost",
  "is_answer_rejected": false,
  "is_bullet_answer": false,
  "search_reqid": "1716922280912146-404265690610183965-**************-BAL",
  "reqid": "1716922280829905-8678730291785779856-********-l7leveler-***-**-***-***-BAL"
}
```

### Response features {#special-circumstances}

Based on the query and search results, {{ search-api-name }} may include the following warnings in a generative response:

* If no relevant documents were found:

    > **No results found.**
    > Rephrase your query or ask something else.

* If {{ search-api-name }} has found the relevant source documents but was unable to extract information:

    > Failed to extract the requested information from the documents. You can try opening them yourself or view the search results.

* If {{ search-api-name }} has found the source documents and succeeded extracting the information but is doubtful about response quality, it will preface its response with:

    > There is various information on this topic online. You can find its overview below.
