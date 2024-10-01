---
title: "Как создать виртуальную машину с OS Login"
description: "Следуя данной инструкции, вы сможете создать виртуальную машину с возможностью доступа по OS Login."
---

# Создать виртуальную машину с OS Login

[OS Login](../../../organization/concepts/os-login.md) используется для предоставления пользователям и сервисным аккаунтам доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ, которая поддерживает OS Login на уровне операционной системы, [назначьте](../../../iam/operations/roles/grant.md) пользователю роли:

{% include [os-login-roles-needed-for-vm-access](../../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

К ВМ с включенным доступом по OS Login можно подключиться как [с помощью YC CLI](os-login.md#connect-with-yc-cli), так и [с помощью стандартного SSH-клиента](os-login.md#connect-with-ssh-client). При подключении можно использовать SSH-сертификат или SSH-ключ, предварительно [добавленный](../../../organization/operations/add-ssh.md) в профиль OS Login пользователя или сервисного аккаунта в {{ org-full-name }}.

При этом на создаваемой ВМ желательно создать локального пользователя и отдельно передать для него SSH-ключ: так вы сможете [подключаться к ВМ по SSH](./ssh.md#vm-connect), если отключите для нее доступ по OS Login. Создать локального пользователя ВМ и передать SSH-ключ для него можно с помощью [метаданных](../../concepts/vm-metadata.md#how-to-send-metadata).

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}

Чтобы создать ВМ с OS Login:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по OS Login. Такие образы доступны в [{{ marketplace-full-name }}](/marketplace).
  
     При создании ВМ в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** включите опцию **Доступ через OS Login**.
  
     Чтобы получить возможность [подключаться](./ssh.md#vm-connect) к ВМ по SSH без использования OS Login, [измените](../vm-control/vm-update.md) настройки ВМ, отключив эту опцию.

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