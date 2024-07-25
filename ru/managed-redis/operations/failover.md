# Переключение мастера

В отказоустойчивом кластере {{ mrd-name }} из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на хост-реплику. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Переключение в среднем занимает несколько минут, кластер в это время доступен.

[Шардированный кластер](../concepts/sharding.md) содержит один или несколько хостов-мастеров — по одному на каждый [шард](../concepts/sharding.md#redis-cluster-structure). Переключение мастера для шардированного кластера осуществляется поочередно для каждого шарда.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы переключить мастер в нешардированном кластере:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нешардированным кластером.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. В строке хоста с ролью `MASTER` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label-title }}**.
    1. В открывшемся окне выберите опцию **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label_confirmation }}** и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

    Чтобы переключить мастер в шардированном кластере:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с шардированным кластером.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. В строке хоста с ролью `MASTER` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label-title }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переключить мастер в нешардированном кластере, выполните команду:

    ```bash
    {{ yc-mdb-rd }} cluster start-failover \
      --name <имя_кластера>
    ```

    Чтобы переключить мастер в шардированном кластере, выполните команду:

    ```bash
    {{ yc-mdb-rd }} cluster start-failover \
      --name <имя_кластера> \
      --hostnames <имя_текущего_мастера>
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md), имя мастера для нужного вам шарда — со [списком хостов в кластере](hosts.md#list).

- API {#api}

    Чтобы переключить мастер, воспользуйтесь методом REST API [startFailover](../api-ref/Cluster/startFailover.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/StartFailover](../api-ref/grpc/cluster_service.md#StartFailover) и передайте в запросе:

    * Идентификатор кластера, в котором нужно переключить мастер, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md).
    * Только для шардированного кластера: имя текущего мастера нужного вам шарда в параметре `hostNames`. Чтобы узнать имя, получите [список хостов в кластере](hosts.md#list).

{% endlist %}
