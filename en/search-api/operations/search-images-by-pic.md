---
title: How to search for images in {{ search-api-name }} by image
description: Follow this guide to learn how to use {{ search-api-full-name }} to send search queries for images based on a source image.
---

# Searching for images by image

You can use {{ search-api-name }} to search through the [Yandex Images](https://yandex.ru/images) index by image and get search results in [JSON format](../concepts/image-search.md#json-response-format). You can run queries using the [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/), and [gRPC API](../api-ref/grpc/). The search results you get depend on the parameters specified in your query.

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Get your cloud ready {#initial-setup}

To use the examples:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user).
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

  1. Create a file named `pic-search-by-pic.py` and paste the following code into it:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations

      import pathlib

      from yandex_ai_studio_sdk import AIStudio
      from yandex_ai_studio_sdk.search_api import FamilyMode

      EXAMPLE_FILE = pathlib.Path(__file__).parent / "image.jpg"


      def main() -> None:
          sdk = AIStudio(
              folder_id="<folder_ID>",
              auth="<API_key>",
          )
          sdk.setup_default_logging()

          # You can pass initial configuration here:
          search = sdk.search_api.by_image(
              family_mode="moderate",
              site="ya.ru",
          )
          # Or configure the Search object later:
          search = search.configure(
              # family mode may be passed as a string or as a special enum value
              family_mode=FamilyMode.NONE,
          )

          # You can reset any config property back to its default value by passing None:
          search = search.configure(site=None)

          search_type = input(
              "Select a search type:\n1: Using a remote image URL (default)\n2: Using bytes data from './image.jpeg'\n\n"
          )
          if not search_type.strip():
              search_type = "1"

          if int(search_type) == 2:

              # The first search option is to search using bytes data:
              image_data = pathlib.Path(EXAMPLE_FILE).read_bytes()
              search_result = search.run(image_data)

          else:

              # The second search option is to search using a remote image url:
              # e.g. Photo of Leo Tolstoy
              url = "https://upload.wikimedia.org/wikipedia/commons/b/be/Leo_Tolstoy_1908_Portrait_%283x4_cropped%29.jpg"
              search_result = search.run_from_url(url)

          # You can examine the search_result structure via pprint
          # to get to know how to work with it:
          # pprint.pprint(search_result)
          # Search results can also be used in boolean context:
          if search_result:
              print(f"{len(search_result)} documents found")
          else:
              print("Nothing found")

          # The third search option is to search using the image's CBIR ID:
          # using CBIR ID is way faster than any other option,
          # but it requires to make at least one "heavy" request to get this ID.

          cbid_id = search_result.cbir_id
          search_result = search.run_from_id(cbid_id, page=1)

          while search_result:
              print(f"Page {search_result.page}:")
              output_filename = (
                  str(pathlib.Path(__file__).parent)
                  + "/"
                  + "results_page_"
                  + str(search_result.page)
                  + ".txt"
              )
              file = open(output_filename, "a")
              for document in search_result:
                  file.write(str(document) + "\n\n")
              print(f"Page {search_result.page} saved to file {output_filename}")
              file.close()

              # search_result.next_page() is a shortcut for
              # `.run_from_id(search_query.cbir_id, page=page + 1)`
              # with search configuration saved from the initial run;
              # last page + 1 will return an "empty" search_result;
              search_result = search_result.next_page()


      if __name__ == "__main__":
          main()
      ```

      Where:

      {% include [sdk-code-legend](../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      You can set the search parameters in the relevant `search_api.by_image` class object properties or the `.configure` method properties:

      * `family_mode`: Results filtering. This is an optional parameter. The possible values are:

          * `moderate`: Moderate filter (default). _Adult_ category documents are excluded from search results unless the query explicitly targets resources of this category.
          * `none`: Filtering is off. Search results include any documents regardless of their contents.
          * `strict`: Family filter. Regardless of the search query, _Adult_ category documents and documents containing profanity are excluded from search results.

  1. Run the file you created:

      ```bash
      python3 pic-search-by-pic.py
      ```

      During execution, the code will ask you to select a search option:

      1. Based on an image published on the internet. The URL of this image is specified in the `url` variable.
      1. Based on an image from the local computer. Local path to the image is specified in the `EXAMPLE_FILE` variable.

      At the final stage, the code will search for images by the [CBIR](https://en.wikipedia.org/wiki/Content-based_image_retrieval) ID and then save the search results page by page in the current directory into text files:

      ```text
      Page 1 saved to file /Users/MyUser/Desktop/results_page_1.txt
      ...
      Page 134 saved to file /Users/MyUser/Desktop/results_page_134.txt
      ```

- REST API {#api}

  1. Create a file with the request body, e.g., `body.json`:

      **body.json**

      {% include [http-body-image-bypic-search](../../_includes/search-api/http-body-image-bypic-search.md) %}

      {% cut "Description of fields" %}

      {% include [http-body-params-image-bypic-search](../../_includes/search-api/http-body-params-image-bypic-search.md) %}

      {% endcut %}

      {% cut "Request body example" %}

      **body.json**

      ```json
      {
        "folderId": "b1gt6g8ht345********",
        "data": "<base64-encoded_image>",
        "page": "1"
      }
      ```

      {% endcut %}

  1. Send an HTTP request specifying the IAM token you got earlier and a path to the request body file:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer <IAM_token>" \
        --data "@body.json" \
        "https://searchapi.{{ api-host }}/v2/image/search_by_image" \
        > result.json
      ```

      {% include [search-images-by-pic-result-json](../../_includes/search-api/search-images-by-pic-result-json.md) %}

- gRPC API {#grpc-api}

  1. Create a file with the request body, e.g., `body.json`:

      **body.json**

      {% include [grpc-body-image-bypic-search](../../_includes/search-api/grpc-body-image-bypic-search.md) %}

      {% cut "Description of fields" %}

      {% include [grpc-body-params-image-bypic-search](../../_includes/search-api/grpc-body-params-image-bypic-search.md) %}

      {% endcut %}

      {% cut "Request body example" %}

      **body.json**

      ```json
      {
        "folder_id": "b1gt6g8ht345********",
        "data": "<base64-encoded_image>",
        "page": "1"
      }
      ```

      {% endcut %}

  1. Run a gRPC call specifying the IAM token you got earlier and a path to the request body file:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d @ < body.json \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.ImageSearchService/SearchByImage \
        > result.json
      ```

      {% include [search-images-by-pic-result-json](../../_includes/search-api/search-images-by-pic-result-json.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./search-images.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)