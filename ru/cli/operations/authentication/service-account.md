---
title: Как аутентифицироваться в {{ yandex-cloud }} CLI от имени сервисного аккаунта
description: Следуя данной инструкции, вы сможете аутентифицироваться в {{ yandex-cloud }} CLI от имени сервисного аккаунта.
---

# Аутентификация от имени сервисного аккаунта

{% note info %}

Выполняя действия от имени сервисного аккаунта, убедитесь, что ему [назначены](../../../iam/operations/sa/assign-role-for-sa.md) необходимые [роли](../../../iam/concepts/access-control/roles.md).

{% endnote %}

Узнайте как аутентифицироваться в {{ yandex-cloud }} CLI:

* [От имени сервисного аккаунта с помощью имперсонации](#use-impersonation). Использование [имперсонации](../../../iam/concepts/access-control/index.md#impersonation) является рекомендованным и наиболее безопасным способом аутентифицироваться в {{ yandex-cloud }} CLI.
* [От имени сервисного аккаунта с помощью авторизованного ключа](#auth-as-sa). Использование [авторизованного ключа](../../../iam/concepts/authorization/key.md) позволяет постоянно аутентифицироваться в {{ yandex-cloud }} CLI с помощью однажды созданного авторизованного ключа. Использование долгоживущего ключа менее безопасно, чем использование имперсонации.
* [От имени сервисного аккаунта изнутри виртуальной машины](#vm-auth-as-sa). Использование привязанного к [виртуальной машине](../../../compute/concepts/vm.md) {{ compute-full-name }} [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) является рекомендованным способом аутентификации в {{ yandex-cloud }} CLI при работе на ВМ.

[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) отличается от [аккаунта пользователя](../../../iam/concepts/users/accounts.md#passport) или [федеративного пользователя](../../../iam/concepts/federations.md). Сервисный аккаунт нельзя использовать для входа в [консоль управления]({{ link-console-main }}), но можно использовать для управления ресурсами в {{ yandex-cloud }}.

## Перед началом работы {#before-begin}

1. Аутентифицируйтесь в CLI как [пользователь](user.md) или как [федеративный пользователь](federated-user.md).
1. Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).

## Выполняйте действия от имени сервисного аккаунта с помощью имперсонации {#use-impersonation}

{% include [impersonation-role-notice](../../../_includes/cli/impersonation-role-notice.md) %}

Чтобы выполнить действие от имени сервисного аккаунта:

1. {% include [list-sas](../../../_includes/cli/list-sas.md) %}
1. При выполнении команд {{ yandex-cloud }} CLI используйте [имперсонацию](../../../iam/concepts/access-control/index.md#impersonation) сервисного аккаунта, указывая его идентификатор в параметре `--impersonate-service-account-id`.

    Например, чтобы создать в каталоге по умолчанию [бакет](../../../storage/concepts/bucket.md) `my-sample-bucket` от имени сервисного аккаунта, выполните команду:

    ```bash
    yc storage bucket create \
      --name my-sample-bucket \
      --impersonate-service-account-id <идентификатор_сервисного_аккаунта>
    ```

Для некоторых команд требуется указание уникального идентификатора облака и каталога. Вы можете запускать такие команды с параметрами `--cloud-id` и `--folder-id`.

## Аутентифицируйтесь от имени сервисного аккаунта с помощью авторизованного ключа {#auth-as-sa}

{% include [auth-as-sa](../../../_includes/cli/auth-as-sa.md) %}

## Аутентифицируйтесь от имени сервисного аккаунта изнутри виртуальной машины {#vm-auth-as-sa}

{% include [vm-auth-as-sa](../../../_includes/cli/vm-auth-as-sa.md) %}


Подробная информация про работу с {{ yandex-cloud }} из ВМ в разделе [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).


#### См. также

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

