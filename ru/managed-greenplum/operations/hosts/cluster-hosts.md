# Управление хостами кластера

Вы можете получить список хостов (мастеров и сегментов) в кластере {{ mgp-name }}.


## Получить список хостов в кластере {#list-hosts}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![hosts.svg](../../../_assets/mdb/hosts.svg) **Хосты**.

    В списке хостов в колонке **Роль** указывается роль каждого хоста:

    * `MASTER` — первичный хост-мастер (PRIMARY). Принимает пользовательские подключения.
    * `REPLICA` — резервный хост-мастер (STANDBY). Реплицирует данные первичного хоста-мастера.
    * `SEGMENT` — хост-сегмент. Хранит часть данных кластера.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы получить список хостов-мастеров в кластере, выполните команду:

    ```bash
    {{ yc-mdb-gp }} hosts list master \
       --cluster-name=<имя кластера>
    ```

    Чтобы получить список хостов-сегментов в кластере, выполните команду:

    ```bash
    {{ yc-mdb-gp }} hosts list segment \
       --cluster-name=<имя кластера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

- API

    Воспользуйтесь методами API [listMasterHosts](../../api-ref/Cluster/listMasterHosts.md) и [listSegmentHosts](../../api-ref/Cluster/listSegmentHosts.md) и передайте значение идентификатора кластера в параметре `clusterId` запроса.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

{% endlist %}


{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
