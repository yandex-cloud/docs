В этом руководстве вы организуете хранение информации с устройства в базе данных кластера {{ mpg-name }}. Чтобы подключить устройство к {{ iot-full-name }}, вам понадобится MQTT-брокер. Все шаги выполняются в [консоли управления]({{ link-console-main }}).

Чтобы начать записывать информацию с устройства в базу данных:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте необходимые ресурсы {{ iot-full-name }}](#resources).
    1. [Создайте реестр](#registry).
    1. [Создайте устройство](#device).
1. [Подключите устройство к MQTT-брокеру](#connect).
1. [Подготовьте базу данных](#db).
    1. [Создайте кластер](#cluster).
    1. [Подключитесь к кластеру](#connect-to-cluster).
    1. [Создайте таблицу](#table).
1. [Создайте функцию для обработки данных](#func).
1. [Создайте триггер для {{ iot-full-name }}](#trigger).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за кластер БД {{ PG }} (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md));
* плата за обмен сообщениями между ресурсами {{ iot-name }} (см. [тарифы {{ iot-full-name }}](../../iot-core/pricing.md));
* плата за вызовы функций и вычислительные ресурсы для их выполнения (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md)).

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
    1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Введите имя сервисного аккаунта: `my-db-function-service-account`.
    1. Нажмите кнопку ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роли](../../iam/concepts/access-control/roles.md) `{{ roles-functions-invoker }}` и `{{ roles-editor }}`.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте необходимые ресурсы {{ iot-full-name }} {#resources}

{% note info %}

В руководстве используется [авторизация по логину и паролю](../../iot-core/concepts/authorization.md#log-pass), поэтому добавлять сертификат реестру и устройству не требуется. В своих проектах вы можете использовать [авторизацию с помощью сертификатов](../../iot-core/concepts/authorization.md#certs).

{% endnote %}

### Создайте реестр {#registry}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать реестр.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_create-registry }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** введите `my-registry`.
    1. Введите пароль.

        * Длина — не менее 14 символов.
        * Должен содержать букву верхнего регистра, букву нижнего регистра и цифру.

        {% note warning %}

        Сохраните пароль, так как прочитать его из {{ iot-full-name }} будет невозможно.

        {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте устройство {#device}

{% list tabs group=instructions %}

- Консоль управления {#console}

    После создания реестра вы попадете в его настройки.

    1. Перейдите на вкладку **{{ ui-key.yacloud.iot.label_devices }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-device }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** введите `my-device`.
    1. Введите пароль.

        * Длина — не менее 14 символов.
        * Должен содержать букву верхнего регистра, букву нижнего регистра и цифру.

        {% note warning %}

        Сохраните пароль, так как прочитать его из {{ iot-full-name }} будет невозможно.

        {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Подключите устройство к MQTT-брокеру {#connect}

{% include [connect-mqtt-broker](./connect-mqtt-broker.md) %}

## Подготовьте базу данных {#db}

### Создайте кластер {#cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите `my-pg-database`.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** выберите `PRODUCTION`.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите `12`.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}**:
        * Укажите платформу `{{ ui-key.yacloud.component.compute.resources.label_platform-standard-v2 }}`.
        * Выберите тип `burstable`.
        * Укажите класс `b2.medium`.

        {% note warning %}

        Класс `b2.medium` был выбран только в рамках тестирования. В реальных проектах использовать хосты с гарантированной долей vCPU ниже 100% не рекомендуется.

        {% endnote %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

        * Выберите `network-ssd`.
        * Укажите размер равным 10 ГБ.

        {% note info %}

        Тип и размер диска следует выбирать в соответствии с решаемыми задачами. Значения, указанные выше, используются для тестирования.

        {% endnote %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:

        * Имя базы данных. Имя БД должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
        * Имя пользователя — владельца БД. Имя пользователя должно содержать только латинские буквы, цифры и подчеркивания.
        * Пароль пользователя. Длина — от 8 до 128 символов.

        Для базы данных, которая создается вместе с кластером, устанавливаются настройки набора символов (кодировки) `LC_CTYPE=C` и `LC_COLLATE=C`. После создания эти настройки изменить нельзя, но вы можете [создать новую базу](../../managed-postgresql/operations/databases.md#add-db) с нужными настройками.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** нажмите ![image](../../_assets/console-icons/pencil.svg) и включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

Подробнее о создании кластера — в разделе [Как создать кластер PostgreSQL](../../managed-postgresql/operations/cluster-create.md#create-cluster).

В дальнейшем настройки кластера можно будет [изменить](../../managed-postgresql/operations/update.md).

### Подключитесь к кластеру {#connect-to-cluster}

После создания кластера вы автоматически будете перенаправлены на страницу **{{ ui-key.yacloud.mdb.clusters.label_title }}**.

Дождитесь, пока статус кластера изменится на `Alive`.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите кластер `my-pg-database`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
    1. В поле **{{ ui-key.yacloud.clickhouse.cluster.explore.label_username }}** укажите имя пользователя, который владеет БД, созданной на предыдущем шаге.
    1. В поле **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** введите пароль, указанный при создании кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.

{% endlist %}

### Создайте таблицу {#table}

В качестве примера источника данных в сценарии используется датчик воздуха, который измеряет следующие параметры:

* Влажность.
* Уровень содержания углекислого газа (CO<sub>2</sub>).
* Давление.
* Температура.

Датчик выдает результат в формате JSON. Например:

```json
{
"DeviceId":"0e3ce1d0-1504-4325-972f-55c961319814",
"TimeStamp":"2020-05-21T22:53:16Z",
"Values":[
    {"Type":"Float","Name":"Humidity","Value":"25.281837"},
    {"Type":"Float","Name":"CarbonDioxide","Value":"67.96608"},
    {"Type":"Float","Name":"Pressure","Value":"110.7021"},
    {"Type":"Float","Name":"Temperature","Value":"127.708824"}
    ]
}
```

Запишите полученную информацию в таблицу базы данных с помощью функции.

После того, как вы [подключились к кластеру](#connect-to-cluster), создайте таблицу. Для этого:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В окне редактирования введите следующий запрос:

        {% note warning %}

        Запрос ниже приведен в качестве примера. Если ваше устройство отправляет другую информацию, измените столбцы в создаваемой таблице.

        {% endnote %}

        ```sql
        CREATE TABLE iot_events (
            event_id varchar(24) not null,
            device_id varchar(50) not null,
            event_datetime timestamptz not null,
            humidity float8 null,
            carbon_dioxide float8 null,
            pressure float8 null,
            temperature float8 null
        )
        ```

    1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.

    Дождитесь появления надписи о завершении выполнения запроса.

{% endlist %}

## Создайте функцию для обработки данных {#func}

Функция будет получать сообщения из MQTT-брокера и записывать данные в таблицу, созданную на предыдущем шаге.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать функцию.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя функции.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте версию функции {#func-version}

После создания функции вы автоматически будете перенаправлены на страницу **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** выберите `python37`.
        * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** оставьте значение по умолчанию: **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.

    1. Создайте файл `myfunction.py`.
    1. В области редактирования файла вставьте код функции, размещенный на [Github](https://github.com/yandex-cloud/examples/blob/master/iot/Samples/PostgreSQL/myfunction.py).

        {% note info %}

        Запрос, который используется для записи данных в БД, формируется в методе `makeInsertStatement`. Если необходимо убрать или добавить параметры, внесите изменения в этот метод.

        {% endnote %}

    1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `myfunction.msgHandler`.
    1. Задайте следующие параметры версии:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.

    1. В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** выберите `my-db-function-service-account`.

    1. Добавьте переменные окружения:

        * `VERBOSE_LOG` — параметр, отвечающий за вывод подробной информации о выполнении функции. Введите значение `True`.
        * `DB_HOSTNAME` — имя хоста БД {{ PG }} для подключения.
        * `DB_PORT` — порт для подключения.
        * `DB_NAME` — имя базы данных для подключения.
        * `DB_USER` — имя пользователя для подключения.
        * `DB_PASSWORD` — пароль, который был введен при [создании кластера](#cluster).

        Чтобы определить значения параметров для подключения:

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали кластер.
        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
        1. Выберите кластер `my-pg-database`.
        1. В строке с нужной БД нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
        1. На вкладке **PowerShell** найдите пример строки подключения.
        1. Перенесите значения переменных `host`, `port`, `dbname` и `user` в соответствующее поле **{{ ui-key.yacloud.common.value }}** переменных окружения функции.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Создайте триггер для {{ iot-full-name }} {#trigger}

Триггер будет принимать копии сообщений из топика устройства и передавать их в функцию для обработки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать триггер.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** введите имя триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_description }}** введите описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_registry }}** введите `my-registry`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_device }}** введите `my-device`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** укажите топик, в который устройство отправляет данные:

            ```
            $devices/<device id>/events
            ```

            Где `<device id>` — идентификатор вашего устройства.

            Триггер будет срабатывать при появлении новых данных в указанном топике.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:

        * Выберите функцию для обработки данных, созданную ранее.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** укажите `$latest`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** укажите `my-db-function-service-account`.

    1. Остальные поля оставьте пустыми или заполните по своему усмотрению.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. [Удалите](../../iot-core/operations/device/device-delete.md) устройство.
1. [Удалите](../../iot-core/operations/registry/registry-delete.md) реестр.
1. [Удалите](../../managed-postgresql/operations/cluster-delete.md) кластер {{ PG }}.
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию.