# Включение и выключение сервиса


В Yandex Identity and Access Management есть возможность включать и выключать [доступ сервисов](../../concepts/service-control.md) к ресурсам пользователя в определенном облаке.

Управлять доступом сервисов к ресурсам могут пользователи с ролью [администратора](../../../resource-manager/security/index.md#resource-manager-admin) или [владельца](../../../resource-manager/security/index.md#resource-manager-clouds-owner) облака.

## Включение сервиса {#enable}

Чтобы выдать сервису доступ к ресурсам в облаке пользователя, включите этот сервис:

{% list tabs group=instructions %}


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется облако, заданное в профиле CLI. Если в профиле CLI облако не задано или вы хотите задать другое облако, указывайте идентификатор нужного облака в команде в параметре `--cloud-id`.

  1. Посмотрите описание команды CLI для включения сервиса:

      ```bash
      yc iam service-control enable --help
      ``` 

  1. [Получите](list-get.md#list) список и информацию о [статусах](../../concepts/service-control.md#access-status) сервисов, которые можно включать и выключать.

  1. Выполните команду, указав идентификатор сервиса, который требуется включить:

      ```bash
      yc iam service-control enable <идентификатор_сервиса>
      ```

      Результат:

      ```text
      done (31s)
      service_id: dspm
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:21:12.331340Z"
      status: ENABLED
      ```

- API {#api}

  Воспользуйтесь методом REST API [enable](../../api-ref/ServiceControl/enable.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Enable](../../api-ref/grpc/ServiceControl/enable.md).

{% endlist %}

В результате [статус](../../concepts/service-control.md#access-status) сервиса в облаке изменится на `ENABLED`, и для этого сервиса в данном облаке будут созданы [сервисные агенты](../../concepts/service-control.md#service-agent), обладающие необходимыми правами на действия с ресурсами пользователя в этом облаке.

## Выключение сервиса {#disable}

Если у сервиса есть ресурсы, использующие доступ к другим ресурсам пользователя в данном облаке, выключить этот сервис нельзя. Чтобы выключить такой сервис, предварительно удалите все ресурсы этого сервиса, использующие доступ к другим ресурсам пользователя.

Чтобы отозвать у сервиса доступ к ресурсам пользователя в облаке, выключите сервис:

{% list tabs group=instructions %}


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется облако, заданное в профиле CLI. Если в профиле CLI облако не задано или вы хотите задать другое облако, указывайте идентификатор нужного облака в команде в параметре `--cloud-id`.

  1. Посмотрите описание команды CLI для выключения сервиса:

      ```bash
      yc iam service-control disable --help
      ``` 

  1. [Получите](list-get.md#list) список и информацию о [статусах](../../concepts/service-control.md#access-status) сервисов, которые можно включать и выключать.

  1. Выполните команду, указав идентификатор сервиса, который требуется выключить:

      ```bash
      yc iam service-control disable <идентификатор_сервиса>
      ```

      Результат:

      ```text
      done (17s)
      service_id: dspm
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-13T09:40:40.339678Z"
      status: DISABLED
      ```

- API {#api}

  Воспользуйтесь методом REST API [disable](../../api-ref/ServiceControl/disable.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Disable](../../api-ref/grpc/ServiceControl/disable.md).

{% endlist %}

В результате [статус](../../concepts/service-control.md#access-status) сервиса в облаке изменится на `DISABLED`, [сервисные агенты](../../concepts/service-control.md#service-agent) этого сервиса в данном облаке будут удалены, а сервис потеряет доступ к ресурсам пользователя в этом облаке.

#### Полезные ссылки {#see-also}

* [Получение статусов сервисов](list-get.md)
* [Доступ сервисов к ресурсам пользователя](../../concepts/service-control.md)