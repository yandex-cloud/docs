# Классификаторы на базе {{ yagpt-name }}

{{ foundation-models-full-name }} позволяет классифицировать передаваемые в промтах текстовые запросы. Классификация в [моделях](./models.md) на базе {{ yagpt-name }} реализована в [{{ foundation-models-name }} Text Classification API](../../text-classification/api-ref/index.md).

В {{ foundation-models-name }} доступна классификация трех типов:
* _Бинарная_ классификация относит запрос к одному из двух возможных классов. Например, [спам](https://ru.wikipedia.org/wiki/Спам) или не спам.
* _Многоклассовая_ классификация относит запрос к одному (и только к одному) из более чем двух классов. Например, центральный процессор компьютера может относиться только к одному поколению.
* Классификация _с несколькими метками_ позволяет относить запрос одновременно к нескольким разным классам, которые не являются взаимоисключающими. Например, к одному и тому же посту в социальной сети может относиться одновременно несколько [хештегов](https://ru.wikipedia.org/wiki/Хештег).

Модели классификации доступны только в [синхронном режиме](../index.md#working-mode).

Сервис {{ foundation-models-name }} предоставляет классификаторы двух видов: [по промту](#readymade) на базе {{ gpt-lite }} и {{ gpt-pro }} и [дообучаемые](#trainable) классификаторы на базе {{ gpt-lite }}.

Чтобы использовать модели классификаторов {{ foundation-models-full-name }}, необходима [роль](../../security/index.md#languageModels-user) `ai.languageModels.user` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

## Классификаторы по промту {#readymade}

Классификаторы по промту {{ foundation-models-name }} позволяют выполнять бинарную и многоклассовую классификацию, не требуют дообучения модели и управляются промтом. Метод [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) Text Classification API позволяет [использовать](../../operations/classifier/readymade.md) два классификатора по промту: _Zero-shot_ и _Few-shot_. В метод `fewShotClassify` можно передать от двух до двадцати классов.

{% note tip %}

{% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

{% endnote %}

### Классификатор Zero-shot {#zero-shot}

Классификатор Zero-shot позволяет выполнять бинарную и многоклассовую классификацию, передавая в теле запроса только [идентификатор модели](./models.md), описание задания, текст запроса и массив с именами классов.

Формат тела запроса для классификатора Zero-shot:

```json
{
  "modelUri": "string",
  "taskDescription": "string",
  "labels": [
    "string",
    "string",
    ...
    "string"
  ],
  "text": "string"
}
```

Где:
* `modelUri` — [идентификатор модели](./models.md), которая будет использоваться для классификации сообщения. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}.
* `taskDescription` — текстовое описание задания для классификатора.
* `labels` — массив классов.

    {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

* `text` — текстовое содержимое сообщения.

Для [запросов](../../operations/classifier/readymade.md) к классификаторам Zero-shot используйте эндпоинт `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification`.


### Классификатор Few-shot {#few-shot}

Классификатор Few-shot позволяет выполнять бинарную и многоклассовую классификацию, передавая в модель массив с примерами запросов для классов, заданных в поле `labels`. Примеры запросов передаются в поле `samples` тела запроса и позволяют улучшить качество результатов, выдаваемых классификатором.

Формат тела запроса для классификатора Few-shot:

```json
{
  "modelUri": "string",
  "taskDescription": "string",
  "labels": [
    "string",
    "string",
    ...
    "string"
  ],
  "text": "string",
  "samples": [
    {
      "text": "string",
      "label": "string"
    },
    {
      "text": "string",
      "label": "string"
    },
    ...
    {
      "text": "string",
      "label": "string"
    }
  ]
}
```

Где:
* `modelUri` — [идентификатор модели](./models.md), которая будет использоваться для классификации сообщения. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}.
* `taskDescription` — текстовое описание задания для классификатора.
* `labels` — массив классов.

    {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

* `text` — текстовое содержимое сообщения.
* `samples` — массив с примерами запросов для классов, заданных в поле `labels`. Примеры запросов передаются в виде объектов, каждый из которых содержит один образец текстового запроса и класс, к которому такой запрос следует относить.

Для [запросов](../../operations/classifier/readymade.md) к классификаторам Few-shot используйте эндпоинт `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification`.

{% note warning %}

Вы можете передавать несколько примеров классификации в одном запросе. Все примеры в запросе не должны превышать 6000 токенов.

{% endnote %}

## Дообучаемые классификаторы {#trainable}

Если качество результатов классификаторов [Zero-shot](#zero-shot) и [Few-shot](#few-shot) вас не устраивает, [дообучите собственный классификатор](../../operations/tuning/tune-classifiers.md) на базе {{ gpt-lite }}. Дообучаемые классификаторы могут быть обучены всем поддерживаемым типам классификации.

Чтобы [выполнить](../../operations/classifier/additionally-trained.md) запрос к классификатору дообученной в {{ ml-platform-name }} модели, используйте метод [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API. В этом случае в модель требуется передать только [идентификатор модели](./models.md) и текст запроса. Имена классов, по которым модель будет распределять запросы, должны быть заданы в процессе дообучения модели и в запросе не передаются.

Формат тела запроса для дообученного классификатора:

```json
{
  "modelUri": "string",
  "text": "string"
}
```

Где:
* `modelUri` — [идентификатор модели](./models.md), которая будет использоваться для классификации сообщения. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} и идентификатор дообученного классификатора.
* `text` — текстовое содержимое сообщения. Суммарное количество токенов на один запрос не должно превышать 8000.

Для [запросов](../../operations/classifier/additionally-trained.md) к дообучаемым классификаторам используйте эндпоинт `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification`.

Имена классов, по которым модель будет распределять запросы, должны быть заданы в процессе дообучения модели и в запросе не передаются.


## Формат ответа {#response}

Все типы классификаторов {{ foundation-models-name }} возвращают результат в следующем формате:

```yaml
{
  "predictions": [
    {
      "label": "string",
      "confidence": "number",
    },
    {
      "label": "string",
      "confidence": "number",
    },
    ...
    {
      "label": "string",
      "confidence": "number",
    }
  ],
  "modelVersion": "string"
}
```

Где:
* `label` — имя класса.
* `confidence` — значение вероятности отнесения текста запроса к данному классу.

    При многоклассовой классификации сумма значений полей вероятности (`confidence`) для всех классов всегда равна `1`.

    При классификации с несколькими метками значение поля вероятности (`confidence`) для каждого класса рассчитывается независимо (сумма значений не равна `1`).