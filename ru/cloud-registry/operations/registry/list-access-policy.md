---
title: Как получить информацию о политике доступа к реестру {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о политике доступа к реестру.
---

# Получить информацию о политике доступа к реестру

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Выберите реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cloud-registry.title_ip-permissions }}**. На странице отобразится подробная информация о политике доступа к реестру.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Получите информацию о политике доступа к реестру:

  ```bash
  yc cloud-registry registry list-ip-permissions <имя_или_идентификатор_реестра>
  ```

  Результат:

  ```text
  +--------+---------------+
  | ACTION |  IP           |
  +--------+---------------+
  | PULL   | 217.132.72.25 |
  +--------+---------------+
  ```

- API {#api}

  Чтобы получить подробную информацию о политике доступа к реестру, воспользуйтесь методом REST API [listIpPermissions](../../api-ref/Registry/listIpPermissions.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListIpPermissions](../../api-ref/grpc/Registry/listIpPermissions.md).

{% endlist %}
