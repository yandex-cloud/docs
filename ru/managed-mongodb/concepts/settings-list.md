# Настройки {{ MG }}

При [создании](../operations/cluster-create.md) или [изменении](../operations/update.md#change-mongod-config) кластера {{ mmg-name }} можно задать настройки, которые относятся к {{ MG }}.

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, [API](../../glossary/rest-api.md) или {{ TF }}. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса, одна и та же настройка будет представлена по-разному. Например, **Max incoming connections** в консоли управления соответствует:

* `max_incoming_connections` в gRPC, CLI или {{ TF }};
* `maxIncomingConnections` в REST API.

Следующие настройки доступны только для Enterprise-версии кластера {{ mmg-name }}:

* [Audit log](#setting-audit-log);
* [Security](#setting-security).

В шардированном кластере некоторые настройки доступны только для определенных [ролей хостов](sharding.md#shard-management).

## Зависимость настроек от класса хостов {#settings-instance-dependent}

Значения некоторых настроек {{ MG }} могут быть автоматически скорректированы при изменении класса хостов:

* Если значения не были заданы или не подходят новому классу, будут применены настройки по умолчанию для этого класса.
* Если заданные вручную настройки подходят для нового класса, они не будут изменены.

Список настроек, зависящих от класса хостов:

* [Net → Max incoming connections](#setting-max-incoming-connections).
* [Engine config → Cache size gb](#setting-engine-cache-size).

## Настройки СУБД уровня кластера {#dbms-cluster-settings}

{% include [mmg-dbms-settings](../../_includes/mdb/mmg-dbms-settings.md) %}
