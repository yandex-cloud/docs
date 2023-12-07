---
title: "Как создать виртуальную машину с OS Login"
description: "Следуя данной инструкции, вы сможете создать виртуальную машину с возможностью доступа через OS Login."
---

# Создать виртуальную машину с OS Login

{% include notitle [preview](../../../_includes/note-preview-by-request.md) %}

[OS Login](../../../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ, которая поддерживает OS Login на уровне операционной системы, [назначьте](../../../iam/operations/roles/grant.md) пользователю роль `compute.osLogin` или `compute.osAdminLogin`.

К ВМ с включенным доступом через OS Login нельзя подключиться с помощью [пары SSH-ключей](./ssh.md#creating-ssh-keys). Тем не менее в создаваемую ВМ желательно передать SSH-ключи: так вы сможете [подключиться к ВМ по SSH](./ssh.md#vm-connect), если отключите для нее доступ через OS Login. Передать в виртуальную машину SSH-ключи можно с помощью [метаданных](../../concepts/vm-metadata.md).

1. Включите [доступ через OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа через OS Login. Такие образы доступны в [{{ marketplace-full-name }}](/marketplace) и содержат `OS Login` в названии.

    При создании ВМ включите опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.

После того как созданная ВМ перейдет в статус `Running`, вы сможете [подключиться](./os-login.md) к ней через OS Login.

Чтобы получить возможность подключаться к созданной ВМ по SSH, нужно отключить для нее доступ через OS Login. Для этого [измените](../vm-control/vm-update.md) настройки ВМ, отключив опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.