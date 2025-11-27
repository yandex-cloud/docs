Decode the result from `Base64`:

```bash
echo "$(< result.json)" | \
  jq -r .rawData | \
  base64 --decode > result.xml
```

The [XML response](../../search-api/concepts/image-search.md#xml-response-format) to the query will be saved to a file named `result.xml`.