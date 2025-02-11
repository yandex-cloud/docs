---
title: Как создать виртуальную машину с {{ oslogin }}
description: Следуя данной инструкции, вы сможете создать виртуальную машину с возможностью доступа по {{ oslogin }}.
---

# Создать виртуальную машину с {{ oslogin }}

[{{ oslogin }}](../../../organization/concepts/os-login.md) используется для предоставления пользователям и сервисным аккаунтам доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ, которая поддерживает {{ oslogin }} на уровне операционной системы, [назначьте](../../../iam/operations/roles/grant.md) пользователю роли:

{% include [os-login-roles-needed-for-vm-access](../../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

К ВМ с включенным доступом по {{ oslogin }} можно подключиться как [с помощью YC CLI](os-login.md#connect-with-yc-cli), так и [с помощью стандартного SSH-клиента](os-login.md#connect-with-ssh-client). При подключении можно использовать SSH-сертификат или SSH-ключ, предварительно [добавленный](../../../organization/operations/add-ssh.md) в профиль {{ oslogin }} пользователя или сервисного аккаунта в {{ org-full-name }}.

При этом на создаваемой ВМ желательно создать локального пользователя и отдельно передать для него SSH-ключ: так вы сможете [подключаться к ВМ по SSH](./ssh.md#vm-connect), если отключите для нее доступ по {{ oslogin }}. Создать локального пользователя ВМ и передать SSH-ключ для него можно с помощью [метаданных](../../concepts/vm-metadata.md#how-to-send-metadata).

{% include [metadata-keys](../../../_includes/compute/os-login-enablement-notice.md) %}

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}

Чтобы создать ВМ с {{ oslogin }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Включите [доступ по {{ oslogin }}](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по {{ oslogin }}. Такие образы доступны в [{{ marketplace-full-name }}](/marketplace).
  
     При создании ВМ в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**. Если эта опция недоступна, значит выбранный образ не поддерживает доступ по {{ oslogin }}.
  
     Чтобы получить возможность [подключаться](./ssh.md#vm-connect) к ВМ по SSH без использования {{ oslogin }}, [измените](../vm-control/vm-update.md) настройки ВМ, отключив эту опцию.

- CLI {#cli}

  1. Включите [доступ по {{ oslogin }}](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по {{ oslogin }}.
  
     При создании ВМ добавьте флаг, включающий доступ через {{ oslogin }}:

     ```bash
     --metadata enable-oslogin=true
     ```

- {{ TF }} {#tf}

  1. Включите [доступ по {{ oslogin }}](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по {{ oslogin }}.
  
     При создании ВМ для ресурса `yandex_compute_instance` укажите в блоке параметров `metadata` параметр, включающий доступ через {{ oslogin }}:

     ```hcl
     metadata = {
       enable-oslogin = true
     }
     ```

- API {#api}

  1. Включите [доступ по {{ oslogin }}](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../vm-create/create-linux-vm.md) с помощью метода REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) из публичного образа с поддержкой доступа по {{ oslogin }}.

     При создании ВМ передайте в поле `metadata` пару `enable-oslogin=true`.

{% endlist %}

После того как созданная ВМ перейдет в статус `Running`, вы сможете [подключиться](./os-login.md) к ней по {{ oslogin }}.