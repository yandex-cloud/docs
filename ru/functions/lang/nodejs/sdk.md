---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Использование SDK

Среда выполнения содержит предустановленную библиотеку для работы с [API {{ yandex-cloud }}](../../../api-design-guide/). Для её использования не требуется добавлять [зависимость](dependencies.md) в приложение, за исключением случаев, когда требуется версия библиотеки, отличающаяся от предустановленной. С исходным кодом библиотеки можно ознакомиться на [GitHub](https://github.com/yandex-cloud/nodejs-sdk).

[SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) позволяет взаимодействовать с сервисами {{ yandex-cloud }} с помощью [сервисного аккаунта](../../operations/function-sa.md), указанного в функции. Например, вы можете получить список доступных вам облаков (аналог команды `yc resource-manager cloud list`):

```js
const {CloudService} = require("yandex-cloud/api/resourcemanager/v1");

module.exports.handler = async function (event, context) {
    const cloudService = new CloudService();
    const clouds = await cloudService.list({});

    return {
        clouds,
    };
};
```

Для удобства локальной отладки и уменьшения загружаемого объема кода функции, добавьте пакет `yandex-cloud` в файл `package.json` в секцию `devDependencies`:

```json
{
  "name": "my-app",
  "version": "1.0.0",
  "devDependencies": {
    "yandex-cloud": "^1.4"
  }
}
```
