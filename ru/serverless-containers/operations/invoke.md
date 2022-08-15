# Вызов контейнера

Вызвать контейнер можно:
* через [HTTPS](#https);
* с помощью [триггера {{ sf-full-name }}](../../functions/concepts/trigger/index.md);
* с помощью [расширения {{ api-gw-full-name }}](../../api-gateway/concepts/extensions/containers.md).

{% note info %}

Чтобы любой пользователь мог вызвать контейнер без передачи заголовка авторизации, [сделайте контейнер публичным](./access-rights.md#public).

{% endnote %}

## HTTPS {#https}

После создания контейнера вы получите ссылку для вызова. Сделайте HTTPS-запрос, передав [IAM-токен](../../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

### Получить ссылку для вызова {#link}

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Выберите сервис **{{ serverless-containers-name }}**.
	1. Выберите контейнер. Ссылка для вызова будет в поле **Ссылка для вызова**.

- CLI

	Чтобы получить ссылку для вызова, выполните команду:

	```
	yc serverless container get <имя_контейнера>
	```

	Результат:

	```
	id: flh7r96juaqq********
	folder_id: aoek6qrs8tjh********
	created_at: "2021-08-17T07:53:10.219Z"
	name: my-beta-container
	description: my beta container description
	url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
	status: ACTIVE
	```

	Ссылка для вызова будет в поле `url`.

{% endlist %}
