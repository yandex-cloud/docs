[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for OpenSearch](../index.md) > [Концепции](index.md) > Роли хостов

# Роли хостов в Managed Service for OpenSearch

Каждый кластер Managed Service for OpenSearch состоит из одной или нескольких групп хостов `OpenSearch` и `Dashboards` (опционально):

* Группа хостов `OpenSearch` может содержать хосты с ролями [DATA](#data) или [MANAGER](#manager).
  
  В кластере должны присутствовать хосты с обеими ролями. Если в кластере есть только одна группа `OpenSearch`, ее хосты совмещают обе роли.

* Группа хостов `Dashboards` может содержать только хосты с ролью [DASHBOARDS](#dashboards).

## Хосты с ролью DATA {#data}

Хосты с этой ролью хранят один или несколько индексов и обеспечивают обработку запросов на поиск, запись и анализ данных.


Чтобы кластер обеспечивал высокую доступность и на него распространялось [Соглашение об уровне обслуживания (SLA)](https://yandex.ru/legal/cloud_sla_mdb/), должны выполняться следующие условия:

1. В кластере должно быть два и более хоста с ролью `DATA`, расположенных в разных [зонах доступности](../../overview/concepts/geo-scope.md). При этом в каждой зоне доступности должно находиться не больше половины хостов с ролью `DATA`.
1. В кластере должны быть настроены [шардирование и репликация](scalability-and-resilience.md) индексов. Это обеспечивает их масштабируемость и отказоустойчивость.


[Подробнее о высокой доступности кластера](high-availability.md).

### Примеры использования {#examples-data}

* [Миграция данных из Elasticsearch](../tutorials/migration-to-opensearch.md)
* [Настройка политики индексов в Managed Service for OpenSearch](../tutorials/opensearch-index-policy.md)
* [Настройка политики холодного хранилища в Managed Service for OpenSearch](../tutorials/opensearch-cold-storage-policy.md)
* [Загрузка данных из Yandex Managed Service for OpenSearch в Yandex Object Storage с помощью Yandex Data Transfer](../tutorials/opensearch-to-object-storage.md)
* [Использование плагина yandex-lemmer в Managed Service for OpenSearch](../tutorials/opensearch-yandex-lemmer.md)

## Хосты с ролью MANAGER {#manager}

Хосты с этой ролью отслеживают состояние кластера и управляют его конфигурацией, обеспечивая работоспособность всех компонентов OpenSearch.

При использовании хостов с ролью `MANAGER` в кластер будет добавлена группа с тремя такими хостами.

Если хосты с ролью `MANAGER` не используются, соответствующую роль необходимо назначить хостам с ролью `DATA`. Однако присутствие выделенных хостов с ролью `MANAGER` позволяет повысить общую надежность кластера и снизить нагрузку на хосты с ролью `DATA`.

{% note warning %}

Если вы добавите в кластер группу хостов с ролью `MANAGER`, где эта роль назначена хостам с ролью `DATA`, такую группу будет невозможно удалить. Вернуть прежнюю конфигурацию хостов можно только [восстановив кластер из резервной копии](../operations/cluster-backups.md#restore).

{% endnote %}

## Хосты с ролью DASHBOARDS {#dashboards}

Хосты с этой ролью размещают OpenSearch Dashboards — инструмент визуализации данных, например, для мониторинга приложений в режиме реального времени, обнаружения угроз, управления инцидентами или персонализированного поиска.

### Примеры использования {#examples-dashboards}

* [Аутентификация в OpenSearch Dashboards с помощью Keycloak](../tutorials/saml-keycloak.md)
* [Загрузка логов из Yandex Audit Trails](../tutorials/trails-to-opensearch.md)
* [Миграция данных из Elasticsearch](../tutorials/migration-to-opensearch.md)