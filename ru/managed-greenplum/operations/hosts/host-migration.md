# Миграция хостов {{ GP }}-кластера в другую зону доступности

Все хосты кластера {{ mgp-name }} располагаются в одной [зоне доступности](../../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. Чтобы перенести хосты из одной зоны в другую, [восстановите кластер из резервной копии](../cluster-backups.md#restore). Во время восстановления из резервной копии укажите новую зону доступности.

{% include [zone-d-disk-restrictions](../../../_includes/mdb/ru-central1-d-local-ssd.md) %}

## Особенности миграции в сервисе {{ data-transfer-full-name }} {#data-transfer}

Если кластер выступает в роли [эндпоинта](../../../data-transfer/concepts/index.md#endpoint) при передаче данных с помощью сервиса {{ data-transfer-name }}:

1. Убедитесь, что хосты кластера располагаются в зоне `{{ region-id }}-a` или `{{ region-id }}-b`, иначе трансфер не будет работать корректно.
1. Если [тип трансфера](../../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) — {{ dt-type-repl }} или {{ dt-type-copy-repl }}, перезапустите трансфер после восстановления из резервной копии. Так он получит сведения о новой топологии кластера. Трансферы типа {{ dt-type-copy }} перезапускать не нужно, так как во время их активации информация о новой топологии передается автоматически.

   {% include [reactivate-a-transfer](../../../_includes/data-transfer/reactivate-a-transfer.md) %}

Подробнее см. в разделе [{#T}](../../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
