Создайте [триггер](../../functions/concepts/trigger/iot-core-trigger.md) для топика устройства или реестра сервиса {{ iot-name }} и обрабатывайте копии сообщений с помощью [функции](../../functions/concepts/function.md) {{ sf-name }}.

{% note warning %}

Триггер должен находиться в одном облаке с реестром или устройством, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Реестр](../../iot-core/concepts/index.md#registry) или [устройство](../../iot-core/concepts/index.md#device), из топиков которых триггер будет принимать копии сообщений. Если у вас их нет:

    * [Создайте реестр](../../iot-core/operations/registry/registry-create.md).
    * [Создайте устройство](../../iot-core/operations/device/device-create.md).

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
        * В поле **Тип** выберите **{{ iot-name }}**.
        * В поле **Запускаемый ресурс** выберите **Функция**.

    1. В блоке **Настройки сообщений {{ iot-name }}** укажите реестр, устройство и MQTT-топик, для которого хотите создать триггер. Если вы создаете триггер для топика реестра, устройство и MQTT-топик можно не указывать.

    1. В блоке **Настройки функции** выберите функцию и укажите:

        {% include [function-settings](function-settings.md) %}
        
    1. (опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request.md](repeat-request.md) %}

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create internet-of-things \
      --name <имя триггера> \
      --registry-id <идентификатор реестра> \
      --device-id <идентификатор устройства> \
      --mqtt-topic '$devices/<идентификатор устройства>/events' \
      --invoke-function-id <идентификатор функции> \
      --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор очереди Dead Letter Queue> \
      --dlq-service-account-id <идентификатор сервисного аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--registry-id` — [идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
    * `--device-id` — [идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
    * `--mqtt-topic` — топик, для которого вы хотите создать триггер.
    
    {% include [trigger-cli-param](trigger-cli-param.md) %}

    Результат:
    
    ```text
    id: a1sl0mkmimfj3uv52fr8
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-09-25T13:54:35.654935Z"
    name: iot-trigger
    rule:
      iot_message:
        registry_id: arenou2oj4ct42eq8g3n
        device_id: areqjd6un3afc3cefcvm
        mqtt_topic: $devices/areqjd6un3afc3cefcvm/events
        invoke_function:
          function_id: d4eofc7n0m03lmudse8l
          function_tag: $latest
          service_account_id: aje3932acd0c5ur7dagp
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
   ```

- API

  Создать триггер для {{ iot-name }} можно с помощью метода API [create](../../functions/triggers/api-ref/Trigger/create.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать триггер для {{ iot-name }}:

  1. Опишите в конфигурационном файле параметры триггера.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<имя триггера>"
       description = "<описание триггера>"
       iot {
         registry_id = "<идентификатор реестра>"
         device_id   = "<идентификатор устройства>"
         topic       = "<идентификатор топика>"
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
     * `iot` — параметры [топика](../../iot-core/concepts/topic/):
	    * `registry-id` — [идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
        * `device-id` — [идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
        * `topic` — идентификатор [топика](../../iot-core/concepts/topic/), для которого вы хотите создать триггер.
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

## См. также {#see-also}

* [Триггер для {{ iot-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}](../../serverless-containers/operations/iot-core-trigger-create.md).
