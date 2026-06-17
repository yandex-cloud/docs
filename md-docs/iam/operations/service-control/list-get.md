# Получение статусов сервисов


В Yandex Identity and Access Management есть возможность управлять [доступом сервисов](../../concepts/service-control.md) к ресурсам пользователя в определенном облаке.

## Получение списка сервисов {#list}

Чтобы получить список сервисов, доступом которых в облаке можно управлять:

{% list tabs group=instructions %}


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется облако, заданное в профиле CLI. Если в профиле CLI облако не задано или вы хотите задать другое облако, указывайте идентификатор нужного облака в команде в параметре `--cloud-id`.

  1. Посмотрите описание команды CLI для получения списка сервисов, доступом которых можно управлять:

      ```bash
      yc iam service-control list --help
      ``` 

  1. Выполните команду:

      ```bash
      yc iam service-control list \
        --limit <количество_сервисов>
      ```

      Где `--limit` — количество сервисов, которые требуется вывести в списке. Необязательный параметр.

      Результат:

      ```text
      +--------------------+----------+
      |     SERVICE ID     |  STATUS  |
      +--------------------+----------+
      | asset-manager      | DEFAULT  |
      | backup             | DEFAULT  |
      | cloud-registry     | ENABLED  |
      | connection-manager | ENABLED  |
      | data-catalog       | DEFAULT  |
      | datasphere         | DISABLED |
      | disk-encryption    | DEFAULT  |
      | dspm               | ENABLED  |
      | security-deck      | ENABLED  |
      | src-integration    | DISABLED |
      | websql             | ENABLED  |
      +--------------------+----------+
      ```

- API {#api}

  Воспользуйтесь методом REST API [list](../../api-ref/ServiceControl/list.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/List](../../api-ref/grpc/ServiceControl/list.md).

{% endlist %}

## Получение информации о статусе сервиса {#get}

Чтобы получить информацию о [статусе](../../concepts/service-control.md#access-status) сервиса в облаке:

{% list tabs group=instructions %}


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется облако, заданное в профиле CLI. Если в профиле CLI облако не задано или вы хотите задать другое облако, указывайте идентификатор нужного облака в команде в параметре `--cloud-id`.

  1. Посмотрите описание команды CLI для получения информации о статусе сервиса в облаке:

      ```bash
      yc iam service-control get --help
      ``` 

  1. [Получите](#list) список сервисов, доступом которых можно управлять.

  1. Выполните команду, указав идентификатор сервиса, информацию о статусе которого в данном облаке требуется получить:

      ```bash
      yc iam service-control get <идентификатор_сервиса>
      ```

      Результат:

      ```text
      service_id: connection-manager
      resource:
        id: aoenvj7ssrvr********
        type: resource-manager.cloud
      updated_at: "2024-03-13T07:21:00.808442047Z"
      status: DISABLED
      ```

- API {#api}

  Воспользуйтесь методом REST API [get](../../api-ref/ServiceControl/get.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Get](../../api-ref/grpc/ServiceControl/get.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Включение и выключение сервиса](enable-disable.md)
* [Доступ сервисов к ресурсам пользователя](../../concepts/service-control.md)