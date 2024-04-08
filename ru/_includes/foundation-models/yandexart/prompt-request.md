```bash
curl -X POST \
    -H "Authorization: Bearer <значение_IAM-токена>" \
    -d @prompt.json \
    https://llm.api.cloud.yandex.net:443/foundationModels/v1/imageGenerationAsync
```

Где:

* `<значение_IAM-токена>` — IAM-токен, полученный для вашего аккаунта.
* `prompt.json` — файл в формате JSON, содержащий параметры запроса.
