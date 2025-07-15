{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  curl \
    --request POST \
    --header "Authorization: Bearer <IAM_token>" \
    --data "@body.json" \
    "https://searchapi.{{ api-host }}/v2/web/search" \
    > result.json
  ```

{% endlist %}