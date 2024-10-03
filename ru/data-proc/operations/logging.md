# Работа с логами

Собирает и отображает логи кластера {{ dataproc-name }} сервис [{{ cloud-logging-full-name }}](../../logging). 

Чтобы следить за событиями кластера и отдельных его хостов, укажите в его настройках нужную [лог-группу](../../logging/concepts/log-group.md). Это можно сделать при [создании](cluster-create.md) или [изменении](cluster-update.md) кластера. Если для кластера не выбрана лог-группа, то для отправки и хранения логов будет использована лог-группа по умолчанию в каталоге кластера.

Подробнее см. в разделе [Логи](../concepts/logs.md).

## Просмотр записей логов {#logging-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера.
    1. В разделе **{{ ui-key.yacloud.mdb.cluster.overview.section_configuration }}** нажмите на имя лог-группы кластера. Откроется страница сервиса {{ cloud-logging-name }}.
    1. Нажмите на строку лог-группы. Откроются логи кластера.
    1. (Опционально) Укажите настройки вывода:
        * [фильтр сообщений](../concepts/logs.md):
           * Получение вывода запуска задания {{ dataproc-name }}:

             ```ini
             job_id="<идентификатор_задания>"
             ```

           * Получение stdout-вывода всех контейнеров YARN приложения:

             ```ini
             application_id="<идентификатор_YARN-приложения>" AND yarn_log_type="stdout"
             ```

           * Получение stderr-вывода YARN контейнера:

             ```ini
             container_id="<идентификатор_YARN-контейнера>" AND yarn_log_type="stderr"
             ```

           * Получение записей логов сервиса YARN Resource Manager с хоста-мастера кластера:

             ```ini
             hostname="<FQDN_хоста-мастера>" AND log_type="hadoop-yarn-resourcemanager"
             ```

        * интересующие уровни сообщений: от `TRACE` до `FATAL`;
        * количество сообщений на странице;
        * интервал сообщений (один из стандартных или произвольный).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Посмотрите описание команды CLI для получения логов:

    ```bash
    yc logging read --help
    ```

  Примеры:

    * Чтобы получить логи сервиса HDFS NameNode кластера {{ dataproc-name }}, выполните команду:

      ```bash
      yc logging read \
         --group-id=<идентификатор_лог-группы> \
         --resource-ids=<идентификатор_кластера> \
         --filter=log_type=hadoop-hdfs-namenode
      ```

    * Чтобы получить логи за последние два часа от всех кластеров {{ dataproc-name }}, связанных с определенной лог-группой, выполните команду:

      ```bash
      yc logging read \
         --group-id=<идентификатор_лог-группы> \
         --resource-types=dataproc.cluster \
         --since=2h
      ```

    * Чтобы получить системный лог кластера за определенный промежуток времени, выполните команду:

      ```bash
      yc logging read \
         --group-id <идентификатор_лог-группы> \
         --resource-ids=<идентификатор_кластера> \
         --filter 'syslog' \
         --since 'YYYY-MM-DDThh:mm:ssZ' \
         --until 'YYYY-MM-DDThh:mm:ssZ'
      ```

      В параметрах `--since` и `--until` укажите границы периода, за который надо запросить лог. Формат времени: `YYYY-MM-DDThh:mm:ssZ`. Пример: `2020-08-10T12:00:00Z`. Время указывается в часовом поясе UTC.

    * Чтобы получить лог по отправке метрик определенного хоста в сервис [{{ monitoring-full-name }}](../../monitoring/index.yaml), выполните команду:

      ```bash
      yc logging read \
         --group-id <идентификатор_лог-группы> \
         --resource-ids=<идентификатор_кластера> \
         --filter 'telegraf and hostname="<FQDN_хоста>"' \
         --since 'YYYY-MM-DDThh:mm:ssZ' \
         --until 'YYYY-MM-DDThh:mm:ssZ'
      ```

   {% note info %}

   Флаг `--group-id` можно опустить и указать сразу идентификатор лог-группы.

   {% endnote %}

      Чтобы получить FQDN хоста:

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
      1. Нажмите на имя нужного кластера.
      1. Перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
      1. Скопируйте FQDN хоста.

{% endlist %}

## Выключение отправки логов {#disable-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    При [создании](cluster-create.md) или [изменении кластера](cluster-update.md) добавьте свойство `dataproc:disable_cloud_logging` со значением `true`.
    
- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    При [создании](cluster-create.md) или [изменении кластера](cluster-update.md) передайте значение `dataproc:disable_cloud_logging=true` в параметре `--property`, либо передайте пустую строку (`""`) вместо идентификатора лог-группы в параметре `--log-group-id`:
    
    ```bash
    {{ yc-dp }} cluster create <имя_кластера> \
       ... \
       --log-group-id=""
    ```

    ```bash
    {{ yc-dp }} cluster update <имя_или_идентификатор_кластера> \
       --property dataproc:disable_cloud_logging=true
    ```

{% endlist %}

## Хранение логов {#logs-storage}

Получение и хранение логов оплачивается по [правилам тарификации](../../logging/pricing.md) сервиса {{ cloud-logging-name }}. По умолчанию логи хранятся три дня. Чтобы изменить срок хранения, [отредактируйте настройки лог-группы](../../logging/operations/retention-period.md).

Подробнее о работе с логами читайте в [документации {{ cloud-logging-name }}](../../logging/operations/index.md).
