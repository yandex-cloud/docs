---
title: "Как создать виртуальную машину с OS Login"
description: "Следуя данной инструкции, вы сможете создать виртуальную машину с возможностью доступа по OS Login."
---

# Создать виртуальную машину с OS Login

[OS Login](../../../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ, которая поддерживает OS Login на уровне операционной системы, [назначьте](../../../iam/operations/roles/grant.md) пользователю роль `compute.osLogin` или `compute.osAdminLogin`.

К ВМ с включенным доступом по OS Login можно подключиться c SSH-сертификатом [через YC CLI](os-login.md#connect-via-cli) или [через стандартный SSH-клиент](os-login.md#connect-via-exported-certificate), а также через YC CLI [с SSH-ключом](os-login.md#connect-via-key), предварительно добавленным в профиль пользователя организации в {{ org-full-name }}.

При этом в создаваемую ВМ желательно передать SSH-ключи: так вы сможете [подключиться к ВМ по SSH](./ssh.md#vm-connect), если отключите для нее доступ по OS Login. Передать в виртуальную машину SSH-ключи можно с помощью [метаданных](../../concepts/vm-metadata.md#how-to-send-metadata).

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}

Чтобы создать ВМ с OS Login:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по OS Login. Такие образы доступны в [{{ marketplace-full-name }}](/marketplace) и содержат `OS Login` в названии.
  
     При создании ВМ включите опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.

     Чтобы получить возможность [подключаться](./ssh.md#vm-connect) к ВМ по SSH без использования OS Login, [измените](../vm-control/vm-update.md) настройки ВМ, отключив опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.

- CLI {#cli}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по OS Login.
  
     При создании ВМ добавьте флаг, включающий доступ через OS Login:

     ```bash
     --metadata enable-oslogin=true
     ```

- API {#api}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../vm-create/create-linux-vm.md) с помощью метода REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) из публичного образа с поддержкой доступа по OS Login.

     При создании ВМ передайте в поле `metadata` пару `enable-oslogin=true`.

{% endlist %}

После того как созданная ВМ перейдет в статус `Running`, вы сможете [подключиться](./os-login.md) к ней по OS Login.