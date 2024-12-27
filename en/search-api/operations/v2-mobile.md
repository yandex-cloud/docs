---
title: How to get mobile search results using {{ search-api-full-name }}'s API v2
description: In this tutorial, you will learn how to get mobile search results using {{ search-api-name }}'s API v2.
---

# Getting mobile search results using API v2

Mobile search results differ from default search results by the ranking formula and presence of links to websites optimized for mobile devices.

1. To get mobile search results, add this field to the request body:

    {% list tabs group=instructions %}

    - REST API {#api}

      The `userAgent` contains the description of the device and browser [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header). Here is an example:

      **body.json**

      ```json
      {
        ...
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```

    - gRPC API {#grpc-api}

      The `user_agent` field contains the description of the device and browser [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header). Here is an example:

      **body.json**

      ```json
      {
        ...
        "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1"
      }
      ```

    {% endlist %}

1. Set the other request body parameters according to the [specification](../concepts/web-search.md#parameters).
1. [Send](./web-search.md#form-request) the request and [get](./web-search.md#get-response) the result.

Mobile search results will be different from default search results by the website ranking, total number of results found, and some other parameters.