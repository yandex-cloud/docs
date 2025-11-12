Декодируйте результат из формата `Base64`:

```bash
echo "$(< result.json)" | \
  jq -r .rawData | \
  base64 --decode > result.xml
```

В результате в файл `result.xml` будет сохранен [XML-ответ](../../search-api/concepts/image-search.md#xml-response-format) по запросу.