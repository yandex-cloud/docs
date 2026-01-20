---
title: How to perform location-based text search in {{ search-api-full-name }}
description: Follow this guide to learn how to use {{ search-api-name }} to send search queries based on the user's location.
---

# Location-based text search

By default, {{ search-api-name }} results are not linked to the user's location because queries are sent from {{ yandex-cloud }} servers. For geolocation-dependent search results, as in a browser, specify in the query parameters the IP address of the user you are going to use to get your search results.

{% note info %}

The IP address must be valid and public. Private subnet addresses do not affect search results.

{% endnote %}

{% list tabs group=instructions %}

- API {#api}

  1. Add the `X-Forwarded-For-Y` field to the request body in the `metadata.fields` section:

      **body.json**

      ```json
      ...
      "metadata": {
        "fields": {
          "X-Forwarded-For-Y": "<user_IP_address>"
        }
      },
      ...
      ```

      Where `X-Forwarded-For-Y` is the user's IP address.

  1. Set the other request body parameters according to the [specification](../api-ref/WebSearch/search.md).
  1. Send the request and get the result. For more information, see [{#T}](./web-search.md).

{% endlist %}
