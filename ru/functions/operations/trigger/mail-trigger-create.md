# Создать триггер для почты, который вызывает функцию {{ sf-name }}

Создайте [триггер для почты](../../concepts/trigger/mail-trigger.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }}, когда на электронную почту приходит письмо. Адрес электронной почты генерируется сервисом автоматически во время создания триггера.

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Функция, которую триггер будет вызывать. Если у вас нет функции:

    * [Создайте функцию](../../../functions/operations/function/function-create.md).
    * [Создайте версию функции](../../../functions/operations/function/version-manage.md).

* (Опционально) Очередь [Dead Letter Queue](../../../functions/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) с правами:
    
    * на вызов функции;
    * (опционально) на запись в очередь Dead Letter Queue;
    * (опционально) на загрузку объектов в бакет.
    
    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md).

* (Опционально) [Бакет](../../../storage/concepts/bucket.md), в который будут сохраняться вложения из писем. Если у вас нет бакета, [создайте его](../../../storage/operations/buckets/create.md) с ограниченным доступом.

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * (Опционально) Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_mail }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_mail-attachments }}**:
      
        {% include [mail-trigger-attachements](../../../_includes/functions/mail-trigger-attachements.md) %}

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    
    ```bash
    yc serverless trigger create mail \
      --name <имя_триггера> \
      --batch-size <размер_группы> \
      --batch-cutoff <максимальное_время_ожидания> \
      --attachements-bucket <имя_бакета> \
      --attachements-service-account-id <идентификатор_сервисного_аккаунта> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```
  

    Где:

    * `--name` — имя триггера.

    {% include [batch-settings-messages](../../../_includes/functions/batch-settings-messages.md) %}

    {% include [attachments-params](../../../_includes/functions/attachments-params.md) %}
    
    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Результат:

    
    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: mail-trigger
    rule:
      mail:
        email: a1s8h8avgl**********-cho1****@serverless.yandexcloud.net
        batch_settings:
          size: "3"
          cutoff: 20s
        attachments_bucket:
          bucket_id: bucket-for-attachments
          service_account_id: ajejeis235ma********
        invoke_function:
          function_id: d4eofc7n0m**********
          function_tag: $latest
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
            service-account-id: aje3932acd**********
    status: ACTIVE
    ```
  

- API

  Чтобы создать триггер для почты, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

{{ sf-name }} автоматически сгенерирует адрес электронной почты, при отправке писем на который будет запускаться триггер. Чтобы посмотреть его, [получите подробную информацию о триггере](trigger-list.md#trigger-get).

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## См. также {#see-also}

* [Триггер для почты, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/mail-trigger-create.md).
