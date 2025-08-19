{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
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

- API {#api}
  
  Чтобы получить информацию о выполненных операциях конкретного подключения {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.ListOperations](../../metadata-hub/api-ref/Connection/listOperations.md) или методом gRPC API [ConnectionService.ListOperations](../../metadata-hub/api-ref/grpc/Connection/listOperations.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](../../metadata-hub/operations/view-connection.md#connection-list) в каталоге.

{% endlist %}