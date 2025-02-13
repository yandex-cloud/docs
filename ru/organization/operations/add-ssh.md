---
title: Как добавить SSH-ключ пользователя
description: Следуя данной инструкции, вы сможете добавить в профиль пользователя SSH-ключи, которые позволят ему подключаться к ВМ и узлам кластеров {{ k8s }}.
---

# Добавить SSH-ключ

Загрузите SSH-ключи в профиль пользователя организации или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) в {{ org-name }}, чтобы с их помощью пользователь или сервисный аккаунт мог подключаться к виртуальным машинам и узлам кластеров {{ k8s }}.

При необходимости перед выполнением инструкции [создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) новую пару SSH-ключей.

Чтобы добавить публичный SSH-ключ в профиль {{ oslogin }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
 
  1. В списке выберите пользователя, в профиль {{ oslogin }} которого вы хотите добавить SSH-ключ.
  
      При необходимости воспользуйтесь фильтром или поиском.

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.page.user.title_tab-ssh-keys }}** и нажмите кнопку **{{ ui-key.yacloud_org.entity.ssh-keys.action.add-key }}**. В открывшемся окне:
  
      1. Задайте имя для добавляемого SSH-ключа.

      1. Введите вручную или загрузите из файла открытый SSH-ключ.

      1. Задайте срок действия загружаемого ключа.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для загрузки SSH-ключа в профиль пользователя:

      ```bash
      yc organization-manager oslogin user-ssh-key create --help
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

  1. Получите идентификатор нужного пользователя, указав полученный ранее идентификатор организации:

      ```bash
      yc organization-manager user list \
        --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      +----------------------+-----------------------+---------------------------------+----------------------+
      |          ID          |       USERNAME        |              EMAIL              |    FEDERATION ID     |
      +----------------------+-----------------------+---------------------------------+----------------------+
      | aje5qd0po0nj******** | sample-user-1         | sample-user-1@yandex.ru         |                      |
      | ajee30kevjjf******** | sample-user-2         | sample-user-2@yandex.ru         |                      |
      | ajeeg4ju49h6******** | sample-user-3         | sample-user-3@yandex.ru         | bpfbl7q3mjbr******** |
      | ajei280a73vc******** | sample-user-4         | sample-user-4@yandex.ru         |                      |
      +----------------------+-----------------------+---------------------------------+----------------------+
      ```

      Если вы хотите добавить SSH-ключ в профиль {{ oslogin }} сервисного аккаунта, [получите](../../iam/operations/sa/get-id.md) идентификатор нужного сервисного аккаунта.

  1. Загрузите SSH-ключ в профиль пользователя или сервисного аккаунта:

      ```bash
      yc organization-manager oslogin user-ssh-key create \
        --organization-id <идентификатор_организации> \
        --name "<имя_ключа>" \
        --subject-id <идентификатор_пользователя_или_СА> \
        --data "<публичный_SSH-ключ>" \
        --expires-at <срок_действия_ключа>
      ```

      Где:

      * `--organization-id` — полученный ранее [идентификатор](./organization-get-id.md) организации.
      * `--name` — имя загружаемого ключа.
      * `--subject-id` — полученный ранее идентификатор [пользователя](./users-get.md) или [сервисного аккаунта](../../iam/operations/sa/get-id.md), в профиль которого добавляется SSH-ключ.
      * `--data` — содержимое публичного SSH-ключа.
      * `--expires-at` — срок действия загружаемого ключа. Необязательный параметр. Позволяет установить для загружаемого ключа произвольный срок действия. Значение может задаваться в двух форматах:

          * дата окончания действия ключа в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `YYYY-MM-DDT00:00:00Z`;
          * продолжительность действия ключа в часах и минутах, например `1h` или `3h30m`.

      Результат:

      ```text
      id: bpfrtmgobqvc********
      subject_id: ajei280a73vc********
      data: ssh-ed25519 AAAAC3Nza_YOUR_PUBLIC_SSH_KEY_Ejal+P1sRgYA3T
      name: My Key
      fingerprint: SHA256:EJQdhwWDFj4TebYQzx9CmKZHr53rNN59u0W********
      organization_id: bpf2c65rqcl8********
      created_at: "2024-03-12T17:42:31.339022059Z"
      expires_at: "2024-03-12T21:12:31.176467230Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_organizationmanager_user_ssh_key" "my_user_ssh_key" {
        organization_id = "<идентификатор_организации>"
        subject_id      = "<идентификатор_пользователя>"
        data            = "<публичный_SSH-ключ>"
        name            = "<имя_ключа>"
        expires_at      = "<срок_действия_ключа>"
      }
      ```

      Где:

      * `organization_id` — [идентификатор](./organization-get-id.md) организации.
      * `subject_id` — идентификатор [пользователя](./users-get.md) или [сервисного аккаунта](../../iam/operations/sa/get-id.md), в профиль которого добавляется SSH-ключ.
      * `data` — содержимое публичного SSH-ключа.
      * `name` — имя загружаемого ключа.
      * `expires_at` — срок действия загружаемого ключа. Необязательный параметр. Позволяет установить для загружаемого ключа произвольные время и дату, по истечении которых ключ становится недействительным. Значение задается в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `YYYY-MM-DDT00:00:00Z`.

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_user_ssh_key).

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

      После этого в профиль пользователя будет загружен SSH-ключ. Чтобы убедиться в том, что SSH-ключ добавлен, выполните команду YC CLI, указав идентификатор организации:

      ```bash
      yc organization-manager oslogin user-ssh-key list --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      +----------------------+--------+----------------------+----------------------+----------------------------------------------------+---------------------+---------------------+
      |          ID          |  NAME  |   ORGANIZATION ID    |      SUBJECT ID      |                    FINGERPRINT                     |     CREATED AT      |     EXPIRES AT      |
      +----------------------+--------+----------------------+----------------------+----------------------------------------------------+---------------------+---------------------+
      | bpf6big3s4h0******** | My key | bpf2c65rqcl8******** | ajei280a73vc******** | SHA256:EJQdhwWDFj4TebYQzx9CmKZHr53rNN59u0W******** | 2024-03-12 18:48:17 | 2024-03-12 21:12:31 |
      +----------------------+--------+----------------------+----------------------+----------------------------------------------------+---------------------+---------------------+
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../organization/api-ref/UserSshKey/create.md) для ресурса [UserSshKey](../../organization/api-ref/UserSshKey/index.md) или вызовом gRPC API [UserSshKeyService/Create](../../organization/api-ref/grpc/UserSshKey/create.md).

{% endlist %}

Добавить SSH-ключ в профиль сервисного аккаунта можно только с помощью CLI, {{ TF }} или API.

Чтобы пользователи могли самостоятельно загружать SSH-ключи в свои профили, [включите](./os-login-access.md) опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}**.

#### См. также {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Подключиться к узлу {{ k8s }} через {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)