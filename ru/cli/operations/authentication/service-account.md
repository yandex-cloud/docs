---
title: Как аутентифицироваться в {{ yandex-cloud }} CLI от имени сервисного аккаунта
description: Следуя данной инструкции, вы сможете аутентифицироваться в {{ yandex-cloud }} CLI от имени сервисного аккаунта.
---

# Аутентификация от имени сервисного аккаунта

{% note info %}

Выполняя действия от имени сервисного аккаунта, убедитесь, что ему [назначены](../../../iam/operations/sa/assign-role-for-sa.md) необходимые [роли](../../../iam/concepts/access-control/roles.md).

{% endnote %}

{% note warning %}

Создание сервисных аккаунтов и их [ключей](../../../iam/concepts/users/service-accounts.md#sa-key) может быть запрещено [политиками авторизации](../../../iam/concepts/access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

Узнайте как аутентифицироваться в {{ yandex-cloud }} CLI:

* [От имени сервисного аккаунта с помощью имперсонации](#use-impersonation)

  {% include [cli-sa-impersonate-intro](../../../_includes/cli/cli-sa-impersonate-intro.md) %}

* [От имени сервисного аккаунта с помощью авторизованного ключа](#auth-as-sa)

  {% include [cli-sa-key-intro](../../../_includes/cli/cli-sa-key-intro.md) %}

* [От имени сервисного аккаунта изнутри виртуальной машины](#vm-auth-as-sa)

  {% include [cli-sa-vm-intro](../../../_includes/cli/cli-sa-vm-intro.md) %}


[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) отличается от [аккаунта пользователя Яндекса](../../../iam/concepts/users/accounts.md#passport), [федеративного пользователя](../../../iam/concepts/federations.md) и [локального пользователя](../../../iam/concepts/users/accounts.md#local). Сервисный аккаунт нельзя использовать для входа в [консоль управления]({{ link-console-main }}), но можно использовать для управления ресурсами в {{ yandex-cloud }} с помощью CLI, {{ TF }} и API.


## Перед началом работы {#before-begin}

Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).

## Выполняйте действия от имени сервисного аккаунта с помощью имперсонации {#use-impersonation}

{% include [cli-sa-impersonate-intro](../../../_includes/cli/cli-sa-impersonate-intro.md) %}

{% include [impersonation-role-notice](../../../_includes/cli/impersonation-role-notice.md) %}

Чтобы выполнить действие от имени сервисного аккаунта:
1. [Установите](../install-cli.md) CLI.
1. Аутентифицируйтесь в CLI как [пользователь Яндекса](user.md), [федеративный пользователь](federated-user.md) или как [локальный пользователь](local-user.md).
1. {% include [list-sas](../../../_includes/cli/list-sas.md) %}
1. При выполнении команд {{ yandex-cloud }} CLI используйте [имперсонацию](../../../iam/concepts/access-control/impersonation.md) сервисного аккаунта, указывая его идентификатор в параметре `--impersonate-service-account-id`.

    Например, чтобы создать в каталоге по умолчанию [бакет](../../../storage/concepts/bucket.md) `my-sample-bucket` от имени сервисного аккаунта, выполните команду:

    ```bash
    yc storage bucket create \
      --name my-sample-bucket \
      --impersonate-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где `--impersonate-service-account-id` — идентификатор сервисного аккаунта, полученный ранее.

Для некоторых команд требуется указание уникального идентификатора облака и каталога. Вы можете запускать такие команды с параметрами `--cloud-id` и `--folder-id`.

## Аутентифицируйтесь от имени сервисного аккаунта с помощью авторизованного ключа {#auth-as-sa}

{% include [cli-sa-key-intro](../../../_includes/cli/cli-sa-key-intro.md) %}

1. [Установите](../install-cli.md) CLI.
1. Аутентифицируйтесь в CLI как [пользователь Яндекса](user.md), [федеративный пользователь](federated-user.md) или [локальный пользователь](local-user.md).

    {% note warning %}

    Аутентификация в CLI аккаунтом Яндекса, федеративным аккаунтом и аккаунтом локального пользователя осуществляется с помощью браузера и графического интерфейса.

    Если вы хотите использовать сервисный аккаунт для работы на сервере без графического интерфейса, выполните подготовительные действия на устройстве с графическим интерфейсом и браузером.

    {% endnote %}

1. Создайте авторизованный ключ и аутентифицируйтесь им в CLI:

    {% include [auth-as-sa](../../../_includes/cli/auth-as-sa.md) %}

## Аутентифицируйтесь от имени сервисного аккаунта изнутри виртуальной машины {#vm-auth-as-sa}

{% include [cli-sa-vm-intro](../../../_includes/cli/cli-sa-vm-intro.md) %}

{% include [vm-auth-as-sa](../../../_includes/cli/vm-auth-as-sa.md) %}


Подробная информация про работу с {{ yandex-cloud }} из ВМ в разделе [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).


#### Полезные ссылки {#see-also}

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

