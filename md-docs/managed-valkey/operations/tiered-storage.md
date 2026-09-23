[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Valkey™](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление многоуровневым хранилищем

# Управление многоуровневым хранилищем в Yandex Managed Service for Valkey™

Вы можете включить [многоуровневое хранилище](../concepts/storage.md#data-tiering), которое позволяет переносить редко используемые данные из оперативной памяти на диск.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Включите многоуровневое хранилище в кластере Yandex Managed Service for Valkey™:

    * При [создании кластера](cluster-create.md) выберите версию СУБД `Valkey TS 9.1`.

    * В существующем кластере [обновите версию](cluster-version-update.md) до `Valkey TS 9.1`. Если версия кластера ниже `9.1`, вначале обновите кластер до этой версии.

{% endlist %}