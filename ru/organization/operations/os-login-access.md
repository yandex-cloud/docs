---
title: "Как включить доступ по OS Login в организации"
description: "Следуя данной инструкции, вы сможете включить в организации доступ к виртуальным машинам и узлам кластеров {{ k8s }} по OS Login."
---

# Включить доступ по OS Login

Доступ по [OS Login](../concepts/os-login.md) позволяет подключаться к ВМ и узлам [кластеров](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ k8s }} c SSH-сертификатом [через YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) или [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate), а также через YC CLI [с SSH-ключом](../../compute/operations/vm-connect/os-login.md#connect-via-key), предварительно добавленным в профиль пользователя организации в {{ org-full-name }}.

Чтобы создавать виртуальные машины или узлы {{ k8s }} с доступом по OS Login, разрешите такую возможность на уровне организации. После этого вы сможете [включить](../../compute/operations/vm-control/vm-update.md#enable-oslogin-access) доступ по OS Login на ВМ, созданных из подготовленного образа с поддержкой OS Login, или самостоятельно [настроить](../../compute/operations/vm-connect/enable-os-login.md) агента OS Login на уже работающей ВМ. Подробнее про подключение по OS Login см. в разделе [{#T}](../../compute/operations/vm-connect/os-login.md).

{% note info %}

Образы с поддержкой OS Login доступны в [{{ marketplace-full-name }}](/marketplace) и содержат `OS Login` в названии.

{% endnote %}

Чтобы включить доступ по OS Login на уровне организации:

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#console}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. Включите необходимые варианты доступа:

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.
          Опция позволяет подключаться к ВМ или узлу кластера {{ k8s }} c SSH-сертификатом OS Login [через YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate).

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}**.
          Опция позволяет подключаться к ВМ или узлу кластера {{ k8s }} через YC CLI [с SSH-ключом](../../compute/operations/vm-connect/os-login.md#connect-via-key), сохраненным в профиле пользователя организации.

      * **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}**.
          Опция доступна, если включен доступ по OS Login при помощи SSH-ключей.
          Позволяет пользователям самостоятельно загружать в свой профиль публичные SSH-ключи для подключения к ВМ или узлам кластеров {{ k8s }}. Чтобы загрузить собственные SSH-ключи, воспользуйтесь инструкцией [Добавить SSH-ключ](./add-ssh.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
      * `--ssh-certificates-enabled` — доступ по OS Login при помощи SSH-сертификатов. Опция позволяет подключаться к ВМ c SSH-сертификатом OS Login [через YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate).

          Чтобы выключить опцию, передайте значение `false` в этом параметре: `--ssh-certificates-enabled=false`.

      * `--ssh-user-keys-enabled` — доступ по OS Login при помощи SSH-ключей. Опция позволяет подключаться к ВМ через YC CLI [с SSH-ключом](../../compute/operations/vm-connect/os-login.md#connect-via-key), сохраненным в профиле пользователя организации.

          Чтобы выключить опцию, передайте значение `false` в этом параметре: `--ssh-user-keys-enabled=false`.

      * `--allow-manage-own-keys` — разрешить пользователям загружать собственные SSH-ключи. Позволяет пользователям самостоятельно загружать в свой профиль публичные SSH-ключи для подключения к ВМ.  Чтобы загрузить собственные SSH-ключи, воспользуйтесь инструкцией [Добавить SSH-ключ](./add-ssh.md). Опция доступна, если включен доступ по OS Login при помощи SSH-ключей.

          Чтобы выключить опцию, передайте значение `false` в этом параметре: `--allow-manage-own-keys=false`.

      Результат:

      ```text
      user_ssh_key_settings:
        enabled: true
        allow_manage_own_keys: true
      ssh_certificate_settings:
        enabled: true
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

      * `organization_id` — идентификатор организации. Получить идентификатор организации вы можете с помощью команды [YC CLI](../../cli/quickstart.md) `yc organization-manager organization list` или в [консоли управления]({{ link-console-main }}).

      * `ssh_certificate_settings` — доступ по OS Login при помощи SSH-сертификатов. Опция позволяет подключаться к ВМ c SSH-сертификатом OS Login [через YC CLI](../../compute/operations/vm-connect/os-login.md#connect-via-cli) и [через стандартный SSH-клиент](../../compute/operations/vm-connect/os-login.md#connect-via-exported-certificate). Параметр `enabled` может принимать значения `true` (опция включена) и `false` (опция выключена).

      * `user_ssh_key_settings` — блок параметров для управления доступом с помощью пользовательских SSH-ключей.

          * `enabled` — доступ по OS Login при помощи SSH-ключей. Опция позволяет подключаться к ВМ через YC CLI [с SSH-ключом](../../compute/operations/vm-connect/os-login.md#connect-via-key), сохраненным в профиле пользователя организации. Может принимать значения `true` (опция включена) и `false` (опция выключена).

          * `allow_manage_own_keys` — разрешить пользователям загружать собственные SSH-ключи. Позволяет пользователям самостоятельно загружать в свой профиль публичные SSH-ключи для подключения к ВМ. Чтобы загрузить собственные SSH-ключи, воспользуйтесь инструкцией [Добавить SSH-ключ](./add-ssh.md). Опция доступна, если включен доступ по OS Login при помощи SSH-ключей. Может принимать значения `true` (опция включена) и `false` (опция выключена).

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_os_login_settings).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание ресурсов.

      После этого настройки организации будут изменены. Чтобы убедиться в том, что доступ по OS Login включен, выполните команду YC CLI, указав идентификатор организации:

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

  Воспользуйтесь методом REST API [updateSettings](../../organization/api-ref/OsLogin/updateSettings.md) для ресурса [OsLogin](../../organization/api-ref/OsLogin/index.md) или вызовом gRPC API [OsLoginService/UpdateSettings](../../organization/api-ref/grpc/os_login_service.md#UpdateSettings).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Подключиться к узлу {{ k8s }} через OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)