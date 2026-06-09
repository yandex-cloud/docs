# Загрузка логов из Yandex Audit Trails в OpenSearch

[Audit Trails](../../audit-trails/index.md) — сервис сбора и выгрузки аудитных логов, который позволяет применять инструменты анализа и оперативного реагирования к событиям на уровне ресурсов Yandex Cloud. [OpenSearch](../../managed-opensearch/index.md) выступает в роли SIEM-системы для анализа логов и реагирования на события безопасности.

Мы покажем, как всего за несколько шагов настроить выгрузку логов из Audit Trails, используя сервисы [Yandex Data Streams](../../data-streams/index.md) и [Yandex Data Transfer](../index.md) и выбрав Yandex Managed Service for OpenSearch в качестве SIEM-системы для анализа логов и реагирования на события безопасности.

# Загрузка аудитных логов в Yandex Managed Service for OpenSearch


Создайте трейл, который будет загружать [аудитные логи](../../audit-trails/concepts/format.md) ресурсов Yandex Cloud в поток данных [Yandex Data Streams](../../data-streams/index.md). Затем настройте непрерывную доставку логов в кластер Yandex Managed Service for OpenSearch с помощью Yandex Data Transfer.

![audit-opensearch-schema](../../_assets/mdb/audit-opensearch-schema.svg)

Вы можете выгружать логи организации, облака или каталога.

