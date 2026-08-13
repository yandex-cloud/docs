{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/data-proc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы получить список заданий, выполните команду:

    ```bash
    {{ yc-dp }} job list --cluster-name=<имя_кластера>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

- API {#api}

    Воспользуйтесь методом API [list](../../data-proc/api-ref/Job/list) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

{% endlist %}
