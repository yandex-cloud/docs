---
title: How to perform text search in {{ search-api-full-name }} in deferred mode
description: Follow this guide to learn how to use {{ search-api-name }} to send search queries and get search results in XML or HTML format in deferred (asynchronous) mode.
---

# Performing text search queries in deferred mode

With {{ search-api-name }}, you can perform text search through the Yandex search database and get search results in [XML](../concepts/response.md) or [HTML](../concepts/html-response.md) format in deferred (asynchronous) mode. You can run queries using the [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/), and [gRPC API](../api-ref/grpc/). The search results you get depend on the parameters specified in your query.

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Get your cloud ready {#initial-setup}

To use the examples:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user) to it.
  1. {% include [sdk-before-begin-step2](../../_includes/search-api/sdk-before-begin-step2.md) %}
  1. {% include [sdk-before-begin-step3](../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. {% include [sdk-before-begin-step6](../../_includes/ai-studio/sdk-before-begin-step6.md) %}

- REST API {#api}

  {% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

  To use the examples, you should additionally install [cURL](https://curl.haxx.se) and [jq](https://stedolan.github.io/jq).

- gRPC API {#grpc-api}

  {% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

  To use the examples, you should additionally install [gRPCurl](https://github.com/fullstorydev/grpcurl) and [jq](https://stedolan.github.io/jq).

{% endlist %}

## Send a search query {#execute-request}

To run a search query:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. Create a file named `web-search-async.py` and paste the following code into it:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations

      from typing import Literal, cast

      from yandex_cloud_ml_sdk import YCloudML

      from yandex_cloud_ml_sdk.search_api import (
          FamilyMode,
          FixTypoMode,
          GroupMode,
          Localization,
          SearchType,
          SortMode,
          SortOrder,
      )

      import pathlib

      USER_AGENT = "Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.6422.112 Mobile Safari/537.36"


      def main() -> None:

          sdk = YCloudML(
              folder_id="<folder_ID>",
              auth="<API_key>",
          )
          sdk.setup_default_logging("error")

          # you could pass any settings when creating the Search object
          search = sdk.search_api.web(
              "RU",
              family_mode=FamilyMode.MODERATE,
              # By default object configuration property values are set to None,
              # which corresponds to the "default" value which is
              # defined at the service's backend.
              # e.g. docs_in_group=None,
          )

          # but also you could reconfigure the Search object at any time:
          search = search.configure(
              # These are enum-type settings,
              # they could be passed as strings as shown below.
              search_type="ru",
              family_mode="strict",
              fix_typo_mode="off",
              group_mode="deep",
              localization="ru",
              sort_order="desc",
              sort_mode="by_time",
              docs_in_group=None,
              groups_on_page=6,
              max_passages=2,
              region="225",
              user_agent=USER_AGENT,
          )

          search_query = input("Enter the search query: ")
          if not search_query.strip():
              search_query = "Yandex Cloud"

          format_ = input("Choose format ([xml]/html): ")
          format_ = format_.strip() or "xml"
          assert format_.lower() in ("xml", "html")
          format_ = cast(Literal["html", "xml"], format_)

          for page in range(0, 10):
              operation = search.run_deferred(search_query, format=format_, page=page)
              search_result = operation.wait(poll_interval=1)
              output_filename = (
                  str(pathlib.Path(__file__).parent)
                  + "/"
                  + "page_"
                  + str(page + 1)
                  + "."
                  + format_
              )
              file = open(output_filename, "a")
              file.write(search_result.decode("utf-8"))
              print(f"Page {page} saved to file {output_filename}")
              file.close()


      if __name__ == "__main__":
          main()
      ```

      Where:

      {% include [sdk-code-legend](../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      {% include [the-search-configure-method-params](../../_includes/search-api/the-search-configure-method-params.md) %}

  1. Run the file you created:

      ```bash
      python3 web-search-async.py
      ```

      {% include [web-search-sdk-output](../../_includes/search-api/web-search-sdk-output.md) %}

- REST API {#api}

  1. Create a search query:

      1. Create a file with the request body, e.g., `body.json`:

          **body.json**

          {% include [http-body-v2](../../_includes/search-api/http-body-v2.md) %}

          {% cut "Description of fields" %}

          {% include [http-v2-body-params](../../_includes/search-api/http-v2-body-params.md) %}

          {% endcut %}

      1. Run an http request by specifying the IAM token you got earlier:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer <IAM_token>" \
            --data "@body.json" \
            "https://searchapi.{{ api-host }}/v2/web/searchAsync"
          ```

          Result:

          ```text
          {
          "done": false,
          "id": "sppger465oq1********",
          "description": "WEB search async",
          "createdAt": "2024-10-02T19:51:02Z",
          "createdBy": "bfbud0oddqp4********",
          "modifiedAt": "2024-10-02T19:51:03Z"
          }
          ```

          {% include [async-api-search-save-id](../../_includes/search-api/async-api-search-save-id.md) %}

  1. Wait until {{ search-api-name }} executes the request and generates a response. This may take from five minutes to a few hours.
  
      To make sure your request was successful, run this HTTP request:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM_token>" \
        https://operation.{{ api-host }}/operations/<request_ID>
      ```

      Where:

      * `<IAM_token>`: Previously obtained IAM token.
      * `<request_ID>`: The Operation object ID you saved at the previous step.

      Result:

      ```text
      {
      "done": true,
      "response": {
        "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
        "rawData": "<Base64_encoded_response_body>"
      },
      "id": "spp82pc07ebl********",
      "description": "WEB search async",
      "createdAt": "2024-10-03T08:07:07Z",
      "createdBy": "bfbud0oddqp4********",
      "modifiedAt": "2024-10-03T08:12:09Z"
      }
      ```

      {% include [async-api-search-check-if-done](../../_includes/search-api/async-api-search-check-if-done.md) %}

  1. After {{ search-api-name }} has successfully processed the request, get the response:

      1. Get the result:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer <IAM_token>" \
            https://operation.{{ api-host }}/operations/<request_ID> \
            > result.json
          ```

          {% include [async-api-search-b64-result-received](../../_includes/search-api/async-api-search-b64-result-received.md) %}

      1. {% include [api-result-base64-decode](../../_includes/search-api/api-result-base64-decode.md) %}

- gRPC API {#grpc-api}

  1. Create a search query:

      1. Create a file with the request body, e.g., `body.json`:

          **body.json**

          {% include [grpc-body-v2](../../_includes/search-api/grpc-body-v2.md) %}

          {% cut "Description of fields" %}

          {% include [grpc-v2-body-params](../../_includes/search-api/grpc-v2-body-params.md) %}

          {% endcut %}

      1. Run a gRPC call by specifying the IAM token you got earlier:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer <IAM_token>" \
            -d @ < body.json \
            searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WebSearchAsyncService/Search
          ```

          Result:

          ```text
          {
            "id": "spp3gp3vhna6********",
            "description": "WEB search async",
            "createdAt": "2024-10-02T19:14:41Z",
            "createdBy": "bfbud0oddqp4********",
            "modifiedAt": "2024-10-02T19:14:42Z"
          }
          ```

          {% include [async-api-search-save-id](../../_includes/search-api/async-api-search-save-id.md) %}

  1. Wait until {{ search-api-name }} executes the request and generates a response. This may take from five minutes to a few hours.

      To make sure the request was successful, run this gRPC call:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d '{"operation_id": "<query_ID>"}' \
        operation.{{ api-host }}:443 yandex.cloud.operation.OperationService/Get
      ```

      Where:

      * `<IAM_token>`: Previously obtained IAM token.
      * `<request_ID>`: The Operation object ID you saved at the previous step.

      Result:

      ```text
      {
        "id": "spp82pc07ebl********",
        "description": "WEB search async",
        "createdAt": "2024-10-03T08:07:07Z",
        "createdBy": "bfbud0oddqp4********",
        "modifiedAt": "2024-10-03T08:12:09Z",
        "done": true,
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
          "rawData": "<Base64_encoded_response_body>"
        }
      }
      ```

      {% include [async-api-search-check-if-done](../../_includes/search-api/async-api-search-check-if-done.md) %}

  1. After {{ search-api-name }} has successfully processed the request, get the response:

      1. Get the result:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer <IAM_token>" \
            -d '{"operation_id": "<request_ID>"}' \
            operation.{{ api-host }}:443 yandex.cloud.operation.OperationService/Get \
            > result.json
          ```

          {% include [async-api-search-b64-result-received](../../_includes/search-api/async-api-search-b64-result-received.md) %}

      1. {% include [api-result-base64-decode](../../_includes/search-api/api-result-base64-decode.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./web-search-sync.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../concepts/response.md)
* [{#T}](../concepts/html-response.md)