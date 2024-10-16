{% include [classifiers-intro](../../_includes/datasphere/classifiers-tuning-intro.md) %}

{% note info %}

Дообучение фундаментальных моделей находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

{% note info %}

Сервис {{ foundation-models-full-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы дообучить классификатор {{ yagpt-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте данные для обучения](#create-data).
1. [Дообучите классификатор](#tuning).
1. [Отправьте запрос к классификатору](#request).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

Обращаться к дообученной модели можно через интерфейс {{ ml-platform-name }} (Playground) или через API {{ foundation-models-name }}. Если вы планируете делать запросы через API, вам понадобится сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md) `{{ roles-yagpt-user }}`. Сервисный аккаунт должен быть участником проекта {{ ml-platform-name }}, в котором будет дообучен классификатор.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `ai-user`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роль `{{ roles-yagpt-user }}`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

#### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог обращаться к дообученному классификатору, добавьте его в список участников проекта.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Выберите аккаунт `ai-user` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

## Подготовьте данные для обучения {#create-data}

{% include [logging](../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

{% include [data-format](../../_includes/datasphere/classifier-training.md) %}

## Дообучите модель {#tuning}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. На панели слева нажмите **{{ ui-key.yc-ui-datasphere.common.foundation-models }}**.
1. Выберите модель **Классификатор {{ yagpt-name }}** и нажмите **{{ ui-key.yc-ui-datasphere.common.tuning-model }}**.
1. В открывшемся окне укажите свой проект и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.common.name }}** введите название модели.
1. Выберите **Тип классификации**:

   * **Бинарная** — если каждый запрос относится к одной из двух групп.
   * **Многоклассовая** — если нужно разделить множество запросов на несколько групп.
   * **С несколькими метками** — если у каждого запроса может быть больше одной группы.

1. Прикрепите файл JSON с парами запросов и классов в поле **{{ ui-key.yc-ui-datasphere.foundation-model.samples-file }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.foundation-model.start-tuning }}** и дождитесь окончания дообучения. Это может занять несколько часов.
1. Чтобы проверить статус дообученной модели:

   * {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
   * В списке доступных ресурсов проекта выберите **{{ ui-key.yc-ui-datasphere.common.models }}**.
   * На вкладке **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.
  
     Также здесь можно получить идентификатор модели, который потребуется для запроса через API.

## Отправьте запрос к дообученному классификатору {#request}

{% list tabs group=programming_language %}

- Playground {#playground}

  1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
  1. В списке доступных ресурсов проекта выберите **{{ ui-key.yc-ui-datasphere.common.models }}**.    
  1. На вкладке **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.
  1. Выберите свою дообученную модель и нажмите **{{ ui-key.yc-ui-datasphere.foundation-model.test-in-playground }}**.
  1. Напишите текст, который нужно классифицировать, в блоке **{{ ui-key.yc-ui-datasphere.yagpt-playground.request.title }}**.
  1. Нажмите **{{ ui-key.yc-ui-datasphere.yagpt-playground.send-request }}**.

- cURL {#curl}

  {% include [curl](../../_includes/curl.md) %}

  1. Создайте файл с телом запроса (например, `body.json`):
  
      ```json
      {
        "model_uri": "cls://<идентификатор_каталога>/<идентификатор_классификатора>",
        "text": "<текст_запроса>"
      }
      ```
  
      Где:
      * `model_uri` — идентификатор модели, которая будет использоваться для классификации сообщения. Параметр содержит [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} и идентификатор [дообученной](../../datasphere/concepts/models/foundation-models.md#classifier-training) в {{ ml-platform-name }} модели.
      * `text` — текстовое содержимое сообщения. Суммарное количество токенов на один запрос не должно превышать 8000.
  
  1. Отправьте запрос к классификатору, выполнив команду:
  
      ```bash
      export IAM_TOKEN=<IAM-токен>
      curl --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "@<путь_к_файлу_с_телом_запроса>" \
        "https://{{ api-host-llm }}:443/foundationModels/v1/textClassification"
      ```
  
      В ответе сервис вернет результаты классификации с определенными значениями вероятности (`confidence`) принадлежности текста запроса к каждому из классов:
  
      ```json
      {
        "predictions": [
          {
            "label": "<название_класса_1>",
            "confidence": 0.00010150671005249023
          },
          {
            "label": "<название_класса_2>",
            "confidence": 0.000008225440979003906
          },
          ...
          {
            "label": "<название_класса_n>",
            "confidence": 0.93212890625
          }
        ],
        "modelVersion": "<версия_модели>"
      }
      ```
  
      При многоклассовой классификации сумма значений полей вероятности (`confidence`) для всех классов всегда равна `1`.

      При классификации с несколькими метками значение поля вероятности (`confidence`) для каждого класса рассчитывается независимо (сумма значений не равна `1`).

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

[Удалите проект](../../datasphere/operations/projects/delete).
