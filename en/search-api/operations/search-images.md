---
title: How to search for an image in {{ search-api-name }} based on a text description
description: Follow this guide to learn how to use {{ search-api-full-name }} to search for images through the Yandex Images index by their text description.
---

# Searching by text description

You can use {{ search-api-name }} to search through the [Yandex Images](https://yandex.ru/images) index by text description and get search results in [XML format](../concepts/image-search.md#xml-response-format). You can run queries using the [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/), and [gRPC API](../api-ref/grpc/). The search results you get depend on the parameters specified in your query.

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

  1. Create a file named `pic-search-by-text.py` and paste the following code into it:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations

      from yandex_cloud_ml_sdk import YCloudML

      from yandex_cloud_ml_sdk.search_api import (
          FamilyMode,
          FixTypoMode,
          ImageColor,
          ImageFormat,
          ImageOrientation,
          ImageSize,
          SearchType,
      )

      import pathlib

      USER_AGENT = "Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.6422.112 Mobile Safari/537.36"


      def main() -> None:
          sdk = YCloudML(
              folder_id="<folder_ID>",
              auth="<API_key>",
          )
          sdk.setup_default_logging()

          # you could pass any settings when creating the Search object
          search = sdk.search_api.image(
              "RU",
              family_mode=FamilyMode.MODERATE,
              # By default object configuration property values are set to None,
              # which corresponds to the "default" value which is
              # defined at the service's backend.
              # e.g. docs_in_group=None,
          )

          # but you can also reconfigure the Search object at any time:
          search = search.configure(
              # These are enum-type settings,
              # they could be passed as strings as shown below.
              search_type="kk",
              family_mode="strict",
              fix_typo_mode="off",
              format="jpeg",
              size="LARGE",
              orientation="vertical",
              color="GRAYSCALE",
              docs_on_page=3,
              site="yandex.ru",
              user_agent=USER_AGENT,
          )

          search = search.configure(
              # any enum-like option may also be passed as an explicit enum option;
              # this might be helpful to control and understand which values there can be
              search_type=SearchType.RU,
              family_mode=FamilyMode.STRICT,
              fix_typo_mode=FixTypoMode.OFF,
              format=ImageFormat.JPEG,
              size=ImageSize.LARGE,
              orientation=ImageOrientation.VERTICAL,
              color=ImageColor.GRAYSCALE,
              docs_on_page=5,
          )

          search_query = input("Enter the search query: ")
          if not search_query.strip():
              search_query = "Yandex Cloud"

          for i in range(5):
              search_result = search.run(search_query, format="xml", page=i)

              output_filename = (
                  str(pathlib.Path(__file__).parent) + "/" + "page_" + str(i) + ".xml"
              )
              file = open(output_filename, "a")
              file.write(search_result.decode("utf-8"))
              print(f"Page {i} saved to file {output_filename}")
              file.close()


      if __name__ == "__main__":
          main()
      ```

      Where:

      {% include [sdk-code-legend](../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      You can set the search parameters in the relevant `search_api.image` class object properties or the `.configure` method properties:

      {% cut "Description of object properties" %}

      * `search_type`: Search type. The possible values are:

          * `ru`: For the `Russian` search type.
          * `tr`: For the `Turkish` search type.
          * `com`: For the `International` search type.
          * `kk`: For the `Kazakh` search type.
          * `be`: For the `Belarusian` search type.
          * `uz`: For the `Uzbek` search type.
      * `family_mode`: Results filtering. This is an optional parameter. The possible values are:

          * `moderate`: Moderate filter (default). _Adult_ category documents are excluded from search results unless the query explicitly targets resources of this category.
          * `none`: Filtering is off. Search results include any documents regardless of their contents.
          * `strict`: Family filter. Regardless of the search query, _Adult_ category documents and documents containing profanity are excluded from search results.
      * `fix_typo_mode`: Search query typo correction setting. This is an optional parameter. The possible values are:

          * `on`: Typo correction enabled (default). Search query typos are corrected automatically.
          * `off`: Typo correction disabled. Search query typos are not corrected. The search is performed strictly as per the query.
      * `format`: Searching for images of specified format. This is an optional parameter. If not set, the search includes images of all formats. The possible values are:

          * `jpeg`: [JPG](https://en.wikipedia.org/wiki/JPEG)
          * `gif`: [GIF](https://en.wikipedia.org/wiki/GIF)
          * `png`: [PNG](https://en.wikipedia.org/wiki/PNG)
      * `size`: Searching for images of specified size. This is an optional parameter. If not set, the search includes images of all sizes. The possible values are:

          * `enormous`: Very large images (over `1600 × 1200` in pixels).
          * `large`: Large images (from `800 × 600` to `1600 × 1200` in pixels).
          * `medium`: Medium images (from `150 × 150` to `800 × 600` in pixels).
          * `small`: Small images (from `32 × 32` to `150 × 150` in pixels).
          * `tiny`: Icons (up to `32 × 32` in pixels).
          * `wallpaper`: Wallpaper images.
      * `orientation`: Searching for images of specified orientation. This is an optional parameter. If not set, the search includes images of any orientation. The possible values are:

          * `vertical`: Vertical images.
          * `horizontal`: Horizontal images.
          * `square`: Square aspect ratio images.
      * `color`: Searching for images with specified color parameters. This is an optional parameter. If not set, the search includes images with any color parameters. The possible values are:

          * `color`: Colored images.
          * `grayscale`: Grayscale images.
          * `red`: Images with red as the main color.
          * `orange`: Images with orange as the main color.
          * `yellow`: Images with yellow as the main color.
          * `green`: Images with green as the main color.
          * `cyan`: Images with cyan as the main color.
          * `blue`: Images with blue as the main color.
          * `violet`: Images with violet as the main color.
          * `white`: Images with white as the main color.
          * `black`: Images with black as the main color.
      * `docs_on_page`: Number of result groups displayed per search result page. You can specify values between `1` and `60`. This is an optional parameter. The default value is `20`.
      * `site`: Searching for images only on specified website, e.g., `yandex.cloud`. This is an optional parameter. If not set, the search includes all websites in the search base.
      * `user_agent`: String containing the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header). Use this parameter to have your search results optimized for a specific device and browser, including [mobile search results](./v2-mobile.md). This is an optional parameter. If not specified, you will get the default output.

      {% endcut %}

  1. Run the file you created:

      ```bash
      python3 pic-search-by-text.py
      ```

      During the execution, the code will prompt you to enter the search query text and, as a result, will save the first five pages of search results for the specified query in [XML format](../concepts/image-search.md#xml-response-format) in the current directory:

      ```text
      Page 0 saved to file /Users/MyUser/Desktop/page_0.xml
      ...
      Page 4 saved to file /Users/MyUser/Desktop/page_4.xml
      ```

- REST API {#api}

  1. Send a query and get a [Base64](https://en.wikipedia.org/wiki/Base64)-encoded result:

      1. Create a file with the request body, e.g., `body.json`:

          **body.json**

          {% include [http-body-imagesearch](../../_includes/search-api/http-body-imagesearch.md) %}

          {% cut "Description of fields" %}

          {% include [http-body-params-imagesearch](../../_includes/search-api/http-body-params-imagesearch.md) %}

          {% endcut %}

          {% cut "Request body example" %}

          **body.json**

          ```json
          {
            "query": {
              "searchType": "SEARCH_TYPE_RU",
              "queryText": "cats"
            },
            "folderId": "b1gt6g8ht345********"
          }
          ```

          {% endcut %}

      1. Send an HTTP request specifying the IAM token you got earlier and a path to the request body file:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer <IAM_token>" \
            --data "@body.json" \
            "https://searchapi.{{ api-host }}/v2/image/search" \
            > result.json
          ```

          {% include [search-images-by-text-result-json](../../_includes/search-api/search-images-by-text-result-json.md) %}

  1. {% include [search-images-by-text-b64-decode](../../_includes/search-api/search-images-by-text-b64-decode.md) %}

- gRPC API {#grpc-api}

  1. Send a query and get a [Base64](https://en.wikipedia.org/wiki/Base64)-encoded result:

      1. Create a file with the request body, e.g., `body.json`:

          **body.json**

          {% include [grpc-body-imagesearch](../../_includes/search-api/grpc-body-imagesearch.md) %}

          {% cut "Description of fields" %}

          {% include [grpc-body-params-imagesearch](../../_includes/search-api/grpc-body-params-imagesearch.md) %}

          {% endcut %}

          {% cut "Request body example" %}

          **body.json**

          ```json
          {
            "query": {
              "search_type": "SEARCH_TYPE_RU",
              "query_text": "cats"
            },
            "folder_id": "b1gt6g8ht345********"
          }
          ```

          {% endcut %}

      1. Run a gRPC call specifying the IAM token you got earlier and a path to the request body file:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer <IAM_token>" \
            -d @ < body.json \
            searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.ImageSearchService/Search \
            > result.json
          ```

          {% include [search-images-by-text-result-json](../../_includes/search-api/search-images-by-text-result-json.md) %}
  
  1. {% include [search-images-by-text-b64-decode](../../_includes/search-api/search-images-by-text-b64-decode.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./search-images-by-pic.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)