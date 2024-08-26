# Использование SDK для функции на Node.js

Чтобы использовать [SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK), необходимо добавить [зависимость](dependencies.md) `@yandex-cloud/nodejs-sdk` в приложение на Node.js. Исходный код библиотеки находится на [GitHub](https://github.com/yandex-cloud/nodejs-sdk).

```json
{
  "name": "my-awesome-package",
  "version": "1.0.0",
  "type": "module",
  "dependencies": {
      "@yandex-cloud/nodejs-sdk": "latest"
  }
}
```

SDK позволяет управлять ресурсами {{ yandex-cloud }} от имени [сервисного аккаунта](../../operations/function-sa.md), который указан в параметрах функции. Например, можно получить список доступных облаков:

```js
import { serviceClients, Session, cloudApi } from '@yandex-cloud/nodejs-sdk';

const { resourcemanager: { cloud_service: { ListCloudsRequest } } } = cloudApi;

export const handler = async function (event, context) {
    const session = new Session({ iamToken: context.token.access_token }); // iamToken можно не указывать явно, он будет извлечен автоматически из сервиса метаданных
    const client = session.client(serviceClients.CloudServiceClient);
    const response = await client.list(ListCloudsRequest.fromPartial({ pageSize: 200 }))

    return {
        statusCode: 200,
        body: {
            clouds: response.clouds,
        }
    };
};
```
