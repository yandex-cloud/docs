---
title: How to search using {{ search-api-name }}
description: Follow this guide to learn how to use {{ search-api-name }} to send search queries and get search results in XML format.
---

# Performing search queries in {{ search-api-name }}

{{ search-api-name }} allows you to perform text and image search in the Yandex search database and get search results in XML format. Search results depend on the parameters specified in the query.

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Prepare your cloud {#initial-setup}

1. [Create](../../iam/operations/sa/create.md) a service account.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) the `{{ roles-search-api-executor }}` role to the created service account.
1. [Create](../../iam/operations/api-key/create.md) an API key for the created service account.
1. [Sign up](./workaround.md) for {{ search-api-name }}.

## Create a search query {#form-request}

Based on the search type selected when signing up for the service, specify the appropriate domain name in the query:
* `yandex.ru`: For the `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` search type.
* `yandex.com.tr`: For the `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}` search type.
* `yandex.com`: For the `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}` search type.

{% list tabs %}

- Text search using the GET method

  For text search, you can use [GET requests](../concepts/get-request.md).

  {% note warning %}

  If you have any special characters in parameter values, replace them with the respective escaped sequences based on percent-encoding. For example, instead of the equals sign (`=`), use `%3D`.

  {% endnote %}

  1. Make a GET request in the following format:

      ```httpget
      https://yandex.<domain>/search/xml
        ? [folderid=<folder_ID>]
        & [apikey=<API_key>]
        & [query=<search_query_text>]
        & [lr=<search_region_ID>]
        & [l10n=<notification_language>]
        & [sortby=<sorting_type>]
        & [filter=<filtering_type>]
        & [maxpassages=<number_of_passages>]
        & [groupby=<result_grouping_options>]
        & [page=<page_number>]
      ```

      For more information about request parameters, see [Request parameters](../concepts/get-request.md#parameters).

      **Request example**:

      ```httpget
      https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=4
      ```

      This request returns the fifth page of search results for the `<table>` command. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Search region is Novosibirsk Oblast, and the notification language is Russian. The **Family search** filter will be applied to the search results. The number of passages is three. The results are grouped by domain and sorted by relevance. Each group contains three documents, and the number of groups returned per page is five.

  1. Send a query to the Yandex search database. To do this, use the [cURL](https://curl.haxx.se) utility:

      ```bash
      curl -X GET \
        -o result.xml \
        'https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=4'
      ```

      As a result of running the query, the `result.xml` file containing the search query results in XML [format](../concepts/response.md) will be saved to the current directory.

- Text search using the POST method

  For text search, you can use [POST requests](../concepts/post-request.md).

  {% note warning %}

  If you have any special characters in the parameter values provided in the request body, replace them with the respective escaped sequences based on the XML encoding. For example, use `&amp;` for ampersand (`&`).

  {% endnote %}

  1. Create a URL of the POST request in the following format:

      ```httpget
      https://yandex.<domain>/search/xml
        ? [folderid=<folder_ID>]
        & [filter=<filtering_type>]
        & [lr=<search_region_ID>]
        & [l10n=<notification_language>]
      ```

      For more information about request URL parameters, see [Request parameters](../concepts/post-request.md#parameters).

      **Request example**:

      ```httppost
      https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&filter=strict&lr=11316&l10n=ru
      ```

  1. Prepare a file with the request body, e.g., `body.xml`.

      **Example of a file with the request body**:

      ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <request>
        <query><table></query>
        <sortby order="descending">tm</sortby>
        <maxpassages>2</maxpassages>
        <page>4</page>
        <groupings>
          <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="3" />
        </groupings>
      </request>
      ```

      For detailed information about the parameters specified in the request body, see [Request body parameters](../concepts/post-request.md#post-body-parameters).

      The following request example returns the fifth page of search results for the `<table>` command. The results are sorted by the document editing time, from the newest to the oldest. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Search region: Novosibirsk Oblast. The **Family search** filter is applied to the search results. The results are grouped by domain. Each group contains three documents, and the number of groups returned per page is 10. The maximum number of passages per document is 2.

  1. Send a query to the Yandex search database. To do this, use the [cURL](https://curl.haxx.se) utility:

      ```bash
      curl -X POST \
        -H "Authorization: Api-Key <API_key>" \
        -d "@body.xml" \
        -o result.xml \
        'https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&filter=strict&lr=11316&l10n=ru'
      ```

      As a result of running the query, the `result.xml` file containing the search query results in XML [format](../concepts/response.md) will be saved to the current directory.

- Searching by images

  Currently, you can use only GET requests to search by images.

  {% note warning %}

  If you have any special characters in parameter values, replace them with the respective escaped sequences based on percent-encoding. For example, instead of the equals sign (`=`), use `%3D`.

  {% endnote %}

  1. Make a GET request in the following format:

      ```text
      https://yandex.<domain>/images-xml
        ? [folderid=<folder_ID>]
        & [apikey=<API_key>]
        & [text=<search_query_text>]
        & [groupby=<result_grouping_options>]
        & [p=<page_number>]
        & [fyandex=<family_search_filter>]
        & [site=<website_domain_name>]
        & [itype=<image_format>]
        & [iorient=<image_orientation>]
        & [isize=<image_size>]
        & [icolor=<image_color>]
      ```

      For more information about request parameters, see [Request parameters](../concepts/pic-search.md#parameters).

      **Request example**:

      ```html
      https://yandex.ru/images-xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&text=funny+cats&groupby=attr=ii.groups-on-page=3&p=2&fyandex=1&site=somepics.ru&itype=jpg&iorient=horizontal&isize=medium&icolor=color
      ```

      This request returns the third page of image search results for the `funny cats` query. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). {{ search-api-name }} will return results for medium-sized colored images found on `somepics.ru` in JPG format with the horizontal image orientation. The _Family search_ filter will be applied to the search results. The page will contain three groups of search results.

  1. Send a query to the Yandex image search database. To do this, use the [cURL](https://curl.haxx.se) utility:

      ```bash
      curl -X GET \
        -o result.xml \
        'https://yandex.ru/images-xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&text=funny+cats&groupby=attr=ii.groups-on-page=3&p=2&fyandex=1&site=somepics.ru&itype=jpg&iorient=horizontal&isize=medium&icolor=color'
      ```

      As a result of running the query, the `result.xml` file containing the search query results in XML [format](../concepts/pic-response.md) will be saved to the current directory.

{% endlist %}