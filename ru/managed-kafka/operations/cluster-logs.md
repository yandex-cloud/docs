# Просмотр логов кластера {{ KF }}

{{ mkf-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% note info %}

Здесь под логом понимается системный лог кластера и его хостов. Этот лог не имеет отношения к логу раздела для топика {{ KF }}, в который брокер записывает поступающие от производителей сообщения.

{% endnote %}

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
    1. Выберите **{{ ui-key.yacloud.kafka.label_filter_origin }}**, **{{ ui-key.yacloud.mdb.cluster.logs.label_hosts }}** и **{{ ui-key.yacloud.mdb.cluster.logs.label_severity }}**.
    1. Укажите период времени, за который нужно отобразить лог.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        {{ yc-mdb-kf }} cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-kf }} cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --columns <список_колонок_лога> \
           --filter <настройки_фильтрации_записей> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * `--columns` — список колонок лога, из которых будет выводиться информация:
            * `hostname` — [имя хоста](cluster-hosts.md).
            * `message` — сообщение, которое выводит компонент.
            * `severity` — уровень логирования. Пример выводимого значения: `INFO`.
            * `origin` — источник сообщения. Примеры выводимых значений: `kafka_server` или `kafka_controller`.

        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить лог кластера, воспользуйтесь методом REST API [listLogs](../api-ref/Cluster/listLogs.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Получить поток записей лога {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    {{ yc-mdb-kf }} cluster list-logs <имя_или_идентификатор_кластера> --follow
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить поток логов кластера, воспользуйтесь методом REST API [streamLogs](../api-ref/Cluster/streamLogs.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

    Если не задавать значение параметра `toTime`, то в поток будут приходить новые записи лога по мере их появления.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
