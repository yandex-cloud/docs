В зависимости от запрошенного формата ответа декодируйте результат из формата `Base64`:

{% list tabs group=search_api_request %}

- XML {#xml}

  ```bash
  echo "$(< result.json)" | \
    jq -r .response.rawData | \
    base64 --decode > result.xml
  ```

  В результате в файл `result.xml` будет сохранен XML-ответ по запросу.

- HTML {#html}

  ```bash
  echo "$(< result.json)" | \
    jq -r .response.rawData | \
    base64 --decode > result.html
  ```

  В результате в файл `result.html` будет сохранен HTML-ответ по запросу.

{% endlist %}