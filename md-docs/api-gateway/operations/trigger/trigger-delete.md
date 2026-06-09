# Удалить триггер в Yandex API Gateway

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится триггер.
    1. Перейдите в сервис **API Gateway**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **Триггеры**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.
    
- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор триггера, [получите](../../../serverless-containers/operations/trigger-list.md) список триггеров в каталоге.
    
    Удалите триггер:
    
    ```bash
    yc serverless trigger delete <имя_триггера>
    ```

    Результат:
    
    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer-test
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: PAUSED
    ```

- API {#api}

  Чтобы удалить триггер, воспользуйтесь методом REST API [delete](../../triggers/api-ref/Trigger/delete.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Delete](../../triggers/api-ref/grpc/Trigger/delete.md).

{% endlist %}