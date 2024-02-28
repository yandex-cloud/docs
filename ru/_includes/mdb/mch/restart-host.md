# Перезапустить хост

Перезапуск хостов может понадобиться, если нужно экстренно устранить такие проблемы, как:

* перерасход ресурсов;
* утечка памяти;
* взаимоблокировка (deadlock) между запросами;
* зависание операций и внутренних процессов {{ CH }}.

Чтобы перезапустить хост:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В строке нужного хоста нажмите на значок ![icon](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
  1. Подтвердите перезагрузку хоста.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  Чтобы перезапустить хост, выполните команду:

  ```bash
  {{ yc-mdb-ch }} host restart <имя_хоста> \
     --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со списком хостов в кластере, имя кластера — со [списком кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- API {#api}

  Чтобы перезапустить хост, воспользуйтесь методом REST API [restartHosts](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md) для ресурса [Cluster](../../../managed-clickhouse/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/RestartHosts](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#RestartHosts) и передайте в запросе:

  * Идентификатор кластера, в котором нужно изменить хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
  * Имя хоста, который надо перезапустить, в параметре `hostNames`. Чтобы узнать имя хоста, получите список хостов в кластере.

{% endlist %}
