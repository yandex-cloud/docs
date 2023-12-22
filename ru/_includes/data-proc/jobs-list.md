{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы получить список заданий, выполните команду:

    ```bash
    {{ yc-dp }} job list --cluster-name=<имя_кластера>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

- API

    Воспользуйтесь методом API [list](../../data-proc/api-ref/Job/list) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

{% endlist %}
