# Получение информации о доступах сервисов

{% include notitle [preview](../../../_includes/note-preview.md) %}

В Yandex Identity and Access Management есть возможность управлять [доступом сервисов](../../concepts/service-control.md) к ресурсам в облаке.

## Получение списка сервисов {#list}

Чтобы получить список сервисов, доступом которых в облаке можно управлять:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для получения списка сервисов, доступом которых к ресурсам облака можно управлять:

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
      | connection-manager | DISABLED |
      | mdb                | DISABLED |
      +--------------------+----------+
      ```

- API {#api}

  Воспользуйтесь методом REST API [list](../../api-ref/ServiceControl/list.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/List](../../api-ref/grpc/service_control_service.md#List).

{% endlist %}

## Получение информации о доступе сервиса {#get}

Чтобы получить информацию о доступе сервиса к ресурсам облака:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для получения информации о доступе сервиса к ресурсам облака:

      ```bash
      yc iam service-control get --help
      ``` 

  1. [Получите](#list) список сервисов, доступом которых можно управлять.

  1. Выполните команду, указав идентификатор сервиса, информацию о доступе которого к ресурсам облака требуется получить:

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

  Воспользуйтесь методом REST API [get](../../api-ref/ServiceControl/get.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Get](../../api-ref/grpc/service_control_service.md#Get).

{% endlist %}