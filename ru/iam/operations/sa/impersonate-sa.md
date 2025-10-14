---
title: Как использовать имперсонацию в {{ iam-full-name }}
description: Следуя данной инструкции, вы узнаете, как выполнять операции с ресурсами {{ yandex-cloud }} от имени сервисного аккаунта с помощью имперсонации.
---

# Использование имперсонации

[Имперсонация](../../concepts/access-control/impersonation.md) позволяет пользователю выполнять действия от имени [сервисного аккаунта](../../concepts/users/service-accounts.md) с помощью параметра `--impersonate-service-account-id` в команде [{{ yandex-cloud }} CLI](../../../cli/index.yaml).

{% note info %}

Чтобы использовать имперсонацию:
* у сервисного аккаунта должны быть [права](../../roles-reference.md), необходимые для выполнения нужного действия с ресурсами {{ yandex-cloud }};
* пользователю должна быть назначена [роль](../../security/index.md#iam-serviceAccounts-tokenCreator) `iam.serviceAccounts.tokenCreator` на нужный сервисный аккаунт или на каталог, в котором находится этот сервисный аккаунт.

{% endnote %}

Чтобы выполнить операцию от имени сервисного аккаунта:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [Узнайте](./get-id.md) идентификатор сервисного аккаунта, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов (в профиле администратора):

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```
      +----------------------+----------+--------+---------------------+-----------------------+
      |          ID          |   NAME   | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
      +----------------------+----------+--------+---------------------+-----------------------+
      | ajebqtreob2d******** | test-sa  |        | 2024-09-08 18:59:45 | 2025-09-04 07:10:00   |
      | aje6o61dvog2******** | my-robot |        | 2023-06-27 16:18:18 | 2025-10-10 18:00:00   |
      +----------------------+----------+--------+---------------------+-----------------------+
      ```

  1. Назначьте сервисному аккаунту `test-sa` роль `viewer` на каталог `my-folder`. В типе субъекта укажите `serviceAccount`, а в значении — идентификатор сервисного аккаунта (в профиле администратора):

      ```
      yc resource-manager folder add-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. [Получите](../users/get.md) идентификатор пользователя и назначьте ему роль `iam.serviceAccounts.tokenCreator` на сервисный аккаунт `test-sa` (в профиле администратора):

      ```
      yc iam service-account add-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:<идентификатор_пользователя>
      ```

  1. Пользователь может выполнить команду от имени сервисного аккаунта `test-sa` с помощью параметра `--impersonate-service-account-id`.

      Например, пользователь может получить список виртуальных машин в каталоге `my-folder`:

      ```
      yc compute instance list \
        --folder-name my-folder \
        --impersonate-service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Также пользователь может получить [IAM-токен](../../concepts/authorization/iam-token.md) сервисного аккаунта `test-sa` для кратковременного доступа:

      ```
      yc iam create-token \
        --impersonate-service-account-id <идентификатор_сервисного_аккаунта>
      ```

      [Срок действия](../../concepts/authorization/iam-token.md#lifetime) полученного токена закончится автоматически.

  1. Если доступ больше не нужен пользователю, отзовите роль у сервисного аккаунта (в профиле администратора):

      ```
      yc resource-manager folder remove-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```
  1. Отзовите роль `iam.serviceAccounts.tokenCreator` у пользователя, получавшего права сервисного аккаунта:

      ```
      yc iam service-account remove-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:<идентификатор_пользователя>
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/access-control/impersonation.md)