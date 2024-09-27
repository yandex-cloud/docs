{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  curl \
    --request GET \
    --header "Authorization: Bearer <значение_IAM-токена>" \
    https://llm.api.cloud.yandex.net:443/operations/<идентификатор_запроса> | \
    jq -r '.response | .image' | base64 -d > image.jpeg
  ```

  Где:

  * `<значение_IAM-токена>` — IAM-токен, полученный для вашего аккаунта.
  * `<идентификатор_запроса>` — идентификатор, полученный после запроса.

{% endlist %}