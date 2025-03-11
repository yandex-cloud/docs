---
title: Модели классификаторов
description: Из статьи вы узнаете о моделях классификаторов, доступных в сервисе {{ foundation-models-name }}.
---

# Модели классификаторов на базе {{ yagpt-name }}

Сервис {{ foundation-models-full-name }} предоставляет доступ к моделям классификаторов на базе {{ gpt-lite }} и {{ gpt-pro }}, которые позволяют [классифицировать](./index.md) передаваемые в промтах текстовые запросы. Классификация реализована в [{{ foundation-models-name }} Text Classification API](../../text-classification/api-ref/index.md).

Если стандартных моделей вам недостаточно, вы можете [дообучить](../tuning/classifier.md) классификатор на базе {{ gpt-lite }}, чтобы модель точнее классифицировала ваши запросы. Чтобы обратиться к дообученной модели классификатора, используйте метод [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API.

| **Модель** | **URI** | **[Режимы работы](../index.md#working-mode)** |
|---|---|---|
| Классификатор по промту на базе {{ gpt-lite }} | `cls://<идентификатор_каталога>/yandexgpt-lite/latest` | Синхронный |
| Классификатор по промту на базе {{ gpt-pro }} | `cls://<идентификатор_каталога>/yandexgpt/latest` | Синхронный |
| Дообученный классификатор | `cls://<URI_базовой_модели>/<версия>@<суффикс_дообучения>` | Синхронный |
| Модель классификатора, дообученная в {{ ml-platform-name }} | `cls://<идентификатор_каталога>/<идентификатор_дообученной_модели>` | Синхронный |

## Обращение к моделям {#addressing-models}

Вы можете обращаться к моделям классификаторов несколькими способами.

{% list tabs group=programming_language %}

- SDK {#sdk}

  При работе с моделями классификаторов через [{{ ml-sdk-full-name }}](../../sdk/index.md) используйте один из следующих форматов:

  * **Название модели**, передается в виде строки.

      ```python
      model = (
        sdk.models.text_classifiers("yandexgpt-lite")
      )
      ```

  * **Название и версия модели**, передаются в виде строк в полях `model_name` и `model_version` соответственно.

      ```python
      model = (
        sdk.models.text_classifiers(model_name="yandexgpt", model_version="latest")
      )
      ```

  * **URI модели**, передается в виде строки, содержащей полный URI модели. Также используйте этот способ для обращения к дообученным моделям.

      ```python
      model = (
        sdk.models.text_classifiers("cls://b1gt6g8ht345********/yandexgpt/latest")
      )
      ```

- API {#curl}

  Чтобы [обратиться](../../operations/classifier/readymade.md) к модели через [REST API](../../text-classification/api-ref/TextClassification/fewShotClassify.md) или [gRPC API](../../text-classification/api-ref/grpc/TextClassification/fewShotClassify.md), в поле `modelUri` тела запроса укажите URI модели, содержащий [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Сегмент `/latest` указывает на версию модели и является необязательным. Чтобы обратиться к модели классификатора на базе {{ yagpt-name }}, используйте метод/вызов `fewShotClassify` Text Classification API.

  **Пример:**

  ```json
  {
    "modelUri": "cls://b1gt6g8ht345********/yandexgpt-lite/latest"
    ...
  }
  ```

  Для обращения к `Latest` версии необязательно задавать версию модели явно, поскольку версия `Latest` используется по умолчанию.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../operations/classifier/readymade.md)
* [{#T}](../../operations/classifier/additionally-trained.md)