# Работа с логами

Собирает и отображает логи кластера Yandex Data Processing сервис [Yandex Cloud Logging](../../logging/index.md). 

Чтобы следить за событиями кластера и отдельных его хостов, укажите в его настройках нужную [лог-группу](../../logging/concepts/log-group.md). Это можно сделать при [создании](cluster-create.md) или [изменении](cluster-update.md) кластера. Если для кластера не выбрана лог-группа, то для отправки и хранения логов будет использована лог-группа по умолчанию в каталоге кластера.

Подробнее в разделе [Логи](../concepts/logs.md).

## Просмотр записей логов {#logging-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex Data Processing**.
    1. Нажмите на имя нужного кластера.
    1. В разделе **Настройки** нажмите на имя лог-группы кластера. Откроется страница сервиса Cloud Logging.
    1. Нажмите на строку лог-группы. Откроются логи кластера.
    1. (Опционально) Укажите настройки вывода:
        * [фильтр сообщений](../concepts/logs.md):
           * Получение вывода запуска задания Yandex Data Processing:

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

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  Посмотрите описание команды CLI для получения логов:

    ```bash
    yc logging read --help
    ```

  Примеры:

    * Чтобы получить логи сервиса HDFS NameNode кластера Yandex Data Processing, выполните команду:

      ```bash
      yc logging read \
         --group-id=<идентификатор_лог-группы> \
         --resource-ids=<идентификатор_кластера> \
         --filter=log_type=hadoop-hdfs-namenode
      ```

    * Чтобы получить логи за последние два часа от всех кластеров Yandex Data Processing, связанных с определенной лог-группой, выполните команду:

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

    * Чтобы получить лог по отправке метрик определенного хоста в сервис [Yandex Monitoring](../../monitoring/index.md), выполните команду:

      ```bash
      yc logging read \
         --group-id <идентификатор_лог-группы> \
         --resource-ids=<идентификатор_кластера> \
         --filter 'telegraf and hostname="<FQDN_хоста>"' \
         --since 'YYYY-MM-DDThh:mm:ssZ' \
         --until 'YYYY-MM-DDThh:mm:ssZ'
      ```

   {% note info %}

   Параметр `--group-id` можно опустить и указать сразу идентификатор лог-группы.

   {% endnote %}

      Чтобы получить FQDN хоста:

      1. Перейдите на [страницу каталога](https://console.yandex.cloud).
      1. Перейдите в сервис **Yandex Data Processing**.
      1. Нажмите на имя нужного кластера.
      1. Перейдите на вкладку **Хосты**.
      1. Скопируйте FQDN хоста.

{% endlist %}

## Выключение отправки логов {#disable-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    При [создании](cluster-create.md) или [изменении кластера](cluster-update.md) добавьте свойство `dataproc:disable_cloud_logging` со значением `true`.
    
- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    При [создании](cluster-create.md) или [изменении кластера](cluster-update.md) передайте значение `dataproc:disable_cloud_logging=true` в параметре `--property`, либо передайте пустую строку (`""`) вместо идентификатора лог-группы в параметре `--log-group-id`:
    
    ```bash
    yc dataproc cluster create <имя_кластера> \
       ... \
       --log-group-id=""
    ```

    ```bash
    yc dataproc cluster update <имя_или_идентификатор_кластера> \
       --property dataproc:disable_cloud_logging=true
    ```

{% endlist %}

## Хранение логов {#logs-storage}

Получение и хранение логов оплачивается по [правилам тарификации](../../logging/pricing.md) сервиса Cloud Logging. По умолчанию логи хранятся три дня. Чтобы изменить срок хранения, [отредактируйте настройки лог-группы](../../logging/operations/retention-period.md).

Подробнее о работе с логами читайте в [документации Cloud Logging](../../logging/operations/index.md).