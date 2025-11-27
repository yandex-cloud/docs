---
title: How to get mobile search results using {{ search-api-full-name }}
description: In this tutorial, you will learn how to get mobile search results using the {{ search-api-name }} interfaces.
---

# Getting mobile search results

Mobile search results differ from default search results by the ranking formula and presence of links to websites optimized for mobile devices.

To get mobile search results:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. In the program code for the search object (`sdk.search_api.web` class object), give a description of the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header) of required device and browser. For example, you can do this in the `user_agent` property of the `.configure` method:

      **mobile-search.py**

      ```json
      ...
      search = search.configure(
          search_type="ru",
          family_mode="strict",
          ...
          user_agent="Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1",
      )
      ...
      ```
  1. Set the rest of the search query parameters as in [{#T}](./web-search.md).
  1. Run the code and get the result.

- REST API {#api}

  1. Add the `userAgent` field to the request body. This field contains a description of the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header) of the device and browser. Here is an example:

      **body.json**

      ```json
      {
        ...
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```
  1. Set the other request body parameters according to the [specification](../concepts/web-search.md#parameters).
  1. Send the request and get the result. For more information, see [{#T}](./web-search.md).

- gRPC API {#grpc-api}

  1. Add the `user_agent` field to the request body. This field contains a description of the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header) of the device and browser. Here is an example:

      **body.json**

      ```json
      {
        ...
        "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```
  1. Set the other request body parameters according to the [specification](../concepts/web-search.md#parameters).
  1. Send the request and get the result. For more information, see [{#T}](./web-search.md).

{% endlist %}


Mobile search results will be different from default search results by the website ranking, total number of results found, and some other parameters.