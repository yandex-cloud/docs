# История изменений в Yandex Managed Service for Trino


## Май 2026 {#may-2026}

* [Доступен новый коннектор](concepts/greenplum-connector.md): Greenplum®/Cloudberry.

## Апрель 2026 {#april-2026}

* Добавлена поддержка приватного доступа к кластеру через [сервисное подключение](concepts/network.md#private-endpoint).
* Добавлена возможность [настраивать группы безопасности](operations/connect.md#configuring-security-groups) для подключения к кластеру, в том числе при работе с коннектором Greenplum®.

## Март 2026 {#march-2026}

* Добавлены отдельные роли для просмотра и редактирования задач на техническое обслуживание: [managed-trino.maintenanceTask.viewer](security.md#managed-trino-maintenanceTask-viewer), [managed-trino.maintenanceTask.editor](security.md#managed-trino-maintenanceTask-editor).
* Для коннектора Iceberg поддержан тип `REST Catalog`. В консоли управления при работе с коннектором Iceberg теперь доступна настройка подключения **Тип Metastore**: Hive Metastore и REST Metastore.
* В консоли управления обновлен интерфейс для выбора подключений через Connection Manager.
* Добавлена возможность настраивать ресурсные группы через консоль управления.
* Для коннекторов добавлены варианты дополнительных настроек.
* Для коннектора Hudi добавлена возможность управления `VIEW` (представлением): создание, изменение, удаление.

## Февраль 2026 {#february-2026}

* Добавлена возможность [настроить права доступа к кластеру](operations/cluster-access.md).
* Добавлена возможность изменить настройки выполнения запросов при [создании](operations/cluster-create.md) и [изменении](operations/cluster-update.md#change-query-params) кластера.

## Ноябрь 2025 {#november-2025}

* [Доступен новый коннектор](concepts/index.md#connector): MySQL®.
* Добавлена возможность загрузить пользовательские сертификаты (параметры TLS) при [создании](operations/cluster-create.md) и [изменении](operations/cluster-update.md#change-version) кластера.
* Доступна новая версия Trino [476](https://trino.io/docs/current/release/release-476.html).

## Октябрь 2025 {#october-2025}

* [Доступен новый коннектор](concepts/index.md#connector): Hudi.
* Добавлена возможность настраивать правила доступа к объектам:
   * каталог Trino;
   * схема;
   * таблица;
   * функция;
   * процедура;
   * запрос;
   * свойства сессии каталога;
   * системные свойства сессии.

## Сентябрь 2025 {#september-2025}

Добавлена возможность выбора версии Trino при [создании](operations/cluster-create.md) и [изменении](operations/cluster-update.md#change-version) кластера.

## Август 2025 {#august-2025}

Добавлена возможность [работать с каталогами в кластере Trino](operations/index.md#catalogs) с помощью методов [REST](api-ref/Catalog/index.md) и вызова [gRPC](api-ref/grpc/Catalog/index.md).
 
## Июль 2025 {#july-2025}

* 21 июля 2025 Managed Service for Trino перешел на стадию [General Availability](../overview/concepts/launch-stages.md), и за его использование начала взиматься плата в соответствии с [правилами тарификации](pricing.md).
* Добавлена возможность [получать подробную информацию об операции для кластера](operations/cluster-list.md).
* Добавлена возможность [получать список каталогов Trino в кластере](operations/cluster-list.md).

## Июнь 2025 {#june-2025}

* Поддержано [отказоустойчивое выполнение запросов в кластере](concepts/retry-policy.md).
* Добавлена возможность совершать операции над кластером и каталогами Trino с помощью [CLI Yandex Cloud](../cli/cli-ref/managed-trino/cli-ref/index.md), [Terraform](tf-ref.md).

## Май 2025 {#may-2025}

* [Доступен новый коннектор](concepts/index.md#connector): MS SQL Server.
* В консоли управления добавлен раздел [**Обслуживание**](operations/cluster-maintenance.md).

## Апрель 2025 {#april-2025}

* Сервис Yandex Managed Service for Trino вышел в [Public Preview](../overview/concepts/launch-stages.md).
* [Доступен новый коннектор](concepts/index.md#connector): Oracle.
* Добавлена интеграция с Yandex Connection Manager.
* Добавлена возможность совершать операции над кластером Trino с помощью [API](api-ref/authentication.md).