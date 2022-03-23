{% note info %}

Задания в статусах `ERROR`, `DONE` или `CANCELLED` отменить нельзя. Чтобы узнать статус задания, получите [список заданий](#list) в кластере.

{% endnote %}

{% list tabs %}

* CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы отменить задание, выполните команду:

    ```bash
    yc dataproc job cancel <идентификатор или имя задания> \
       --cluster-name=<имя кластера>
    ```

    Идентификатор и имя задания можно получить со [списком заданий в кластере](#list), имя кластера — со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

* API

    Воспользуйтесь методом API [cancel](../../data-proc/api-ref/Job/cancel) и передайте в запросе:

    * идентификатор кластера в параметре `clusterId`;
    * идентификатор задания в параметре `jobId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list), идентификатор задания — со [списком заданий в кластере](#list).

{% endlist %}
