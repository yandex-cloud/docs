{% include [triggers-preview](triggers-preview-stage.md) %}

Создайте триггер для [топика](../../iot-core/concepts/topic.md) устройства или реестра сервиса {{ iot-name }} и обрабатывайте копии сообщений с помощью [функции](../../functions/concepts/function.md) {{ sf-name }}.

{% note important %}

Триггер должен находиться в одном облаке с реестром или устройством, из топика которого он читает сообщения.

{% endnote %}

## Перед началом {#before-begin}

Для создания триггера вам понадобятся: 
1. Сервисный аккаунт с правами на вызов функции. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).
1. [Реестр](../../iot-core/concepts/index.md#registry) или [устройство](../../iot-core/concepts/index.md#device), из топиков которых триггер будет забирать копии сообщений. Если у вас их еще нет:
    - [Создайте реестр](../../iot-core/operations/registry/registry-create.md).
    - [Создайте устройство](../../iot-core/operations/device/device-create.md).
1. [Функция](../../functions/concepts/function.md), которой триггер будет передавать сообщения на обработку. Если у вас еще нет функции: 
    - [Создайте функцию](../../functions/operations/function/function-create.md).
    - [Создайте версию функции и загрузите в нее код функции](../../functions/operations/function/version-manage.md#func-version-create).

## Создайте триггер {#trigger-create}

Создайте триггер для топика устройства.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Создайте триггер: 

    - `--name` — имя триггера.
    - `--registry-id` — [уникальный идентификатор реестра](../../iot-core/operations/registry/registry-list.md).
    - `--device-id` — [уникальный идентификатор устройства](../../iot-core/operations/device/device-list.md). Если вы создаете триггер для топика реестра, этот параметр можно пропустить.
    - `--mqtt-topic` — топик, для которого вы хотите создать триггер. 
    - `--invoke-function-id` — уникальный идентификатор функции. 
    - `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции. 
           
    ```
    $ yc serverless trigger create internet-of-things 
        --name iot-trigger \
        --registry-id arenou2oj4ct42eq8g3n \
        --device-id areqjd6un3afc3cefcvm \
        --mqtt-topic '$devices/areqjd6un3afc3cefcvm/events' \
        --invoke-function-id d4eofc7n0m03lmudse8l \
        --invoke-function-service-account-id aje3932acd0c5ur7dagp
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
    ```
    
{% endlist %}


## Проверьте результат {#check-result}

Проверьте, что функция была запущена, посмотрев логи функции:  
1. Посмотрите логи функции, в них должна отображаться информация о вызове функции. В данном примере функция выводит информацию об обработанных сообщениях. 

    ```
    $ yc serverless function logs b09e5lu91ta21vdrrgma
    
    2019-09-25 14:00:00     MESSAGE_BATCH
    2019-09-25 14:00:00     {
    2019-09-25 14:00:00       "event_metadata": {
    2019-09-25 14:00:00         "event_id": "9e016299-866f-4900-8830-d674cbff3577",
    2019-09-25 14:00:00         "event_type": "yandex.cloud.events.iot.IoTMessage",
    2019-09-25 14:00:00         "created_at": "2019-09-25T13:59:59.208724628Z"
    2019-09-25 14:00:00       },
    2019-09-25 14:00:00       "details": {
    2019-09-25 14:00:00         "registry_id": "arenou2oj4ct42eq8g3n",
    2019-09-25 14:00:00         "device_id": "areqjd6un3afc3cefcvm",
    2019-09-25 14:00:00         "mqtt_topic": "$devices/areqjd6un3afc3cefcvm/events",
    2019-09-25 14:00:00         "payload": "VGVzdCA0"
    2019-09-25 14:00:00       }
    2019-09-25 14:00:00     }
    2019-09-25 14:00:00     END RequestID: 1ba57cbe-c2ce-4d1a-91a3-9592e945b45a
    2019-09-25 14:00:00     REPORT RequestID: 1ba57cbe-c2ce-4d1a-91a3-9592e945b45a Duration: 368.362 ms Billed Duration: 400 ms Memory Size: 128 MB Max Memory Used: 13 MB
    ```
