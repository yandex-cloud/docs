# Включить доступ по OS Login

{% note info %}

Если на уровне организации [включен](os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.

{% endnote %}

С помощью сервиса [OS Login](../concepts/os-login.md) вы можете управлять SSH-доступом к [виртуальным машинам](../../compute/concepts/vm.md#project) и [отдельным узлам в группах узлов](../../managed-kubernetes/concepts/index.md#node-group) в составе [кластеров Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), полагаясь только на механизмы [сервиса Yandex Identity and Access Management](../../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ или узел Kubernetes при их создании. OS Login связывает учетную запись пользователя ВМ или узла Kubernetes с аккаунтом в Yandex Identity Hub — учетной записью [пользователя организации](../concepts/membership.md) или [сервисным аккаунтом](../../iam/concepts/users/service-accounts.md).

{% note alert %}

Если у пользователя есть права [суперпользователя](https://ru.wikipedia.org/wiki/Root) на ВМ, то он может сохранить доступ к ней даже при [отзыве ролей](../security/index.md#revoke). Чтобы пользователь не смог зайти на ВМ с прежними правами, [создайте](../../compute/operations/images-with-pre-installed-software/create.md) новую ВМ из чистого образа.

{% endnote %}

Чтобы создавать виртуальные машины или узлы Kubernetes с доступом по OS Login, разрешите такую возможность на уровне организации. Для этого:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.

  1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **Настройки безопасности**.

  1. Включите необходимые режимы работы:

      * **Доступ по OS Login при помощи SSH-сертификатов (рекомендуется)**.
          Режим позволяет подключаться к ВМ или узлу кластера Kubernetes по SSH-сертификату [через Yandex Cloud CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client).

      * **Доступ по OS Login при помощи SSH-ключей**.
          Режим позволяет подключаться к ВМ или узлу кластера Kubernetes через Yandex Cloud CLI или через стандартный SSH-клиент по SSH-ключу, сохраненному в [профиле OS Login](../concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

      * **Разрешить членам организации управлять своими SSH-ключами**.
          Позволяет пользователям самостоятельно загружать в свои профили OS Login публичные SSH-ключи для подключения к ВМ или узлам кластеров Kubernetes.

          Добавить в профиль новый SSH-ключ можно в консоли управления при создании ВМ или с помощью инструкции [Добавить SSH-ключ](add-ssh.md).

          Загружать SSH-ключи в [профили OS Login](../concepts/os-login.md#os-login-profiles) сервисных аккаунтов могут только пользователи [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративные](../../iam/concepts/users/accounts.md#saml-federation) или [локальные](../../iam/concepts/users/accounts.md#local) пользователи, которым назначена [роль](../security/index.md#organization-manager-osLogins-admin) `organization-manager.osLogins.admin` или выше.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для включения доступа по OS Login на уровне организации:

      ```bash
      yc organization-manager oslogin update-settings --help
      ```

  1. Получите идентификатор нужной организации:

      ```bash
      yc organization-manager organization list
      ```

      Результат:

      ```text
      +----------------------+-------------------------+-------------------------+
      |          ID          |          NAME           |          TITLE          |
      +----------------------+-------------------------+-------------------------+
      | bpf1smsil5q0******** | sample-organization-1   | My organization         |
      | bpf2c65rqcl8******** | sample-organization-new | New organization        |
      +----------------------+-------------------------+-------------------------+
      ```

  1. Включите доступ по OS Login для выбранной организации:

      ```bash
      yc organization-manager oslogin update-settings \
        --organization-id <идентификатор_организации> \
        --ssh-certificates-enabled \
        --ssh-user-keys-enabled \
        --allow-manage-own-keys
      ```

      Где:

      * `--organization-id` — полученный ранее идентификатор организации.
      * `--ssh-certificates-enabled` — доступ по OS Login при помощи SSH-сертификатов. Опция позволяет подключаться к ВМ и узлам кластеров Kubernetes по SSH-сертификату [через Yandex Cloud CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client).

          Чтобы выключить опцию, передайте значение `false` в этом параметре: `--ssh-certificates-enabled=false`.

      * `--ssh-user-keys-enabled` — доступ по OS Login при помощи SSH-ключей. Опция позволяет подключаться к ВМ и узлам кластеров Kubernetes через Yandex Cloud CLI или через стандартный SSH-клиент по SSH-ключу, сохраненному в профиле OS Login пользователя организации или сервисного аккаунта.

          Чтобы выключить опцию, передайте значение `false` в этом параметре: `--ssh-user-keys-enabled=false`.

      * `--allow-manage-own-keys` — разрешить пользователям загружать собственные SSH-ключи. Позволяет пользователям самостоятельно загружать в свой профиль OS Login публичные SSH-ключи для подключения к ВМ и узлам кластеров Kubernetes. Чтобы загрузить собственные SSH-ключи, воспользуйтесь инструкцией [Добавить SSH-ключ](add-ssh.md).

          Чтобы выключить опцию, передайте значение `false` в этом параметре: `--allow-manage-own-keys=false`.

          {% note info %}

          Загружать SSH-ключи в [профили OS Login](../concepts/os-login.md#os-login-profiles) сервисных аккаунтов могут только пользователи [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративные](../../iam/concepts/users/accounts.md#saml-federation) или [локальные](../../iam/concepts/users/accounts.md#local) пользователи, которым назначена [роль](../security/index.md#organization-manager-osLogins-admin) `organization-manager.osLogins.admin` или выше.

          {% endnote %}

      Результат:

      ```text
      user_ssh_key_settings:
        enabled: true
        allow_manage_own_keys: true
      ssh_certificate_settings:
        enabled: true
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_organizationmanager_os_login_settings" "my_os_login_settings" {
        organization_id = "<идентификатор_организации>"
        ssh_certificate_settings {
          enabled = true
        }
        user_ssh_key_settings {
          enabled               = true
          allow_manage_own_keys = true
        }
      }
      ```

      Где:

      * `organization_id` — идентификатор организации. Получить идентификатор организации вы можете с помощью команды [Yandex Cloud CLI](../../cli/quickstart.md) `yc organization-manager organization list` или в [интерфейсе Cloud Center](https://center.yandex.cloud).

      * `ssh_certificate_settings` — доступ по OS Login при помощи SSH-сертификатов. Опция позволяет подключаться к ВМ и узлам кластеров Kubernetes по SSH-сертификату [через Yandex Cloud CLI](../../compute/operations/vm-connect/os-login.md#connect-with-yc-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-with-ssh-client). Параметр `enabled` может принимать значения `true` (опция включена) и `false` (опция выключена).

      * `user_ssh_key_settings` — блок параметров для управления доступом с помощью пользовательских SSH-ключей.

          * `enabled` — доступ по OS Login при помощи SSH-ключей. Опция позволяет подключаться к ВМ и узлам кластеров Kubernetes через Yandex Cloud CLI по SSH-ключу, сохраненному в профиле пользователя организации. Может принимать значения `true` (опция включена) и `false` (опция выключена).

          * `allow_manage_own_keys` — разрешить пользователям загружать собственные SSH-ключи. Позволяет пользователям самостоятельно загружать в свой профиль OS Login публичные SSH-ключи для подключения к ВМ и узлам кластеров Kubernetes. Чтобы загрузить собственные SSH-ключи, воспользуйтесь инструкцией [Добавить SSH-ключ](add-ssh.md). Может принимать значения `true` (опция включена) и `false` (опция выключена).

          {% note info %}

          Загружать SSH-ключи в [профили OS Login](../concepts/os-login.md#os-login-profiles) сервисных аккаунтов могут только пользователи [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративные](../../iam/concepts/users/accounts.md#saml-federation) или [локальные](../../iam/concepts/users/accounts.md#local) пользователи, которым назначена [роль](../security/index.md#organization-manager-osLogins-admin) `organization-manager.osLogins.admin` или выше.

          {% endnote %}

      Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](../../terraform/resources/organizationmanager_os_login_settings.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание ресурсов.

      После этого настройки организации будут изменены. Чтобы убедиться в том, что доступ по OS Login включен, выполните команду Yandex Cloud CLI, указав идентификатор организации:

      ```bash
      yc organization-manager oslogin get-settings --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      user_ssh_key_settings:
        enabled: true
        allow_manage_own_keys: true
      ssh_certificate_settings:
        enabled: true
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateSettings](../api-ref/OsLogin/updateSettings.md) для ресурса [OsLogin](../api-ref/OsLogin/index.md) или вызовом gRPC API [OsLoginService/UpdateSettings](../api-ref/grpc/OsLogin/updateSettings.md).

{% endlist %}

{% note info %}

Минимально необходимая роль, позволяющая просматривать список профилей OS Login пользователей — [роль](../security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей OS Login, см. в разделе [Управление доступом в Yandex Identity Hub](../security/index.md#service-roles).

{% endnote %}

#### См. также {#see-also}

* [Создать профиль OS Login](os-login-profile-create.md)
* [Добавить SSH-ключ](add-ssh.md)
* [Подключиться к виртуальной машине по OS Login](../../compute/operations/vm-connect/os-login.md)
* [Подключиться к узлу Kubernetes через OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)