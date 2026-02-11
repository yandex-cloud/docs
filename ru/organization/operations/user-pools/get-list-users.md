---
title: Как получить список пользователей в пуле в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете получить список пользователей в пуле в {{ org-name }}.
---

# Получить список пользователей в пуле


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. Перейдите на вкладку **Участники**. Отобразится список всех пользователей пула.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка пользователей в [пуле](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user list --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp user list --userpool-id <идентификатор_пула>
      ```

      Где `--userpool-id` — идентификатор пула, список пользователей которого нужно получить.

- API {#api}

  Воспользуйтесь методом REST API [User.List](../../idp/api-ref/User/list.md) для ресурса [User](../../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/List](../../idp/api-ref/grpc/User/list.md).

{% endlist %}