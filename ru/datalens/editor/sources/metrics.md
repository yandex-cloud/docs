
# Metrics

**Интерфейс**: [`https://metrics.yandex-team.ru`](https://metrics.yandex-team.ru)

**Префикс**: `/_metrics` -> `https://metrics.yandex-team.ru`

---

## Интеграция {#integration}

С сервисом есть более тесная интеграция.
На странице с графиком есть кнопка **Stat export**.
В результате вас перенаправит на график в Yandex Charts.

## Формирование источника данных {#forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/metrics/v1`.
Метод `buildSource` принимает один аргумент: `object` со следующими свойствами:

|Имя|Тип|Описание|Обязательный / По умолчанию|
|:---|:---|:---|:---|
|graphName|`string`|Имя графика на Metrics|Обязательный
|startDate|`string`|ISO дата начала периода|Обязательный
|endDate|`string`|ISO дата конца периода|Обязательный
|confidentOnly|`boolean`|Только проверенные точки|`false`
|config|`object[]`|Массив конфигураций|Обязательный

Описание конфигурации включает в себя следующее **обязательное** свойство:

|Имя|Тип|Описание
|:---|:---|:---
|filter|`object`|Описание фильтра

Описание фильтра состоит из следующих **обязательных** свойств:

|Имя|Тип|Описание
|:---|:---|:---
|system|`string`|Имя системы
|metric|`string`|Имя метрики

### Пример {#forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Metrics = require('libs/metrics/v1');

// формируем источник данных
const metricsSource = Metrics.buildSource({
    graphName: 'history',
    startDate: '2018-01-01',
    endDate: '2018-02-01',
    confidentOnly: false,
    config: [
        {
            filter: {
                system: '142',
                metric: 'proxima-5'
            }
        },
        {
            filter: {
                system: '140',
                metric: 'proxima-5'
            }
        }
    ]
});

// экспортируем источник данных
module.exports = {
    metricsSource: metricsSource
};
```

## Примеры {#examples}

[Метрика `proxima-5`, системы `140` и `142`](https://charts.yandex-team.ru/editor/Templates/simple-metrics)
