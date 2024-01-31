# Управление плагинами {{ OS }}

При создании кластера в {{ mos-short-name }} вы можете указать желаемый список плагинов, и они будут автоматически установлены в кластер. Полный список доступных плагинов приведен в разделе [{#T}](../concepts/plugins.md#opensearch).

## Получить список установленных плагинов {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список установленных плагинов, запросите информацию об {{ OS }}-кластере:

    ```bash
    {{ yc-mdb-os }} cluster get <имя_или_идентификатор_кластера>
    ```

    Список плагинов указан в параметре `config.opensearch.plugins`.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить список установленных плагинов, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Включенные плагины будут перечислены в списке `config.opensearch.plugins`.

    {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Изменить список установленных плагинов {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** укажите плагины, которые должны быть установлены.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список установленных плагинов {{ OS }}, выполните команду:

    ```bash
    {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
       --plugins <плагины>
    ```

    В параметре `--plugins` перечислите нужные плагины через запятую. Чтобы сохранить плагины, которые были установлены ранее, также укажите их параметре `--plugins`.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы изменить список установленных плагинов, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Список плагинов в параметре `configSpec.opensearchSpec.plugins`. Плагины, не указанные в списке, будут выключены.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
