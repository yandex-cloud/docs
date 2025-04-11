---
title: '{{ search-api-full-name }}''s generative response to a text query'
description: This article describes the format {{ search-api-name }}'s generative response to a text query.
---

# Generative response

You can use {{ search-api-name }} text search together with [{{ yagpt-name }}](../../foundation-models/concepts/yandexgpt/index.md) generative AI to get a comprehensive and concise _generative response_ to a user query. To generate such a response, the model analyzes the relevant text search results retrieved by {{ search-api-name }} from your company's websites. 

By default, you can send no more than one synchronous query per second to get a generative response. For more information about {{ search-api-name }} limits, see [{#T}](./limits.md).

{% include [note-preview-by-request](../../_includes/note-preview.md) %}

{% note warning %}

Until April 1, 2025, you can only get a generative response to queries sent via the [API v1](./index.md#api-v1). 

Starting April 1, 2025, the generative response feature will only be available in the [API v2](./index.md#api-v2) interface. For more information on the pricing of generative responses to queries, see [{#T}](../pricing.md).

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
  "site": [
    "<website_1_address_for_search>",
    "<website_2_address_for_search>",
    ...
    "<website_n_address_for_search>"
  ],
  "host": [
    "<host_1_for_search>",
    "<host_2_for_search>",
    ...
    "<host_n_for_search>"
  ],
  "url": [
    "<page_1_for_search>",
    "<page_2_for_search>",
    ...
    "<page_n_for_search>"
  ],
  "search_additional_text": "<additional_text_for_search>",
  "fix_misspell": true|false,
  "enable_nrfm_docs": true|false
}
```

### Request parameters

* `messages`: Single search query or a search query with context in the form of chat with the model. It is specified as an array of objects, each one containing two elements:
    * `content`: Text of user query or the model's response (depending on the `role` value).
    * `role`: Message sender's role. The possible values are:
        * `user`: Means the message is sent by the user, and the `content` field contains the user's query.
        * `assistant`: Means the message is sent by the model, and the `content` field contains the model's response.

    For more information about the {{ yagpt-name }} chat mode, see [{#T}](../../foundation-models/operations/yandexgpt/create-chat.md).
* `site`: Restricts the search to a specific array of websites.

    For example, for the `yandex.cloud` website, the search will target all `yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
    * `yandex.cloud/`
    * `subdomain.yandex.cloud/`
    * `yandex.cloud/path/`
    * `subdomain.yandex.cloud/path/`

    You can use the `site` field to specify the exact path to the search area, e.g., `{{ link-docs }}`.
* `host`: Restricts the search to a specific array of hosts.

    For example, for the `yandex.cloud/` host, the search will target all `yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
    * `yandex.cloud/`
    * `yandex.cloud/path/`

    Unlike `site`-based restrictions, `host`-based restrictions do not apply to subdomains. You also cannot provide a specific path to the search area in the `host` field.
* `url`: Restricts the search to a specific array of pages, e.g., `{{ link-docs }}/serverless-containers/concepts/container` and `{{ link-docs }}/container-registry/concepts/docker-image`.

    {% note info %}

    To restrict the search, you simply need to specify one of these fields in your query: `site`, `host`, or `url`.

    The `host` field has priority over the `site` field, and `url` has priority over `host`. If you provide all three parameters in your query, the search will be limited to the `url` value, and the `host` and `site` values will be ignored.

    {% endnote %}

* `search_additional_text`: Additional text to add to each query. It is used to provide [search operators]({{ link-yandex }}/support/search/ru/query-language/search-operators), such as `date:`, `mime:`, and `lang:`. For example, if you provide `"search_additional_text": "date:>2025-01-01"`, the query response will only return documents updated after January 1, 2025. This is an optional parameter.
* `fix_misspell`: This parameter enables checking the query text for typos. If it is set, the query text is checked for typos before sending and the response will include the `is_fixed_misspell` field to indicate whether any typos were found. If there are typos, the `fixed_misspell` field will also appear in the response, containing the fixed query text that was sent to the model. This is an optional parameter. The possible values are `true` or `false`.
* `enable_nrfm_docs`: This parameter determines whether search results will include documents which are not directly accessible from the home page. It only applies if the search scope is set by the `site` parameter. For example, if you want the results to include a page that is not accessible through any of the links on the home page, set `enable_nrfm_docs` to `true`. This is an optional parameter. The possible values are `true` or `false`.

Request body example:

```json
{
  "messages": [
    {
      "content": "What is containerization and how is it implemented in {{ yandex-cloud }}?",
      "role": "user"
    }
  ],
  "site": [
    "https://ru.wikipedia.org/wiki/Контейнеризация",
    "{{ link-docs }}/serverless-containers/",
    "{{ link-docs }}/container-registry/"
  ],
  "search_additional_text": "date:>2025-01-01",
  "fix_misspell": "true",
  "enable_nrfm_docs": "true"
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

  SEARCH_API_GENERATIVE = (
      f"https://ya.ru/search/xml/generative?folderid={os.getenv('FOLDER_ID')}"
  )

  def main():
      headers = {"Authorization": f"Api-Key {os.getenv('API_KEY')}"}
      data = {
          "messages": [
              {
                  "content": "What is containerization and how is it implemented in Yandex Cloud?",
                  "role": "user",
              }
          ],
          "site": [
              "https://ru.wikipedia.org/wiki/Контейнеризация",
              "https://yandex.cloud/ru/docs/serverless-containers/",
              "https://yandex.cloud/ru/docs/container-registry/",
          ],
          "search_additional_text": "date:>2025-01-01",
          "fix_misspell": "true",
          "enable_nrfm_docs": "true",
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
  "search_queries": [
    "<additional_query_1>",
    "<additional_query_2>",
    ...
    "<additional_query_n>"
  ],
  "is_answer_rejected": false|true,
  "is_bullet_answer": false|true,
  "used_sources": {
    "1": {
      "url": "<link_1>",
      "title": "<title_1>"
    },
    "2": {
      "url": "<link_2>",
      "title": "<title_2>"
    },
    ...
    "n": {
      "url": "<link_n>",
      "title": "<title_n>"
    }
  },
  "search_reqid": "<Yandex_Search_query_ID>",
  "search_reqids": [
    "<query_1_ID>",
    "<query_2_ID>",
    ...
    "<query_n_ID>"
  ],
  "is_fixed_misspell": true|false,
  "fixed_misspell": "<fixed_query_text >",
  "reqid": "<Search_API_query_ID>"
}
```

Where:
* `message.content`: Text of the generative response. The footnotes within the text refer to sources, which are listed in the `used_sources` field.
* `links`: List of links to documents found when processing the query, which could be used by {{ yagpt-name }} to generate the response.
* `titles`: List of document titles.
* `final_search_query`: Final text of the search query, refined by the {{ yagpt-name }} model and used for the generative response. May be different from the original user query.
* `search_queries`: List of additional search queries sent by the generative model to the search engine.
* `is_answer_rejected`: Indicates the model's refusal to provide a response for ethical reasons:

    * `false`: Model has returned a response.
    * `true`: Model has refused to return a response.

* `is_bullet_answer`: Indicates a bullet answer where the model cannot give a proper response and returns a set of bullets with various data.
* `used_sources`: Array of links directly used in generating the response, with footnotes in `message.content`.
* `search_reqid`: Unique query ID in Yandex Search.
* `search_reqids`: List of unique IDs of search queries.
* `is_fixed_misspell`: Indicates whether any typos were found in the query text. This parameter is optional. It appears in the response only if you provide `fix_misspell` in the request body. The possible values are `true` or `false`.
* `fixed_misspell`: Fixed query text. This parameter is optional. It appears in the response only if you provide `fix_misspell` in the request body and typos were found in the query text.
* `reqid`: {{ search-api-name }} unique query ID.

Here is an example of a generative response with website limitation:

```json
{
  "message": {
    "content": "**Containerization** is a virtualization technique where the operating system 
    kernel manages several isolated user-space instances 
    rather than just one. [2] These instances, typically called containers or zones, behave like 
    separate OS instances in terms of the processes running in them. 
    [2] The kernel provides complete isolation between containers, ensuring that programs from different 
    containers cannot interfere with each other. [2]\n\n**In {{ yandex-cloud }}, 
    containerization is implemented through {{ serverless-containers-full-name }}**. 
    [1][3] It enables you to launch an app contained in a Docker image in your cloud. 
    [1] After creating a container revision, you can invoke it via HTTPS, using a trigger 
    or the {{ api-gw-full-name }} extension. [1]\n\n**To store and distribute 
    Docker images**, {{ yandex-cloud }} uses **{{ container-registry-full-name }}**. 
    [9] These images reside in the same {{ yandex-cloud }} data centers as 
    the other cloud infrastructure, ensuring high-speed access to images 
    and zero external traffic costs. [9]",
    "role": "assistant"
  },
  "links": [
    "{{ link-docs }}/serverless-containers/concepts/container",
    "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
    "{{ link-docs }}/serverless-containers/tutorials/deploy-app-container",
    "{{ link-docs }}/serverless-containers/quickstart/",
    "{{ link-docs }}/serverless-containers/operations/",
    "{{ link-docs }}/container-registry/tutorials/gitlab-containers",
    "{{ link-docs }}/container-registry/tutorials/run-docker-on-vm/",
    "{{ link-docs }}/serverless-containers/operations/environment-variables-add",
    "{{ link-docs }}/container-registry/",
    "{{ link-docs }}/container-registry/operations/docker-image/docker-image-push"
  ],
  "titles": [
    "Container in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
    "Containerization (Wikipedia)",
    "Running a containerized app in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
    "Getting started with {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
    "Guides on using {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
    "Continuous deployment of containerized applications using GitLab | {{ yandex-cloud }} documentation",
    "Running a Docker image on a VM | {{ yandex-cloud }} documentation",
    "Adding container environment variables | {{ yandex-cloud }} documentation",
    "{{ container-registry-full-name }} | {{ yandex-cloud }} documentation",
    "Pushing a Docker image to a registry in Container Registry | {{ yandex-cloud }} documentation"
  ],
  "final_search_query": "what is containerization date 2025 01 01 date 2025 01 01 date 2025 01 01",
  "search_queries": [
    "what is containerization and how is it implemented in yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
    "how is containerization implemented in yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
    "what is containerization date 2025 01 01 date 2025 01 01 date 2025 01 01"
  ],
  "is_answer_rejected": false,
  "is_bullet_answer": false,
  "used_sources": {
    "1": {
      "url": "https://yandex.cloud/ru/docs/serverless-containers/concepts/container",
      "title": "Container in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation"
    },
    "2": {
      "url": "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
      "title": "Containerization (Wikipedia)"
    },
    "3": {
      "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/deploy-app-container",
      "title": "Running a containerized app in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation"
    },
    "9": {
      "url": "https://yandex.cloud/ru/docs/container-registry/",
      "title": "{{ container-registry-full-name }} | {{ yandex-cloud }} documentation"
    }
  },
  "search_reqid": "17411978********-11075146747********-ngp6et3xflkdijxp-BAL",
  "search_reqids": [
    "17411978********-43463840495********-ngp6et3xflkdijxp-BAL",
    "17411978********-10071988840********-w3usj3adrg7trlwu-BAL",
    "17411978********-11075146747********-ngp6et3xflkdijxp-BAL"
  ],
  "is_fixed_misspell": true,
  "fixed_misspell": "What is containerization and how is it implemented in {{ yandex-cloud }}?",
  "reqid": "17411978********-152552007787********-balancer-l7leveler-kubr-yp-vla-32-BAL"
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
