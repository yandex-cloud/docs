# Остановка и запуск {{ GP }}-кластера

При необходимости вы можете остановить кластер и запустить его заново.

## Остановить кластер {#stop-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Найдите нужный кластер в списке, нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Остановить**.
    1. Подтвердите остановку кластера и нажмите кнопку **Остановить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы остановить кластер {{ GP }}, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster stop <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [stop](../api-ref/Cluster/stop.md) и передайте значение идентификатора кластера в параметре `clusterId` запроса.

    Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Запустить кластер {#start-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Найдите нужный остановленный кластер в списке, нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Запустить**.
    1. Подтвердите запуск кластера и нажмите кнопку **Запустить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запустить кластера {{ GP }}, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster start <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [start](../api-ref/Cluster/start.md) и передайте значение идентификатора кластера в параметре `clusterId` запроса.

    Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
