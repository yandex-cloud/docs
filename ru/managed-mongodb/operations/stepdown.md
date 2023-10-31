# Переключение первичной реплики

Если в кластере есть [несколько реплик](../concepts/replication.md), то при необходимости можно переключить первичную реплику (мастер).

Переключение в среднем занимает менее одной минуты. Во время переключения кластер может быть недоступен для записи в течение нескольких секунд.

Подробнее о переключении первичной реплики см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/method/rs.stepDown/).

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}**.
    1. Нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) в строке `PRIMARY` хоста и выберите пункт **{{ ui-key.yacloud.mongodb.hosts.action_stepdown-host }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переключить первичную реплику в кластере, выполните команду:

    ```bash
    {{ yc-mdb-mg }} hosts stepdown <имя_текущей_первичной_реплики> \
       --name=<имя_кластера>
    ```

    Имя первичной реплики для нужного шарда можно получить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Чтобы переключить первичную реплику, воспользуйтесь методом REST API [stepdownHosts](../api-ref/Cluster/stepdownHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/StepdownHosts](../api-ref/grpc/cluster_service.md#StepdownHosts) и передайте в запросе:

    * Идентификатор кластера, в котором нужно переключить первичную реплику, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя текущей первичной реплики в параметре `hostNames`. Чтобы узнать имя, получите [список хостов в кластере](hosts.md#list).

{% endlist %}
