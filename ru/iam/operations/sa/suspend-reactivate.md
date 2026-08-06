---
title: Как заблокировать и разблокировать сервисный аккаунт
description: Следуя данной инструкции, вы сможете заблокировать и разблокировать сервисный аккаунт.
---

# Блокировка и разблокировка сервисного аккаунта

Чтобы [заблокировать](#suspend) или [разблокировать](#reactivate) сервисный аккаунт, у вас должна быть роль `editor` на сервисный аккаунт. Также подойдет [роль](../../security/index.md#iam-serviceAccounts-admin) `{{ roles-iam-sa-admin }}` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит аккаунт.

## Заблокировать сервисный аккаунт {#suspend}

Чтобы приостановить работу [сервисного аккаунта](../../concepts/users/service-accounts.md) в {{ yandex-cloud }}, заблокируйте его. Все роли аккаунта сохраняются, но перестают действовать до разблокировки.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды блокировки сервисного аккаунта:

      ```bash
      yc iam service-account suspend --help
      ```

  1. Получите список сервисных аккаунтов в каталоге по умолчанию:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

  1. Заблокируйте сервисный аккаунт, указав его имя или идентификатор:

      ```bash
      yc iam service-account suspend <имя_или_идентификатор_аккаунта>
      ```

      Например:

      ```bash
      yc iam service-account suspend my-robot
      ```

- API {#api}

  Чтобы заблокировать сервисный аккаунт, воспользуйтесь методом REST API [suspend](../../api-ref/ServiceAccount/suspend.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Suspend](../../api-ref/grpc/ServiceAccount/suspend.md).

{% endlist %}

## Разблокировать сервисный аккаунт {#reactivate}

Чтобы возобновить работу [сервисного аккаунта](../../concepts/users/service-accounts.md) в {{ yandex-cloud }}, разблокируйте его.

Если система автоматически заблокировала аккаунт по истечении срока жизни (параметр `--expires-at`), [укажите](update.md#update-expires-at) новый срок жизни [сервисного аккаунта](../../concepts/users/service-accounts.md#sa-suspend) или выполните команду `reactivate` по инструкции ниже.

{% note warning %}

Команда `reactivate` снимет блокировку, но не изменит параметр `expires-at`. Если вы не [обновите](update.md#update-expires-at) срок жизни сервисного аккаунта, система повторно заблокирует аккаунт.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды разблокировки сервисного аккаунта:

      ```bash
      yc iam service-account reactivate --help
      ```

  1. Получите список сервисных аккаунтов в каталоге по умолчанию:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

  1. Разблокируйте сервисный аккаунт, указав его имя или идентификатор:

      ```bash
      yc iam service-account reactivate <имя_или_идентификатор_аккаунта>
      ```

      Например:

      ```bash
      yc iam service-account reactivate my-robot
      ```

- API {#api}

  Чтобы разблокировать сервисный аккаунт, воспользуйтесь методом REST API [reactivate](../../api-ref/ServiceAccount/reactivate.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Reactivate](../../api-ref/grpc/ServiceAccount/reactivate.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/users/service-accounts.md)
* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](delete.md)
