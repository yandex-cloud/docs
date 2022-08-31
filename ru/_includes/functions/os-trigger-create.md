Создайте [триггер для {{ objstorage-name }}](../../functions/concepts/trigger/os-trigger.md), который будет вызывать [функцию](../../functions/concepts/function.md) {{ sf-name }} или [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }} при создании, перемещении или удалении [объекта](../../storage/concepts/object.md) в бакете.

Для создания триггера вам понадобятся:

* Функция или контейнер, которые триггер будет запускать.

    * Если у вас нет функции:

        * [Создайте функцию](../../functions/operations/function/function-create.md).
        * [Создайте версию функции](../../functions/operations/function/version-manage.md#func-version-create).

    * Если у вас нет контейнера:

        * [Создайте контейнер](../../serverless-containers/operations/create.md).
        * [Создайте ревизию контейнера](../../serverless-containers/operations/manage-revision.md#create).

* [Бакет](../../storage/concepts/bucket.md), при событиях с объектами в котором триггер будет запускаться. Если у вас нет бакета, [создайте его](../../storage/operations/buckets/create.md).

* (опционально) Очередь [Dead Letter Queue](../../functions/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогли обработать функция или контейнер. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с правами на вызов функции или контейнера и (опционально) запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md). Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ sf-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Object Storage**.
        * Выберите, что будет запускать триггер — функцию или контейнер.

    1. В блоке **Настройки Object Storage**:

        * В поле **Бакет** выберите бакет, для событий с объектами которого хотите создать триггер.
        * В поле **Типы событий** выберите [события](../../functions/concepts/trigger/os-trigger.md#event), после наступления которых триггер будет запускаться.
        * (опционально) В поле **Префикс ключа объекта** введите [префикс](../../functions/concepts/trigger/os-trigger.md#filter) для фильтрации.
        * (опционально) В поле **Суффикс ключа объекта** введите [суффикс](../../functions/concepts/trigger/os-trigger.md#filter) для фильтрации.

    1. Если триггер будет запускать:

        * функцию, в блоке **Настройки функции** выберите ее и укажите:

            * [тег версии функции](../../functions/concepts/function.md#tag);
            * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться функция.

        * контейнер, в блоке **Настройки контейнера** выберите его и укажите:

            * [ревизию контейнера](../../serverless-containers/concepts/container.md#revision);
            * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться контейнер.

    1. (опционально) В блоке **Настройки повторных запросов**:

        * В поле **Интервал** укажите время, через которое будет сделан повторный вызов функции или контейнера, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
        * В поле **Количество попыток** укажите количество повторных вызовов функции или контейнера, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Допустимые значения — от 1 до 5, значение по умолчанию — 1.

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь [Dead Letter Queue](../../functions/concepts/dlq.md) и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, который запускает функцию, выполните команду:

    ```
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

    * `--name` — имя таймера.
    * `--bucket-id` — идентификатор бакета.
    * `--prefix` — [префикс](../../functions/concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Необязательный параметр. Используется для фильтрации.
    * `--suffix` — [суффикс](../../functions/concepts/trigger/os-trigger.md#filter) ключа объекта в бакете. Необязательный параметр. Используется для фильтрации.
    * `--events` — [события](../../functions/concepts/trigger/os-trigger.md#event), после наступления которых триггер запускается.
    * `--invoke-function-id` — идентификатор функции.
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    * `--retry-attempts` — время, через которое будет сделан повторный вызов функции, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--retry-interval` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../../functions/concepts/dlq.md). Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--dlq-queue-id` — идентификатор очереди [Dead Letter Queue](../../functions/concepts/dlq.md). Необязательный параметр.
    * `--dlq-service-account-id` — сервисный аккаунт с правами на запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md). Необязательный параметр.

    Результат:

    ```
    id: a1s92agr8mpgeo3kjt48
    folder_id: b1g88tflru0ek1omtsu0
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
          function_id: d4eofc7n0m03lmudsk7y
          function_tag: $latest
          service_account_id: aje3932acd0c5ur7drte
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknnpj1ll45e:dlq
            service-account-id: aje3932acd0c5ur7dagp
    status: ACTIVE
    ```

- API

    Создать триггер для {{ objstorage-name }} можно с помощью метода API [create](../../functions/triggers/api-ref/Trigger/create.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

        {% include [name-format](../../_includes/name-format.md) %}

     * `description` — описание триггера.
     * `object_storage` — параметры хранилища:
        * `bucket_id` — идентификатор бакета.
        * Выберите один или несколько типов [событий](../../functions/concepts/trigger/os-trigger.md#event), которые будет обрабатывать триггер:
            * `create` — триггер вызовет функцию при создании нового объекта в хранилище. Принимает значения `true` или `false`.
            * `update` — триггер вызовет функцию при обновлении объекта в хранилище. Принимает значения `true` или `false`.
            * `delete` — триггер вызовет функцию при удалении объекта из хранилища. Принимает значения `true` или `false`.
        * `prefix` — [префикс](../../functions/concepts/trigger/os-trigger.md#filter) для фильтрации.
        * `suffix` — [суффикс](../../functions/concepts/trigger/os-trigger.md#filter) для фильтрации.
     * `function` — настройки функции, которую будет запускать триггер:
        * `id` — идентификатор функции.
        * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.

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

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

        ```
        yc serverless trigger get <идентификатор триггера>
        ```

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](check-result.md) %}
