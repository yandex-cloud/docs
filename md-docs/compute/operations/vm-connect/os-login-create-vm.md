[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Работа на виртуальной машине > OS Login > Создать ВМ с OS Login

# Создать виртуальную машину с OS Login

[OS Login](../../../organization/concepts/os-login.md) используется для предоставления пользователям и [сервисным аккаунтам](../../../iam/concepts/users/service-accounts.md) доступа к [виртуальным машинам](../../concepts/vm.md#project), полагаясь только на механизмы [сервиса Yandex Identity and Access Management](../../../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ при ее создании.

{% note tip %}

Чтобы иметь возможность создавать виртуальные машины с доступом по OS Login и [подключаться](os-login.md) к таким ВМ, [включите](../../../organization/operations/os-login-access.md) OS Login на уровне [организации](../../../organization/quickstart.md) Yandex Cloud.

{% endnote %}

Чтобы подключиться к виртуальной машине или узлу Kubernetes с включенным доступом по OS Login пользователю или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, должны быть назначены роли:

* [роль](../../security/index.md#compute-oslogin) `compute.osLogin` или `compute.osAdminLogin`.
* [роль](../../../resource-manager/security/index.md#resource-manager-auditor) `resource-manager.auditor` и выше на каталог, в котором размещена виртуальная машина или узел Kubernetes.
* [роль](../../security/index.md#compute-operator) `compute.operator` для подключении с помощью Yandex Cloud CLI.

К ВМ с включенным доступом по OS Login можно подключиться как [с помощью CLI](os-login.md#connect-with-yc-cli), так и [с помощью стандартного SSH-клиента](os-login.md#connect-with-ssh-client). При подключении можно использовать SSH-сертификат или SSH-ключ, предварительно [добавленный](../../../organization/operations/add-ssh.md) в профиль OS Login пользователя или сервисного аккаунта в Yandex Identity Hub.

{% note info %}

На создаваемой ВМ желательно создать локального пользователя и отдельно передать для него SSH-ключ: так вы сможете [подключиться к ВМ по SSH](ssh.md#vm-connect) даже в том случае, если отключите для нее доступ по OS Login. Создать локального пользователя ВМ и передать SSH-ключ для него можно с помощью [метаданных](../../concepts/metadata/sending-metadata.md).

Для пользователей, добавленных через метаданные:

* после включения доступа к ВМ по OS Login из метаданных удаляются ключи, указанные в `user-data` и `ssh-keys`;
* после отключения доступа к ВМ по OS Login удаленные ключи пересоздаются.

{% endnote %}

Чтобы создать ВМ с OS Login:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по OS Login. Такие образы доступны в [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace).
  
     При создании ВМ в блоке **Доступ** выберите вариант **Доступ по OS Login**. Если эта опция недоступна, значит выбранный образ не поддерживает доступ по OS Login.
  
     Чтобы получить возможность [подключаться](ssh.md#vm-connect) к ВМ по SSH без использования OS Login, [измените](../vm-control/vm-update.md) настройки ВМ и в блоке **Доступ** выберите вариант **SSH-ключ**.

- CLI {#cli}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по OS Login.
  
     При создании ВМ задайте параметр, включающий доступ через OS Login:

     ```bash
     --metadata enable-oslogin=true
     ```

- Terraform {#tf}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../images-with-pre-installed-software/create.md) из подготовленного образа с поддержкой доступа по OS Login.
  
     При создании ВМ для ресурса `yandex_compute_instance` укажите в блоке параметров `metadata` параметр, включающий доступ через OS Login:

     ```hcl
     metadata = {
       enable-oslogin = true
     }
     ```

- API {#api}

  1. Включите [доступ по OS Login](../../../organization/operations/os-login-access.md) на уровне организации.

  1. [Создайте ВМ](../vm-create/create-linux-vm.md) с помощью метода REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) из публичного образа с поддержкой доступа по OS Login.

     При создании ВМ передайте в поле `metadata` пару `enable-oslogin=true`.

{% endlist %}

После того как созданная ВМ перейдет в статус `Running`, вы сможете [подключиться](os-login.md) к ней по OS Login.

{% note info %}

Для сервисных аккаунтов [профили OS Login](../../../organization/concepts/os-login.md#os-login-profiles) не создаются автоматически. Чтобы подключаться к ВМ или узлу Kubernetes от имени сервисного аккаунта, [вручную создайте](../../../organization/operations/os-login-profile-create.md) для него профиль OS Login.

{% endnote %}