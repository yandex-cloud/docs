Чтобы развернуть сервис автоматических ответов на отзывы Wildberries:

1. [Подготовьте облако к работе](#before-begin).
1. [Получите API-токен Wildberries](#wb-token).
1. [Подготовьте код](#prepare-code).
1. [Разверните сервис](#deploy) — одним из способов: через Serverless Framework (быстро, всё создаётся автоматически) или поэтапно через консоль управления (вручную).
1. [Проверьте работу сервиса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](paid-resources.md) %}


## Получите API-токен Wildberries {#wb-token}

API-токен Wildberries даёт сервису доступ к разделу отзывов в кабинете продавца.

1. Перейдите в [кабинет продавца Wildberries](https://seller.wildberries.ru/).
1. Откройте раздел **Профиль** → **Настройки** → **Доступ к API**.
1. Создайте новый ключ с областью **Отзывы и вопросы** (Feedbacks).
1. Сохраните токен — он понадобится при развёртывании.

Подробнее о токенах Wildberries см. в [официальной документации Wildberries для разработчиков](https://dev.wildberries.ru/openapi/api-information).


## Подготовьте код {#prepare-code}

Клонируйте [репозиторий](https://github.com/eslazarev/ai-wildberries-review-responder) с исходным кодом сервиса:

```bash
git clone https://github.com/eslazarev/ai-wildberries-review-responder.git
cd ai-wildberries-review-responder
```

В репозитории уже есть всё необходимое для развёртывания:

* `src/` — исходный код приложения, построенный по гексагональной архитектуре.
* `requirements.txt` — список Python-зависимостей.
* `settings.yaml` — конфигурация по умолчанию: базовые URL, размер пачки отзывов, период запуска, шаблон промпта и системные инструкции для модели.
* `serverless.yml` — манифест Serverless Framework: описывает функцию, cron-триггер и оба сервисных аккаунта (`{{ roles-yagpt-user }}` для функции и `{{ roles-functions-invoker }}` для триггера).

Точка входа для {{ sf-name }} — `src.entrypoints.yandex_cloud_function.handler`. Внутри функции:

1. Загружаются настройки из `settings.yaml` и переменных окружения.
1. Если переменная `LLM__API_KEY` пуста или равна `null`, в качестве токена для {{ yagpt-full-name }} используется IAM-токен сервисного аккаунта из `context.token`.
1. Wildberries-клиент получает список неотвеченных отзывов.
1. Для каждого отзыва строится промпт по шаблону из `settings.yaml`.
1. LLM возвращает текст ответа.
1. Wildberries-клиент публикует ответ.


## Разверните сервис {#deploy}

Выберите подходящий способ развёртывания.

{% list tabs group=instructions %}

- Serverless Framework {#serverless}

  Этот способ создаёт **все** ресурсы — функцию, cron-триггер и оба сервисных аккаунта (`wb-responder-function-service-account` с ролью `{{ roles-yagpt-user }}` и `wb-responder-trigger-service-account` с ролью `{{ roles-functions-invoker }}`) — одной командой согласно манифесту `serverless.yml`.

  Требуется установленный [Node.js 18+](https://nodejs.org) и [Serverless Framework 3](https://www.serverless.com/framework/docs/getting-started).

  1. В корне клонированного репозитория установите зависимости:

     ```bash
     npm install
     ```

  1. Запустите развёртывание, передав API-токен Wildberries из шага [Получите API-токен Wildberries](#wb-token):

     ```bash
     WILDBERRIES__API_TOKEN='ваш_wb_token' serverless deploy
     ```

     На этом развёртывание завершено. Переменная `LLM__API_KEY` по умолчанию равна `null` — функция использует IAM-токен сервисного аккаунта, создаваемого в этой же команде.

  1. Чтобы изменить периодичность запуска, передайте переменную `WILDBERRIES__CHECK_EVERY_MINUTES` (значение в минутах, по умолчанию 30):

     ```bash
     WILDBERRIES__CHECK_EVERY_MINUTES='15' WILDBERRIES__API_TOKEN='ваш_wb_token' serverless deploy
     ```

  1. Чтобы использовать вместо {{ yagpt-name }} другую OpenAI-совместимую модель (OpenAI, Ollama и т. п.), задайте также `LLM__API_KEY`, при необходимости — `LLM__MODEL` и `LLM__BASE_URL`:

     ```bash
     LLM__API_KEY='ваш_llm_api_key' WILDBERRIES__API_TOKEN='ваш_wb_token' serverless deploy
     ```

- Консоль управления {#console}

  Если хочется собрать инфраструктуру вручную, повторите шаги ниже. Через консоль все ресурсы создаются по отдельности.

  **1. Создайте сервисные аккаунты.**

  1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт с именем `wb-responder-function-sa` и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-yagpt-user }}` — функция использует его IAM-токен для обращения к {{ yagpt-name }}.
  1. [Создайте](../../../iam/operations/sa/create.md) второй сервисный аккаунт с именем `wb-responder-trigger-sa` и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-functions-invoker }}` — от его имени cron-триггер будет вызывать функцию.

  **2. Создайте функцию.**

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}** и задайте имя `wb-responder-function`.
  1. В корне клонированного репозитория соберите ZIP-архив с папкой `src/` и файлами `requirements.txt`, `settings.yaml`:

     ```bash
     zip -r wb-responder.zip src requirements.txt settings.yaml
     ```

  1. Создайте версию функции с параметрами:

     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python312`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `src.entrypoints.yandex_cloud_function.handler`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `512 {{ ui-key.yacloud.common.units.label_megabyte }}`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `30`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** — **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**, загрузите `wb-responder.zip`.
     * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `wb-responder-function-sa`.

  1. Добавьте переменные окружения:

     * `WILDBERRIES__API_TOKEN` — токен Wildberries из шага [Получите API-токен Wildberries](#wb-token).
     * `LLM__API_KEY` — оставьте пустым или задайте `null`, чтобы функция использовала IAM-токен сервисного аккаунта при работе с {{ yagpt-name }}.

  1. Сохраните версию.

  **3. Создайте триггер-таймер.**

  1. На странице сервиса **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** и нажмите **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}** задайте:

     * Имя триггера — `wb-responder-trigger`.
     * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** — `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.

  1. В блоке **Таймер** укажите cron-выражение, например `*/30 * * * ? *` — запуск каждые 30 минут.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию `wb-responder-function`, тег версии `$latest` и сервисный аккаунт `wb-responder-trigger-sa`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Проверьте работу сервиса {#test}

1. В кабинете продавца Wildberries убедитесь, что есть хотя бы один неотвеченный отзыв.
1. В [консоли управления]({{ link-console-main }}) откройте функцию `wb-responder-function` и перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** — функция выполнится разово, без ожидания триггера. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** должен появиться статус **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}**.
1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** и убедитесь, что в логах нет ошибок и видны записи о том, что отзывы обработаны.
1. Через несколько минут вернитесь в кабинет продавца Wildberries и проверьте, что у обработанных отзывов появились ответы.

Если в логах появляются ошибки авторизации Wildberries (`401 Unauthorized`), убедитесь, что переменная окружения `WILDBERRIES__API_TOKEN` содержит токен с областью **Отзывы и вопросы**.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Если разворачивали через Serverless Framework, удалите всё одной командой:

   ```bash
   serverless remove
   ```

   В этом случае оставшиеся шаги выполнять не нужно.

1. [Удалите](../../../functions/operations/trigger/trigger-delete.md) триггер `wb-responder-trigger`.
1. [Удалите](../../../functions/operations/function/function-delete.md) функцию `wb-responder-function`.
1. [Удалите](../../../iam/operations/sa/delete.md) сервисные аккаунты `wb-responder-function-sa` и `wb-responder-trigger-sa`.
