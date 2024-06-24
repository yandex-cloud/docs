# Просмотр логов кластера {{ CH }}

{{ mch-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Получить логи кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.clickhouse.cluster.switch_logs }}**.
    1. Укажите период времени, за который нужно отобразить логи: введите его вручную или выберите в календаре, нажав на поле ввода дат.
    1. При необходимости укажите хосты и уровень логирования в строке с полем ввода дат.

    Будет отображен список записей в логе за выбранный период времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

    Если записей слишком много и отображается только часть из них, нажмите на кнопку **{{ ui-key.yacloud.common.label_load-more }}** в конце списка.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        {{ yc-mdb-ch }} cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера:

        ```bash
        {{ yc-mdb-ch }} cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --columns <список_колонок_для_вывода_информации> \
           --filter <настройки_фильтрации_записей> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * `--columns` — список колонок для вывода информации:
            * `hostname` — [имя хоста](hosts.md#list-hosts).
            * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
            * `message` — сообщение, которое выводит компонент.
            * `query_id` — идентификатор запроса.
            * `severity` — уровень логирования, например, `Debug`.
            * `thread` — идентификатор потока, участвующего в обработке запросов.
        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить логи кластера, воспользуйтесь методом REST API [listLogs](../api-ref/Cluster/listLogs.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

    * Значение `CLICKHOUSE` в параметре `serviceType`.

{% endlist %}

## Получить поток логов кластера {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    {{ yc-mdb-ch }} cluster list-logs <имя_или_идентификатор_кластера> --follow
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить поток логов кластера, воспользуйтесь методом REST API [streamLogs](../api-ref/Cluster/streamLogs.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/StreamLogs](../api-ref/grpc/cluster_service.md#StreamLogs) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

    * Значение `CLICKHOUSE` в параметре `serviceType`.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
