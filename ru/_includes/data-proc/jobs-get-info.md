{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Нажмите на имя нужного задания.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Для получения общей информации о задании выполните команду:

    ```bash
    {{ yc-dp }} job get \
       --cluster-name=<имя_кластера> \
       --name=<имя_задания>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

- API

    Воспользуйтесь методом API [get](../../data-proc/api-ref/Job/get) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Его можно получить со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list)
    * Идентификатор задания в параметре `jobId`. Его можно получить со [списком заданий в кластере](#list).

{% endlist %}
