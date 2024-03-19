# Выдача и отзыв доступа сервисов

{% include notitle [preview](../../../_includes/note-preview.md) %}

В Yandex Identity and Access Management есть возможность выдавать и отзывать [доступ сервисов](../../concepts/service-control.md) к ресурсам в облаке.

{% include [service-control-access](../../../_includes/iam/service-control-access.md) %}

## Выдача доступа сервису {#enable}

Чтобы выдать сервису доступ к ресурсам облака:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для выдачи сервису доступа к ресурсам облака:

      ```bash
      yc iam service-control enable --help
      ``` 

  1. [Получите](./list-get.md#list) список сервисов, доступом которых можно управлять.

  1. Выполните команду, указав идентификатор сервиса, которому требуется выдать доступ к ресурсам облака:

      ```bash
      yc iam service-control enable <идентификатор_сервиса>
      ```

      Результат:

      ```text
      done (31s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:21:12.331340Z"
      status: ENABLED
      ```

- API {#api}

  Воспользуйтесь методом REST API [enable](../../api-ref/ServiceControl/enable.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Enable](../../api-ref/grpc/service_control_service.md#Enable).

{% endlist %}

## Отзыв доступа у сервиса {#disable}

Отозвать у сервиса доступ к облаку можно только в том случае, если в этом сервисе нет ресурсов, которые связаны с ресурсами какого-то другого сервиса в облаке. Если такие ресурсы есть, предварительно удалите их, либо вместо отзыва у сервиса доступа [приостановите](./pause-resume.md#pause) его.

Чтобы отозвать у сервиса доступ к ресурсам облака:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для отзыва у сервиса доступа к ресурсам облака:

      ```bash
      yc iam service-control disable --help
      ``` 

  1. [Получите](./list-get.md#list) список сервисов, доступом которых можно управлять.

  1. Выполните команду, указав идентификатор сервиса, у которого требуется отозвать доступ к ресурсам облака:

      ```bash
      yc iam service-control disable <идентификатор_сервиса>
      ```

      Результат:

      ```text
      done (17s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-13T09:40:40.339678Z"
      status: DISABLED
      ```

- API {#api}

  Воспользуйтесь методом REST API [disable](../../api-ref/ServiceControl/disable.md) для ресурса [ServiceControl](../../api-ref/ServiceControl/index.md) или вызовом gRPC API [ServiceControlService/Disable](../../api-ref/grpc/service_control_service.md#Disable).

{% endlist %}