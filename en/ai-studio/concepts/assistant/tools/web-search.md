---
title: WebSearch in {{ assistant-api }}
description: This section describes WebSearch, a {{ assistant-api }} tool which enables you to create personalized assistants capable of generating responses based on information retrieved from the internet.
---

# WebSearch

AI assistants use WebSearch to fetch relevant information from public web sources and summarize it to generate a response to a user query.

You can limit the search scope to specific websites or allow access to the entire internet. We recommend setting the narrowest possible scope of target websites as this enables your assistant to respond faster. To make sure you get the most up-to-date information, configure WebSearch to filter out documents based on their last update date.

WebSearch tool is billed as a [generative response](../../../../search-api/pricing.md) in {{ search-api-full-name }}.

To enable your AI assistant to use WebSearch, do the following:

{% list tabs group=programming_language %}

- cURL {#curl}

  In the [API](../../api.md), when [creating](../../../assistants/api-ref/Assistant/create.md) or [updating](../../../assistants/api-ref/Assistant/update.md) an AI assistant, include the tool's configuration in the `genSearch` object within the `tools` array of the request body:

  ```json
  {
    ...
    "tools": [
      {
        "genSearch": {
          "options": {
            "site": {
              "site": [
                "<website_1_address_for_search>",
                "<website_2_address_for_search>",
                ...
                "<website_n_address_for_search>"
              ]
            },
            "host": {
              "host": [
                "<host_1_for_search>",
                "<host_2_for_search>",
                ...
                "<host_n_for_search>"
              ]
            },
            "url": {
              "url": [
                "<page_1_for_search>",
                "<page_2_for_search>",
                ...
                "<page_n_for_search>"
              ]
            },
            "enableNrfmDocs": true|false,
            "searchFilters": [
              {
                "date": "<document_update_date>",
                "lang": "<document_language>",
                "format": "<document_format>"
              }
            ]
          },
          "description": "<tool_description>"
        }
      }
    ],
  }
  ```

  Where:

  * The `site`, `host`, and `url` objects define the search scope. This is an optional setting. If none of these objects are specified, the search will target all internet websites.
  
      Note that the `site`, `host`, and `url` objects are mutually exclusive; you can only set one of them:

      * `site`: Restricts the search to a specific array of websites.

          For example, for the `yandex.cloud` website, the search will target all `*.yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
          * `yandex.cloud/`
          * `subdomain.yandex.cloud/`
          * `yandex.cloud/path/`
          * `subdomain.yandex.cloud/path/`

          In the `site` object, you can specify the exact path to the search area, e.g., `{{ link-docs }}`.
      * `host`: Restricts the search to a specific array of hosts.

          For example, for the `yandex.cloud/` host, the search will target all `yandex.cloud/*` documents, i.e., the results will include pages with the following URLs:
          * `yandex.cloud/`
          * `yandex.cloud/path/`

          Unlike `site`-based restrictions, `host`-based restrictions do not apply to subdomains. You also cannot provide a specific path to the search area in the `host` object.
      * `url`: Restricts the search to a specific array of pages, e.g., `{{ link-docs }}/serverless-containers/concepts/container` and `{{ link-docs }}/container-registry/concepts/docker-image`.
  * `enableNrfmDocs`: Parameter that determines whether search results will include documents which are not directly accessible from the home page. It only applies if the search scope is set by the `site` object. For example, if you want the results to include a page that is not accessible through any of the links on the home page, set `enableNrfmDocs` to `true`. This is an optional setting. The possible values are `true` or `false`.
  * `searchFilters`: Additional text to add to each query. It is used to provide the `date:`, `mime:`, and `lang:` [search operators]({{ link-yandex }}/support/search/ru/query-language/search-operators). For example, if you provide `"date": ">20250101"`, the query response will only return documents updated after January 1, 2025. This is an optional setting. The `date`, `lang`, and `format` fields are mutually exclusive: you can only provide one of them in the request body.
  * `description`: Required text description of the WebSearch tool you are creating. This description must define conditions for the AI assistant to use the tool.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../../operations/assistant/create-with-websearch.md)
* [{#T}](./vector-store.md)