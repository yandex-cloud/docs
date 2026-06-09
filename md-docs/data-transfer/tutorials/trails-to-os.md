# Загрузка логов из {{ at-full-name }} в {{ OS }}

[{{ at-name }}](../../audit-trails/index.md) — сервис сбора и выгрузки аудитных логов, который позволяет применять инструменты анализа и оперативного реагирования к событиям на уровне ресурсов {{ yandex-cloud }}. [OpenSearch](../../managed-opensearch/index.md) выступает в роли SIEM-системы для анализа логов и реагирования на события безопасности.

Мы покажем, как всего за несколько шагов настроить выгрузку логов из {{ at-name }}, используя сервисы [{{ yds-full-name }}](../../data-streams/index.md) и [{{ data-transfer-full-name }}](../index.md) и выбрав {{ mos-full-name }} в качестве SIEM-системы для анализа логов и реагирования на события безопасности.

# Загрузка аудитных логов в {{ mos-full-name }}


Создайте трейл, который будет загружать [аудитные логи](../../audit-trails/concepts/format.md) ресурсов {{ yandex-cloud }} в поток данных [{{ yds-full-name }}](../../data-streams/index.md). Затем настройте непрерывную доставку логов в кластер {{ mos-full-name }} с помощью {{ data-transfer-full-name }}.

![audit-opensearch-schema](../../_assets/mdb/audit-opensearch-schema.svg)

Вы можете выгружать логи организации, облака или каталога.

Чтобы экспортировать аудитные логи:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте трейл, который отправляет логи в поток данных {{ yds-name }}](#create-trail).
1. [Создайте кластер {{ mos-name }}](#create-os).
1. [Настройте трансфер для доставки логов в кластер {{ mos-name }}](#configure-data-transfer).
1. [Проверьте результат](#check-result).
1. [Загрузите дополнительный контент](#additional-content).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mos-name }}: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mos-name }}](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Сервис {{ yds-name }} (см. [тарифы {{ yds-name }}](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* База данных {{ ydb-name }}, работающая в бессерверном режиме: операции с данными, объем хранимых данных и резервных копий (см. [тарифы {{ ydb-name }}](../../ydb/pricing/index.md)).

## Создайте трейл, который отправляет логи в поток данных {{ yds-name }} {#create-trail}

[Создайте трейл](../../audit-trails/operations/create-trail.md), который отправляет логи в поток данных с именем `audit‑trails`. Использование потока с таким именем позволяет упростить загрузку объектов библиотеки [Security Content](#additional-content).

При создании трейла выберите нужную [область сбора логов](../../audit-trails/concepts/trail.md#collecting-area).

## Создайте кластер {{ mos-name }} {#create-os}

{% list tabs group=instructions %}

- Вручную {#manual}

  [Создайте кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации.

- С помощью {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [trails-to-opensearch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-audit-trails-to-opensearch/blob/main/trails-to-opensearch.tf).

       В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mos-name }};
        * кластер-приемник {{ mos-name }};
        * трансфер.

    1. Укажите в файле `trails-to-opensearch.tf` переменные:

        * `os_version` — версия {{ OS }} в кластере-приемнике;
        * `os_admin_password` — пароль пользователя `admin`;
        * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

       В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Настройте трансфер для доставки логов в кластер {{ mos-name }} {#configure-data-transfer}

1. [Создайте эндпоинт для источника](../operations/endpoint/source/data-streams.md):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ yds-full-name }}`.
    * **Параметры эндпоинта**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-name }} из списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока {{ yds-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_audit_trails_v1.title }}`.

1. [Создайте эндпоинт для приемника](../operations/endpoint/target/opensearch.md):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ OS }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер-приемник из списка.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — укажите имя и пароль пользователя с доступом к базе, например, [пользователя `admin`](../../managed-opensearch/operations/cluster-users.md).

1. Создайте и активируйте трансфер:

   {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - С помощью {{ TF }} {#tf}

        1. Укажите в файле `trails-to-opensearch.tf` переменные:

            * `source_endpoint_id` — идентификатор эндпоинта для источника;
            * `target_endpoint_id` — идентификатор эндпоинта для приемника;
            * `transfer_enabled` — значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

   {% endlist %}

## Проверьте результат {#check-result}

Убедитесь, что данные из {{ at-name }} успешно загружаются в {{ OS }}:

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. Подключитесь к кластеру-приемнику с помощью [{{ OS }} Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
1. Выберите общий тенант `Global`.
1. Создайте новый шаблон индекса с именем `audit-trails*`:

    1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
    1. В разделе **Management** выберите **Stack Management**.
    1. Перейдите в раздел **Index Patterns** и внизу страницы нажмите на ссылку **create an index pattern**.
    1. В поле **Index pattern name** укажите `audit-trails*` и нажмите кнопку **Next step**.
    1. В поле **Time field** выберите `application_usage_daily.timestamp` и нажмите кнопку **Create index pattern**.

1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
1. В разделе **OpenSearch Dashboards** выберите **Discover**.
1. В открывшемся дашборде должны появиться данные из {{ at-name }} в формате [Elastic Common Schema]({{ links.es.docs }}/ecs/current/ecs-reference.html).

![opensearch-discover](../../_assets/mdb/opensearch-discover.png)

{% note warning %}

Поставка данных в приемники {{ mes-short-name }} и {{ mos-short-name }} работает в режиме `at least once`: если в переносимых таблицах нет первичного ключа, то в аудитных логах могут создаваться дубликаты.

{% endnote %}

## Загрузите дополнительный контент {#additional-content}

Для удобства пользователей команда безопасности {{ yandex-cloud }} подготовила библиотеку Solution Library — набор примеров и рекомендаций по построению безопасной инфраструктуры в {{ yandex-cloud }}. Библиотека доступна в [публичном репозитории на GitHub](https://github.com/yandex-cloud-examples/yc-security-solutions-library). Она включает следующие объекты для загрузки в {{ OS }}:

* дашборд с вариантами использования и статистикой;
* набор готовых запросов для поиска событий безопасности;
* примеры событий, на которые предварительно настроены оповещения (назначение уведомлений клиент указывает самостоятельно).

Все необходимые поля событий преобразованы в формат [Elastic Common Schema (ECS)]({{ links.es.docs }}/ecs/current/index.html), а полная таблица маппинга находится в [документе {{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-elk/blob/main/papers/Описание%20объектов.pdf).

Чтобы воспользоваться Security Content:

1. Клонируйте репозиторий {{ yandex-cloud }} Security Solution Library:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-opensearch.git
    ```

1. Подключитесь к кластеру-приемнику с помощью [{{ OS }} Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
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

Используйте примеры кода для сущностей `monitor` и `trigger` при настройке [алертов]({{ os.docs }}/monitoring-plugins/alerting/index/):

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
1. [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).
1. [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).
1. Удалите [трейл {{ at-name }}](../../audit-trails/concepts/trail.md).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       [Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

   - С помощью {{ TF }} {#tf}

       1. В терминале перейдите в директорию с планом инфраструктуры.
       
           {% note warning %}
       
           Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
       
           {% endnote %}
       
       1. Удалите ресурсы:
       
           1. Выполните команду:
       
               ```bash
               terraform destroy
               ```
       
           1. Подтвердите удаление ресурсов и дождитесь завершения операции.
       
           Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

   {% endlist %}


## Дополнительные материалы {#video}

Больше информации о сценариях поставок данных в вебинаре {{ yandex-cloud }}:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvkntkhjbfsn2c7ptv?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=bzWmmPp6KFg).