Чтобы экспортировать аудитные логи:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте трейл, который отправляет логи в поток данных Data Streams](#create-trail).
1. [Создайте кластер Managed Service for OpenSearch](#create-os).
1. [Настройте трансфер для доставки логов в кластер Managed Service for OpenSearch](#configure-data-transfer).
1. [Проверьте результат](#check-result).
1. [Загрузите дополнительный контент](#additional-content).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for OpenSearch](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Сервис Data Streams (см. [тарифы Data Streams](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* База данных Managed Service for YDB, работающая в бессерверном режиме: операции с данными, объем хранимых данных и резервных копий (см. [тарифы Managed Service for YDB](../../ydb/pricing/index.md)).

## Создайте трейл, который отправляет логи в поток данных Data Streams {#create-trail}

[Создайте трейл](../../audit-trails/operations/create-trail.md), который отправляет логи в поток данных с именем `audit‑trails`. Использование потока с таким именем позволяет упростить загрузку объектов библиотеки [Security Content](#additional-content).

При создании трейла выберите нужную [область сбора логов](../../audit-trails/concepts/trail.md#collecting-area).

## Создайте кластер Managed Service for OpenSearch {#create-os}

{% list tabs group=instructions %}

- Вручную {#manual}

  [Создайте кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации.

- С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [trails-to-opensearch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-audit-trails-to-opensearch/blob/main/trails-to-opensearch.tf).

       В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch;
        * кластер-приемник Managed Service for OpenSearch;
        * трансфер.

    1. Укажите в файле `trails-to-opensearch.tf` переменные:

        * `os_version` — версия OpenSearch в кластере-приемнике;
        * `os_admin_password` — пароль пользователя `admin`;
        * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

       Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте необходимую инфраструктуру:

       1. Выполните команду для просмотра планируемых изменений:
       
          ```bash
          terraform plan
          ```
       
          Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
       
       1. Если вас устраивают планируемые изменения, внесите их:
          1. Выполните команду:
       
             ```bash
             terraform apply
             ```
       
          1. Подтвердите изменение ресурсов.
          1. Дождитесь завершения операции.

       В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Настройте трансфер для доставки логов в кластер Managed Service for OpenSearch {#configure-data-transfer}

1. [Создайте эндпоинт для источника](../operations/endpoint/source/data-streams.md):

    * **Тип базы данных** — `Yandex Data Streams`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **База данных** — выберите базу данных Managed Service for YDB из списка.
            * **Поток** — укажите имя потока Data Streams.
            * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **Расширенные настройки**:

            * **Правила конвертации** — `Парсер AuditTrails.v1`.

1. [Создайте эндпоинт для приемника](../operations/endpoint/target/opensearch.md):

    * **Тип базы данных** — `OpenSearch`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **Тип подключения** — `Кластер Managed Service for OpenSearch`.

                * **Кластер Managed Service for OpenSearch** — выберите кластер-приемник из списка.

            * **Пользователь** и **Пароль** — укажите имя и пароль пользователя с доступом к базе, например, [пользователя `admin`](../../managed-opensearch/operations/cluster-users.md).

1. Создайте и активируйте трансфер:

   {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../operations/transfer.md#create) типа **Репликация**, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **Реплицируется**.

    - С помощью Terraform {#tf}

        1. Укажите в файле `trails-to-opensearch.tf` переменные:

            * `source_endpoint_id` — идентификатор эндпоинта для источника;
            * `target_endpoint_id` — идентификатор эндпоинта для приемника;
            * `transfer_enabled` — значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

           1. Выполните команду для просмотра планируемых изменений:
           
              ```bash
              terraform plan
              ```
           
              Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
           
           1. Если вас устраивают планируемые изменения, внесите их:
              1. Выполните команду:
           
                 ```bash
                 terraform apply
                 ```
           
              1. Подтвердите изменение ресурсов.
              1. Дождитесь завершения операции.

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус **Реплицируется**.

   {% endlist %}

## Проверьте результат {#check-result}

Убедитесь, что данные из Audit Trails успешно загружаются в OpenSearch:

1. Дождитесь перехода трансфера в статус **Реплицируется**.
1. Подключитесь к кластеру-приемнику с помощью [OpenSearch Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
1. Выберите общий тенант `Global`.
1. Создайте новый шаблон индекса с именем `audit-trails*`:

    1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
    1. В разделе **Management** выберите **Stack Management**.
    1. Перейдите в раздел **Index Patterns** и внизу страницы нажмите на ссылку **create an index pattern**.
    1. В поле **Index pattern name** укажите `audit-trails*` и нажмите кнопку **Next step**.
    1. В поле **Time field** выберите `application_usage_daily.timestamp` и нажмите кнопку **Create index pattern**.

1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
1. В разделе **OpenSearch Dashboards** выберите **Discover**.
1. В открывшемся дашборде должны появиться данные из Audit Trails в формате [Elastic Common Schema](https://www.elastic.co/guide/en/ecs/current/ecs-reference.html).

![opensearch-discover](../../_assets/mdb/opensearch-discover.png)

{% note warning %}

Поставка данных в приемники Managed Service for Elasticsearch и Managed Service for OpenSearch работает в режиме `at least once`: если в переносимых таблицах нет первичного ключа, то в аудитных логах могут создаваться дубликаты.

{% endnote %}

## Загрузите дополнительный контент {#additional-content}

Для удобства пользователей команда безопасности Yandex Cloud подготовила библиотеку Solution Library — набор примеров и рекомендаций по построению безопасной инфраструктуры в Yandex Cloud. Библиотека доступна в [публичном репозитории на GitHub](https://github.com/yandex-cloud-examples/yc-security-solutions-library). Она включает следующие объекты для загрузки в OpenSearch:

* дашборд с вариантами использования и статистикой;
* набор готовых запросов для поиска событий безопасности;
* примеры событий, на которые предварительно настроены оповещения (назначение уведомлений клиент указывает самостоятельно).

Все необходимые поля событий преобразованы в формат [Elastic Common Schema (ECS)](https://www.elastic.co/guide/en/ecs/current/index.html), а полная таблица маппинга находится в [документе Yandex Cloud Security Solution Library](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-elk/blob/main/papers/Описание%20объектов.pdf).

Чтобы воспользоваться Security Content:

1. Клонируйте репозиторий Yandex Cloud Security Solution Library:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-opensearch.git
    ```

1. Подключитесь к кластеру-приемнику с помощью [OpenSearch Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
1. В разделе **Management** выберите **Stack Management**.
1. Перейдите в раздел **Saved Objects** и импортируйте файлы из каталога `yc-export-auditlogs-to-opensearch/update-opensearch-scheme/content-for-transfer/`:

    * `dashboard.ndjson`
    * `filters.ndjson`
    * `search.ndjson`

### Дашборд {#dashboard}

Воспользуйтесь подготовленным дашбордом `Audit-trails-dashboard`:

1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
1. В разделе **OpenSearch Dashboards** выберите **Dashboard**.
1. В списке дашбордов выберите `Audit-trails-dashboard`.

![opensearch-audit-trails-dashboard](../../_assets/mdb/opensearch-audit-trails-dashboard.png)

### События безопасности {#discover}

Используйте подготовленный запрос для просмотра событий безопасности, которые можно отбирать с помощью фильтров.

1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
1. В разделе **OpenSearch Dashboards** выберите **Discover**.
1. На вкладке **Open** выберите запрос `Search:Yandexcloud: Yandexcloud: Interesting fields`.

![opensearch-search-yandexcloud-interesting-fields](../../_assets/mdb/opensearch-search-yandexcloud-interesting-fields.png)

### Настройка алертов {#alerts}

Используйте примеры кода для сущностей `monitor` и `trigger` при настройке [алертов](https://opensearch.org/docs/latest/monitoring-plugins/alerting/index/):

1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
1. В разделе **OpenSearch Plugins** выберите **Alerting**.
1. Скопируйте содержимое файлов примеров в окно создания:

    * [monitor.json](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-opensearch/blob/main/update-opensearch-scheme/content-for-transfer/monitor.json)
    * [trigger_action_example.json](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-opensearch/blob/main/update-opensearch-scheme/content-for-transfer/trigger_action_example.json)

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../operations/transfer.md#delete).
1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.
1. [Удалите базу данных Managed Service for YDB](../../ydb/operations/manage-databases.md#delete-db).
1. [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).
1. Удалите [трейл Audit Trails](../../audit-trails/concepts/trail.md).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       [Удалите кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-delete.md).

   - С помощью Terraform {#tf}

       1. В терминале перейдите в директорию с планом инфраструктуры.
       
           {% note warning %}
       
           Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
       
           {% endnote %}
       
       1. Удалите ресурсы:
       
           1. Выполните команду:
       
               ```bash
               terraform destroy
               ```
       
           1. Подтвердите удаление ресурсов и дождитесь завершения операции.
       
           Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

   {% endlist %}


## Дополнительные материалы {#video}

Больше информации о сценариях поставок данных в вебинаре Yandex Cloud:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvkntkhjbfsn2c7ptv?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=bzWmmPp6KFg).