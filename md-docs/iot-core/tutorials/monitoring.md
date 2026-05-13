# Мониторинг показаний датчиков и уведомления о событиях


В этом руководстве вы настроите мониторинг и уведомления об изменениях показаний датчиков, подключенных к сервису [Yandex IoT Core](../index.md). Датчики будут эмулированы с помощью сервиса [Yandex Cloud Functions](../../functions/index.md). Если у вас есть подключенные датчики, используйте их.

Для работы с руководством вам не нужно создавать и настраивать [виртуальные машины](../../compute/concepts/vm.md) — вся работа основана на бессерверных вычислениях Cloud Functions. Исходный код руководства доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-server-room-iot-monitoring).

Чтобы настроить мониторинг показаний датчиков в серверной комнате:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте необходимые ресурсы Yandex IoT Core](#resources-step).
1. [Создайте эмулятор устройства в Cloud Functions](#emulator-step).
1. [Настройте мониторинг показаний датчиков](#configure-monitoring).

Если ресурсы больше не нужны, [удалите их](#cleanup).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:
* плата за количество сообщений Yandex IoT Core (см. [тарифы Yandex IoT Core](../pricing.md));
* плата за количество вызовов [функции](../../functions/concepts/function.md) Cloud Functions (см. [тарифы Yandex Cloud Functions](../../functions/pricing.md));
* плата за запись пользовательских [метрик](../../monitoring/concepts/data-model.md#metric) через API сервиса [Monitoring](../../monitoring/index.md) (см. [тарифы Yandex Monitoring](../../monitoring/pricing.md)).

### Создайте сервисные аккаунты {#create-sa}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `my-emulator-function-service-account` для отправки данных. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `functions.functionInvoker` и `iot.devices.writer`.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `my-metrics-function-service-account` для обработки данных. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `functions.functionInvoker` и `editor`.

## Создайте необходимые ресурсы Yandex IoT Core {#resources-step}

[Реестр](../concepts/index.md#registry) и [устройство](../concepts/index.md#device) — основные компоненты сервиса Yandex IoT Core для обмена данными и командами. Чтобы устройства могли обмениваться данными, их необходимо создавать в одном реестре.

### Создайте реестр и настройте авторизацию по логину и паролю {#registry-step}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **IoT Core**.
  1. Нажмите кнопку **Создать реестр**.
  1. В поле **Имя** введите имя реестра. Например, `my-registry`.
  1. В поле **Пароль** задайте пароль доступа к реестру. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% note info %}
      
      Сохраните пароль, он понадобится вам для [аутентификации](../concepts/authorization.md).
      
      {% endnote %}

  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте устройство и настройте авторизацию по логину и паролю {#device-step}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **IoT Core**.
  1. Выберите реестр, созданный на предыдущем шаге.
  1. В меню слева выберите раздел **Устройства**.
  1. Нажмите кнопку **Добавить устройство**.
  1. В поле **Имя** введите имя устройства. Например, `my-device`.
  1. В поле **Пароль** задайте пароль доступа к устройству. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% note info %}
      
      Сохраните пароль, он понадобится вам для [аутентификации](../concepts/authorization.md).
      
      {% endnote %}

  1. (Опционально) Добавьте алиас:
      1. Нажмите кнопку **Добавить алиас**.
      1. Заполните поля: введите алиас (например `events`) и тип [топика](../concepts/topic/index.md) после `$devices/{id}` (например, `events`).

          Вы сможете использовать алиас `events` вместо топика `$devices/{id}/events`.
      1. Повторите действия для каждого добавляемого алиаса.
  1. Нажмите кнопку **Создать**.
  1. Повторите действия для каждого устройства, которое вы хотите создать.

{% endlist %}

## Создайте эмулятор устройства в Cloud Functions {#emulator-step}

Эмулятор отправляет данные с датчиков устройства и обрабатывает данные для мониторинга и [алертов](../../monitoring/concepts/alerting/alert.md).

### Создайте функцию эмуляции отправки данных с устройства {#emulation-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Создайте функцию:
      1. Нажмите кнопку **Создать функцию**.
      1. В поле **Имя** введите имя функции. Например, `my-device-emulator-function`.
      1. Нажмите кнопку **Создать**.
  1. Создайте версию функции:
      1. В открывшемся окне **Редактор** выберите `Node.js 18`.
      1. Отключите опцию **Добавить файлы с примерами кода**.
      1. Нажмите кнопку **Продолжить**.
      1. В поле **Источник кода** выберите `Редактор кода`.
      1. Нажмите кнопку **Создать файл**:
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

      1. В поле **Точка входа** укажите `device-emulator.handler`.
      1. В блоке **Параметры** укажите:
          * **Таймаут** — `10`.
          * **Память** — `128 МБ`.
          * **Сервисный аккаунт** — `my-emulator-function-service-account`.
          * **Переменные окружения**:
              Ключ | Описание | Значение
              :--- | :--- | :---
              `HUMIDITY_SENSOR_VALUE`    | Базовое значение показания датчика влажности.         | `80.15`
              `TEMPERATURE_SENSOR_VALUE` | Базовое значение показания датчика температуры.       | `25.25`
              `RACK_DOOR_SENSOR_VALUE`   | Показания датчика открытия дверцы стойки.             | `False`
              `ROOM_DOOR_SENSOR_VALUE`   | Показания датчика открытия двери в серверную комнату. | `False`
              `SMOKE_SENSOR_VALUE`       | Показания детектора дыма.                             | `False`
              `WATER_SENSOR_VALUE`       | Показания детектора воды.                             | `False`
              `IOT_CORE_DEVICE_ID`       | Идентификатор устройства, которое вы создали.         | См. в [консоли управления](https://console.yandex.cloud)<br>сервиса Yandex IoT Core.
              `DEVICE_ID`                | Пользовательское название устройства.                 | Задается пользователем.

      1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

### Протестируйте функцию эмуляции {#test-emulation-function}

(Опционально) Для получения подробной информации с датчиков, [подпишите](../operations/subscribe.md#one-device) реестр на [топик](../concepts/topic/index.md) устройства Yandex IoT Core.

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Выберите функцию `my-device-emulator-function`.
  1. В меню слева выберите **Тестирование**.
  1. В списке **Тег версии** выберите `$latest` — последнюю созданную функцию.
  1. Нажмите кнопку **Запустить тест**.

      При успешном выполнении функции в поле **Состояние функции** отобразится статус **Выполнена**, и в поле **Ответ функции** появится результат:

      ```json
      {
        "statusCode" : 200
      }
      ```

      Если вы подписались на топик устройства Yandex IoT Core, вы получите в терминале JSON вида:

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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. На панели слева выберите **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В поле **Имя** введите имя триггера. Например, `my-emulator-function-trigger`.
  1. В поле **Тип** выберите `Таймер`.
  1. В поле **Cron-выражение** введите `* * * * ? *` (вызов один раз в минуту).
  1. В блоке **Настройки функции** введите ранее заданные параметры функции:
      * **Функция** — `my-device-emulator-function`.
      * **Тег версии функции** — `$latest`.
      * **Сервисный аккаунт** — `my-emulator-function-service-account`.
  1. (Опционально) Настройте параметры блоков **Настройки повторных запросов** и **Настройки Dead Letter Queue**. Они обеспечивают сохранность данных.
      * **Настройки повторных запросов** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **Настройки Dead Letter Queue** позволяют перенаправлять сообщения, которые не смогли обработать получатели в обычных [очередях](../../message-queue/concepts/queue.md).

          В качестве DLQ очереди вы можете настроить стандартную очередь сообщений. Если вы еще не создавали очередь сообщений, [создайте ее в сервисе Yandex Message Queue](../../message-queue/operations/message-queue-new-queue.md).
  1. Нажмите кнопку **Создать триггер**.

{% endlist %}

### Создайте функцию обработки принимаемых данных {#processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. На панели слева выберите раздел **Функции**.
  1. Создайте функцию:
      1. Нажмите кнопку **Создать функцию**.
      1. В поле **Имя** введите имя функции. Например, `my-monitoring-func`.
      1. Нажмите кнопку **Создать**.
  1. Создайте версию функции:
      1. В открывшемся окне **Редактор** выберите `Python 3.12`.
      1. Отключите опцию **Добавить файлы с примерами кода**.
      1. Нажмите кнопку **Продолжить**.
      1. В поле **Источник кода** выберите `Редактор кода`.
      1. Нажмите кнопку **Создать файл**:
          * Имя файла — `monitoring.py`.
          * Содержимое файла — код функции с [GitHub](https://github.com/yandex-cloud-examples/yc-server-room-iot-monitoring/blob/master/monitoring.py).

              В этой функции подготовка данных для отправки в сервис мониторинга находится в методе `makeAllMetrics`. Если вы захотите добавить или удалить параметры, выполните изменения в этом методе.

      1. В поле **Точка входа** укажите `monitoring.msgHandler`.
      1. В блоке **Параметры** укажите:
          * **Таймаут** — `10`.
          * **Память** — `128 МБ`.
          * **Сервисный аккаунт** — `my-metrics-function-service-account`.
          * **Переменные окружения**:

              Ключ | Описание | Значение
              :--- | :--- | :---
              `VERBOSE_LOG`       | Включение и отключение записи данных. | `True`
              `METRICS_FOLDER_ID` | Идентификатор каталога, в котором развернуты сервисы и для которого вы создадите дашборд в сервисе Monitoring. | См. в [консоли управления](https://console.yandex.cloud).

      1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

### Протестируйте функцию обработки данных {#test-processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Выберите функцию `my-monitoring-func`.
  1. В меню слева выберите **Тестирование**.
  1. В списке **Тег версии** выберите `$latest` — последнюю созданную функцию.
  1. В поле **Входные данные** вставьте данные:

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

  1. Нажмите кнопку **Запустить тест**.

      При успешном выполнении функции в поле **Состояние функции** отобразится статус **Выполнена**, а в поле **Ответ функции** появится результат:

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

Триггер вызовет функцию, когда в [топике устройства](../concepts/topic/devices-topic.md) появится сообщение.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. На панели слева выберите **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В поле **Имя** введите имя триггера. Например, `my-monitoring-func-trigger`.
  1. В поле **Тип** выберите `IoT Core (устройство)`.
  1. В блоке **Настройки сообщений IoT Core** введите ранее заданные параметры реестра и устройства:
      * **Реестр** — `my-registry`.
      * **Устройство** — `my-device`.
      * **MQTT-топик** — `$devices/<идентификатор_устройства>/events`, где `<идентификатор_устройства>` — это идентификатор устройства в сервисе **Yandex IoT Core**.
  1. В блоке **Настройки функции** введите ранее заданные параметры функции:
      * **Функция** — `my-monitoring-func`.
      * **Тег версии функции** — `$latest`.
      * **Сервисный аккаунт** — `my-metrics-function-service-account`.
  1. (Опционально) Настройте параметры блоков **Настройки повторных запросов** и **Настройки Dead Letter Queue**. Они обеспечивают сохранность данных.
      * **Настройки повторных запросов** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **Настройки Dead Letter Queue** позволяют перенаправлять сообщения, которые не смогли обработать получатели в обычных [очередях](../../message-queue/concepts/queue.md).

          В качестве DLQ очереди вы можете настроить стандартную очередь сообщений. Если вы еще не создавали очередь сообщений, [создайте ее в сервисе Yandex Message Queue](../../message-queue/operations/message-queue-new-queue.md).
  1. Нажмите кнопку **Создать триггер**.

  Все данные от устройства автоматически попадут в сервис **Monitoring**.

{% endlist %}

## Настройте мониторинг показаний датчиков {#configure-monitoring}

Для наблюдения за показаниями датчиков используется дашборд в сервисе [Yandex Monitoring](../../monitoring/index.md). Показания датчиков поступают с контроллера на сервер раз в минуту по [MQTT-протоколу](../../glossary/mqtt-server.md#mqtt-protocol). Когда показания датчиков достигают заданных значений, Monitoring отправляет уведомления пользователям.

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

- Интерфейс Monitoring {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Monitoring**.
  1. Перейдите на вкладку **Дашборды**.
  1. Нажмите кнопку **Создать**.
  1. Справа вверху нажмите кнопку **Сохранить**.
  1. В открывшемся окне введите название дашборда и нажмите кнопку **Сохранить**.

{% endlist %}

### Создайте графики {#create-diagrams}

Создайте график изменения температуры:

{% list tabs group=instructions %}

- Интерфейс Monitoring {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Monitoring**.
  1. Перейдите на вкладку **Дашборды**.
  1. Напротив названия нужного дашборда нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) → **Редактировать**.
  1. В нижнем блоке нажмите **График**.
  1. Создайте запрос для графика:

      1. В редакторе запроса нажмите значок ![image](../../_assets/console-icons/plus.svg).
      1. В списке сервисов **service=** выберите `Custom Metrics`.
      1. В списке типов графиков **name=** выберите `Temperature` — температура в помещении.
      1. В списке **device_id=** выберите идентификатор устройства, по которому вы хотите создать график.

  1. Справа вверху нажмите кнопку **Сохранить**.

  Аналогичным способом создайте другие графики:

    * `Humidity` — влажность в помещении;
    * `Water sensor` — вода на полу (есть вода / нет воды);
    * `Smoke sensor` — дым (есть дым / нет дыма);
    * `Room door sensor` — открытие двери в помещение (дверь открыта / дверь закрыта);
    * `Rack door sensor` — открытие дверцы серверной стойки (дверца открыта / дверца закрыта).

  Дашборд доступен по ссылке всем пользователям Yandex Cloud с ролью `viewer`. Вы можете его настраивать, изменять масштаб, включать и отключать автоматическое обновление данных.

{% endlist %}

### Протестируйте работу графиков на дашборде {#test-dashboard}

Если поменять базовые значения в переменных окружения функции эмулирующего устройства, эти изменения отразятся на графиках.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Выберите функцию `my-device-emulator-function`.
  1. Нажмите на вкладку **Редактор**.
  1. В нижней части окна в блоке **Переменные окружения** в поле **Значение** замените несколько исходных значений переменных на любые другие.

      Ключ | Исходное значение | Новое значение
      :--- | :--- | :---
      `HUMIDITY_SENSOR_VALUE`    | `80.15` | `40`
      `TEMPERATURE_SENSOR_VALUE` | `25.25` | `15`
      `RACK_DOOR_SENSOR_VALUE`   | `False` | `True`
      `ROOM_DOOR_SENSOR_VALUE`   | `False` | `True`
      `SMOKE_SENSOR_VALUE`       | `False` | `True`
      `WATER_SENSOR_VALUE`       | `False` | `True`

  1. Нажмите кнопку **Сохранить изменения** и дождитесь завершения операции.

{% endlist %}

{% list tabs group=instructions %}

- Интерфейс Monitoring {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Monitoring** и посмотрите, как изменились показатели графиков.

{% endlist %}

### Создайте канал уведомлений {#create-channel}

Настройте список получателей и выберите способ уведомлений.

{% list tabs group=instructions %}

- Интерфейс Monitoring {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Monitoring**.
  1. Перейдите на вкладку **Каналы уведомлений**.
  1. Нажмите кнопку **Создать канал**.
  1. В поле **Имя** укажите название канала. Например, `my-message-channel`.
  1. В списке **Метод** выберите `Email`.

      Вы также можете настроить уведомления через SMS, push-уведомления или в Telegram.

  1. В списке **Получатели** выберите учетную запись.

      Вы можете выбрать несколько получателей уведомлений. В качестве получателей вы можете указать аккаунты пользователей, у которых есть доступ к вашему [облаку](../../resource-manager/concepts/resources-hierarchy.md#cloud). Подробнее о том, [как добавить пользователя в Yandex Cloud](../../organization/operations/add-account.md).
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте алерт {#create-alerts}

Создайте алерт по показаниям датчика температуры в помещении и подключите к нему созданный канал уведомлений.

Сервис отправит этот алерт получателям, если в течение определенного периода (`5 минут`) датчик температуры в серверной комнате будет показывать определенную температуру:
* `50 градусов` — алерт `Warning` (предупреждение).
* `70 градусов` — алерт `Alarm` (критическое значение).

{% list tabs group=instructions %}

- Интерфейс Monitoring {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Monitoring**.
  1. Нажмите кнопку **Создать алерт**.
  1. В поле **Имя** введите имя алерта.
  1. В блоке **Настройки алерта** нажмите значок ![image](../../_assets/console-icons/plus.svg) и заполните поля:
      1. В списке сервисов **service=** выберите `Custom Metrics`.
      1. В списке типов алертов **name=** выберите `Temperature`.
      1. В списке **device_id=** выберите идентификатор устройства, по которому вы хотите создать алерт.
  1. В блоке **Условия срабатывания** задайте условия срабатывания алерта:
      1. В списке **Функция агрегации** выберите `Среднее`.
      1. В списке **Функция сравнения** выберите `Больше`.
      1. В поле **Warning** введите `50`.
      1. В поле **Alarm** введите `70`.
      1. В списке **Окно вычисления** выберите `5 минут`.
  1. В блоке **Уведомления** нажмите кнопку **Редактировать**, затем кнопку **Добавить**.
  1. В открывшемся окне в поле **Способ уведомления** выберите `my-message-channel` и нажмите кнопку **Добавить**.
  1. В нижней части окна нажмите кнопку **Создать**.

{% endlist %}

Вы можете создавать и настраивать алерты на любую метрику в сервисе Monitoring.

В результате выполнения руководства:
* Вы сможете отслеживать показания датчиков на графиках.
* Если показания датчиков достигнут заданных значений, вы получите уведомления.

## Как удалить созданные ресурсы {#cleanup}

Чтобы перестать платить за созданные ресурсы:
* [Удалите реестр в сервисе Yandex IoT Core](../operations/registry/registry-delete.md)
* [Удалите устройство в сервисе Yandex IoT Core](../operations/device/device-delete.md)
* [Удалите функции в сервисе Cloud Functions](../../functions/operations/function/function-delete.md)
* [Удалите триггеры для вызова функций в сервисе Cloud Functions](../../functions/operations/trigger/trigger-delete.md)
* [Удалите дашборд в сервисе Monitoring](../../monitoring/operations/dashboard/delete-dashboard.md)
* [Удалите алерт в сервисе Monitoring](../../monitoring/operations/alert/delete-alert.md)
* Удалите [канал уведомлений](../../monitoring/concepts/alerting/notification-channel.md) в сервисе Monitoring.