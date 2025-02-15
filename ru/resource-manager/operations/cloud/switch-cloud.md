---
title: Инструкция по переключению на другое облако в {{ resmgr-full-name }}
description: Из статьи вы узнаете, как переключиться на другое облако в {{ resmgr-full-name }}.
---

# Переключение на другое облако

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке слева выберите нужное облако или каталог.

      ![image](../../../_assets/resource-manager/switch-cloud-n-n.png)

- CLI {#cli}

  Есть два способа выбрать облако, которое используется в CLI по умолчанию:
  * выбрать облако при [создании профиля](../../../cli/operations/profile/profile-create.md);
  * изменить параметр `cloud-id` в конфигурации профиля.

  Чтобы изменить параметр `cloud-id` для текущего профиля:

  1. Посмотрите описание команды для изменения параметров конфигурации:

      ```
      yc config set --help
      ```

  1. Узнайте идентификатор облака, которое вы хотите использовать. Для этого получите список доступных облаков:

      ```
      yc resource-manager cloud list
      +----------------------+----------------------+-------------------------------+
      |          ID          |         NAME         |          DESCRIPTION          |
      +----------------------+----------------------+-------------------------------+
      | b1gg8sgd16g7******** | cloud-b1gg8s******** | ...                           |
      | b1gjqgj3hhvj******** | cloud-b1gjqg******** | ...                           |
      +----------------------+----------------------+-------------------------------+
      ```

      {% note info %}

      Если в списке только одно облако, значит у вас нет доступа к другим облакам. Чтобы получить доступ к облаку, попросите [владельца](../../concepts/resources-hierarchy.md#owner) облака [добавить](../../../iam/operations/users/create.md) вас в его облако.

      {% endnote %}

  1. Укажите идентификатор облака, которое будет использоваться по умолчанию:

      ```
      yc config set cloud-id b1gjqgj3hhvj********
      ```

- API {#api}

  Сейчас нет возможности переключиться на другое облако с помощью API.

{% endlist %}
