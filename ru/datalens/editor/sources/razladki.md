
# Разладки

**Интерфейс**: [`https://razladki.yandex-team.ru`](https://razladki.yandex-team.ru)

**Префикс**: `/_razladki` -> `https://razladki.yandex-team.ru`

---

## Особенности {#features}

Сервис присылает время в UTC формате.

---

## Формирование источника данных {#forming-data-source}

Для формирования источника данных используется метод `buildSource` модуля `libs/razladki/v1`.
Метод `buildSource` принимает один аргумент: `object` со следующими **обязательными** свойствами:

|Имя|Тип|Описание
|:---|:---|:---
|project|`string`|Имя проекта
|metric|`string` `string[]`|Метрика/метрики
|date_min|`string`|Начало периода (`YYYY-MM-DD hh:mm`)
|date_max|`string`|Конец периода (`YYYY-MM-DD hh:mm`)

### Пример {#forming-data-source-example}

Вкладка **Urls**
```js
// подключаем модуль источника данных
const Razladki = require('libs/razladki/v1');

// формируем источник данных
const razladkiSource = Razladki.buildSource({
    project: 'freshness_sbs',
    metric: [
        'production_vs_october_2017_winrate',
        'production_vs_october_2017_winrate_fast'
    ],
    date_min: '2018-01-01',
    date_max: '2018-02-01'
});

// экспортируем источник данных
module.exports = {
    razladkiSource: razladkiSource
};
```

## Работа с данными из источника {#work-with-data-source}

Метод `prepareGraph` модуля `libs/razladki/v1` используется для формирования данных для отрисовки и в качестве
аргументов принимает данные полученные от источника и `object` со следующими свойствами:

|Имя|Тип|Описание|По умолчанию
|:---|:---|:---|:---
|useTimeShift|`boolean`|Использовать локальное время (добавляет 3 часа к временному ряду)|`false`

### Пример {#work-with-data-source-example}

Вкладка **JavaScript**
```js
// подключаем модуль источника данных
const Razladki = require('libs/razladki/v1');

// запрашиваем загруженные данные
const loadedData = ChartEditor.getLoadedData();

// формируем данные для отрисовки
const result = Razladki.prepareGraph(
    loadedData.razladkiSource,
    {useTimeShift: true}
);

// экспортируем данные для отрисовки
module.exports = result;
```

## Примеры {#examples}

[График по данным из Разладок](https://charts.yandex-team.ru/editor/Templates/simple-razladki)
