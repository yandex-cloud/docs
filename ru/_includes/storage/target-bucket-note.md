{% note info %}

Чтобы записывать логи в целевой бакет, для которого настроена [политика доступа](../../storage/concepts/policy.md), [добавьте](../../storage/operations/buckets/policy.md#apply-policy) в нее правило, разрешающее всем учетным записям выполнять действие `PutObject`, а в качестве ресурса укажите имя бакета с [префиксом ключа](../../storage/concepts/server-logs.md#key-prefix) для объектов с логами, например `<имя_бакета>/logs/*`.

{% endnote %}