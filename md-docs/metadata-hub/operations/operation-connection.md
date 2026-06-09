# Получение информации об операции

## Получить список операций для конкретного подключения {#operations-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ metadata-hub-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

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

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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
  
  Чтобы получить информацию о выполненных операциях конкретного подключения {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.ListOperations](../connection-manager/api-ref/Connection/listOperations.md) или методом gRPC API [ConnectionService.ListOperations](../connection-manager/api-ref/grpc/Connection/listOperations.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

{% endlist %}

## Получить информацию о конкретной операции {#operation}

{% list tabs group=instructions %}

- API {#api}
  
  Чтобы получить информацию о конкретной операции, воспользуйтесь методом REST API [Operation.Get](../connection-manager/api-ref/Operation/get.md) или методом gRPC API [OperationService.Get](../connection-manager/api-ref/grpc/Operation/get.md) и передайте в запросе идентификатор операции.

  Идентификатор операции можно получить со [списком операций](operation-connection.md#operations-list) подключения.

{% endlist %}