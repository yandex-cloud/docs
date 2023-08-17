# Управление плагинами {{ OS }}

При создании кластера в {{ mos-short-name }} вы можете указать желаемый список плагинов, и они будут автоматически установлены в кластер. Полный список доступных плагинов приведен в разделе [{#T}](../concepts/plugins.md#opensearch).

## Получить список установленных плагинов {#list}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера.

- API

    Чтобы получить список установленных плагинов, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Включенные плагины будут перечислены в списке `config.opensearch.plugins`.

    {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Изменить список установленных плагинов {#update}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![pencil](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** укажите плагины, которые должны быть установлены.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API

    Чтобы изменить список установленных плагинов, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Список плагинов в параметре `configSpec.opensearchSpec.plugins`. Плагины, не указанные в списке, будут выключены.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
