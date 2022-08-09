{% include [get-logs-info](note-info-get-logs.md) %}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите на имя нужного задания.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы получить логи выполнения задания, выполните команду:

    ```bash
    {{ yc-dp }} job log \
       --cluster-name=<имя кластера> \
       --name=<имя задания>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

- API

    Воспользуйтесь методом API [listLog](../../data-proc/api-ref/Job/listLog) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Его можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).
    * Идентификатор задания в параметре `jobId`. Его можно получить со [списком заданий в кластере](#list).

{% endlist %}
