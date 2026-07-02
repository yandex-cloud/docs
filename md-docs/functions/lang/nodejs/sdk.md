[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Разработка на Node.js](index.md) > Использование SDK

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

SDK позволяет управлять ресурсами Yandex Cloud от имени [сервисного аккаунта](../../operations/function-sa.md), который указан в параметрах функции. Например, можно получить список доступных облаков:

```js
import { Session } from '@yandex-cloud/nodejs-sdk';
import { cloudService } from '@yandex-cloud/nodejs-sdk/resourcemanager-v1';

export const handler = async function (event, context) {
    const session = new Session({ iamToken: context.token.access_token }); // iamToken можно не указывать явно, он будет извлечен автоматически из сервиса метаданных
    const client = session.client(cloudService.CloudServiceClient);
    const response = await client.list(cloudService.ListCloudsRequest.fromPartial({}))

    return {
        statusCode: 200,
        body: {
            clouds: response.clouds,
        }
    };
};
```