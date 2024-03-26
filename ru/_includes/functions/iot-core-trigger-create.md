Создайте [триггер](../../functions/concepts/trigger/iot-core-trigger.md) для [топика](../../iot-core/concepts/topic/index.md) [устройства](../../iot-core/concepts/index.md#device) или [реестра](../../iot-core/concepts/index.md#registry) [{{ iot-name }}](../../iot-core/) и обрабатывайте копии сообщений с помощью [функции](../../functions/concepts/function.md) [{{ sf-full-name }}](../../functions/).

{% note warning %}

Триггер должен находиться в одном [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) с реестром или устройством, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* Реестр или устройство, из топиков которых триггер будет принимать копии сообщений. Если у вас их нет:
  * [Создайте реестр](../../iot-core/operations/registry/registry-create.md).
  * [Создайте устройство](../../iot-core/operations/device/device-create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать триггер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Введите имя и описание триггера.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}** укажите реестр, устройство и MQTT-топик, для которого хотите создать триггер. Если вы создаете триггер для топика реестра, устройство и MQTT-топик можно не указывать. Если MQTT-топик не указан, триггер срабатывает для всех топиков реестра или устройства.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

     {% include [function-settings](function-settings.md) %}

  1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

     {% include [repeat-request.md](repeat-request.md) %}

  1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с правами на запись в нее.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы создать триггер, который вызывает функцию, выполните команду:

  ```bash
  yc serverless trigger create internet-of-things \
    --name <имя_триггера> \
    --registry-id <идентификатор_реестра> \
    --device-id <идентификатор_устройства> \
    --mqtt-topic '$devices/<идентификатор_устройства>/events' \
    --batch-size <размер_группы_сообщений> \
    --batch-cutoff <максимальное_время_ожидания> \
    --invoke-function-id <идентификатор_функции> \
    --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
    --retry-attempts 1 \
    --retry-interval 10s \
    --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
    --dlq-service-account-id <идентификатор_сервисного_аккаунта>
  ```

  Где:
  * `--name` — имя триггера.
  * `--registry-id` — [идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
  * `--device-id` — [идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
  * `--mqtt-topic` — MQTT-топик, для которого вы хотите создать триггер. Необязательный параметр. Если параметр не указан, триггер срабатывает для всех топиков реестра или устройства.

  {% include [trigger-param](../iot-core/trigger-param-cf.md) %}

  {% include [trigger-cli-param](trigger-cli-param.md) %}

  Результат:

  ```text
  id: a1sl0mkmimfj********
  folder_id: b1g88tflru0e********
  created_at: "2019-09-25T13:54:35.654935Z"
  name: iot-trigger
  rule:
    iot_message:
      registry_id: arenou2oj4ct********
      device_id: areqjd6un3af********
      mqtt_topic: $devices/areqjd6un3af********/events
      batch_settings:
        size: "1"
        cutoff: 0s
      invoke_function:
        function_id: d4eofc7n0m03********
        function_tag: $latest
        service_account_id: aje3932acd0c********
        retry_settings:
          retry_attempts: "1"
          interval: 10s
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ iot-name }}:
  1. Опишите в конфигурационном файле параметры триггера.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<имя_триггера>"
       description = "<описание_триггера>"
       iot {
         registry_id  = "<идентификатор_реестра>"
         device_id    = "<идентификатор_устройства>"
         topic        = "<идентификатор_топика>"
         batch_cutoff = 10
         batch_size   = 1
       }
       function {
         id                 = "<идентификатор_функции>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
     }
     ```

     Где:
     * `name` — имя триггера. Формат имени:

       {% include [name-format](../../_includes/name-format.md) %}

     * `description` — описание триггера.
     * `iot` — параметры топика:
       * `registry-id` — [идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
       * `device-id` — [идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
       * `topic` — идентификатор топика, для которого вы хотите создать триггер. Если топик не указан, триггер срабатывает для всех топиков реестра или устройства.
     * `function` — настройки функции, которую будет запускать триггер:
       * `id` — идентификатор функции.
       * `service_account_id` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с правами на вызов функции.
     * `batch_cutoff` — максимальное время ожидания. Допустимые значения от 1 до 60 секунд. Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в контейнер. Число сообщений при этом не превышает указанный размер группы `batch-size`.
     * `batch_size` — размер группы сообщений. Допустимые значения от 1 до 10.

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

        ```bash
        yc serverless trigger get <идентификатор_триггера>
        ```

- API {#api}

  Чтобы создать триггер для {{ iot-name }}, воспользуйтесь методом REST API [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ iot-name }}, который передает сообщения из топиков реестров и устройств в контейнер {{ serverless-containers-full-name }}](../../serverless-containers/operations/iot-core-trigger-create.md).
