[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Анализ и визуализация данных > Аналитика > Поиск событий Yandex Cloud в Query

# Поиск событий Yandex Cloud в Yandex Query


В [Yandex Query](../../query/index.md) интегрирована поддержка Audit Trails. Вы можете анализировать события ресурсов Yandex Cloud, выполняя [аналитические](../../query/concepts/batch-processing.md) и [потоковые](../../query/concepts/stream-processing.md) запросы на языке YQL.

Аналитические запросы можно выполнять для логов, которые хранятся в бакете, а потоковые — для логов в потоке данных Yandex Data Streams.

![](../../_assets/audit-trails/tutorials/audit-trails-query.png)

Чтобы подключить бакет с [аудитными логами](../../audit-trails/concepts/events.md) к Yandex Query и выполнить запросы на языке [YQL](../../query/yql-tutorials/index.md):

1. [Подготовьте окружение](#prepare-environment).
1. [Создайте соединение между трейлом и YQ](#trail-yq).
1. [Выполните запрос к логам в Object Storage](#perform-request).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за использование бакета ([тарифы Object Storage](../../storage/pricing.md)).


## Подготовьте окружение {#prepare-environment}


### Создайте бакет для аудитных логов {#create-backet}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md), например `example-folder`.
    1. Перейдите в сервис **Object Storage**.
    1. Нажмите **Создать бакет**.
    1. На странице создания бакета:
        * укажите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming);
        * в полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`;
        * для остальных параметров оставьте значения по умолчанию.
    1. Нажмите **Создать бакет**.

{% endlist %}


### Создайте сервисные аккаунты {#create-sa}

Создайте сервисный аккаунт `trail-sa`:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `example-folder`.
    1. Перейдите в сервис **Identity and Access Management**.
    1. Нажмите кнопку **Создать сервисный аккаунт**.
    1. Укажите **Имя** — `trail-sa`.
    1. Нажмите кнопку **Создать**.

{% endlist %}

Аналогично создайте сервисный аккаунт с именем `bucket-yq-sa`.


### Назначьте права сервисным аккаунтам {#grant-roles}

Назначьте сервисному аккаунту `trail-sa` роли `audit-trails.viewer` и `storage.uploader`:

{% list tabs group=instructions %}

- CLI {#cli}
  
    1. Роль `audit-trails.viewer` на организацию:

        ```bash
        yc organization-manager organization add-access-binding \
        --role audit-trails.viewer \
        --id <идентификатор_организации> \
        --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где `--service-account-id` — идентификатор сервисного аккаунта `trail-sa`.

        Результат:

        ```text
        done (1s)
        ```

        Подробнее о команде `yc organization-manager organization add-access-binding` смотрите в [справочнике CLI](../../cli/cli-ref/organization-manager/cli-ref/organization/add-access-binding.md).

    1. Роль `storage.uploader` на каталог `example-folder`:

        ```bash
        yc resource-manager folder add-access-binding example-folder \
          --role storage.uploader \
          --subject serviceAccount:<<идентификатор_сервисного_аккаунта>
        ```

        Где `--subject` — идентификатор сервисного аккаунта `trail-sa`.

        Результат:

        ```text
        done (1s)
        ```

        Подробнее о команде `yc resource-manager folder add-access-binding` смотрите в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

{% endlist %}

Назначьте сервисному аккаунту `bucket-yq-sa` роль `storage.viewer` на каталог `example-folder`:

{% list tabs group=instructions %}

- CLI {#cli}
  
    ```bash
    yc resource-manager folder add-access-binding example-folder \
        --role storage.viewer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
    ```

    Где `--subject` — идентификатор сервисного аккаунта `bucket-yq-sa`.

    Результат:

    ```text
    done (1s)
    ```

    Подробнее о команде `yc resource-manager folder add-access-binding` смотрите в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

{% endlist %}


## Создайте трейл {#create-trail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Audit Trails**.
  1. Нажмите кнопку **Создать трейл**.
  1. В поле **Имя** укажите `logsyq`.
  1. В блоке **Назначение** задайте параметры объекта назначения:
      * **Назначение** — `Object Storage`.
      * **Бакет** — выберите [созданный ранее](#create-backet) бакет.
  1. В блоке **Сервисный аккаунт** выберите `trail-sa`.
  1. В блоке **Сбор событий c уровня конфигурации** задайте параметры сбора аудитных логов уровня конфигурации:

      * **Сбор событий** — выберите `Включено`.
      * **Ресурс** — выберите `Организация`.
      * **Организация** — не требует заполнения, содержит имя текущей организации.
      * **Облако** — оставьте значение по умолчанию `Все`.

  1. В блоке **Сбор событий с уровня сервисов** в поле **Сбор событий** выберите `Выключено`.
  1. Нажмите кнопку **Создать**.

{% endlist %}


## Создайте соединение между трейлом и YQ {#trail-yq}

Соединение необходимо создать только при первом подключении трейла к YQ.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
    1. Перейдите в сервис **Audit Trails**.
    1. Выберите трейл `logsyq`.
    1. Нажмите **Обработать в YQ**.
    1. Создайте соединение:
        * выберите **Сервисный аккаунт** `bucket-yq-sa`;
        * для остальных параметров оставьте значения по умолчанию.
    1. Нажмите **Создать**.
    1. В окне с параметрами привязки к данным нажмите **Создать**.

  Вы перейдете на страницу создания запроса к логам трейла.

{% endlist %}


## Выполните запрос к логам в Object Storage {#perform-request}

Откройте страницу создания аналитического запроса к логам Audit Trails:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог с трейлом.
    1. Перейдите в сервис **Audit Trails**.
    1. Выберите трейл, для которого настроено [соединение с YQ](#trail-yq).
    1. Нажмите **Обработать в YQ**, чтобы перейти на страницу выполнения аналитического запроса.

{% endlist %}

Выполните запросы событий для привязки `audit-trails-logsyq-object_storage`:

1. Удаление каталога:

    1. Выберите в списке запрос **1. Найти, кто удалил каталог**.
    1. Отредактируйте запрос, указав идентификатор каталога:

        ```SQL
        SELECT * FROM bindings.`audit-trails-logsyq-object_storage`
        WHERE
            JSON_VALUE(data, "$.event_type") = 'yandex.cloud.audit.resourcemanager.DeleteFolder' 
            and JSON_VALUE(data, "$.details.folder_name") = '<идентификатор_каталога>' 
            LIMIT 100;
        ```

    1. Нажмите **Выполнить**.

1. Включение доступа по серийной консоли:

    1. Выберите в списке запрос **6. Изменение ВМ — добавление доступа к серийной консоли**.
    1. Отредактируйте запрос, указав количество отображаемых записей:

        ```SQL
        SELECT * FROM bindings.`<audit-trails-logsyq-object_storage>`
        WHERE
            JSON_VALUE(data, "$.event_type") = 'yandex.cloud.audit.compute.UpdateInstance' 
            and JSON_VALUE(data, "$.details.metadata_serial_port_enable") = '1' 
            LIMIT <количество_записей>;
        ```

    1. Нажмите **Выполнить**.

1. Изменение прав доступ к бакету Object Storage:

    1. Выберите в списке запрос **11. Подозрительные действия с хранилищем логов Audit Trails (Object Storage Bucket)**.
    1. Отредактируйте запрос, указав количество отображаемых записей:

        ```SQL
        SELECT * FROM bindings.`audit-trails-logsyq-object_storage`
        WHERE
            (JSON_VALUE(data, "$.event_type") = 'yandex.cloud.audit.storage.BucketAclUpdate' 
            or JSON_VALUE(data, "$.event_type") = 'yandex.cloud.audit.storage.BucketPolicyUpdate') 
            LIMIT <количество_записей>;
        ```

    1. Нажмите **Выполнить**.

1. Назначение права администратора:

    1. Выберите в списке запрос **20. Назначение прав admin (на ресурсы: folder, cloud)**.
    1. Отредактируйте запрос, указав количество отображаемых записей:

        ```SQL
        SELECT * FROM bindings.`audit-trails-logsyq-object_storage`
        WHERE
            JSON_VALUE(data, "$.details.access_binding_deltas.access_binding.role_id") = 'admin' 
            LIMIT <количество_записей>;
        ```

    1. Нажмите **Выполнить**.


## Как удалить созданные ресурсы {#clear-out}

Если для выполнения руководства вы создали отдельный бакет, вы можете [удалить его](../../storage/operations/buckets/delete.md), чтобы перестать платить за [использование бакета](../../storage/pricing.md).