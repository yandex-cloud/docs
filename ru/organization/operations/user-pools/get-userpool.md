---
title: Как получить информацию о пуле пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы получите информацию о пуле пользователей в {{ org-name }}.
---

# Получить информацию о пуле пользователей


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool get --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool get <идентификатор_пула>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Get](../../idp/api-ref/Userpool/get.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Get](../../idp/api-ref/grpc/Userpool/get.md).

{% endlist %}