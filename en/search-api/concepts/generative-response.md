---
title: '{{ search-api-full-name }}''s generative response to a text query'
description: This article describes the format {{ search-api-name }}'s generative response to a text query.
---

# Generative response

You can use {{ search-api-name }} text search together with [{{ yagpt-name }}](../../foundation-models/concepts/yandexgpt/index.md) generative AI to get a comprehensive and concise _generative response_ to a user query. To generate such a response, the model analyzes the relevant text search results retrieved by {{ search-api-name }} from your company's websites.

By default, you can send no more than one synchronous query per second to get a generative response. For more information about {{ search-api-name }} limits, see [{#T}](./limits.md).

The generative response feature is only available in the [API v2](./index.md#api-v2) interface. For more information on the pricing of generative responses to queries, see [{#T}](../pricing.md).

You need the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user) to run queries.

{% note info %}

You can get a generative response only when searching within a given search area: an array of sites, hosts, or pages. No generative response is available when querying the Yandex search database.

{% endnote %}

## Request body format {#body}

The names of the request body fields are different in [REST API](../api-ref/index.md) and [gPRC API](../api-ref/grpc/index.md): the former uses [camelCase](https://en.wikipedia.org/wiki/Camel_case), while the latter uses [snake_case](https://en.wikipedia.org/wiki/Snake_case).

Each query seeking a generative response must contain the following request body in [JSON](https://en.wikipedia.org/wiki/JSON) format:

{% list tabs group=instructions %}

- REST API {#api}

  ```json 
  {
    "messages": [
      {
        "content": "<message_1_text>",
        "role": "ROLE_USER"
      },
      {
        "content": "<model_2_response>",
        "role": "ROLE_ASSISTANT"
      },
      {
        "content": "<message_3_text>",
        "role": "ROLE_USER"
      },
      {
        "content": "<model_4_response>",
        "role": "ROLE_ASSISTANT"
      },
      ...
      {
        "content": "<message_n_text>",
        "role": "ROLE_USER"
      }
    ],
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
    "folderId": "<folder_ID>",
    "fixMisspell": true|false,
    "enableNrfmDocs": true|false,
    "searchFilters": [
      {
        "date": "<document_update_date>",
        "lang": "<document_language>",
        "format": "<document_format>"
      }
    ]
  }
  ```

  Where:

  {% include [gen-response-legend-part1](../../_includes/search-api/gen-response-legend-part1.md) %}

  * `folderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
  * `fixMisspell`: This parameter enables checking the query text for typos. If the parameter is set, the query text is checked for typos before it is sent. If there are typos, the `fixedMisspellQuery` field is added to the response, containing the fixed query text that was sent to the model. This is an optional parameter. The possible values are `true` or `false`.
  * `enableNrfmDocs`: This parameter determines whether search results will include documents which are not directly accessible from the home page. It only applies if the search scope is set by the `site` parameter. For example, if you want the results to include a page that is not accessible through any of the links on the home page, set `enableNrfmDocs` to `true`. This is an optional parameter. The possible values are `true` or `false`.
  * `searchFilters`: Additional text to add to each query. It is used to provide the `date:`, `mime:`, and `lang:` [search operators]({{ link-yandex }}/support/search/ru/query-language/search-operators). For example, if you provide `"date": ">20250101"`, the query response will only return documents updated after January 1, 2025. This is an optional parameter. The `date`, `lang`, and `format` fields are mutually exclusive: you can only provide one of them in the request body.

  {% cut "Request body example:" %}

  ```json
  {
    "messages": [
      {
        "content": "What is containerization and how is it implemented in {{ yandex-cloud }}?",
        "role": "ROLE_USER"
      }
    ],
    "site": {
      "site": [
          "https://ru.wikipedia.org/wiki/Контейнеризация",
          "https://yandex.cloud/ru/docs/serverless-containers/",
          "https://yandex.cloud/ru/docs/container-registry/"
      ]
    },
    "folderId": "aoevhr118rhc********",
    "fixMisspell": "true",
    "enableNrfmDocs": "true",
    "searchFilters": [
      {
        "date": ">20250101"
      }
    ]
  }
  ```

  {% endcut %}

- gRPC API {#grpc-api}

  ```json 
  {
    "messages": [
      {
        "content": "<message_1_text>",
        "role": "ROLE_USER"
      },
      {
        "content": "<model_1_response>",
        "role": "ROLE_ASSISTANT"
      },
      {
        "content": "<message_2_text>",
        "role": "ROLE_USER"
      },
      {
        "content": "<model_3_response>",
        "role": "ROLE_ASSISTANT"
      },
      ...
      {
        "content": "<message_n_text>",
        "role": "ROLE_USER"
      }
    ],
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
    "folder_id": "<folder_ID>",
    "fix_misspell": true|false,
    "enable_nrfm_docs": true|false,
    "search_filters": [
      {
        "date": "<document_update_date>",
        "lang": "<document_language>",
        "format": "<document_format>"
      }
    ]
  }
  ```

  Where:

  {% include [gen-response-legend-part1](../../_includes/search-api/gen-response-legend-part1.md) %}

  * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
  * `fix_misspell`: This parameter enables checking the query text for typos. If the parameter is set, the query text is checked for typos before it is sent. If there are typos, the `fixed_misspell_query` field is added to the response, containing the fixed query text that was sent to the model. This is an optional parameter. The possible values are `true` or `false`.
  * `enable_nrfm_docs`: This parameter determines whether search results will include documents which are not directly accessible from the home page. It only applies if the search scope is set by the `site` parameter. For example, if you want the results to include a page that is not accessible through any of the links on the home page, set `enable_nrfm_docs` to `true`. This is an optional parameter. The possible values are `true` or `false`.
  * `search_filters`: Additional text to add to each query. It is used to provide the `date:`, `mime:`, and `lang:` [search operators]({{ link-yandex }}/support/search/ru/query-language/search-operators). For example, if you provide `"date": ">20250101"`, the query response will only return documents updated after January 1, 2025. This is an optional parameter. The `date`, `lang`, and `format` fields are mutually exclusive: you can only provide one of them in the request body.

  {% cut "Request body example:" %}

  ```json
  {
    "messages": [
      {
        "content": "What is containerization and how is it implemented in {{ yandex-cloud }}?",
        "role": "ROLE_USER"
      }
    ],
    "site": {
      "site": [
          "https://ru.wikipedia.org/wiki/Контейнеризация",
          "https://yandex.cloud/ru/docs/serverless-containers/",
          "https://yandex.cloud/ru/docs/container-registry/"
      ]
    },
    "folder_id": "aoevhr118rhc********",
    "fix_misspell": "true",
    "enable_nrfm_docs": "true",
    "search_filters": [
      {
        "date": ">20250101"
      }
    ]
  }
  ```

  {% endcut %}

{% endlist %}

## Submitting a query {#send-request}

{% list tabs group=instructions %}

- REST API {#api}

  To send a query, use the [search](../api-ref/GenSearch/search.md) method for [GenSearch](../api-ref/GenSearch/index.md). Install [cURL](https://curl.haxx.se) and [jq](https://stedolan.github.io/jq) if needed:

  ```bash
  curl \
    --request POST \
    --header "Authorization: Bearer <IAM_token>" \
    --data "@<file_path>" \
    "https://searchapi.{{ api-host }}/v2/gen/search" \
    | jq
  ```

  {% include [gen-response-request-legend](../../_includes/search-api/gen-response-request-legend.md) %}

- gRPC API {#grpc-api}

  To send a query, use the [GenSearchService/Search](../api-ref/grpc/GenSearch/search.md) call. Install [gRPCurl](https://github.com/fullstorydev/grpcurl) and [jq](https://stedolan.github.io/jq) if needed:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \
    -d @ <file_path> \
    searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.GenSearchService/Search \
    | jq
  ```

  {% include [gen-response-request-legend](../../_includes/search-api/gen-response-request-legend.md) %}

{% endlist %}

## Generative response {#response}

{{ search-api-name }} returns a JSON format response with the following syntax:

{% list tabs group=instructions %}

- REST API {#api}

  ```json
  {
    "message": {
      "content": "<response_text>",
      "role": "ROLE_ASSISTANT"
    },
    "sources": [
      {
        "used": false|true,
        "url": "<link_to_found_document_1>",
        "title": "<title_of_found_document_1>"
      },
      {
        "used": false|true,
        "url": "<link_to_found_document_2>",
        "title": "<title_of_found_document_2>"
      },
      ...
      {
        "used": false|true,
        "url": "<link_to_found_document_n>",
        "title": "<title_of_found_document_n>"
      }
    ],
    "searchQueries": [
      {
        "text": "<query_1_text>",
        "reqId": "<query_1_ID>"
      },
      {
        "text": "<query_2_text>",
        "reqId": "<query_2_ID>"
      },
      ...
      {
        "text": "<query_n_text>",
        "reqId": "<query_n_ID>"
      },
    ],
    "isAnswerRejected": false|true,
    "isBulletAnswer": false|true,
    "fixedMisspellQuery": "<fixed_query_text >"
  }
  ```

  Where:
  * `message.content`: Text of the generative response. The footnotes within the text refer to sources, the list and order of which are given in the `sources` field.
  * `sources`: Array of source documents that were found during the query, could be used by {{ yagpt-name }} as data sources when forming the response, and can be footnoted in the `message.content` field. Each source document contains the following fields:

      * `used`: Indicates whether the document was used to generate the response. The possible values are `true` or `false`.
      * `url`: Document URL.
      * `title`: Document title.
  * `searchQueries`: List of additional search queries sent by the generative model to the search engine. Each query contains the following fields:

      * `text`: Search query text.
      * `reqId`: {{ search-api-name }} unique query ID.
  * `isAnswerRejected`: Indicates the model's refusal to provide a response for ethical reasons:

      * `false`: Model has returned a response.
      * `true`: Model has refused to return a response.
  * `isBulletAnswer`: Indicates a bullet response where the model cannot give a proper response and suggests a set of bullets with various information:

      * `false`: Model gave a good answer.
      * `true`: Model suggested a set of bullets.
  * `fixedMisspellQuery`: Fixed query text. This parameter is optional. It appears in the response only if you provide `fixMisspell` in the request body and typos were found in the query text.

  {% cut "Here is an example of a generative response with website limitation:" %}

  ```json
  [
    {
      "message": {
        "content": "**Containerization** (OS-level virtualization) is a **virtualization method** 
        in which the OS kernel manages several isolated user-space instances 
        instead of a single one. [1] These instances (containers or zones) are identical
        to a separate OS instance in terms of the processes running inside them. [1] vCPU 
        provides complete container isolation, so applications from different containers 
        have no impact on one another. [1]\n\n**In {{ yandex-cloud }}, containerization is implemented with the help of 
        {{ serverless-containers-full-name }}**. [5][6] A container allows you to run an application 
        contained in a Docker image, in {{ yandex-cloud }}. [6] \n\n**Some aspects of containerization in 
        {{ yandex-cloud }}:**\n\n* **Creating a container revision**. [6] You can only create a container revision 
        from a Docker image uploaded to a registry in {{ container-registry-full-name }}. [6] Other registries are not 
        supported. [6] The revision contains all the information you need to run the container. [6]\n* 
        **Invoking a container**. [6] Once you have created a revision, you can invoke the container via HTTPS 
        using a trigger or the {{ api-gw-full-name }} extension. [6]\n* **Scaling a container**. [6] If 
        the container is invoked faster than the instance can process the request, the service scales the container 
        by running additional instances of it. [6] This enables concurrent request 
        processing. [6]\n* **Provisioned instances**. [6] A provisioned instance 
        is a container instance that is guaranteed not to have a cold start when you run it. [6]",
        "role": "ROLE_ASSISTANT"
      },
      "sources": [
        {
          "used": false,
          "url": "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
          "title": "Containerization (Wikipedia)"
        },
        {
          "used": true,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/functions-framework-to-container",
          "title": "Developing functions in Functions Framework and deploying them to {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/container-registry/",
          "title": "{{ container-registry-full-name }} | {{ yandex-cloud }} documentation"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/container-registry/concepts/docker-image",
          "title": "Docker image. What is it and how does it work? | {{ yandex-cloud }} documentation"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/operations/",
          "title": "How to work with {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation"
        },
        {
          "used": true,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/concepts/container",
          "title": "Container in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation"
        },
        {
          "used": true,
          "url": "https://yandex.cloud/ru/docs/container-registry/operations/docker-image/docker-image-push",
          "title": "Pushing a Docker image to a registry in {{ container-registry-name }} | {{ yandex-cloud }} documentation"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/deploy-app-container",
          "title": "Running a containerized app in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/container-registry/tutorials/fault-tolerance",
          "title": "Configuring a fault-tolerant architecture in {{ yandex-cloud }} | {{ yandex-cloud }} documentation"
        },
        {
          "used": false,
          "url": "https://yandex.cloud/ru/docs/serverless-containers/tf-ref",
          "title": "{{ TF }} reference for {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation"
        }
      ],
      "searchQueries": [
        {
          "text": "what is containerization and how is it implemented in yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
          "reqId": "1742492744075717-6834712924673670818-e23cqdex********-BAL"
        },
        {
          "text": "how containerization is implemented in yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
          "reqId": "1742492744352285-5531077099747983300-hhsihxn5********-BAL"
        },
        {
          "text": "what is containerization date 2025 01 01 date 2025 01 01 date 2025 01 01",
          "reqId": "1742492744351443-10540017330195862709-gai4ndrg********-BAL"
        }
      ],
      "isAnswerRejected": false,
      "isBulletAnswer": false,
      "fixedMisspellQuery": "What is containerization and how is it implemented in Yandex Cloud?"
    }
  ]
  ```

  {% endcut %}

- gRPC API {#grpc-api}

  ```json
  {
    "message": {
      "content": "<response_text>",
      "role": "ROLE_ASSISTANT"
    },
    "sources": [
      {
        "url": "<link_to_found_document_1>",
        "title": "<title_of_found_document_1>",
        "used": false|true
      },
      {
        "url": "<link_to_found_document_2>",
        "title": "<title_of_found_document_2>",
        "used": false|true
      },
      ...
      {
        "url": "<link_to_found_document_n>",
        "title": "<title_of_found_document_n>",
        "used": false|true
      }
    ],
    "search_queries": [
      {
        "text": "<query_1_text>",
        "req_id": "<query_1_ID>"
      },
      {
        "text": "<query_2_text>",
        "req_id": "<query_2_ID>"
      },
      ...
      {
        "text": "<query_n_text>",
        "req_id": "<query_n_ID>"
      },
    ],
    "is_answer_rejected": false|true,
    "is_bullet_answer": false|true,
    "fixed_misspell_query": "<fixed_query_text >"
  }
  ```

  Where:
  * `message.content`: Text of the generative response. The footnotes within the text refer to sources, the list and order of which are given in the `sources` field.
  * `sources`: Array of source documents that were found during the query, could be used by {{ yagpt-name }} as data sources when forming the response, and can be footnoted in the `message.content` field. Each source document contains the following fields:

      * `url`: Document URL.
      * `title`: Document title.
      * `used`: Indicates whether the document was used to generate the response. The possible values are `true` or `false`.
  * `search_queries`: List of additional search queries sent by the generative model to the search engine. Each query contains the following fields:

      * `text`: Search query text.
      * `req_id`: {{ search-api-name }} unique query ID.
  * `is_answer_rejected`: Indicates the model's refusal to provide a response for ethical reasons:

      * `false`: Model has returned a response.
      * `true`: Model has refused to return a response.
  * `is_bullet_answer`: Indicates a bullet response where the model cannot give a proper response and suggests a set of bullets with various information:

      * `false`: Model gave a good answer.
      * `true`: Model suggested a set of bullets.
  * `fixed_misspell_query`: Fixed query text. This parameter is optional. It appears in the response only if you provide `fix_misspell` in the request body and typos were found in the query text.

  {% cut "Here is an example of a generative response with website limitation:" %}

  ```json
  {
    "message": {
      "content": "**Containerization** (OS-level virtualization) is a **virtualization method** 
      in which the OS kernel manages several isolated user-space instances 
      instead of a single one. [1] These instances (containers or zones) are identical 
      to a separate OS instance in terms of the processes running inside them. [1] vCPU provides 
      complete container isolation, so applications from different containers have no impact 
      on one another. [1]\n\n**In {{ yandex-cloud }}, containerization is implemented with the help of 
      {{ serverless-containers-full-name }}**. [7] It allows you to run an application 
      contained in a Docker image, in {{ yandex-cloud }}. [7] \n\n**Some aspects of containerization in 
      {{ yandex-cloud }}:**\n\n* **Creating a container revision**. [7] You can only create a revision 
      from a Docker image uploaded to a registry in {{ container-registry-full-name }}. [7] Other registries are not supported. 
      . [7] The revision contains all the information you need to run the container. [7]\n* **Invoking 
      a container**. [7] Once you have created a revision, you can invoke the container via HTTPS using a trigger 
      or the {{ api-gw-full-name }} extension. [7]\n* **Scaling a container**. [7] If the container is invoked 
      faster than the instance can process the request, the service scales the container by running 
      its additional instances. [7] This ensures parallel processing of queries. [7]\n* 
      **Provisioned instances**. [7] This is a container instance that is guaranteed not to have 
      a cold start when you run it. [7] In a provisioned instance, before the container is invoked, 
      the {{ serverless-containers-name }} runtime components are initialized, and the user application is loaded and initialized. [7]",
      "role": "ROLE_ASSISTANT"
    },
    "sources": [
      {
        "url": "https://ru.wikipedia.org/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F",
        "title": "Containerization (Wikipedia)",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/functions-framework-to-container",
        "title": "Developing functions in Functions Framework and deploying them to {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
        "used": true
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/",
        "title": "Yandex Container Registry | {{ yandex-cloud }} documentation",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/concepts/docker-image",
        "title": "Docker image. What is it and how does it work? | {{ yandex-cloud }} documentation",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/operations/docker-image/docker-image-push",
        "title": "Pushing a Docker image to a registry in {{ container-registry-name }} | {{ yandex-cloud }} documentation",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/tutorials/deploy-app-container",
        "title": "Running a containerized app in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/concepts/container",
        "title": "Container in {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/tf-ref",
        "title": "{{ TF }} reference for {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
        "used": true
      },
      {
        "url": "https://yandex.cloud/ru/docs/serverless-containers/operations/",
        "title": "How to work with {{ serverless-containers-full-name }} | {{ yandex-cloud }} documentation",
        "used": false
      },
      {
        "url": "https://yandex.cloud/ru/docs/container-registry/tutorials/fault-tolerance",
        "title": "Configuring a fault-tolerant architecture in {{ yandex-cloud }} | {{ yandex-cloud }} documentation",
        "used": false
      }
    ],
    "search_queries": [
      {
        "text": "what is containerization and how is it implemented in yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
        "req_id": "1742493532407414-13584885235180537459-jjleoq7t********-BAL"
      },
      {
        "text": "how containerization is implemented in yandex cloud date 2025 01 01 date 2025 01 01 date 2025 01 01",
        "req_id": "1742493532717030-17218638161437229208-rs6g5w5h********-BAL"
      },
      {
        "text": "what is containerization date 2025 01 01 date 2025 01 01 date 2025 01 01",
        "req_id": "1742493532716328-3123354248981714225-rs6g5w5h********-BAL"
      }
    ],
    "is_answer_rejected": false,
    "is_bullet_answer": false,
    "fixed_misspell_query": "What is containerization and how is it implemented in {{ yandex-cloud }}?"
  }
  ```

  {% endcut %}

{% endlist %}

## Response features {#special-circumstances}

Based on the query and search results, {{ search-api-name }} may include the following warnings in a generative response:

* If no relevant documents were found:

    > **No results found.**
    > Rephrase your query or ask something else.

* If {{ search-api-name }} has found the relevant source documents but was unable to extract information:

    > Failed to extract the requested information from the documents. You can try opening them yourself or view the search results.

* If {{ search-api-name }} has found the source documents and succeeded extracting the information but is doubtful about response quality, it will preface its response with:

    > There is various information on this topic online. You can find its overview below.
