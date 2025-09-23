```bash
curl \
  --request POST \
  --header "Authorization: Bearer <значение_IAM-токена>" \
  --data @prompt.json \
  https://llm.api.cloud.yandex.net:443/foundationModels/v1/imageGenerationAsync
```

Где:

* `<значение_IAM-токена>` — IAM-токен, полученный для вашего аккаунта.
* `prompt.json` — файл в формате JSON, содержащий параметры запроса.
