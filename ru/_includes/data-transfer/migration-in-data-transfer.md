## Особенности миграции в сервисе {{ data-transfer-full-name }} {#data-transfer}

Если кластер выступает в роли [эндпоинта](../../data-transfer/concepts/index.md#endpoint) при передаче данных с помощью сервиса {{ data-transfer-name }} и используется [тип трансфера](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) {{ dt-type-repl }} или {{ dt-type-copy-repl }}, перезапустите трансфер после миграции кластера. Так трансфер получит сведения о новой топологии кластера.

Трансферы типа {{ dt-type-copy }} перезапускать не нужно, так как во время их активации информация о новой топологии передается автоматически.

{% include [reactivate-a-transfer](reactivate-a-transfer.md) %}

Подробнее см. в разделе [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
