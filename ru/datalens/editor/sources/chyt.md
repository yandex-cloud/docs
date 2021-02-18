
# CHYT (ClickHouse over YT)

## Как работать с CHYT из ChartEditor

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

#### Пример

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

## Как работать с CHYT из ChartWizard

Чтобы подключить кластер CHYT и начать работать с ним ChartWizard вам необходимо выполнить следующие шаги:
* Перейти на [страницу соединений](https://charts.yandex-team.ru/connections).
* Создать соединение к CHYT.
* Cоздать [датасет](https://stat.yandex-team.ru/datasets) на основании этого соединения.
* Cоздать чарт в [Wizard](https://charts.yandex-team.ru/wizard) на основании этого датасета.

Также много информации и рекомендаций по работе с CHYT содержится в нашем клубе в Этушке:
* [Базовые вещи](https://clubs.at.yandex-team.ru/statistics/1692)
* [Рекомендации](https://clubs.at.yandex-team.ru/statistics/1921)
