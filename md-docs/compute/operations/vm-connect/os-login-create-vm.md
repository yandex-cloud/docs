# Создать виртуальную машину с {{ oslogin }}

[{{ oslogin }}](../../../organization/concepts/os-login.md) используется для предоставления пользователям и [сервисным аккаунтам](../../../iam/concepts/users/service-accounts.md) доступа к [виртуальным машинам](../../concepts/vm.md#project), полагаясь только на механизмы [сервиса {{ iam-full-name }}](../../../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ при ее создании.

{% note tip %}

Чтобы иметь возможность создавать виртуальные машины с доступом по {{ oslogin }} и [подключаться](os-login.md) к таким ВМ, [включите](../../../organization/operations/os-login-access.md) {{ oslogin }} на уровне [организации](../../../organization/quickstart.md) {{ yandex-cloud }}.

{% endnote %}

Чтобы подключиться к виртуальной машине или узлу {{ k8s }} с включенным доступом по {{ oslogin }} пользователю или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, должны быть назначены роли:

* [роль](../../security/index.md#compute-oslogin) `compute.osLogin` или `compute.osAdminLogin`.
* [роль](../../../resource-manager/security/index.md#resource-manager-auditor) `resource-manager.auditor` и выше на каталог, в котором размещена виртуальная машина или узел {{ k8s }}.
* [роль](../../security/index.md#compute-operator) `compute.operator` для подключении с помощью {{ yandex-cloud }} CLI.

К ВМ с включенным доступом по {{ oslogin }} можно подключиться как [с помощью CLI](os-login.md#connect-with-yc-cli), так и [с помощью стандартного SSH-клиента](os-login.md#connect-with-ssh-client). При подключении можно использовать SSH-сертификат или SSH-ключ, предварительно [добавленный](../../../organization/operations/add-ssh.md) в профиль {{ oslogin }} пользователя или сервисного аккаунта в {{ org-full-name }}.

{% note info %}

На создаваемой ВМ желательно создать локального пользователя и отдельно передать для него SSH-ключ: так вы сможете [подключиться к ВМ по SSH](ssh.md#vm-connect) даже в том случае, если отключите для нее доступ по {{ oslogin }}. Создать локального пользователя ВМ и передать SSH-ключ для него можно с помощью [метаданных](../../concepts/metadata/sending-metadata.md).

Для пользователей, добавленных через метаданные:

* после включения доступа к ВМ по {{ oslogin }} из метаданных удаляются ключи, указанные в `user-data` и `ssh-keys`;
* после отключения доступа к ВМ по {{ oslogin }} удаленные ключи пересоздаются.

{% endnote %}

Чтобы создать ВМ с {{ oslogin }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Включите [доступ по {{ oslogin }}](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по {{ oslogin }}. Такие образы доступны в [{{ marketplace-full-name }}](https://yandex.cloud/ru/marketplace).
  
     При создании ВМ в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**. Если эта опция недоступна, значит выбранный образ не поддерживает доступ по {{ oslogin }}.
  
     Чтобы получить возможность [подключаться](ssh.md#vm-connect) к ВМ по SSH без использования {{ oslogin }}, [измените](../vm-control/vm-update.md) настройки ВМ и в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}**.

- CLI {#cli}

  1. Включите [доступ по {{ oslogin }}](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по {{ oslogin }}.
  
     При создании ВМ задайте параметр, включающий доступ через {{ oslogin }}:

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

  1. [Создайте ВМ](../vm-create/create-linux-vm.md) с помощью метода REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) из публичного образа с поддержкой доступа по {{ oslogin }}.

     При создании ВМ передайте в поле `metadata` пару `enable-oslogin=true`.

{% endlist %}

После того как созданная ВМ перейдет в статус `Running`, вы сможете [подключиться](os-login.md) к ней по {{ oslogin }}.

{% note info %}

Для сервисных аккаунтов [профили {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) не создаются автоматически. Чтобы подключаться к ВМ или узлу {{ k8s }} от имени сервисного аккаунта, [вручную создайте](../../../organization/operations/os-login-profile-create.md) для него профиль {{ oslogin }}.

{% endnote %}