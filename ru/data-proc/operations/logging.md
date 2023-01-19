# Работа с логами

Собирает и отображает логи кластера {{ dataproc-name }} сервис [{{ cloud-logging-full-name }}](../../logging). 

Чтобы следить за событиями кластера и отдельных его хостов, укажите в его настройках нужную [лог-группу](../../logging/concepts/log-group.md). Это можно сделать при [создании](cluster-create.md) или [изменении](cluster-update.md) кластера. Если для кластера не выбрана лог-группа, то для отправки и хранения логов будет использована лог-группа по умолчанию в каталоге кластера.

Подробнее см. в разделе [{#T}](../concepts/logs.md).

## Просмотр записей логов {#logging-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/logs.svg) **Логи**.
    1. (опционально) Укажите настройки вывода:
        * [фильтр сообщений](../concepts/logs.md):
           * Получение вывода запуска задания {{ dataproc-name }}:

             ```ini
             job_id="<идентификатор задания>"
             ```

           * Получение stdout-вывода всех контейнеров YARN приложения:

             ```ini
             application_id="<идентификатор YARN приложения>" AND yarn_log_type="stdout"
             ```

           * Получение stderr-вывода YARN контейнера:

             ```ini
             container_id="<идентификатор YARN контейнера>" AND yarn_log_type="stderr"
             ```

           * Получение записей логов сервиса YARN Resource Manager с управляющего хоста кластера:

             ```ini
             hostname="<FQDN управляющего хоста>" AND log_type="hadoop-yarn-resourcemanager"
             ```

        * интересующие уровни сообщений: от `TRACE` до `FATAL`;
        * количество сообщений на странице;
        * интервал сообщений (один из стандартных или произвольный).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  Посмотрите описание команды CLI для получения логов:

    ```bash
    yc logging read --help
    ```

  Примеры:

    * Чтобы получить логи сервиса HDFS NameNode кластера {{ dataproc-name }}, выполните команду:

      ```bash
      yc logging read \
         --group-id=<идентификатор лог-группы> \
         --resource-ids=<идентификатор кластера> \
         --filter=log_type=hadoop-hdfs-namenode
      ```

    * Чтобы получить логи за последние два часа от всех кластеров {{ dataproc-name }}, связанных с определенной лог-группой, выполните команду:

      ```bash
      yc logging read \
         --group-id=<идентификатор лог-группы> \
         --resource-types=dataproc.cluster \
         --since=2h
      ```

{% endlist %}

## Выключение отправки логов {#disable-logs}

{% list tabs %}

- Консоль управления

    При [создании](cluster-create.md) или [изменении кластера](cluster-update.md) добавьте свойство `dataproc:disable_cloud_logging` со значением `true`.
    
- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    При [создании](cluster-create.md) или [изменении кластера](cluster-update.md) передайте значение `dataproc:disable_cloud_logging=true` в параметре `--property`, либо передайте пустую строку (`""`) вместо идентификатора лог-группы в параметре `--log-group-id`:
    
    ```bash
    {{ yc-dp }} cluster create <имя кластера> \
       ... \
       --log-group-id=""
    ```
    
    ```bash
    {{ yc-dp }} cluster update <идентификатор или имя кластера> \
       --property dataproc:disable_cloud_logging=true
    ```

{% endlist %}

## Хранение логов {#logs-storage}

Получение и хранение логов оплачивается по [правилам тарификации](../../logging/pricing.md) сервиса {{ cloud-logging-full-name }}. Чтобы изменить срок хранения и правила доступа к логам, [измените настройки лог-группы](../../logging/operations/retention-period.md).

Подробнее о работе с логами см. в [документации {{ cloud-logging-full-name }}](../../logging/operations/index.md).
