# Просмотр информации о подключении


## Получить список подключений {#connection-list}


{% note info %}

В списке подключений показываются только те подключения, к которым у пользователя есть доступ (выдана [роль `connection-manager.auditor`](../security/connection-manager-roles.md#connection-manager-auditor) или [роль `connection-manager.viewer`](../security/connection-manager-roles.md#connection-manager-viewer)). Пользователь с доступом к каталогу будет видеть все подключения в этом каталоге.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список подключений:

  1. Посмотрите описание команды CLI для получения списка подключений:

      ```bash
      yc metadata-hub connection-manager connection list --help
      ```

  1. Получите список подключений, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection list
      ```

      Чтобы получить только нужные подключения, передайте в команде один или несколько флагов:

      * `--db-type` — тип базы данных. Возможные значения: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`.

      * `--is-manual` — подключения, созданные вручную.

      * `--mdb-cluster-id` — идентификатор кластера.

      * `--is-on-premise` — подключения к пользовательским инсталляциям.
      
      Например, чтобы получить подключения к пользовательским инсталляциям базы данных `mysql`, выполните команду:
      
      ```bash
      yc metadata-hub connection-manager connection list \
        --db-type mysql \
        --is-on-premise
      ```

- API {#api}

  Чтобы получить список подключений Connection Manager в каталоге по умолчанию, воспользуйтесь методом REST API [Connection.List](../connection-manager/api-ref/Connection/list.md) или методом gRPC API [ConnectionService.List](../connection-manager/api-ref/grpc/Connection/list.md).

  Чтобы посмотреть список подключений в другом каталоге, передайте в запросе идентификатор каталога. [Подробнее о том, как получить идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}

## Просмотр информации о подключении {#connection-get}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите на строку подключения для просмотра детальной информации о нем.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о подключении:
  
  1. Посмотрите описание команды CLI для получения информации о подключении:

      ```bash
      yc metadata-hub connection-manager connection get --help
      ```

  1. Получите информацию о подключении, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection get <идентификатор_подключения>
      ```

      Идентификатор подключения можно получить со [списком подключений](#connection-list) в каталоге.

- API {#api}
  
  Чтобы получить информацию о подключении Connection Manager, воспользуйтесь методом REST API [Connection.Get](../connection-manager/api-ref/Connection/get.md) или методом gRPC API [ConnectionService.Get](../connection-manager/api-ref/grpc/Connection/get.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

{% endlist %}

## Просмотр зависимостей подключения {#dependencies}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **Зависимости**.

     В списке [зависимостей](../concepts/connection-manager.md#dependencies) показываются кластеры управляемых баз данных и экземпляры сервисов, которые используют Connection Manager для хранения информации о подключениях. Нажмите на строку в списке зависимостей, чтобы перейти к кластеру или экземпляру сервиса.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о зависимостях подключения:
  
  1. Посмотрите описание команды CLI для получения информации о зависимостях подключения:

      ```bash
      yc metadata-hub connection-manager connection resolve-cluster --help
      ```

  1. Получите информацию о зависимостях подключения, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection resolve-cluster <идентификатор_подключения>
      ```

      Идентификатор подключения можно получить со [списком подключений](#connection-list) в каталоге.

      {% note info %}
      
      Для подключений к кластерам управляемых баз данных команда `resolve-cluster` возвращает топологию кластера. Для подключений к пользовательским инсталляциям баз данных команда возвращает ту же информацию, что и команда [get](#connection-get).
      
      {% endnote %}

- API {#api}
  
  Чтобы получить информацию о зависимостях подключения Connection Manager, воспользуйтесь методом REST API [Connection.ResolveCluster](../connection-manager/api-ref/Connection/resolveCluster.md) или методом gRPC API [ConnectionService.ResolveCluster](../connection-manager/api-ref/grpc/Connection/resolveCluster.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

  {% note info %}

  Для подключений к кластерам управляемых баз данных метод `ResolveCluster` возвращает топологию кластера. Для подключений к пользовательским инсталляциям баз данных метод возвращает ту же информацию, что и метод [Get](view-connection.md#connection-get).

  {% endnote %}

{% endlist %}

## Просмотр выполненных операций {#operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **Операции**.

     В списке операций вы можете просмотреть все операции выбранного подключения с момента его создания:

     * `Create` — подключение создано;
     * `Update` — подключение изменено;
     * `Delete` — подключение удалено;
     * `Set access bindings` — назначены роли пользователям данного подключения;
     * `Update access bindings` — изменены роли пользователей данного подключения.

     Вы также можете просмотреть технические операции:

     * `Bump version` — обновлена версия секрета для подключений MDB;
     * `Update references` — обновлены ссылки на подключение;
     * `Update version references` — обновлены ссылки на версию подключения при создании или удалении бэкапа кластера MDB;
     * `Delete version` — удалена версия подключения после удаления последнего бэкапа кластера MDB.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о выполненных операциях конкретного подключения:
  
  1. Посмотрите описание команды CLI для получения информации о выполненных операциях:

      ```bash
      yc metadata-hub connection-manager connection list-operations --help
      ```

  1. Получите информацию о выполненных операциях, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection list-operations <идентификатор_подключения>
      ```

      Идентификатор подключения можно получить со [списком подключений](#connection-list) в каталоге.

- API {#api}
  
  Чтобы получить информацию о выполненных операциях конкретного подключения Connection Manager, воспользуйтесь методом REST API [Connection.ListOperations](../connection-manager/api-ref/Connection/listOperations.md) или методом gRPC API [ConnectionService.ListOperations](../connection-manager/api-ref/grpc/Connection/listOperations.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

{% endlist %}