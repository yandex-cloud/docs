{% list tabs group=programming_language %}

- cURL {#curl}

	```bash
    curl -X POST \
        -H "Authorization: Bearer <значение_IAM-токена>" \
        -d @req_art.json \
        https://llm.api.cloud.yandex.net:443/foundationModels/v1/imageGenerationAsync
	```
	
	Где:

	* `<значение_IAM-токена>` — IAM-токен, полученный для вашего аккаунта.
	* `req_art.json` — файл в формате JSON, содержащий параметры запроса.

{% endlist %}