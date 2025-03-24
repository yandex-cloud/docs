# Мониторинг показаний датчиков и уведомления о событиях


В этом руководстве вы настроите мониторинг и уведомления об изменениях показаний датчиков, подключенных к сервису [{{ iot-name }}](../../iot-core/). Датчики будут эмулированы с помощью сервиса [{{ sf-full-name }}](../../functions/). Если у вас есть подключенные датчики, используйте их.

Для работы с руководством вам не нужно создавать и настраивать [виртуальные машины](../../compute/concepts/vm.md) — вся работа основана на бессерверных вычислениях {{ sf-name }}. Исходный код руководства доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-server-room-iot-monitoring).

Чтобы настроить мониторинг показаний датчиков в серверной комнате:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте необходимые ресурсы {{ iot-name }}](#resources-step).
1. [Создайте эмулятор устройства в {{ sf-name }}](#emulator-step).
1. [Настройте мониторинг показаний датчиков](#configure-monitoring).

Если ресурсы больше не нужны, [удалите их](#cleanup).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:
* плата за количество сообщений {{ iot-name }} (см. [тарифы {{ iot-full-name }}](../../iot-core/pricing.md));
* плата за количество вызовов [функции](../../functions/concepts/function.md) {{ sf-name }} (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за запись пользовательских [метрик](../../monitoring/concepts/data-model.md#metric) через API сервиса [{{ monitoring-name }}](../../monitoring/index.yaml) (см. [тарифы {{ monitoring-full-name }}](../../monitoring/pricing.md)).

### Создайте сервисные аккаунты {#create-sa}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `my-emulator-function-service-account` для отправки данных. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `{{ roles-functions-invoker }}` и `iot.devices.writer`.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `my-metrics-function-service-account` для обработки данных. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `{{ roles-functions-invoker }}` и `{{ roles-editor }}`.

## Создайте необходимые ресурсы {{ iot-name }} {#resources-step}

[Реестр](../../iot-core/concepts/index.md#registry) и [устройство](../../iot-core/concepts/index.md#device) — основные компоненты сервиса {{ iot-name }} для обмена данными и командами. Чтобы устройства могли обмениваться данными, их необходимо создавать в одном реестре.

### Создайте реестр и настройте авторизацию по логину и паролю {#registry-step}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_create-registry }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя реестра. Например, `my-registry`.
  1. В поле **{{ ui-key.yacloud.common.password }}** задайте пароль доступа к реестру. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте устройство и настройте авторизацию по логину и паролю {#device-step}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Выберите реестр, созданный на предыдущем шаге.
  1. В меню слева выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-device }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя устройства. Например, `my-device`.
  1. В поле **{{ ui-key.yacloud.common.password }}** задайте пароль доступа к устройству. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. (Опционально) Добавьте алиас:
      1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Заполните поля: введите алиас (например `events`) и тип [топика](../../iot-core/concepts/topic/index.md) после `$devices/{id}` (например, `events`).

          Вы сможете использовать алиас `events` вместо топика `$devices/{id}/events`.
      1. Повторите действия для каждого добавляемого алиаса.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Повторите действия для каждого устройства, которое вы хотите создать.

{% endlist %}

## Создайте эмулятор устройства в {{ sf-name }} {#emulator-step}

Эмулятор отправляет данные с датчиков устройства и обрабатывает данные для мониторинга и [алертов](../../monitoring/concepts/alerting/alert.md).

### Создайте функцию эмуляции отправки данных с устройства {#emulation-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Создайте функцию:
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** введите имя функции. Например, `my-device-emulator-function`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте версию функции:
      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `Node.js 18`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**:
          * Имя файла — `device-emulator.js`.
          * Содержимое файла — код функции с [GitHub](https://github.com/yandex-cloud-examples/yc-server-room-iot-monitoring/blob/master/device-emulator.js).
      1. Аналогичным образом создайте файл `package.json` со следующим содержимым:

          ```json
          {
            "name": "my-app",
            "version": "1.0.0",
            "dependencies": {
              "yandex-cloud": "*"
            }
          }
          ```

      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `device-emulator.handler`.
      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `my-emulator-function-service-account`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
              Ключ | Описание | Значение
              :--- | :--- | :---
              `HUMIDITY_SENSOR_VALUE`    | Базовое значение показания датчика влажности.         | `80.15`
              `TEMPERATURE_SENSOR_VALUE` | Базовое значение показания датчика температуры.       | `25.25`
              `RACK_DOOR_SENSOR_VALUE`   | Показания датчика открытия дверцы стойки.             | `False`
              `ROOM_DOOR_SENSOR_VALUE`   | Показания датчика открытия двери в серверную комнату. | `False`
              `SMOKE_SENSOR_VALUE`       | Показания детектора дыма.                             | `False`
              `WATER_SENSOR_VALUE`       | Показания детектора воды.                             | `False`
              `IOT_CORE_DEVICE_ID`       | Идентификатор устройства, которое вы создали.         | См. в [консоли управления]({{ link-console-main }})<br>сервиса {{ iot-name }}.
              `DEVICE_ID`                | Пользовательское название устройства.                 | Задается пользователем.

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Протестируйте функцию эмуляции {#test-emulation-function}

(Опционально) Для получения подробной информации с датчиков, [подпишите](../../iot-core/operations/subscribe.md#one-device) реестр на [топик](../../iot-core/concepts/topic/index.md) устройства {{ iot-name }}.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Выполните команду:

  ```bash
  yc iot mqtt subscribe \
    --username <идентификатор_реестра> \
    --password <пароль_реестра> \
    --topic '$devices/<идентификатор_устройства>/events' \
    --qos 1
  ```

  Где:
  * `--username` и `--password` — параметры авторизации с помощью логина и пароля.
  * `--topic` — топик устройства для отправки данных или алиас топика.
  * `--qos` — [уровень качества обслуживания](../../glossary/qos.md) (QoS).

  Команда должна продолжать выполняться до завершения тестирования.

{% endlist %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `my-device-emulator-function`.
  1. В меню слева выберите **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В списке **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** выберите `$latest` — последнюю созданную функцию.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

      При успешном выполнении функции в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** отобразится статус **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}**, и в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** появится результат:

      ```json
      {
        "statusCode" : 200
      }
      ```

      Если вы подписались на топик устройства {{ iot-name }}, вы получите в терминале JSON вида:

      ```json
      {
        "DeviceId":"my-device-id",
        "TimeStamp":"2024-06-14T15:29:59Z",
        "Values":[
            {"Type":"Float","Name":"Humidity","Value":"80.84"},
            {"Type":"Float","Name":"Temperature","Value":"25.46"},
            {"Type":"Bool","Name":"Water sensor","Value":"False"},
            {"Type":"Bool","Name":"Smoke sensor","Value":"False"},
            {"Type":"Bool","Name":"Room door sensor","Value":"False"},
            {"Type":"Bool","Name":"Rack door sensor","Value":"False"}
            ]
        }
      ```

{% endlist %}

### Создайте триггер для вызова функции с периодичностью один раз в минуту {#minute-trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** введите имя триггера. Например, `my-emulator-function-trigger`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** введите `* * * * ? *` (вызов один раз в минуту).
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** введите ранее заданные параметры функции:
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** — `my-device-emulator-function`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** — `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** — `my-emulator-function-service-account`.
  1. (Опционально) Настройте параметры блоков **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** и **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**. Они обеспечивают сохранность данных.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** позволяют перенаправлять сообщения, которые не смогли обработать получатели в обычных [очередях](../../message-queue/concepts/queue.md).

          В качестве DLQ очереди вы можете настроить стандартную очередь сообщений. Если вы еще не создавали очередь сообщений, [создайте ее в сервисе {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

### Создайте функцию обработки принимаемых данных {#processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите раздел **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
  1. Создайте функцию:
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** введите имя функции. Например, `my-monitoring-func`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте версию функции:
      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `Python 3.12`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**:
          * Имя файла — `monitoring.py`.
          * Содержимое файла — код функции с [GitHub](https://github.com/yandex-cloud-examples/yc-server-room-iot-monitoring/blob/master/monitoring.py).

              В этой функции подготовка данных для отправки в сервис мониторинга находится в методе `makeAllMetrics`. Если вы захотите добавить или удалить параметры, выполните изменения в этом методе.

      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `monitoring.msgHandler`.
      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `my-metrics-function-service-account`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              Ключ | Описание | Значение
              :--- | :--- | :---
              `VERBOSE_LOG`       | Включение и отключение записи данных. | `True`
              `METRICS_FOLDER_ID` | Идентификатор каталога, в котором развернуты сервисы и для которого вы создадите дашборд в сервисе {{ monitoring-name }}. | См. в [консоли управления]({{ link-console-main }}).

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Протестируйте функцию обработки данных {#test-processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `my-monitoring-func`.
  1. В меню слева выберите **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В списке **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** выберите `$latest` — последнюю созданную функцию.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** вставьте данные:

      ```json
      {
        "messages": [
        {
          "event_metadata": {
            "event_id": "160d239876d9714800",
            "event_type": "yandex.cloud.events.iot.IoTMessage",
            "created_at": "2020-05-08T19:16:21.267616072Z",
            "folder_id": "b112345678910"
          },
          "details": {
            "registry_id": "are1234567890",
            "device_id": "are0987654321",
            "mqtt_topic": "$devices/are0987654321/events",
            "payload": "eyJWYWx1ZXMiOiBbeyJUeXBlIjogIkZsb2F0IiwgIlZhbHVlIjogIjI1Ljc0IiwgIk5hbWUiOiAiSHVtaWRpdHkifSwgeyJUeXBlIjogIkZsb2F0IiwgIlZhbHVlIjogIjgwLjY1IiwgIk5hbWUiOiAiVGVtcGVyYXR1cmUifSwgeyJUeXBlIjogIkJvb2wiLCAiVmFsdWUiOiAiRmFsc2UiLCAiTmFtZSI6ICJXYXRlciBzZW5zb3IifSwgeyJUeXBlIjogIkJvb2wiLCAiVmFsdWUiOiAiRmFsc2UiLCAiTmFtZSI6ICJTbW9rZSBzZW5zb3IifSwgeyJUeXBlIjogIkJvb2wiLCAiVmFsdWUiOiAiRmFsc2UiLCAiTmFtZSI6ICJSb29tIGRvb3Igc2Vuc29yIn0sIHsiVHlwZSI6ICJCb29sIiwgIlZhbHVlIjogIkZhbHNlIiwgIk5hbWUiOiAiUmFjayBkb29yIHNlbnNvciJ9XSwgIlRpbWVTdGFtcCI6ICIyMDIwLTA1LTIxVDIzOjEwOjE2WiIsICJEZXZpY2VJZCI6ICIwZTNjZTFkMC0xNTA0LTQzMjUtOTcyZi01NWM5NjEzMTk4MTQifQ=="
          }
        }]
      }
      ```

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

      При успешном выполнении функции в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** отобразится статус **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}**, а в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** появится результат:

      ```json
      {
        "statusCode" : 200 ,
        "headers" : {
          "Content-Type" : "text/plain"
        },
      "isBase64Encoded" : false
      }
      ```

{% endlist %}

### Создайте триггер для вызова функции обработки данных по сигналу {#signal-trigger}

Триггер вызовет функцию, когда в [топике устройства](../../iot-core/concepts/topic/devices-topic.md) появится сообщение.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** введите имя триггера. Например, `my-monitoring-func-trigger`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}** введите ранее заданные параметры реестра и устройства:
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_registry }}** — `my-registry`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_device }}** — `my-device`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** — `$devices/<идентификатор_устройства>/events`, где `<идентификатор_устройства>` — это идентификатор устройства в сервисе **{{ iot-name }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** введите ранее заданные параметры функции:
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** — `my-monitoring-func`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** — `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** — `my-metrics-function-service-account`.
  1. (Опционально) Настройте параметры блоков **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** и **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**. Они обеспечивают сохранность данных.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** позволяют перенаправлять сообщения, которые не смогли обработать получатели в обычных [очередях](../../message-queue/concepts/queue.md).

          В качестве DLQ очереди вы можете настроить стандартную очередь сообщений. Если вы еще не создавали очередь сообщений, [создайте ее в сервисе {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

  Все данные от устройства автоматически попадут в сервис **{{ monitoring-name }}**.

{% endlist %}

## Настройте мониторинг показаний датчиков {#configure-monitoring}

Для наблюдения за показаниями датчиков используется дашборд в сервисе [{{ monitoring-full-name }}](../../monitoring/). Показания датчиков поступают с контроллера на сервер раз в минуту по [MQTT-протоколу](../../glossary/mqtt-server.md#mqtt-protocol). Когда показания датчиков достигают заданных значений, {{ monitoring-name }} отправляет уведомления пользователям.

{% cut "Формат передачи данных" %}

```json
{
  "DeviceId":"e7a68b2d-464e-4222-88bd-c9e8********",
  "TimeStamp":"2020-05-21T10:16:43Z",
  "Values":[{
    "Type":"Float",
    "Name":"Humidity",
    "Value":"12.456"
  },
  {
    "Type":"Float",
    "Name":"Temperature",
    "Value":"-23.456"
  },
  {
    "Type":"Bool",
    "Name":"Water sensor",
    "Value":"false"
  },
  {
    "Type":"Bool",
    "Name":"Smoke sensor",
    "Value":"false"
  },
  {
    "Type":"Bool",
    "Name":"Room door sensor",
    "Value":"true"
  },
  {
    "Type":"Bool",
    "Name":"Rack door sensor",
    "Value":"false"}
    ]
 }
```

{% endcut %}

Настройте мониторинг показаний датчиков: создайте [графики](../../monitoring/concepts/visualization/widget.md#chart) на [дашборде](../../monitoring/concepts/visualization/dashboard.md), [канал уведомлений](../../monitoring/concepts/alerting/notification-channel.md) и [алерт](../../monitoring/concepts/alerting/alert.md)

### Создайте дашборд {#create-dashboard}

{% list tabs group=instructions %}

- Интерфейс {{ monitoring-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
  1. В открывшемся окне введите название дашборда и нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

{% endlist %}

### Создайте графики {#create-diagrams}

Создайте график изменения температуры:

{% list tabs group=instructions %}

- Интерфейс {{ monitoring-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Напротив названия нужного дашборда нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud_monitoring.actions.common.edit }}**.
  1. В нижнем блоке нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
  1. Создайте запрос для графика:

      1. В редакторе запроса нажмите значок ![image](../../_assets/console-icons/plus.svg).
      1. В списке сервисов **service=** выберите `{{ ui-key.yacloud_monitoring.services.label_custom }}`.
      1. В списке типов графиков **name=** выберите `Temperature` — температура в помещении.
      1. В списке **device_id=** выберите идентификатор устройства, по которому вы хотите создать график.

  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

  Аналогичным способом создайте другие графики:

    * `Humidity` — влажность в помещении;
    * `Water sensor` — вода на полу (есть вода / нет воды);
    * `Smoke sensor` — дым (есть дым / нет дыма);
    * `Room door sensor` — открытие двери в помещение (дверь открыта / дверь закрыта);
    * `Rack door sensor` — открытие дверцы серверной стойки (дверца открыта / дверца закрыта).

  Дашборд доступен по ссылке всем пользователям {{ yandex-cloud }} с ролью `{{ roles-viewer }}`. Вы можете его настраивать, изменять масштаб, включать и отключать автоматическое обновление данных.

{% endlist %}

### Протестируйте работу графиков на дашборде {#test-dashboard}

Если поменять базовые значения в переменных окружения функции эмулирующего устройства, эти изменения отразятся на графиках.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `my-device-emulator-function`.
  1. Нажмите на вкладку **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**.
  1. В нижней части окна в блоке **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}** в поле **{{ ui-key.yacloud_components.forms.label_value }}** замените несколько исходных значений переменных на любые другие.

      Ключ | Исходное значение | Новое значение
      :--- | :--- | :---
      `HUMIDITY_SENSOR_VALUE`    | `80.15` | `40`
      `TEMPERATURE_SENSOR_VALUE` | `25.25` | `15`
      `RACK_DOOR_SENSOR_VALUE`   | `False` | `True`
      `ROOM_DOOR_SENSOR_VALUE`   | `False` | `True`
      `SMOKE_SENSOR_VALUE`       | `False` | `True`
      `WATER_SENSOR_VALUE`       | `False` | `True`

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}** и дождитесь завершения операции.

{% endlist %}

{% list tabs group=instructions %}

- Интерфейс {{ monitoring-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}** и посмотрите, как изменились показатели графиков.

{% endlist %}

### Создайте канал уведомлений {#create-channel}

Настройте список получателей и выберите способ уведомлений.

{% list tabs group=instructions %}

- Интерфейс {{ monitoring-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.channel.field_name }}** укажите название канала. Например, `my-message-channel`.
  1. В списке **{{ ui-key.yacloud_monitoring.channel.field_method }}** выберите `{{ ui-key.yacloud_monitoring.channel.title_method-email }}`.

      Вы также можете настроить уведомления через SMS, push-уведомления или в Telegram.

  1. В списке **{{ ui-key.yacloud_monitoring.channel.field_recipients }}** выберите учетную запись.

      Вы можете выбрать несколько получателей уведомлений. В качестве получателей вы можете указать аккаунты пользователей, у которых есть доступ к вашему [облаку](../../resource-manager/concepts/resources-hierarchy.md#cloud). Подробнее о том, [как добавить пользователя в {{ yandex-cloud }}](../../iam/operations/users/create.md).
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.channel.button_create }}**.

{% endlist %}

### Создайте алерт {#create-alerts}

Создайте алерт по показаниям датчика температуры в помещении и подключите к нему созданный канал уведомлений.

Сервис отправит этот алерт получателям, если в течение определенного периода (`5 минут`) датчик температуры в серверной комнате будет показывать определенную температуру:
* `50 градусов` — алерт `Warning` (предупреждение).
* `70 градусов` — алерт `Alarm` (критическое значение).

{% list tabs group=instructions %}

- Интерфейс {{ monitoring-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя алерта.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}** нажмите значок ![image](../../_assets/console-icons/plus.svg) и заполните поля:
      1. В списке сервисов **service=** выберите `{{ ui-key.yacloud_monitoring.services.label_custom }}`.
      1. В списке типов алертов **name=** выберите `Temperature`.
      1. В списке **device_id=** выберите идентификатор устройства, по которому вы хотите создать алерт.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** задайте условия срабатывания алерта:
      1. В списке **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}** выберите `{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.avg }}`.
      1. В списке **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** выберите `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
      1. В поле **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** введите `50`.
      1. В поле **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** введите `70`.
      1. В списке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window }}** выберите `5 минут`.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** нажмите кнопку **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.edit-notify-methods }}**, затем кнопку **{{ ui-key.yacloud_monitoring.actions.common.add }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.notification-method }}** выберите `my-message-channel` и нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.add }}**.
  1. В нижней части окна нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

Вы можете создавать и настраивать алерты на любую метрику в сервисе {{ monitoring-name }}.

В результате выполнения руководства:
* Вы сможете отслеживать показания датчиков на графиках.
* Если показания датчиков достигнут заданных значений, вы получите уведомления.

## Как удалить созданные ресурсы {#cleanup}

Чтобы перестать платить за созданные ресурсы:
* [Удалите реестр в сервисе {{ iot-name }}](../../iot-core/operations/registry/registry-delete.md)
* [Удалите устройство в сервисе {{ iot-name }}](../../iot-core/operations/device/device-delete.md)
* [Удалите функции в сервисе {{ sf-name }}](../../functions/operations/function/function-delete.md)
* [Удалите триггеры для вызова функций в сервисе {{ sf-name }}](../../functions/operations/trigger/trigger-delete.md)
* [Удалите дашборд в сервисе {{ monitoring-name }}](../../monitoring/operations/dashboard/delete-dashboard.md)
* [Удалите алерт в сервисе {{ monitoring-name }}](../../monitoring/operations/alert/delete-alert.md)
* Удалите [канал уведомлений](../../monitoring/concepts/alerting/notification-channel.md) в сервисе {{ monitoring-name }}.
