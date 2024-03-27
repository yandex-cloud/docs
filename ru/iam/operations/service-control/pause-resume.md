# Приостановка и возобновление доступа сервисов

{% include notitle [preview](../../../_includes/note-preview.md) %}

В Yandex Identity and Access Management есть возможность приостанавливать и возобновлять [доступ сервисов](../../concepts/service-control.md) к ресурсам в облаке.

{% include [service-control-access](../../../_includes/iam/service-control-access.md) %}

## Приостановка доступа сервиса {#pause}

Приостановить доступ сервиса к облаку возможно даже в том случае, если у этого сервиса есть ресурсы, использующие в своей работе ресурсы других сервисов облака.

{% note alert %}

Если для работы ресурсов сервиса необходим доступ к другим ресурсам в облаке, то приостановка доступа к облаку для этого сервиса может привести к нарушениям в работе ресурсов, в т.ч. к потере данных. 

{% endnote %}

Чтобы приостановить доступ сервиса к ресурсам облака:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для приостановки доступа сервиса к ресурсам облака:

      ```bash
      yc iam service-control pause --help
      ``` 

  1. [Получите](./list-get.md#list) список сервисов, доступом которых можно управлять.

  1. Выполните команду, указав идентификатор сервиса, для которого требуется приостановить доступ к ресурсам облака:

      ```bash
      yc iam service-control pause <идентификатор_сервиса> \
        --force
      ```

      Где `--force` — параметр, который позволяет приостановить доступ сервиса в том случае, если в сервисе есть ресурсы, для работы которых необходим доступ к ресурсам других сервисов облака. Необязательный параметр.

      Результат:

      ```text
      done (11s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:22:23.609016Z"
      status: PAUSED
      ```

- API {#api}

  Воспользуйтесь методом REST API [pause](../../api-ref/ServiceControl/pause.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Pause](../../api-ref/grpc/service_control_service.md#Pause).

{% endlist %}

## Возобновление доступа сервиса {#resume}

Возобновить доступ возможно только для сервиса, доступ к которому ранее был [приостановлен](#pause).

Чтобы возобновить доступ сервиса к ресурсам облака:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для возобновления доступа сервиса к ресурсам облака:

      ```bash
      yc iam service-control resume --help
      ``` 

  1. [Получите](./list-get.md#list) список сервисов, доступом которых можно управлять.

  1. Выполните команду, указав идентификатор сервиса, для которого требуется возобновить доступ к ресурсам облака:

      ```bash
      yc iam service-control resume <идентификатор_сервиса>
      ```

      Результат:

      ```text
      done (10s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:22:58.247213Z"
      status: ENABLED
      ```

- API {#api}

  Воспользуйтесь методом REST API [resume](../../api-ref/ServiceControl/resume.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Resume](../../api-ref/grpc/service_control_service.md#Resume).

{% endlist %}