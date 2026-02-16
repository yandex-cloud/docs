# Получение IAM-токена сервисного аккаунта с помощью контейнера

Если ревизия контейнера создана с сервисным аккаунтом, вы можете получить [IAM-токен](../../iam/concepts/authorization/iam-token.md) из сервиса метаданных в формате [Google Compute Engine](../../compute/operations/vm-info/get-info.md#inside-instance) с помощью API.

Для этого изнутри контейнера выполните GET-запрос по адресу `http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token` и укажите HTTP-заголовок `Metadata-Flavor: Google`.

Ниже приведен пример функции для получения IAM-токена.

{% list tabs %}

- JavaScript

    ```js
    const fetch = require("node-fetch");
	let url = 'http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token';
	let headers = {'Metadata-Flavor': 'Google'};

	async function getToken(event) {
	    const resp = await fetch(url, {
	        headers: headers,
	    });
	    let respJson = await resp.json();
	    return {
	        token: respJson['access_token'],
	        expiresInSeconds: respJson['expires_in'],
	    };
	};
    ```

{% endlist %}