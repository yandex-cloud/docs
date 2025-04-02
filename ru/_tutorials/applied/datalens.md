# Мониторинг состояния географически распределенных устройств


В этом руководстве вы настроите мониторинг состояния устройств (например, вендинговых автоматов), подключенных к сервису [{{ iot-full-name }}](../../iot-core/index.yaml) и расположенных в разных точках города. Вы сможете наблюдать за состоянием автоматов на карте и графиках сервиса [{{ datalens-full-name }}](../../datalens/index.yaml). Датчики будут эмулированы с помощью сервиса [{{ sf-full-name }}](../../functions/index.yaml). Если у вас есть подключенные датчики, используйте их. Для хранения данных будет использован сервис [{{ mpg-full-name }}](../../managed-postgresql/index.yaml).

Исходный код руководства доступен в репозитории на [GitHub](https://github.com/yandex-cloud-examples/yc-geo-dist-devices-iot-monitoring).

Чтобы настроить мониторинг показаний датчиков:
1. [Подготовьте облако к работе](#configure-cloud).
1. [Создайте кластер {{ mpg-name }}](#postgresql-step).
1. [Создайте необходимые ресурсы {{ iot-name }}](#resources-step).
1. [Создайте эмулятор устройств в {{ sf-name }}](#emulator-step).
1. [Создайте функцию обработки данных в {{ sf-name }}](#processing-function-step).
1. [Настройте мониторинг в {{ datalens-name }}](#configure-datalens).

Если созданные ресурсы вам больше не нужны, [удалите их](#cleanup).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:
* плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за количество [сообщений](../../message-queue/concepts/message.md) (см. [тарифы {{ iot-full-name }}](../../iot-core/pricing.md));
* плата за количество вызовов [функции](../../functions/concepts/function.md) {{ sf-name }} (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за вычислительные ресурсы и хранилище [кластера](../../managed-postgresql/concepts/index.md) {{ mpg-name }} (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md)).

## Подготовьте облако к работе {#configure-cloud}

* [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `my-emulator-function-service-account` для отправки данных. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `{{ roles-functions-invoker }}`, `iot.devices.writer` и `{{ roles-viewer }}`.
* Создайте сервисный аккаунт `my-db-function-service-account` для обработки данных. Назначьте ему роли `{{ roles-functions-invoker }}` и `{{ roles-editor }}`.
* [Создайте](../../vpc/operations/network-create.md) облачную сеть и хотя бы одну [подсеть](../../vpc/operations/subnet-create.md) в зоне доступности `{{ region-id }}-a`, `{{ region-id }}-b` или `{{ region-id }}-d`.
* [Создайте](../../vpc/operations/security-group-create.md) группу безопасности `my-pg-sg` и [добавьте](../../vpc/operations/security-group-add-rule.md) правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

## Создайте кластер в {{ mpg-name }} {#postgresql-step}

В примере используются минимальные значения параметров [хоста](../../managed-postgresql/concepts/instance-types.md). Для реальных задач рекомендуется выбирать хосты с гарантированной долей vCPU 100%.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Укажите имя кластера, например `my-pg-database`.
  1. В списке **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** выберите `PRODUCTION`.
  1. В списке **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите `15`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** укажите:

      * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** — `{{ ui-key.yacloud.mdb.forms.resource_presets_field_gen_v3 }}`.
      * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** — `standard`.
      * Класс — `{{ s3-c2-m8 }}`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Выберите `network-hdd`.
      * Укажите размер `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `user1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — задайте пароль доступа к БД.

          {% include [password-save](../../_includes/iot-core/password-save.md) %}

      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-collate }}** — `C`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-ctype }}** — `C`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:

      1. Выберите облачную сеть, в которой создана группа безопасности `my-pg-sg`.
      1. Выберите группу безопасности `my-pg-sg`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:

      1. Оставьте один хост.
      1. Нажмите значок ![image](../../_assets/console-icons/pencil.svg).
      1. В открывшемся окне включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** и нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** включите опции **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** и **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

  Создание кластера может занять несколько минут.

{% endlist %}

## Создайте необходимые ресурсы {{ iot-name }} {#resources-step}

[Реестр](../../iot-core/concepts/index.md#registry) и [устройство](../../iot-core/concepts/index.md#device) — основные компоненты сервиса {{ iot-name }} для обмена данными и командами. Чтобы устройства могли обмениваться данными, их необходимо создавать в одном реестре.

### Создайте реестр и настройте авторизацию по логину и паролю {#registry-step}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_create-registry }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя реестра. Например, `my-registry`.
  1. В поле **{{ ui-key.yacloud.common.password }}** задайте пароль доступа к реестру. Пароль должен быть длиной не менее 14 символов, должен содержать строчные буквы, заглавные буквы и цифры. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% include [iot-authorization](../_tutorials_includes/iot-authorization.md) %}

### Создайте устройства и настройте авторизацию по логину и паролю {#device-step}

Создайте три устройства: `my-device-1`, `my-device-2` и `my-device-3`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Выберите реестр, созданный на предыдущем шаге.
  1. В меню слева выберите **{{ ui-key.yacloud.iot.label_devices }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-device }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя устройства `my-device-1`.
  1. В поле **{{ ui-key.yacloud.common.password }}** задайте пароль доступа к устройству. Пароль должен быть длиной не менее 14 символов, должен содержать строчные буквы, заглавные буквы и цифры. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. (Опционально) Добавьте алиас:

      1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Заполните поля: введите алиас (например `events`) и тип [топика](../../iot-core/concepts/topic/index.md) после `$devices/{id}` (например, `events`).

          В результате вместо топика `$devices/<идентификатор_устройства>/events` вы сможете использовать алиас `events`.

      1. Повторите действия для каждого добавляемого алиаса.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Аналогичным образом создайте устройства `my-device-2` и `my-device-3`.

{% endlist %}

{% include [iot-authorization](../_tutorials_includes/iot-authorization.md) %}

## Создайте эмулятор устройств в {{ sf-name }} {#emulator-step}

Эмулятор отправит данные с устройств в кластер {{ mpg-name }}.

Чтобы запустить эмулятор, создайте [функцию](../../functions/concepts/function.md) эмуляции отправки данных с датчиков устройств и [триггер](../../functions/concepts/trigger/index.md) для вызова этой функции с периодичностью один раз в минуту.

### Создайте функцию эмуляции отправки данных с устройства {#emulation_function}

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

      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `device-emulator.handler`.

      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `my-emulator-function-service-account`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

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
              `REGISTRY_ID`               | Идентификатор реестра, который вы создали   | См. в [консоли управления]({{ link-console-main }})<br>сервиса {{ iot-name }}

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Протестируйте функцию эмуляции {#test-emulation-function}

1. (Опционально) Чтобы получать подробную информацию с датчиков, [подпишите](../../iot-core/operations/subscribe.md#one-device) реестр на [топик](../../iot-core/concepts/topic/index.md) устройства {{ iot-name }}.

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Выберите функцию `my-device-emulator-function`.
      1. В меню слева выберите **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
      1. В списке **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** выберите `$latest` — последнюю созданную версию функции.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

          При успешном выполнении функции в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** отобразится статус **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}**, и в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** появится результат:

          ```json
          {
            "statusCode" : 200
          }
          ```

          Если перед выполнением тестирования вы подписались на топик устройства {{ iot-name }}, в терминале вы получите объект JSON вида:

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

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** введите имя триггера. Например, `my-emulator-function-trigger`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** выберите `{{ ui-key.yacloud_billing.common.button_cron-1min }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** укажите параметры функции:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** — `my-device-emulator-function`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** — `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** — `my-emulator-function-service-account`.

  1. (Опционально) В блоках **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** и **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** задайте параметры, которые позволят не потерять данные в случае сбоя:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** позволяют перенаправлять сообщения, которые триггер отправляет в функцию.

          В качестве очереди [Dead Letter Queue](../../message-queue/concepts/dlq.md) вы можете использовать [стандартную очередь](../../message-queue/concepts/queue.md#standard-queues) сообщений. Если у вас нет очереди сообщений, [создайте ее в сервисе {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

## Создайте функцию обработки данных в {{ sf-name }} {#processing-function-step}

Создайте функцию обработки данных, протестируйте ее и посмотрите результат обработки данных. Затем создайте триггер для вызова функции и посмотрите результат его работы.

### Создайте функцию обработки принимаемых данных {#processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
  1. Создайте функцию:

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** введите имя функции. Например, `my-db-function`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Создайте версию функции:

      1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `Python 3.12`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**:

          * Имя файла — `myfunction.py`.
          * Содержимое файла — код функции с [GitHub](https://github.com/yc-geo-dist-devices-iot-monitoring/blob/main/myfunction.py).

      1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `myfunction.msgHandler`.
      1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `my-db-function-service-account`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              Ключ | Описание | Значение
              :--- | :--- | :---
              `VERBOSE_LOG` | Включение и отключение записи данных | `True`
              `DB_HOSTNAME` | FQDN хоста в {{ mpg-name }} | См. в [консоли управления]({{ link-console-main }})<br>сервиса {{ mpg-name }}
              `DB_PORT`     | Порт подключения к кластеру в {{ mpg-name }} | `6432`
              `DB_NAME`     | Имя кластера в {{ mpg-name }} | `db1`
              `DB_USER`     | Имя пользователя для подключения к кластеру в {{ mpg-name }} | `user1`
              `DB_PASSWORD` | Пароль подключения к БД в {{ mpg-name }} | Пароль, который вы задали в {{ mpg-name }}

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Протестируйте функцию обработки данных {#test-processing-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `my-db-function`.
  1. В меню слева выберите **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В списке **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** выберите `$latest` — последнюю созданную версию функции.
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
            "payload": "ewogICAgICAgICAgICAiRGV2aWNlSWQiOiJhcmU1NzBrZTA1N29pcjg1bDlmciIsCiAgICAgICAgICAgICJUaW1lU3RhbXAiOiIyMDIwLTA2LTExVDExOjA3OjIwWiIsCiAgICAgICAgICAgICJWYWx1ZXMiOlsKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkJvb2wiLCJOYW1lIjoiU2VydmljZSBkb29yIHNlbnNvciIsIlZhbHVlIjoiRmFsc2UifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IlBvd2VyIFZvbHRhZ2UiLCJWYWx1ZSI6IjI1LjA2In0sCiAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsIk5hbWUiOiJUZW1wZXJhdHVyZSIsIlZhbHVlIjoiMTEuMjEifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IkNhc2ggZHJhd2VyIGZ1bGxuZXNzIiwiVmFsdWUiOiI2Ny44OSJ9LAogICAgICAgICAgICAgICAgeyJJdGVtcyI6WwogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiMSIsIk5hbWUiOiJJdGVtIDEiLCJGdWxsbmVzcyI6IjUwLjY1In0sCiAgICAgICAgICAgICAgICAgICAgeyJUeXBlIjoiRmxvYXQiLCAiSWQiOiIyIiwiTmFtZSI6Ikl0ZW0gMiIsIkZ1bGxuZXNzIjoiODAuOTcifSwKICAgICAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsICJJZCI6IjMiLCJOYW1lIjoiSXRlbSAzIiwiRnVsbG5lc3MiOiIzMC4zMyJ9LAogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiNCIsIk5hbWUiOiJJdGVtIDQiLCJGdWxsbmVzcyI6IjE1LjE1In0KICAgICAgICAgICAgICAgIF19CiAgICAgICAgICAgICAgICBdCiAgICAgICAgICAgIH0="
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

### Просмотрите результат обработки данных в {{ mpg-name }} {#processing-function-results}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите кластер `my-pg-database`.
  1. В меню слева выберите **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
  1. В поле **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** введите пароль, который вы задали для доступа к БД, и нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
  1. Выберите папку `public`.
  1. Посмотрите результаты обработки данных в таблицах `iot_events` и `iot_position`.

{% endlist %}

### Создайте триггер для вызова функции обработки данных {#processing-function-trigger}

Триггер вызовет функцию, когда в [топике устройства](../../iot-core/concepts/topic/devices-topic.md) появятся сообщения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** введите имя триггера. Например, `my-db-func-trigger`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}** укажите параметры реестра и устройства:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_registry }}** — `my-registry`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_device }}** — `Любое устройство`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** — `$devices/#`.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** укажите параметры функции:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** — `my-db-function`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** — `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** — `my-db-function-service-account`.

  1. (Опционально) В блоках **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** и **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** задайте параметры, которые позволят не потерять данные в случае сбоя:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** позволяют повторно вызывать функцию, если текущий вызов функции завершается с ошибкой.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** позволяют перенаправлять сообщения, которые триггер отправляет в функцию.

          В качестве очереди Dead Letter Queue вы можете использовать стандартную очередь сообщений. Если у вас нет очереди сообщений, [создайте ее в сервисе {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

### Просмотрите результат работы триггера в {{ mpg-name }} {#processing-function-trigger-results}

Через некоторое время после создания триггера вы можете проверить, как он работает.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите кластер `my-pg-database`.
  1. В меню слева выберите **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
  1. В поле **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** укажите пароль, который вы задали для доступа к БД, и нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
  1. Выберите папку `public`.
  1. Посмотрите изменения в таблице `iot_events`.

{% endlist %}

## Настройте мониторинг в {{ datalens-name }} {#configure-datalens}

Чтобы наблюдать за состоянием устройств, настройте [подключение](../../datalens/concepts/connection.md), создайте [датасет](../../datalens/dataset/index.md), [чарты](../../datalens/concepts/chart/index.md) и [дашборд](../../datalens/concepts/dashboard.md).

### Настройте подключение к {{ mpg-name }} {#connect-mpg}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
  1. Нажмите кнопку **Создать подключение**.
  1. Выберите коннектор **{{ PG }}**.

      При подключении к внешнему источнику данных (который не является ресурсом {{ yandex-cloud }}) предоставьте доступ к источнику [для диапазонов IP-адресов сервиса {{ datalens-name }}](../../datalens/concepts/connection.md#changing-connection-ranges).

  1. Выберите облако и каталог.
  1. Выберите кластер `my-pg-database` и хост.
  1. В поле **Порт** укажите `6432`.
  1. Выберите базу данных `db1` и пользователя `user1`.
  1. В поле **Пароль** укажите пароль, который вы задали для доступа к БД в сервисе {{ mpg-name }}.
  1. Нажмите кнопку **Создать подключение**.
  1. В открывшемся окне укажите имя подключения `MyPGConnection` и нажмите кнопку **Создать**.

{% endlist %}

### Создайте датасет {#create-dataset}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
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

- Интерфейс {{ datalens-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
  1. Нажмите кнопку **Создать чарт**.
  1. На панели слева нажмите кнопку ![image](../../_assets/console-icons/circles-intersection.svg) **Выберите датасет** и выберите датасет `My-pg-dataset`, который вы создали ранее.
  1. Выберите [тип чарта](../../datalens/visualization-ref/line-chart.md) **Линейная диаграмма**.
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

- Интерфейс {{ datalens-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
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
      1. Выберите [тип чарта](../../datalens/visualization-ref/map-chart.md) `Карта`.
      1. Из блока **Измерения** в меню слева перетащите измерения в блок **Карта**:
          * `Position` в секцию **Геоточки**.
          * `item1_fullness`, `item2_fullness`, `item3_fullness`, `item4_fullness` и `cash_drawer` в секцию **Тултипы**.

              В правой части окна отобразится масштабируемая карта, на которой вендинговые автоматы отмечены точками на карте, а тултипы при наведении указателя на точки — строками легенды.
      1. Нажмите кнопку **Сохранить**.
      1. В открывшемся окне укажите имя чарта или используйте сгенерированное имя `My-pg-dataset — Карта` и нажмите **Сохранить**.

{% endlist %}

### Создайте дашборд {#create-dashboard}

{% list tabs group=instructions %}

- Интерфейс {{ datalens-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
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
      1. В списке **Значение по умолчанию** выберите идентификатор одного из устройств, которое вы создали в сервисе {{ iot-name }}.
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

1. [Удалите](../../iot-core/operations/device/device-delete.md) устройства в сервисе {{ iot-name }}.
1. [Удалите](../../iot-core/operations/registry/registry-delete.md) реестр в сервисе {{ iot-name }}.
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггеры для вызова функций в сервисе {{ sf-name }}.
1. [Удалите](../../functions/operations/function/function-delete.md) функции в сервисе {{ sf-name }}.
1. [Удалите](../../managed-postgresql/operations/cluster-delete.md) кластер в сервисе {{ mpg-name }}.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.