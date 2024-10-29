---
title: Создать триггер, который передает сообщения в контейнер {{ serverless-containers-name }} из топика реестра или устройства {{ iot-full-name }}
description: Создайте триггер для топика устройства или реестра {{ iot-name }} для обработки копии сообщений в контейнере {{ serverless-containers-name }}.
---

# Создать триггер, который передает сообщения в контейнер {{ serverless-containers-name }} из топика реестра или устройства {{ iot-full-name }}

Создайте [триггер](../concepts/trigger/iot-core-trigger.md) для топика устройства или реестра {{ iot-name }} и обрабатывайте копии сообщений с помощью [контейнера](../concepts/container.md) {{ serverless-containers-name }}.

{% note warning %}

Триггер должен находиться в одном облаке с реестром или устройством, из топика которого он читает сообщения.

{% endnote %}

## Перед началом работы {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Реестр](../../iot-core/concepts/index.md#registry) или [устройство](../../iot-core/concepts/index.md#device), из топиков которых триггер будет принимать копии сообщений. Если у вас их нет:

    * [Создайте реестр](../../iot-core/operations/registry/registry-create.md).
    * [Создайте устройство](../../iot-core/operations/device/device-create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}** укажите реестр, устройство и MQTT-топик, для которого хотите создать триггер. Если вы создаете триггер для топика реестра, устройство и MQTT-топик можно не указывать. Если MQTT-топик не указан, триггер срабатывает для всех топиков реестра или устройства.
 
    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        {% include [batch-settings](../../_includes/functions/batch-settings.md) %}

        {% include [batch-messages](../../_includes/serverless-containers/batch-messages.md) %} 

    1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create internet-of-things \
      --name <имя_триггера> \
      --registry-id <идентификатор_реестра> \
      --device-id <идентификатор_устройства> \
      --mqtt-topic '<MQTT-топик_брокера>' \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts <количество_повторных_вызовов> \
      --retry-interval <интервал_между_повторными_вызовами> \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--registry-id` — [идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
    * `--device-id` — [идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
    * `--mqtt-topic` — MQTT-топик, для которого вы хотите создать триггер. Необязательный параметр. Если параметр не указан, триггер срабатывает для всех топиков реестра или устройства.

    {% include [trigger-param](../../_includes/iot-core/trigger-param-sc.md) %}

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: iot-trigger
    rule:
      iot_message:
        registry_id: arenou2oj4h2********
        device_id: areqjd6un3h2********
        mqtt_topic: $devices/areqjd6unh2********/events
        batch_settings:
          size: "1"
          cutoff: 0s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje3932acdh2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ iot-name }}:

  1. Опишите в конфигурационном файле параметры триггера:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name = "<имя_триггера>"
        container {
          id                 = "<идентификатор_контейнера>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          retry_attempts     = "<количество_повторных_вызовов>"
          retry_interval     = "<интервал_между_повторными_вызовами>"
        }
        iot {
          registry_id  = "<идентификатор_реестра>"
          device_id    = "<идентификатор_устройства>"
          topic        = "<MQTT-топик_брокера>"
          batch_cutoff = "<максимальное_время_ожидания>"
          batch_size   = "<размер_группы_сообщений>"
        }
        dlq {
         queue_id           = "<идентификатор_очереди_Dead_Letter_Queue>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
      }
      ```

      Где:

      * `name` — имя триггера. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

      * `container` — параметры контейнера:

        {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

        {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      * `iot` — параметры триггера:

        * `registry-id` — [идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
        * `device-id` — [идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно не указывать.
        * `topic` — MQTT-топик, для которого вы хотите создать триггер. Необязательный параметр. Если параметр не указан, триггер срабатывает для всех топиков реестра или устройства.
        * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует сообщения не дольше `batch_cutoff` и отправляет их в контейнер. Число сообщений при этом не превышает `batch_size`.
        * `batch_size` — размер группы сообщений из MQTT-топиков. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  Чтобы создать триггер для {{ iot-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [{#T}](../../functions/operations/trigger/iot-core-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/iot-core-trigger-create.md)
