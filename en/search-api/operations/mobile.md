---
title: How to get mobile search results using {{ search-api-full-name }}'s API v1
description: In this tutorial, you will learn how to get a mobile search results file using {{ search-api-name }}'s API v1.
---

# Getting mobile search results using API v1

Mobile search results differ from default search results by the ranking formula and presence of links to websites optimized for mobile devices.

To get mobile search results:

1. Add to your request a [header](https://en.wikipedia.org/wiki/User-Agent_header) entitled `user-agent` containing the device and browser description. Here is an example:

    {% list tabs group=programming_language %}

    - cURL {#curl}

      ```bash
      curl \
        --header 'user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1' \
        '<GET request>'
      ```

    - Python {#python}

      ```python
      import subprocess

      MOBILE_HEADER = 'user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1'
      URL = f'<GET request>'
      with open('mob.xml', 'w') as f:
         subprocess.run(['curl', '-H', MOBILE_HEADER, URL], stdout=f)
      ```

    {% endlist %}

    {% note info %}

    The above example uses a [GET request](../concepts/get-request.md). If using a [POST](../concepts/post-request.md) request, add a similar header.

    {% endnote %}

1. Set the remaining request parameters based on the [specification](../concepts/get-request.md#get-request-format) and [send](./searching.md#form-request) the request.

Mobile search results will be different from default search results by the website ranking, total number of results found, and some other parameters.