---
title: Получение информации о статусах сервисов {{ yandex-cloud }}
description: С помощью этой инструкции вы научитесь получать информацию о статусах сервисов в облаке {{ yandex-cloud }}.
---

# Получение статусов сервисов



{% include notitle [preview](../../../_includes/note-preview.md) %}


В {{ iam-full-name }} есть возможность управлять [доступом сервисов](../../concepts/service-control.md) к ресурсам пользователя в определенном облаке.

## Получение списка сервисов {#list}

Чтобы получить список сервисов, доступом которых в облаке можно управлять:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

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
      | connection-manager | ENABLED  |
      | datasphere         | DISABLED |
      | disk-encryption    | DEFAULT  |
      | dspm               | DEFAULT  |
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

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

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

#### См. также {#see-also}

* [{#T}](./enable-disable.md)
* [{#T}](../../concepts/service-control.md)