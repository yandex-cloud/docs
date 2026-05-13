# Миграция эндпоинтов и трансфера Data Transfer в другую зону доступности


[Трансферы](../../concepts/index.md#transfer) можно переносить из одной [зоны доступности](../../../overview/concepts/geo-scope.md) в другую. Способ переноса зависит от того, какой сервис выступает в качестве эндпоинта в трансфере: [пользовательская инсталляция БД](#on-premise) или [управляемая БД Yandex Cloud](#managed-service). Если вы [переносите данные](../../tutorials/index.md#migration) между пользовательской инсталляцией и управляемой БД, сначала перенесите эндпоинт на основе пользовательской инсталляции, затем — на основе управляемой БД.

## Перенести эндпоинт на основе пользовательской инсталляции {#on-premise}

1. Если [тип трансфера](../../concepts/transfer-lifecycle.md#transfer-types) — **Репликация** или **Копирование и репликация**, [деактивируйте](../transfer.md#deactivate) трансфер и дождитесь его перехода в статус **Остановлен**.
1. [Создайте подсеть](../../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите эндпоинт.
1. Если пользовательская инсталляция установлена на виртуальной машине Yandex Cloud, выполните действия:

   
   1. [Остановите ВМ](../../../compute/operations/vm-control/vm-stop-and-start.md#stop).
   1. [Перенесите ВМ в другую зону доступности](../../../compute/operations/vm-control/vm-change-zone.md).
   1. [Запустите ВМ](../../../compute/operations/vm-control/vm-stop-and-start.md#start).


1. [Укажите новую подсеть](index.md#update) в настройках эндпоинта с пользовательской инсталляцией.
1. Если вы деактивировали трансфер ранее, [активируйте](../transfer.md#activate) его и дождитесь перехода трансфера в статус **Реплицируется**.

   {% note warning %}

   Если трансфер включает в себя эндпоинт на основе управляемой БД, перед активацией трансфера [перенесите](#managed-service) этот эндпоинт в другую зону доступности.

   {% endnote %}

## Перенести эндпоинт на основе управляемой базы данных {#managed-service}

1. Перенесите хосты кластера в другую зону доступности. Подробнее см. в документации сервисов:

   * [Yandex Managed Service for ClickHouse®](../../../managed-clickhouse/operations/host-migration.md);
   * [Yandex StoreDoc](../../../storedoc/operations/host-migration.md);
   * [Yandex Managed Service for MySQL®](../../../managed-mysql/operations/host-migration.md);
   * [Yandex Managed Service for OpenSearch](../../../managed-opensearch/operations/host-migration.md);
   * [Yandex Managed Service for PostgreSQL](../../../managed-postgresql/operations/host-migration.md);
   * [Yandex Managed Service for YDB](../../../ydb/operations/migration-to-an-availability-zone.md).

1. Если [тип трансфера](../../concepts/transfer-lifecycle.md#transfer-types) — **Репликация** или **Копирование и репликация**, перезапустите трансфер, чтобы он получил сведения о новой топологии кластера. Трансферы типа **Копирование** перезапускать не нужно, так как во время их активации информация о новой топологии передается автоматически.

   Чтобы перезапустить трансфер, выберите один из двух способов:
   
   * [Деактивируйте](../transfer.md#deactivate) трансфер и дождитесь его перехода в статус **Остановлен**. Затем [активируйте](../transfer.md#activate) трансфер и дождитесь его перехода в статус **Реплицируется**.
   * Измените какую-либо [настройку трансфера](../transfer.md#update) или [эндпоинта](index.md#update).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._