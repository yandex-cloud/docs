
# Конвертация старых визардов в Editor-скрипт

Конвертация Wizard-чартов в Editor скрипт осуществляется посредством вызова метода API.


Скрипт использует служебный модуль `libs/legacy-wizard/v1` и конфигурацию, описанную на вкладке Shared.
За счет этого результат выполнения Editor скрипта такой же, как результат выполнения Wizard чарта.


Изменения в скрипт рекомендуется добавлять перед `module.exports = result;`, модифицируя содержимое `result`.
Описание конфигурации в данный момент недокументировано и изменения возможны только на интуитивном уровне.

## API {#api}

[Аутентификация](../api/auth.md) • [Идентификация](../api/identification.md)

`POST` `https://charts.yandex-team.ru/api/wizard/v1/convert`

* `wizardKey` - путь до Wizard чарта
* `editorKey` - путь до Editor скрипта (**Примечание**: папки должны быть созданы заранее)

### Пример запроса {#example-request}

```bash
curl -X POST https://charts.yandex-team.ru/api/wizard/v1/convert \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d '{
    "wizardKey": "Examples/simple-graph-wizard",
    "editorKey": "Wizard to Editor Convert Test/simple-graph-wizard"
  }'
```

### Пример ответа {#example-response}

```json
{
   "entryId": "wvo8n6c0uy9cs",
   "key": "Wizard to Editor Convert Test/simple-graph-wizard",
   "data": {
     ...
   },
   ...
 }

```

## Примеры {#examples}

* [Wizard to Editor Convert Test/simple-graph-wizard-converted](https://charts.yandex-team.ru/editor/Wizard%20to%20Editor%20Convert%20Test/simple-graph-wizard-converted)

  Конвертирован из [Examples/simple-graph-wizard](https://charts.yandex-team.ru/wizard/Examples/simple-graph-wizard).
На основе примера [Examples/plot-lines](https://charts.yandex-team.ru/editor/examples/plot-lines) в скрипт был добавлен новый источник и линии.
Внесенные в код изменения можно увидеть в истории изменений скрипта.
