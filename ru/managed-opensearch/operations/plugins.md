# Управление плагинами {{ OS }}

При создании кластера в {{ mos-short-name }} вы можете указать желаемый список плагинов, и они будут автоматически установлены в кластер. Полный список доступных плагинов приведен в разделе [{#T}](../concepts/plugins.md#opensearch).

## Получить список установленных плагинов {#list}

{% list tabs %}

- API

    Воспользуйтесь методом API [get](../api-ref/Cluster/get.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Включенные плагины будут перечислены в списке `config.opensearch.plugins`.

    Идентификатор кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Изменить список установленных плагинов {#update}

{% list tabs %}

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Список плагинов в параметре `configSpec.opensearchSpec.plugins`. Плагины, не указанные в списке, будут выключены.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
