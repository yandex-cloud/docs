---
title: Как получить информацию о политике доступа к реестру {{ container-registry-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о политике доступа к реестру.
---

# Получить информацию о политике доступа к реестру

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится реестр.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/tray.svg) **{{ ui-key.yacloud.cr.switch_registry }}**.
  1. Выберите реестр.
  1. На странице **{{ ui-key.yacloud.cr.registry.label_ip-permissions }}** отобразится подробная информация о политике доступа к реестру.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы узнать имя или идентификатор реестра, [получите](registry-list.md) список реестров в каталоге.
  
  Получите информацию о политике доступа к реестру:

  ```bash
  yc container registry list-ip-permissions <имя_реестра>
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

  Чтобы получить подробную информацию о политике доступа к реестру, воспользуйтесь методом REST API [listIpPermission](../../api-ref/Registry/listIpPermission.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListIpPermission](../../api-ref/grpc/registry_service.md#ListIpPermission).

{% endlist %}