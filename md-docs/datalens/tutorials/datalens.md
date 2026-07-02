[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > [Практические руководства](index.md) > Работа с геоданными > Мониторинг состояния географически распределенных устройств

# Мониторинг состояния географически распределенных устройств

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../iot-core/sunset.md).

{% endnote %}


В этом руководстве вы настроите мониторинг состояния устройств (например, вендинговых автоматов), подключенных к сервису [Yandex IoT Core](../../iot-core/index.md) и расположенных в разных точках города. Вы сможете наблюдать за состоянием автоматов на карте и графиках сервиса [Yandex DataLens](../index.md). Датчики будут эмулированы с помощью сервиса [Yandex Cloud Functions](../../functions/index.md). Если у вас есть подключенные датчики, используйте их. Для хранения данных будет использован сервис [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md).

Исходный код руководства доступен в репозитории на [GitHub](https://github.com/yandex-cloud-examples/yc-geo-dist-devices-iot-monitoring).

Чтобы настроить мониторинг показаний датчиков:
1. [Подготовьте облако к работе](#configure-cloud).
1. [Создайте кластер Managed Service for PostgreSQL](#postgresql-step).
1. [Создайте необходимые ресурсы Yandex IoT Core](#resources-step).
1. [Создайте эмулятор устройств в Cloud Functions](#emulator-step).
1. [Создайте функцию обработки данных в Cloud Functions](#processing-function-step).
1. [Настройте мониторинг в DataLens](#configure-datalens).

Если созданные ресурсы вам больше не нужны, [удалите их](#cleanup).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Реестр Yandex IoT Core: количество отправленных сообщений ([тарифы Yandex IoT Core](../../iot-core/pricing.md)).
* Функции Yandex Cloud Functions: количество вызовов функции, время простоя подготовленных экземпляров и выделенные для выполнения функции вычислительные ресурсы ([тарифы Yandex Cloud Functions](../../functions/pricing.md)).


## Подготовьте облако к работе {#configure-cloud}

* [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `my-emulator-function-service-account` для отправки данных. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `functions.functionInvoker`, `iot.devices.writer` и `viewer`.
* Создайте сервисный аккаунт `my-db-function-service-account` для обработки данных. Назначьте ему роли `functions.functionInvoker` и `editor`.
* [Создайте](../../vpc/operations/network-create.md) облачную сеть и хотя бы одну [подсеть](../../vpc/operations/subnet-create.md) в зоне доступности `ru-central1-a`, `ru-central1-b` или `ru-central1-d`.
* [Создайте](../../vpc/operations/security-group-create.md) группу безопасности `my-pg-sg` и [добавьте](../../vpc/operations/security-group-add-rule.md) правило для входящего трафика:

    * **Диапазон портов** — `6432`.
    * **Протокол** — `TCP`.
    * **Источник** — `CIDR`.
    * **CIDR блоки** — `0.0.0.0/0`.

## Создайте кластер в Managed Service for PostgreSQL {#postgresql-step}

В примере используются минимальные значения параметров [хоста](../../managed-postgresql/concepts/instance-types.md). Для реальных задач рекомендуется выбирать хосты с гарантированной долей vCPU 100%.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите кнопку **Создать кластер**.
  1. Укажите имя кластера, например `my-pg-database`.
  1. В списке **Окружение** выберите `PRODUCTION`.
  1. В списке **Версия** выберите `17`.
  1. В блоке **Класс хоста** укажите:

      * **Платформа** — `Intel Ice Lake`.
      * **Тип** — `standard`.
      * Класс — `s3-c2-m8 (2 vCPU, 8 ГБ)`.

  1. В блоке **Размер хранилища**:

      * Выберите `network-hdd`.
      * Укажите размер `10 ГБ`.

  1. В блоке **База данных** укажите:

      * **Имя БД** — `db1`.
      * **Имя пользователя** — `user1`.
      * **Пароль** — задайте пароль доступа к БД.

          {% note info %}
          
          Сохраните пароль, он понадобится вам для [аутентификации](../../iot-core/concepts/authorization.md).
          
          {% endnote %}

      * **Локаль сортировки (LC_COLLATE)** — `C`.
      * **Локаль набора символов (LC_CTYPE)** — `C`.

  1. В блоке **Сетевые настройки**:

      1. Выберите облачную сеть, в которой создана группа безопасности `my-pg-sg`.
      1. Выберите группу безопасности `my-pg-sg`.

  1. В блоке **Хосты**:

      1. Оставьте один хост.
      1. Нажмите значок ![image](../../_assets/console-icons/pencil.svg).
      1. В открывшемся окне включите опцию **Публичный доступ** и нажмите кнопку **Сохранить**.

  1. В блоке **Дополнительные настройки** включите опции **Доступ из DataLens** и **Доступ из консоли управления**.
  1. Нажмите кнопку **Создать кластер**.

  Создание кластера может занять несколько минут.

{% endlist %}

## Создайте необходимые ресурсы Yandex IoT Core {#resources-step}

[Реестр](../../iot-core/concepts/index.md#registry) и [устройство](../../iot-core/concepts/index.md#device) — основные компоненты сервиса Yandex IoT Core для обмена данными и командами. Чтобы устройства могли обмениваться данными, их необходимо создавать в одном реестре.

### Создайте реестр и настройте авторизацию по логину и паролю {#registry-step}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы выполняете руководство.
  1. Перейдите в сервис **IoT Core**.
  1. Нажмите кнопку **Создать реестр**.
  1. В поле **Имя** введите имя реестра. Например, `my-registry`.
  1. В поле **Пароль** задайте пароль доступа к реестру. Пароль должен быть длиной не менее 14 символов, должен содержать строчные буквы, заглавные буквы и цифры. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% note info %}
      
      Сохраните пароль, он понадобится вам для [аутентификации](../../iot-core/concepts/authorization.md).
      
      {% endnote %}

  1. Нажмите кнопку **Создать**.

{% endlist %}

Вы также можете использовать авторизацию с помощью сертификатов. Подробнее [об авторизации в Yandex IoT Core](../../iot-core/concepts/authorization.md).

### Создайте устройства и настройте авторизацию по логину и паролю {#device-step}

Создайте три устройства: `my-device-1`, `my-device-2` и `my-device-3`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **IoT Core**.
  1. Выберите реестр, созданный на предыдущем шаге.
  1. В меню слева выберите **Устройства**.
  1. Нажмите кнопку **Добавить устройство**.
  1. В поле **Имя** введите имя устройства `my-device-1`.
  1. В поле **Пароль** задайте пароль доступа к устройству. Пароль должен быть длиной не менее 14 символов, должен содержать строчные буквы, заглавные буквы и цифры. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% note info %}
      
      Сохраните пароль, он понадобится вам для [аутентификации](../../iot-core/concepts/authorization.md).
      
      {% endnote %}

  1. (Опционально) Добавьте алиас:

      1. Нажмите кнопку **Добавить алиас**.
      1. Заполните поля: введите алиас (например `events`) и тип [топика](../../iot-core/concepts/topic/index.md) после `$devices/{id}` (например, `events`).

          В результате вместо топика `$devices/<идентификатор_устройства>/events` вы сможете использовать алиас `events`.

      1. Повторите действия для каждого добавляемого алиаса.

  1. Нажмите кнопку **Создать**.
  1. Аналогичным образом создайте устройства `my-device-2` и `my-device-3`.

{% endlist %}

Вы также можете использовать авторизацию с помощью сертификатов. Подробнее [об авторизации в Yandex IoT Core](../../iot-core/concepts/authorization.md).

## Создайте эмулятор устройств в Cloud Functions {#emulator-step}

Эмулятор отправит данные с устройств в кластер Managed Service for PostgreSQL.

Чтобы запустить эмулятор, создайте [функцию](../../functions/concepts/function.md) эмуляции отправки данных с датчиков устройств и [триггер](../../functions/concepts/trigger/index.md) для вызова этой функции с периодичностью один раз в минуту.

### Создайте функцию эмуляции отправки данных с устройства {#emulation_function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Cloud Functions**.
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
          * Содержимое файла — код функции с [GitHub](https://github.com/yandex-cloud-examples/yc-geo-dist-devices-iot-monitoring/blob/main/device-emulator.js).

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
              `CASH_DRAWER_SENSOR_VALUE`  | Процент заполненности отсека купюр          | `67.89`
              `TEMPERATURE_SENSOR_VALUE`  | Базовое значение температуры в отсеке выдачи товара | `10.34`
              `POWER_SENSOR_VALUE`        | Базовое значение напряжения сети            | `24.12`
              `SERVICE_DOOR_SENSOR_VALUE` | Показания датчика открытия сервисной дверцы | `False`
              `ITEM1_SENSOR_VALUE`        | Остаток товара типа 1                       | `50.65`
              `ITEM2_SENSOR_VALUE`        | Остаток товара типа 2                       | `80.97`
              `ITEM3_SENSOR_VALUE`        | Остаток товара типа 3                       | `30.33`
              `ITEM4_SENSOR_VALUE`        | Остаток товара типа 4                       | `15.15`
              `REGISTRY_ID`               | Идентификатор реестра, который вы создали   | Идентификатор можно узнать в [консоли управления](https://console.yandex.cloud)<br>сервиса Yandex IoT Core

      1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

### Протестируйте функцию эмуляции {#test-emulation-function}

1. (Опционально) Чтобы получать подробную информацию с датчиков, [подпишите](../../iot-core/operations/subscribe.md#one-device) реестр на [топик](../../iot-core/concepts/topic/index.md) устройства Yandex IoT Core.

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc iot mqtt subscribe \
        --username <идентификатор_реестра> \
        --password <пароль_реестра> \
        --topic '$devices/<идентификатор_устройства>/events/#' \
        --qos 1
      ```

      Где:
      * `--username` и `--password` — параметры авторизации с помощью логина и пароля.
      * `--topic` — топик устройства для отправки данных или алиас топика.
      * `--qos` — [уровень качества обслуживания](../../glossary/qos.md) (QoS).

      Выполнение команды не должно прерываться до завершения тестирования функции.

      Подробнее о команде `yc iot mqtt subscribe` читайте в [справочнике CLI](../../cli/cli-ref/iot/cli-ref/mqtt/subscribe.md).

    {% endlist %}

1. Протестируйте функцию эмуляции:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
      1. Перейдите в сервис **Cloud Functions**.
      1. Выберите функцию `my-device-emulator-function`.
      1. В меню слева выберите **Тестирование**.
      1. В списке **Тег версии** выберите `$latest` — последнюю созданную версию функции.
      1. Нажмите кнопку **Запустить тест**.

          При успешном выполнении функции в поле **Состояние функции** отобразится статус **Выполнена**, и в поле **Ответ функции** появится результат:

          ```json
          {
            "statusCode" : 200
          }
          ```

          Если перед выполнением тестирования вы подписались на топик устройства Yandex IoT Core, в терминале вы получите объект JSON вида:

          ```json
          {
            "DeviceId":"areulpu7dnou********",
            "TimeStamp":"2024-06-19T08:29:14Z",
            "Values":[
                {"Type":"Bool","Name":"Service door sensor","Value":"False"},
                {"Type":"Float","Name":"Power Voltage","Value":"24.91"},
                {"Type":"Float","Name":"Temperature","Value":"10.51"},
                {"Type":"Float","Name":"Cash drawer fullness","Value":"67.89"},
                {"Items":[
                    {"Type":"Float", "Id":"1","Name":"Item 1","Fullness":"50.65"},
                    {"Type":"Float", "Id":"2","Name":"Item 2","Fullness":"80.97"},
                    {"Type":"Float", "Id":"3","Name":"Item 3","Fullness":"30.33"},
                    {"Type":"Float", "Id":"4","Name":"Item 4","Fullness":"15.15"}
                ]}
                ]
            }
          ```

    {% endlist %}

### Создайте триггер для вызова функции с периодичностью один раз в минуту {#minute-trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В поле **Имя** введите имя триггера. Например, `my-emulator-function-trigger`.
  1. В поле **Тип** выберите `Таймер`.
  1. В поле **Cron-выражение** выберите `Каждую минуту`.
  1. В блоке **Настройки функции** укажите параметры функции:

      * **Функция** — `my-device-emulator-function`.
      * **Тег версии функции** — `$latest`.
      * **Сервисный аккаунт** — `my-emulator-function-service-account`.

  1. (Опционально) В блоках **Настройки повторных запросов** и **Настройки Dead Letter Queue** задайте параметры, которые позволят не потерять данные в случае сбоя:

      * **Настройки повторных запросов** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **Настройки Dead Letter Queue** позволяют перенаправлять сообщения, которые триггер отправляет в функцию.

          В качестве очереди [Dead Letter Queue](../../message-queue/concepts/dlq.md) вы можете использовать [стандартную очередь](../../message-queue/concepts/queue.md#standard-queues) сообщений. Если у вас нет очереди сообщений, [создайте ее в сервисе Yandex Message Queue](../../message-queue/operations/message-queue-new-queue.md).

  1. Нажмите кнопку **Создать триггер**.

{% endlist %}

## Создайте функцию обработки данных в Cloud Functions {#processing-function-step}

Создайте функцию обработки данных, протестируйте ее и посмотрите результат обработки данных. Затем создайте триггер для вызова функции и посмотрите результат его работы.

### Создайте функцию обработки принимаемых данных {#processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите **Функции**.
  1. Создайте функцию:

      1. Нажмите кнопку **Создать функцию**.
      1. В поле **Имя** введите имя функции. Например, `my-db-function`.
      1. Нажмите кнопку **Создать**.

  1. Создайте версию функции:

      1. В открывшемся окне **Редактор** выберите `Python 3.12`.
      1. Отключите опцию **Добавить файлы с примерами кода**.
      1. Нажмите кнопку **Продолжить**.
      1. В поле **Источник кода** выберите `Редактор кода`.
      1. Нажмите кнопку **Создать файл**:

          * Имя файла — `myfunction.py`.
          * Содержимое файла — код функции с [GitHub](https://github.com/yandex-cloud-examples/yc-geo-dist-devices-iot-monitoring/blob/main/myfunction.py).

      1. В поле **Точка входа** укажите `myfunction.msgHandler`.
      1. В блоке **Параметры** укажите:

          * **Таймаут** — `10`.
          * **Память** — `128 МБ`.
          * **Сервисный аккаунт** — `my-db-function-service-account`.
          * **Переменные окружения**:

              Ключ | Описание | Значение
              :--- | :--- | :---
              `VERBOSE_LOG` | Включение и отключение записи данных | `True`
              `DB_HOSTNAME` | FQDN хоста в Managed Service for PostgreSQL | FQDN можно узнать в [консоли управления](https://console.yandex.cloud)<br>сервиса Managed Service for PostgreSQL
              `DB_PORT`     | Порт подключения к кластеру в Managed Service for PostgreSQL | `6432`
              `DB_NAME`     | Имя кластера в Managed Service for PostgreSQL | `db1`
              `DB_USER`     | Имя пользователя для подключения к кластеру в Managed Service for PostgreSQL | `user1`
              `DB_PASSWORD` | Пароль подключения к БД в Managed Service for PostgreSQL | Пароль, который вы задали в Managed Service for PostgreSQL

      1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

### Протестируйте функцию обработки данных {#test-processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Cloud Functions**.
  1. Выберите функцию `my-db-function`.
  1. В меню слева выберите **Тестирование**.
  1. В списке **Тег версии** выберите `$latest` — последнюю созданную версию функции.
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
            "payload": "ewogICAgICAgICAgICAiRGV2aWNlSWQiOiJhcmU1NzBrZTA1N29pcjg1bDlmciIsCiAgICAgICAgICAgICJUaW1lU3RhbXAiOiIyMDIwLTA2LTExVDExOjA3OjIwWiIsCiAgICAgICAgICAgICJWYWx1ZXMiOlsKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkJvb2wiLCJOYW1lIjoiU2VydmljZSBkb29yIHNlbnNvciIsIlZhbHVlIjoiRmFsc2UifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IlBvd2VyIFZvbHRhZ2UiLCJWYWx1ZSI6IjI1LjA2In0sCiAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsIk5hbWUiOiJUZW1wZXJhdHVyZSIsIlZhbHVlIjoiMTEuMjEifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IkNhc2ggZHJhd2VyIGZ1bGxuZXNzIiwiVmFsdWUiOiI2Ny44OSJ9LAogICAgICAgICAgICAgICAgeyJJdGVtcyI6WwogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiMSIsIk5hbWUiOiJJdGVtIDEiLCJGdWxsbmVzcyI6IjUwLjY1In0sCiAgICAgICAgICAgICAgICAgICAgeyJUeXBlIjoiRmxvYXQiLCAiSWQiOiIyIiwiTmFtZSI6Ikl0ZW0gMiIsIkZ1bGxuZXNzIjoiODAuOTcifSwKICAgICAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsICJJZCI6IjMiLCJOYW1lIjoiSXRlbSAzIiwiRnVsbG5lc3MiOiIzMC4zMyJ9LAogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiNCIsIk5hbWUiOiJJdGVtIDQiLCJGdWxsbmVzcyI6IjE1LjE1In0KICAgICAgICAgICAgICAgIF19CiAgICAgICAgICAgICAgICBdCiAgICAgICAgICAgIH0="
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

### Просмотрите результат обработки данных в Managed Service for PostgreSQL {#processing-function-results}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите кластер `my-pg-database`.
  1. В меню слева выберите **SQL**.
  1. В поле **Пароль** введите пароль, который вы задали для доступа к БД, и нажмите кнопку **Подключиться**.
  1. Выберите папку `public`.
  1. Посмотрите результаты обработки данных в таблицах `iot_events` и `iot_position`.

{% endlist %}

### Создайте триггер для вызова функции обработки данных {#processing-function-trigger}

Триггер вызовет функцию, когда в [топике устройства](../../iot-core/concepts/topic/devices-topic.md) появятся сообщения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В поле **Имя** введите имя триггера. Например, `my-db-func-trigger`.
  1. В поле **Тип** выберите `IoT Core (устройство)`.
  1. В блоке **Настройки сообщений IoT Core** укажите параметры реестра и устройства:

      * **Реестр** — `my-registry`.
      * **Устройство** — `Любое устройство`.
      * **MQTT-топик** — `$devices/#`.

  1. В блоке **Настройки функции** укажите параметры функции:

      * **Функция** — `my-db-function`.
      * **Тег версии функции** — `$latest`.
      * **Сервисный аккаунт** — `my-db-function-service-account`.

  1. (Опционально) В блоках **Настройки повторных запросов** и **Настройки Dead Letter Queue** задайте параметры, которые позволят не потерять данные в случае сбоя:

      * **Настройки повторных запросов** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **Настройки Dead Letter Queue** позволяют перенаправлять сообщения, которые триггер отправляет в функцию.

          В качестве очереди Dead Letter Queue вы можете использовать стандартную очередь сообщений. Если у вас нет очереди сообщений, [создайте ее в сервисе Yandex Message Queue](../../message-queue/operations/message-queue-new-queue.md).

  1. Нажмите кнопку **Создать триггер**.

{% endlist %}

### Просмотрите результат работы триггера в Managed Service for PostgreSQL {#processing-function-trigger-results}

Через некоторое время после создания триггера вы можете проверить, как он работает.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите кластер `my-pg-database`.
  1. В меню слева выберите **SQL**.
  1. В поле **Пароль** укажите пароль, который вы задали для доступа к БД, и нажмите кнопку **Подключиться**.
  1. Выберите папку `public`.
  1. Посмотрите изменения в таблице `iot_events`.

{% endlist %}

## Настройте мониторинг в DataLens {#configure-datalens}

Чтобы наблюдать за состоянием устройств, настройте [подключение](../concepts/connection/index.md), создайте [датасет](../dataset/index.md), [чарты](../concepts/chart/index.md) и [дашборд](../concepts/dashboard.md).

### Настройте подключение к Managed Service for PostgreSQL {#connect-mpg}

{% list tabs group=instructions %}

- Интерфейс DataLens {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **DataLens**.
  1. Нажмите кнопку **Создать подключение**.
  1. Выберите коннектор **PostgreSQL**.

      При подключении к внешнему источнику данных (который не является ресурсом Yandex Cloud) предоставьте доступ к источнику [для диапазонов IP-адресов сервиса DataLens](../concepts/connection/index.md#changing-connection-ranges).

  1. Выберите облако и каталог.
  1. Выберите кластер `my-pg-database` и хост.
  1. В поле **Порт** укажите `6432`.
  1. Выберите базу данных `db1` и пользователя `user1`.
  1. В поле **Пароль** укажите пароль, который вы задали для доступа к БД в сервисе Managed Service for PostgreSQL.
  1. Нажмите кнопку **Создать подключение**.
  1. В открывшемся окне укажите имя подключения `MyPGConnection` и нажмите кнопку **Создать**.

{% endlist %}

### Создайте датасет {#create-dataset}

{% list tabs group=instructions %}

- Интерфейс DataLens {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **DataLens**.
  1. Нажмите кнопку **Создать датасет**.
  1. На панели слева нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить**.
  1. Выберите подключение `MyPGConnection`.
  1. В меню слева выберите таблицы `public.iot_events` и `public.iot_position`, перетащите их вправо.
  1. Нажмите кнопку **Сохранить**.
  1. В открывшемся окне укажите имя датасета `My-pg-dataset` и нажмите **Создать**.

      Датасет появится в списке.

{% endlist %}

### Создайте чарт по показателям температуры и напряжения сети {#create-chart}

{% list tabs group=instructions %}

- Интерфейс DataLens {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **DataLens**.
  1. Нажмите кнопку **Создать чарт**.
  1. На панели слева нажмите кнопку ![image](../../_assets/console-icons/circles-intersection.svg) **Выберите датасет** и выберите датасет `My-pg-dataset`, который вы создали ранее.
  1. Выберите [тип чарта](../visualization-ref/line-chart.md) **Линейная диаграмма**.
  1. Из блока **Измерения** в меню слева перетащите измерения в блок **Линейная диаграмма**:
      * `event_datetime` в секцию **X**.

          В нижней части графика по оси X отобразится временная шкала.
      * `temperature` и `power_voltage` в секцию **Y**.

      По оси Y в виде графика отобразятся значения температуры и напряжения сети.
  1. Нажмите кнопку **Сохранить**.
  1. В открывшемся окне укажите имя чарта или используйте сгенерированное имя `My-pg-dataset — Линейная диаграмма` и нажмите **Сохранить**.

{% endlist %}

### Создайте чарт с картой {#create-chart-map}

{% list tabs group=instructions %}

- Интерфейс DataLens {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **DataLens**.
  1. Создайте поле для определения координат устройств:
      1. В меню слева выберите **Датасеты**.
      1. В списке выберите датасет `My-pg-dataset`.
      1. Выберите вкладку **Поля**.
      1. В правой части окна нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить поле**.
      1. В открывшемся окне в поле **Название поля** введите `Position`.
      1. В поле **Формула** вставьте `GEOPOINT([latitude],[longitude])`.
      1. Нажмите кнопку **Создать**.
      1. Нажмите кнопку **Сохранить**.
  1. Создайте чарт:
      1. Справа вверху нажмите кнопку **Создать чарт**.
      1. Выберите [тип чарта](../visualization-ref/map-chart.md) `Карта`.
      1. Из блока **Измерения** в меню слева перетащите измерения в блок **Карта**:
          * `Position` в секцию **Геоточки**.
          * `item1_fullness`, `item2_fullness`, `item3_fullness`, `item4_fullness` и `cash_drawer` в секцию **Тултипы**.

              В правой части окна отобразится масштабируемая карта, на которой вендинговые автоматы отмечены точками на карте, а тултипы при наведении указателя на точки — строками легенды.
      1. Нажмите кнопку **Сохранить**.
      1. В открывшемся окне укажите имя чарта или используйте сгенерированное имя `My-pg-dataset — Карта` и нажмите **Сохранить**.

{% endlist %}

### Создайте дашборд {#create-dashboard}

{% list tabs group=instructions %}

- Интерфейс DataLens {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы выполняете руководство.
  1. Перейдите в сервис **DataLens**.
  1. Нажмите кнопку **Создать дашборд**.
  1. Добавьте на дашборд чарты `My-pg-dataset — Карта` и `My-pg-dataset — Линейная диаграмма`, которые вы создали ранее:
      1. На нижней панели нажмите **Чарт**.
      1. В открывшемся окне в поле **Чарт** нажмите кнопку **Выбрать** и выберите `My-pg-dataset — Карта`.
      1. Нажмите кнопку **Добавить**.
      1. Повторите действия — добавьте чарт `My-pg-dataset — Линейная диаграмма`.
  1. Настройте селектор:
      1. На нижней панели нажмите **Селектор**.
      1. В поле **Датасет** нажмите кнопку **Выбрать** и выберите `My-pg-dataset`.
      1. В списке **Поле** выберите `device_id`.
      1. В списке **Значение по умолчанию** выберите идентификатор одного из устройств, которое вы создали в сервисе Yandex IoT Core.
      1. В поле **Заголовок** введите `Устройство`.
      1. Нажмите кнопку **Добавить**.
  1. Настройте связи:
      1. Справа вверху нажмите кнопку **Связи**.
      1. В открывшемся окне в списке выберите чарт `My-pg-dataset — Карта`.
      1. В раскрывающемся списке **Вх.связь** выберите `Игнор`.

          Для карты параметр **Связи** не действует.

      1. В списке выберите чарт `My-pg-dataset — Линейная диаграмма`.
      1. В раскрывающемся списке **Вх.связь** выберите `Вх.связь`.
      1. Нажмите кнопку **Сохранить**.

  1. Нажмите кнопку **Сохранить**.
  1. В открывшемся окне введите название дашборда `MyDash`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

В результате выполнения руководства вы сможете отслеживать показания датчиков на карте и графике.

## Как удалить созданные ресурсы {#cleanup}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../iot-core/operations/device/device-delete.md) устройства в сервисе Yandex IoT Core.
1. [Удалите](../../iot-core/operations/registry/registry-delete.md) реестр в сервисе Yandex IoT Core.
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггеры для вызова функций в сервисе Cloud Functions.
1. [Удалите](../../functions/operations/function/function-delete.md) функции в сервисе Cloud Functions.
1. [Удалите](../../managed-postgresql/operations/cluster-delete.md) кластер в сервисе Managed Service for PostgreSQL.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.