# Выгрузить логи в Data Streams

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится лог-группа.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Logging**.
    1. В строке с лог-группой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
    1. В открывшемся меню нажмите кнопку **Редактировать**.
    1. В поле **Поток данных** выберите имеющийся [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) или [создайте](../../data-streams/operations/manage-streams.md#create-data-stream) новый.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}
  
    Чтобы выгружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), выполните команду:

    ```bash
    yc logging group update \
      --name=<имя_лог-группы> \
      --data-stream=<идентификатор_потока>
    ```

    Где:
    * `--name` — имя лог-группы.
    * `--data-stream` — идентификатор потока данных [Yandex Data Streams](../../data-streams/index.md), который состоит из [зоны доступности](../../overview/concepts/geo-scope.md), [идентификатора облака](../../resource-manager/operations/cloud/get-id.md), идентификатора [базы данных](../../ydb/concepts/resources.md#database) и имени [потока данных](../../data-streams/concepts/glossary.md#stream-concepts).

    >Например, укажите идентификатор потока `/ru-central1/b1gvlrnlei4l********/etn780rpm7e5********/default`, если:
     >* `ru-central1` — регион;
     >* `b1gvlrnlei4l********` — идентификатор облака;
     >* `etn780rpm7e5********` — идентификатор базы данных YDB;
     >* `default` — имя потока.

- API {#api}

    Чтобы выгружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), воспользуйтесь методом REST API [update](../api-ref/LogGroup/update.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Update](../api-ref/grpc/LogGroup/update.md).

{% endlist %}

В указанный поток данных автоматически будут перенаправляться записи, которые добавили в лог-группу.