---
title: Модели генерации изображений
description: Из статьи вы узнаете о моделях генерации изображений, доступных в сервисе {{ foundation-models-name }}.
---

# Модели {{ yandexart-name }}

Сервис {{ foundation-models-full-name }} предоставляет доступ к модели {{ yandexart-name }}, которая генерирует изображения по текстовому описанию методом каскадной диффузии, итеративно детализируя изображения из шума.

| **Назначение** | **URI** | **[Режимы работы](../index.md#working-mode)** |
|---|---|---|
| Генерация изображения по текстовому описанию | `art://<идентификатор_каталога>/yandex-art/latest` | Асинхронный |

## Обращение к модели {#addressing-models}

Вы можете обращаться к модели генерации изображений несколькими способами.

{% list tabs group=programming_language %}

- SDK {#sdk}

  При работе с моделью генерации изображений через [{{ ml-sdk-full-name }}](../../sdk/index.md) используйте один из следующих форматов:

  * **Название модели**, передается в виде строки.

      ```python
      model = (
        sdk.models.image_generation("yandex-art")
      )
      ```

  * **Название и версия модели**, передаются в виде строк в полях `model_name` и `model_version` соответственно.

      ```python
      model = (
        sdk.models.image_generation(model_name="yandex-art", model_version="latest")
      )
      ```

  * **URI модели**, передается в виде строки, содержащей полный URI модели.

      ```python
      model = (
        sdk.models.image_generation("art://b1gt6g8ht345********/yandex-art/latest")
      )
      ```

- API {#curl}

  Чтобы [обратиться](../../operations/yandexart/request.md) к модели через [REST API](../../image-generation/api-ref/index.md) или [gRPC API](../../image-generation/api-ref/grpc/index.md), в поле `modelUri` тела запроса укажите URI модели, содержащий [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Сегмент `/latest` указывает на версию модели и является необязательным.

  **Пример:**

  ```json
  {
    "modelUri": "art://b1gt6g8ht345********/yandex-art/latest"
    ...
  }
  ```

  Для обращения к `Latest` версии необязательно задавать версию модели явно, поскольку версия `Latest` используется по умолчанию.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../operations/yandexart/request.md)