---
title: "Как аутентифицироваться в CLI {{ yandex-cloud }} от имени сервисного аккаунта"
description: "Следуя данной инструкции, вы сможете аутентифицироваться в CLI от имени сервисного аккаунта." 
---

# Аутентификация от имени сервисного аккаунта

Узнайте как аутентифицироваться в CLI:
- [От имени сервисного аккаунта](#auth-as-sa).
- [От имени сервисного аккаунта изнутри виртуальной машины](#vm-auth-as-sa).

[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) отличается от [аккаунта пользователя](../../../iam/concepts/index.md#passport) или [федеративного пользователя](../../../iam/concepts/federations.md). Сервисный аккаунт нельзя использовать для входа в [консоль управления]({{ link-console-main }}), но можно использовать для управления ресурсами в {{ yandex-cloud }}.

## Перед началом работы {#before-begin}

1. Аутентифицируйтесь в CLI как [пользователь](user.md) или как [федеративный пользователь](federated-user.md).
1. Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).

## Аутентифицируйтесь от имени сервисного аккаунта {#auth-as-sa}

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

