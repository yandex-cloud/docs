---
title: Как получить идентификатор или почту пользователя в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете получить идентификатор или почту пользователя.
---

# Получить идентификатор или почту пользователя

Вы можете получить следующую информацию о пользователях, которые зарегистрированы в организации:
* идентификатор;
* логин;
* почта;
* идентификатор федерации.

{% note info %}

Получить идентификатор или почту может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [Роли](../security/index.md#admin).

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  {% include [users-info](../../_includes/users-info.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды получения информации о пользователях организации:

      ```bash
      yc organization-manager user list --help
      ```

  1. С помощью команды, получите информацию о пользователях, указав идентификатор организации:

      ```bash
      yc organization-manager user list --organization-id <идентификатор_организации>
      ```

      Где `organization-id` — идентификатор организации.

      Результат:

      ```text
      +----------------------+----------+--------------------------+-----------------------+
      |          ID          | USERNAME |          EMAIL           |     FEDERATION ID     |
      +----------------------+----------+--------------------------+-----------------------+
      | ajeebjmlsdk9******** | hatter   | hatter@{{yandex-domain}} | gyuiawudhiks********  |
      | bsdeoujmzsdk******** | alice    | alice@{{yandex-domain}}  |                       |
      +----------------------+----------+--------------------------+-----------------------+
      ```

- API {#api}

  Получите параметры пользователя с помощью [запроса к API](../api-ref/User/listMembers.md).

{% endlist %}