---
title: Запустить модель в пакетном режиме в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете обработать большой объем данных с помощью пакетного режима работы модели.
---

# Запустить модель в пакетном режиме

## Перед началом работы {#before-begin}


{% list tabs group=programming_language %}

- Консоль управления {#console}

  Для работы из консоли управления подготовительные действия не требуются.

- SDK {#sdk}

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../security/index.md#languageModels-user) `ai.editor`.
  1. [Получите](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) и сохраните API-ключ сервисного аккаунта.

      {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
  1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите [библиотеку {{ ml-sdk-name }}](../../sdk/index.md):

      ```bash
      pip install yandex-cloud-ml-sdk
      ```

{% endlist %}

## Подготовьте данные {#create-dataset}

1. Подготовьте данные для запуска модели. В зависимости от решаемой задачи и используемой модели, это может быть `TextTextToTextGenerationRequest` для [текстовой генерации](../../concepts/resources/dataset.md#text-requests) или  `ImageTextToTextGenerationRequest` для [визуально-текстовых моделей](../../concepts/resources/dataset.md#vlm-requests).
1. [Создайте датасет](../resources/create-dataset.md) любым удобным способом. Вы также сможете создать датасет позднее на этапе запуска модели.

## Запустите модель {#run-batch}

{% list tabs group=programming_language %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роли](../../security/index.md) `ai.playground.user` и `ai.datasets.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/gear-play.svg) **Запуски в пакетном режиме**.
  1. Нажмите **Запустить**.
  1. Выберите модель для запуска.
  1. Добавьте датасет: выберите существующий или загрузите новый файл.
  1. Задайте температуру модели.
  1. Нажмите кнопку **Запустить**.

- SDK {#sdk}

  1. Создайте файл `batch-run.py` и добавьте в него код. :

     {% include [batch-run](../../../_includes/foundation-models/examples/batch-run.md) %}

     Где:

     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создан [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
     * `<API-ключ>` — [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта, полученный ранее и необходимый для [аутентификации в API](../../../foundation-models/api-ref/authentication.md).

   	  {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
        
     * `<URI_модели>` — идентификатор модели для запуска. Поддерживаются модели [текстовой генерации](../../concepts/yandexgpt/models.md#batch) и [визуально-текстовые](../../concepts/multimodal/index.md) модели.
     * `<идентификатор_датасета>` — идентификатор датасета с запросами к модели.

  1. Выполните созданный файл:

     ```bash
     python3 batch-run.py
     ```

{% endlist %}

{% note tip %}

Время работы модели в пакетном режиме зависит от размеров датасета и может занимать несколько суток. Статус запуска можно отследить в [консоли управления]({{ link-console-main }}/link/foundation-models/batches/).

{% endnote %}
