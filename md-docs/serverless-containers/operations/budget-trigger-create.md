# Создать триггер для бюджетов, который вызывает контейнер {{ serverless-containers-name }}

Создайте [триггер для бюджетов](../concepts/trigger/budget-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} при превышении пороговых значений.

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Контейнер, который триггер будет вызывать. Если у вас нет контейнера:

    * [Создайте контейнер](create.md).
    * [Создайте ревизию контейнера](manage-revision.md#create).

* (Опционально) Очередь [Dead Letter Queue](../concepts/dlq.md), куда будут перенаправляться сообщения, которые не смог обработать контейнер. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с правами на вызов контейнера и (опционально) запись в очередь Dead Letter Queue. Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

* Бюджет, при превышении порога которого триггер будет запускаться. Если у вас нет бюджета, [создайте его](../../billing/operations/budgets.md).

## Создать триггер {#trigger-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

       * Введите имя и описание триггера.
       * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_billing-budget }}`.
       * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_billing-budget }}** выберите платежный аккаунт и бюджет. Можно выбрать **{{ ui-key.yacloud.serverless-functions.triggers.form.label_any-budget }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container }}** выберите его и [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого он будет вызываться.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}** укажите время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}** укажите количество повторных вызовов контейнера, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Допустимые значения — от 1 до 5, значение по умолчанию — 1.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create billing-budget \
      --name <имя_триггера> \
      --billing-account-id <идентификатор_платежного_аккаунта> \
      --budget-id <идентификатор_бюджета> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--billing-account-id` — идентификатор платежного аккаунта.
    * `--budget-id` — идентификатор бюджета.

    * `--invoke-container-id` — идентификатор контейнера.
    * `--invoke-container-service-account-id` — идентификатор сервисного аккаунта с правами на вызов контейнера.
    * `--retry-attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--retry-interval` — время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--dlq-queue-id` — идентификатор очереди Dead Letter Queue. Необязательный параметр.
    * `--dlq-service-account-id` — идентификатор сервисного аккаунта с правами на запись в очередь Dead Letter Queue. Необязательный параметр.

    Результат:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflruh2********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: budget-trigger
    rule:
      billing-budget:
        billing-account-id: dn2char50jh2********
        budget-id: dn2jnshmdlh2********
        invoke_container:
          container_id: d4eofc7n0mh2********
          service_account_id: aje3932acdh2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmkh2********:dlq
            service-account-id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы создать триггер для бюджетов, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи контейнера](../concepts/logs.md), в них отображается информация о вызовах.

## См. также {#see-also}

* [{#T}](../../functions/operations/trigger/budget-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/budget-trigger-create.md)