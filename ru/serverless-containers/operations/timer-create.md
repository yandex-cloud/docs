# Создать таймер, который вызывает контейнер {{ serverless-containers-name }}

Создайте [таймер](../concepts/trigger/timer.md) — триггер, который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} по расписанию.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** укажите расписание вызова функции в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).
        * (опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-payload }}** укажите сообщение, которое будет передаваться в функцию при срабатывании таймера в поле `payload`. Тип данных — строка, длина которой не более 4096 символов.

    1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    
    ```bash
    yc serverless trigger create timer \
      --name <имя_таймера> \
      --cron-expression '<cron_выражение>' \
      --payload <сообщение> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```
  

    Где:

    * `--name` — имя таймера.
    * `--cron-expression` — расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).
    * `--payload` — сообщение, которое будет передаваться в функцию при срабатывании таймера. Длина строки должна быть не более 4096 символов.

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    
    ```text
    id: a1s5msktij**********
    folder_id: b1gmit33hg**********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        payload: <сообщение>
        invoke_container_with_retry:
          container_id: bba5jb38o8**********
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
            service-account-id: aje3932acd**********
    status: ACTIVE
    ```
  

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name = "<имя_таймера>"
        timer {
          cron_expression = "<cron-выражение>"
        }
        container {
          id                 = "<идентификатор_контейнера>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          retry_attempts     = <количество_повторных_вызовов>
          retry_interval     = <интервал_между_повторными_вызовами>
        }
        dlq {
          queue_id           = "<идентификатор_очереди_DLQ>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      * `name` — имя таймера.
      * `timer.0.cron_expression` — расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).
      * `container.0.id` — идентификатор контейнера.
      * `container.0.service_account_id` — идентификатор сервисного аккаунта с правами на вызов контейнера.
      * `container.0.retry_attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
      * `container.0.retry_interval` — время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
      * `dlq.0.queue_id` — идентификатор очереди Dead Letter Queue. Необязательный параметр.
      * `dlq.0.service_account_id` — сервисный аккаунт с правами на запись в очередь Dead Letter Queue. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc serverless trigger list
      ```

- API

  Чтобы создать таймер, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [Таймер, который вызывает функцию {{ sf-name }}](../../functions/operations/trigger/timer-create.md).
