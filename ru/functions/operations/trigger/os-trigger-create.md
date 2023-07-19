# Создать триггер для {{ objstorage-name }}, который вызывает функцию {{ sf-name }}

Создайте [триггер для {{ objstorage-name }}](../../concepts/trigger/os-trigger.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} при создании, перемещении или удалении [объекта](../../../storage/concepts/object.md) в бакете.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* [Бакет](../../../storage/concepts/bucket.md), при событиях с объектами в котором триггер будет запускаться. Если у вас нет бакета, [создайте его](../../../storage/operations/buckets/create.md) с ограниченным доступом.

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
        * В поле **Тип** выберите **{{ objstorage-name }}**.
        * В поле **Запускаемый ресурс** выберите **Функция**.

    1. В блоке **Настройки {{ objstorage-name }}**:

        * В поле **Бакет** выберите бакет, для событий с объектами которого хотите создать триггер.
        * В поле **Типы событий** выберите [события](../../concepts/trigger/os-trigger.md#event), после наступления которых триггер будет запускаться.
        * (опционально) В поле **Префикс ключа объекта** введите [префикс](../../concepts/trigger/os-trigger.md#filter) для фильтрации.
        * (опционально) В поле **Суффикс ключа объекта** введите [суффикс](../../concepts/trigger/os-trigger.md#filter) для фильтрации.

    1. В блоке **Настройки функции** выберите функцию и укажите:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. (Опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. (Опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create object-storage \
      --name <имя триггера> \
      --bucket-id <идентификатор бакета> \
      --prefix '<префикс ключа объекта>' \
      --suffix '<суффикс ключа объекта>' \
      --events 'create-object','delete-object','update-object' \
      --invoke-function-id <идентификатор функции> \
      --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
      --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--bucket-id` — идентификатор бакета.
    * `--prefix` — [префикс](../../concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Необязательный параметр. Используется для фильтрации.
    * `--suffix` — [суффикс](../../concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Необязательный параметр. Используется для фильтрации.
    * `--events` — [события](../../concepts/trigger/os-trigger.md#event), после наступления которых триггер запускается.
    
    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s92agr8mpg********
    folder_id: b1g88tflru0e********
    created_at: "2019-12-18T09:47:50.079103Z"
    name: os-trigger
    rule:
      object_storage:
        event_type:
        - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
        - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
        bucket_id: s3-for-trigger
        prefix: dev
        suffix: 12.jpg
        invoke_function:
          function_id: d4eofc7n0m03********
          function_tag: $latest
          service_account_id: aje3932acd0c********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknn********:dlq
            service-account-id: aje3932acd0c********
    status: ACTIVE
    ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать триггер для {{ objstorage-name }}:

  1. Опишите в конфигурационном файле параметры триггера.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<имя триггера>"
       description = "<описание триггера>"
       object_storage {
          bucket_id = "<идентификатор бакета>"
          create    = true
          update    = true
       }
       function {
         id                 = "<идентификатор функции>"
         service_account_id = "<идентификатор сервисного аккаунта>"
       }
     }
     ```

     Где:

     * `name` — имя триггера. Формат имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `description` — описание триггера.
     * `object_storage` — параметры хранилища:
        * `bucket_id` — идентификатор бакета.
        * Выберите один или несколько типов [событий](../../concepts/trigger/os-trigger.md#event), которые будет обрабатывать триггер:
            * `create` — триггер вызовет функцию при создании нового объекта в хранилище. Принимает значения `true` или `false`.
            * `update` — триггер вызовет функцию при обновлении объекта в хранилище. Принимает значения `true` или `false`.
            * `delete` — триггер вызовет функцию при удалении объекта из хранилища. Принимает значения `true` или `false`.
        * `prefix` — [префикс](../../concepts/trigger/os-trigger.md#filter) для фильтрации.
        * `suffix` — [суффикс](../../concepts/trigger/os-trigger.md#filter) для фильтрации.
     * `function` — настройки функции, которую будет запускать триггер:
        * `id` — идентификатор функции.
        * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

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

- API

  Чтобы создать триггер для {{ objstorage-name }}, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ objstorage-name }}, который вызывает контейнер {{ serverless-containers-name }}](../../../serverless-containers/operations/os-trigger-create.md).
