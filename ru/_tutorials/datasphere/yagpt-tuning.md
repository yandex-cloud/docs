В [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) можно [дообучить](../../datasphere/concepts/models/foundation-models.md#tuning-abilities) нейросеть [{{ yagpt-name }}](../../yandexgpt/concepts/index.md) определенному формату ответов или принципам анализа текста, чтобы она точнее отражала специфику ваших задач. Для этого нужно подготовить файл с парами запросов и эталонных ответов и запустить дообучение. Обучить модель новой информации, например базе знаний службы поддержки, не получится.

{% note info %}

Дообучение фундаментальных моделей находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

{% note info %}

Сервис {{ yagpt-full-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы дообучить модель {{ yagpt-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте данные для обучения](#create-data).
1. [Дообучите модель](#model-tuning).
1. [Протестируйте модель](#model-test).

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

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} (опционально) {#create-sa}

Обращаться к дообученной модели можно через интерфейс {{ ml-platform-name }} (Playground) или через API v1 в синхронном режиме. Если вы планируете делать запросы через API, вам понадобится сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md) `{{ roles-yagpt-user }}`. Сервисный аккаунт должен быть участником проекта {{ ml-platform-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `ai-user`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роль `{{ roles-yagpt-user }}`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

#### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог обращаться к дообученной модели из кода проекта {{ ml-platform-name }}, добавьте его в список участников проекта.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
    1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
    1. Выберите аккаунт `ai-user` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

## Подготовьте данные для обучения {#create-data}

Данные для дообучения модели необходимо сохранить в файл JSON в кодировке UTF-8 в виде пар [запросов и эталонных ответов](../../datasphere/concepts/models/foundation-models.md#yagpt-tuning). Для успешного запуска дообучения требуется не менее 10 пар.

Пример наполнения файла:

```json
[
{
    "request": "с новым годом!",
    "response": "С Новым годом!"
},
{
    "request": "хорший прадукт, все рикомендуею!",
    "response": "Хороший продукт, всем рекомендую!"
},
{
    "request": "у меня притензия к ихнему сервису!",
    "response": "У меня претензия к их сервису!"
}
…
]
```

## Дообучите модель {#model-tuning}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}

1. На панели слева нажмите **{{ ui-key.yc-ui-datasphere.common.foundation-models }}**.

1. Выберите модель **{{ ui-key.yc-ui-datasphere.common.YGPT }}** и нажмите **{{ ui-key.yc-ui-datasphere.common.tuning-model }}**.

1. В открывшемся окне укажите свой проект и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

1. В поле **{{ ui-key.yc-ui-datasphere.common.name }}** введите название модели, например `my-first-model`.

1. Задайте **{{ ui-key.yc-ui-datasphere.foundation-model.learning-rate }}**. Темп обучения определяет размер шага на каждой итерации при поиске оптимального решения. При высоких значениях модель будет быстрее сходиться, но увеличится риск переобучения модели.

1. В блоке **{{ ui-key.yc-ui-datasphere.foundation-model.data-for-tuning }}**:

    * В поле **{{ ui-key.yc-ui-datasphere.foundation-model.samples-file }}** прикрепите файл JSON с парами запросов и ответов.
    * В поле **{{ ui-key.yc-ui-datasphere.foundation-model.instruction }}** опишите условия выполнения задания, контекст, возможные ограничения или задайте стиль ответа. Это необязательный пункт, но после запуска дообучения инструкцию будет нельзя изменить. Эта инструкция станет частью дообученной модели.

1. Нажмите **{{ ui-key.yc-ui-datasphere.foundation-model.start-tuning }}** и дождитесь окончания дообучения.

1. Чтобы проверить статус дообученной модели:

    * {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
    * В списке доступных ресурсов проекта выберите **{{ ui-key.yc-ui-datasphere.common.models }}**.
    * На вкладке **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.

      Также здесь можно получить идентификатор модели, который потребуется для запроса через API.

## Протестируйте модель {#model-test}

{% list tabs group=programming_language %}

- Playground {#playground}

    1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}

    1. В списке доступных ресурсов проекта выберите **{{ ui-key.yc-ui-datasphere.common.models }}**.
    
    1. На вкладке **{{ ui-key.yc-ui-datasphere.common.projects-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.tuned-foundation-models }}**.

    1. Выберите свою дообученную модель и нажмите **{{ ui-key.yc-ui-datasphere.foundation-model.test-in-playground }}**.

    1. Сформулируйте свой запрос к модели в блоке **{{ ui-key.yc-ui-datasphere.yagpt-playground.request.title }}**.

    1. Чтобы изменить вариативность, передвигайте ползунок в поле **{{ ui-key.yc-ui-datasphere.yagpt-playground.temperature.title }}**. Чем выше значение, тем более непредсказуемым будет результат выполнения запроса.

- {{ jlab }}Lab {#jupyterlab}

    Скопируйте код в ячейку ноутбука, если вы не использовали инструкцию для дообучения модели:

    ```python
    import requests
    req = {
            "modelUri": "ds://<идентификатор_дообученной_модели>",
            "completionOptions": {
                "stream": False,
                "temperature": 0.1,
                "maxTokens": "2000"
            },
            "messages": [
                {
                "role": "user",
                "text": "<текст_запроса>"
                }
            ]            
    }
    headers = {"Authorization" : "Bearer " + '<IAM-токен>',
            "x-folder-id": "<идентификатор_каталога>", }
    res = requests.post("https://llm.api.cloud.yandex.net/foundationModels/v1/completion",
        headers=headers, json=req)
    print(res.json())
    ```

    Где:

    * `modelUri` — идентификатор дообученной модели. Можно [найти](#model-tuning) в списке доступных ресурсов проекта.
    * `temperature` — температура. Чем выше значение, тем более непредсказуемым будет результат выполнения запроса.
    * `maxTokens` — максимальное число токенов в ответе модели.
    * `<IAM-токен>` — значение [IAM-токена сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md).
    * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.

    Если вы использовали инструкцию для дообучения, укажите ее текст в сообщении с ролью `system`:

    ```python
    import requests
    req = {
            "modelUri": "ds://<идентификатор_дообученной_модели>",
            "completionOptions": {
                "stream": False,
                "temperature": 0.1,
                "maxTokens": "2000"
            },
            "messages": [
                {
                "role": "system",
                "text": "<текст_инструкции>"
                },
                {
                "role": "user",
                "text": "<текст_запроса>"
                }
            ]    
    }
    headers = {"Authorization" : "Bearer " + '<IAM-токен>',
                       "x-folder-id": "<идентификатор_каталога>", }
    res = requests.post("https://llm.api.cloud.yandex.net/foundationModels/v1/completion",
        headers=headers, json=req)
    print(res.json())
    ```

    Подробнее о параметрах запроса к дообученной модели см. в [документации {{ yagpt-full-name }}](../../yandexgpt/concepts/index.md).

- cURL {#curl}

    {% include [curl](../../_includes/curl.md) %}

    1. Создайте файл JSON с параметрами запроса к модели. Если вы не использовали инструкцию для дообучения, скопируйте в него следующий код:
    
       ```json
        {
        "modelUri": "ds://<идентификатор_дообученной_модели>",
        "completionOptions": {
            "stream": false,
            "temperature": 0.1,
            "maxTokens": "2000"
        },
        "messages": [
            {
            "role": "user",
            "text": "<текст_запроса>"
            }
        ]
        }
       ```

       Где:

       * `modelUri` — идентификатор дообученной модели. Можно [найти](#model-tuning) в списке доступных ресурсов проекта.
       * `temperature` — температура. Чем выше значение, тем более непредсказуемым будет результат выполнения запроса.
       * `maxTokens` — максимальное число токенов в ответе модели.
       * `text` — текст запроса.

       Если вы использовали инструкцию для дообучения, в JSON файле укажите ее текст в сообщении с ролью `system`:

       ```json
        {
        "modelUri": "ds://<идентификатор_дообученной_модели>",
        "completionOptions": {
            "stream": false,
            "temperature": 0.1,
            "maxTokens": "2000"
        },
        "messages": [
            {
            "role": "system",
            "text": "<текст_инструкции>"
            },
            {
            "role": "user",
            "text": "<текст_запроса>"
            }
        ]
        }
       ```

    1. Отправьте запрос через командную оболочку:
   
       ```bash
       curl --request POST
           -H "Content-Type: application/json"
           -H "Authorization: Bearer <IAM-токен>"
           -H "x-folder-id: <идентификатор_каталога>"
           -d prompt.json
           https://llm.{{ api-host }}/foundationModels/v1/completion
       ```
        
       Где:
   
       * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.
       * `<IAM-токен>` — значение [IAM-токена сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md).
       * `prompt.json` — файл в формате JSON, содержащий параметры запроса.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

[Удалите проект](../../datasphere/operations/projects/delete).
