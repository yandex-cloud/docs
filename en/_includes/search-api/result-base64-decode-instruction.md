Depending on the requested response format, decode the result from `Base64`:

{% list tabs group=search_api_request %}

- XML {#xml}

    ```bash
    echo "$(< result.json)" | \
      jq -r .rawData | \
      base64 --decode > result.xml
    ```

    The XML response to the query will be saved to a file named `result.xml`.

- HTML {#html}

    ```bash
    echo "$(< result.json)" | \
      jq -r .rawData | \
      base64 --decode > result.html
    ```

    The HTML response to the query will be saved to a file named `result.html`.

{% endlist %}