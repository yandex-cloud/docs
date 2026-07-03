# Удалить каталог

Если у вас есть каталог [{{ rest-catalog-name }}](../../concepts/components/rest-catalog.md) в [проекте](../projects/create-project.md), вы можете удалить его.

{% note warning %}

Если включена **[защита от удаления](../../concepts/components/rest-catalog.md#catalog)** (`spec.deletionProtection: true`), каталог удалить нельзя. Сначала отключите защиту: установите `spec.deletionProtection: false` в манифесте и примените изменения (`kubectl apply`), либо отключите защиту в [настройках каталога](edit-catalog.md) в консоли управления. После этого можно удалить каталог.

{% endnote %}

{% note warning %}

Пользователи каталога (`RestCatalogPrincipal`) не удаляются автоматически вместе с каталогом. Перед удалением каталога удалите всех его пользователей. Подробнее см. [Удалить пользователя каталога](delete-principal.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Найдите название нужного каталога в списке каталогов проекта: `kubectl get RestCatalog -n <название проекта>`.
  1. Удалите ресурс каталога: `kubectl delete RestCatalog <название каталога> -n <название проекта>`.


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Iceberg REST Catalog**.
  1. На вкладке **Каталоги** выберите каталог.
  1. Нажмите **Удалить**.
  1. Подтвердите удаление.

{% endlist %}
