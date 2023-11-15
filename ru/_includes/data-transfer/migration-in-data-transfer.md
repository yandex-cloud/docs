## Особенности миграции в сервисе {{ data-transfer-full-name }} {#data-transfer}

Если ваш кластер выступает в роли [эндпоинта](../../data-transfer/concepts/index.md#endpoint) при передаче данных с помощью сервиса {{ data-transfer-name }}:

1. Убедитесь, что все хосты кластера располагаются не только в зоне `{{ region-id }}-d`, иначе трансфер не будет работать корректно. Если вы переносите хосты в зону `{{ region-id }}-d`, расположите хотя бы один хост в зоне `{{ region-id }}-a` или `{{ region-id }}-b`. Трансфер автоматически выберет подходящую зону. Если в вашем кластере один хост, разместите его в зоне `{{ region-id }}-a` или `{{ region-id }}-b`.

1. Если [тип вашего трансфера](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) — {{ dt-type-repl }} или {{ dt-type-copy-repl }}, после добавления новых хостов и удаления старых перезапустите трансфер. Так он получит сведения о новой топологии кластера. Трансферы типа {{ dt-type-copy }} перезапускать не нужно, так как во время их активации информация о новой топологии передается автоматически.

   {% include [reactivate-a-transfer](reactivate-a-transfer.md) %}

Подробнее см. в разделе [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
