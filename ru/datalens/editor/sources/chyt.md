# CHYT (ClickHouse over YT)

## Как работать с CHYT из ChartEditor {#working-from-charteditor}

{% note alert %}

Рекомендуем использовать [созданное подключение](../../operations/connection/chyt/create-chyt.md) {{ datalens-short-name }} вместо работы с CHYT через ChartEditor.

{% endnote %}

С помощью ChartEditor вы можете работать с данными из публичных кластеров.

Пока что доступны кластеры:
* Hahn
* Arnold
* Vanga

Для формирования источника данных используется метод `buildSource` модуля `libs/chyt/v1`.
Метод `buildSource` принимает один аргумент: `object` со следующими свойствами:
|Имя|Тип|Описание|Обязательное / По умолчанию
|:---|:---|:---|:---
|cluster|`string`|Название кластера|Обязательное
|cliqueId|`string`|ID клики или алиас|Обязательное
|token|`string`|OAuth токен для авторизации|Обязательное
|query|`string`|Запрос|Обязательное
|cache|`boolean`|Кеширование|`false`

#### Пример {#working-from-charteditor-example}

Вкладка **Urls**

```js
const {buildSource} = require('libs/chyt/v1');

// Запрос
const query = `
    SELECT 2+2
`;

module.exports = {
    example: buildSource({
        cluster: 'hahn', // кластер
        cliqueId: '8d255cea-660d35d6-3fe03e8-5f426888', // id любой публичной клики или алиас
        // cliqueId: '*ch_datalens',
        token: ChartEditor.getSecrets()['token'], // yt token
        query
    })
};
```

