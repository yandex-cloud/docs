---
title: Включение и выключение сервисов {{ yandex-cloud }}
description: С помощью этой инструкции вы научитесь включать и выключать сервисы, чтобы управлять их доступом к ресурсам пользователя в облаке {{ yandex-cloud }}.
---

# Включение и выключение сервиса



{% include notitle [preview](../../../_includes/note-preview.md) %}


В {{ iam-full-name }} есть возможность включать и выключать [доступ сервисов](../../concepts/service-control.md) к ресурсам пользователя в определенном облаке.

{% include [service-control-access](../../../_includes/iam/service-control-access.md) %}

## Включение сервиса {#enable}

Чтобы выдать сервису доступ к ресурсам в облаке пользователя, включите этот сервис:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для включения сервиса:

      ```bash
      yc iam service-control enable --help
      ``` 

  1. [Получите](./list-get.md#list) список и информацию о [статусах](../../concepts/service-control.md#access-status) сервисов, которые можно включать и выключать.

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

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. Посмотрите описание команды CLI для выключения сервиса:

      ```bash
      yc iam service-control disable --help
      ``` 

  1. [Получите](./list-get.md#list) список и информацию о [статусах](../../concepts/service-control.md#access-status) сервисов, которые можно включать и выключать.

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

#### См. также {#see-also}

* [{#T}](./list-get.md)
* [{#T}](../../concepts/service-control.md)