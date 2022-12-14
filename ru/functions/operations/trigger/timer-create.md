# Создать таймер, который вызывает функцию {{ sf-name }}

Создайте [таймер](../../concepts/trigger/timer.md) — триггер, который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} по расписанию.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ sf-name }}**.

    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Таймер**.
        * В поле **Запускаемый ресурс** выберите **Функция**.

    1. В блоке **Настройки таймера** укажите расписание вызова функции в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).

    1. В блоке **Настройки функции** выберите функцию и укажите:

    	{% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. (опционально) В блоке **Настройки повторных запросов**:

    	{% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create timer \
      --name <имя таймера> \
      --cron-expression '<cron-выражение>' \
      --invoke-function-id <идентификатор функции> \
      --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
      --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    Где:

    * `--name` — имя таймера.
    * `--cron-expression` — расписание вызова функции в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).
    
    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: timer
    rule:
      timer:
        cron_expression: 5 12 * * ? *
        invoke_function_with_retry:
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

    Создать таймер можно с помощью метода API [create](../../triggers/api-ref/Trigger/create.md).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать триггер, который запускает функцию:

  1. Опишите в конфигурационном файле параметры триггера:

     * `name` — имя таймера. Формат имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `description` — описание триггера.
     * `timer` — настройки триггера:
       * `cron_expression` — расписание вызова функции в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).
     * `function` — настройки функции, которую будет запускать триггер:
       * `id` — идентификатор функции.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<имя таймера>"
       description = "<описание триггера>"
       timer {
         cron_expression = "* * * * ? *"
       }
       function {
         id = "<идентификатор функции>"
       }
     }
     ```

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/function_trigger).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../../cli/quickstart.md):

        ```
        yc serverless trigger get <идентификатор триггера>
        ```

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## См. также {#see-also}

* [Таймер, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/timer-create.md).
