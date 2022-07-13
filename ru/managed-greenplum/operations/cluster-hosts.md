# Управление хостами кластера

## Получить список хостов в кластере {#list}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку ![hosts.svg](../../_assets/mdb/hosts.svg) **Хосты**.

    В списке хостов в колонке **Роль** указывается роль каждого хоста:

    * `MASTER` — первичный хост-мастер (PRIMARY). Принимает пользовательские подключения.
    * `REPLICA` — резервный хост-мастер (STANDBY). Реплицирует данные первичного хоста-мастера.
    * `SEGMENT` — хост-сегмент. Хранит часть данных кластера.

- API

    Воспользуйтесь методами API [listMasterHosts](../api-ref/Cluster/listMasterHosts.md) и [listSegmentHosts](../api-ref/Cluster/listSegmentHosts.md) и передайте значение идентификатора кластера в параметре `clusterId` запроса.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
