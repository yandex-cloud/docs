---
title: Как создать профиль {{ oslogin }}
description: Следуя данной инструкции, вы сможете создать профиль {{ oslogin }}.
---

# Создать профиль {{ oslogin }}

[Профили {{ oslogin }}](../concepts/os-login.md#os-login-profiles) по умолчанию создаются для всех пользователей организации и [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md) при [включении доступа по {{ oslogin }}](./os-login-access.md). У одного пользователя или сервисного аккаунта в организации {{ org-name }} может быть несколько профилей {{ oslogin }} — разные профили позволяют подключаться к [ВМ](../../compute/concepts/vm.md) или узлам [кластеров](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ k8s }} от имени разных локальных пользователей этих ВМ или узлов {{ k8s }}.

{% include [os-login-profile-tab-access-notice](../../_includes/organization/os-login-profile-tab-access-notice.md) %}

Чтобы создать дополнительный профиль {{ oslogin }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
 
  1. В списке выберите пользователя, для которого вы хотите создать профиль {{ oslogin }}.
  
      При необходимости воспользуйтесь фильтром или поиском.
  
  1. На странице пользователя перейдите на вкладку **{{ ui-key.yacloud_org.user.title_oslogin-profiles }}** и нажмите кнопку **{{ ui-key.yacloud_org.entity.oslogin-profile.action.create }}**. В открывшемся окне:

      1. Введите имя пользователя в ОС, которое будет присвоено пользователю организации или сервисному аккаунту при подключении к ВМ. Должно быть уникальным в пределах системы.

          {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

      1. В поле **{{ ui-key.yacloud_org.form.oslogin.field_uid }}** задайте уникальный числовой идентификатор пользователя (UID) в диапазоне от `1000` до `65534`. Должен быть уникальным в пределах системы.

      1. (Опционально) В поле **{{ ui-key.yacloud_org.form.oslogin.field_home-directory }}** укажите путь к домашнему каталогу пользователя.

      1. (Опционально) В поле **{{ ui-key.yacloud_org.form.oslogin.field_shell }}** укажите путь к исполняемому файлу командной оболочки.

      1. Нажмите кнопку **{{ ui-key.yacloud_org.forms.action.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания профиля {{ oslogin }}:

      ```bash
      yc organization-manager oslogin profile create --help
      ```

  1. Получите идентификатор нужной организации:

      ```bash
      yc organization-manager organization list
      ```

      Результат:

      ```text
      +----------------------+-------------------------+-----------------------+--------+
      |          ID          |          NAME           |         TITLE         | LABELS |
      +----------------------+-------------------------+-----------------------+--------+
      | bpf1smsil5q0******** | sample-organization-1   | My organization       |        |
      | bpf2c65rqcl8******** | sample-organization-new | New organization      |        |
      +----------------------+-------------------------+-----------------------+--------+
      ```

  1. Получите идентификатор нужного пользователя, указав идентификатор организации, к которой он относится:

      ```bash
      yc organization-manager user list \
        --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      +----------------------+----------+-------------------+---------------+-----------------------+
      |          ID          | USERNAME |       EMAIL       | FEDERATION ID | LAST AUTHENTICATED AT |
      +----------------------+----------+-------------------+---------------+-----------------------+
      | rser11gh89el******** | user01   | user01@example.ru |               |                       |
      | mber02hy54km******** | user02   | user02@example.ru |               |                       |
      +----------------------+----------+-------------------+---------------+-----------------------+
      ```

      Если вы хотите создать профиль {{ oslogin }} для сервисного аккаунта, [получите](../../iam/operations/sa/get-id.md) идентификатор нужного сервисного аккаунта.

  1. Создайте профиль {{ oslogin }} для выбранного пользователя или сервисного аккаунта:

      ```bash
      yc organization-manager oslogin profile create \
        --organization-id <идентификатор_организации> \
        --subject-id <идентификатор_пользователя_или_сервисного_аккаунта> \
        --login <логин> \
        --uid <числовой_идентификатор> \
        --home-directory <путь_к_домашнему_каталогу> \
        --shell <путь_до_исполняемого_файла_командной_оболочки>
      ```

      Где:

      * `--organization-id` — полученный ранее идентификатор организации.
      * `--subject-id` — полученный ранее идентификатор пользователя или сервисного аккаунта.
      * `--login` — имя пользователя в ОС, которое будет присвоено ему при подключении к ВМ. Должно быть уникальным в пределах системы.

          {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

      * `--uid` — уникальный числовой идентификатор пользователя (UID) в диапазоне от `1000` до `65534`. Должен быть уникальным в пределах системы.
      * `--home-directory` — путь к домашнему каталогу пользователя на ВМ. Необязательный параметр. Значение по умолчанию — `/home/<имя_пользователя>`.
      * `--shell` — путь к исполняемому файлу командной оболочки на ВМ. Необязательный параметр. Значение по умолчанию — `/bin/bash`.

      Результат:

      ```text
      id: aje6ddct3de5********
      organization_id: bpf1smsil5q0********
      subject_id: rser11gh89el********
      login: new-os-login
      uid: "100500"
      home_directory: home/username
      shell: bin/bash
      ```

- API {#api}

  Воспользуйтесь методом REST API [createProfile](../../organization/api-ref/OsLogin/createProfile.md) для ресурса [OsLogin](../../organization/api-ref/OsLogin/index.md) или вызовом gRPC API [OsLoginService/CreateProfile](../../organization/api-ref/grpc/OsLogin/createProfile.md).

{% endlist %}

Создать профиль {{ oslogin }} сервисного аккаунта можно только с помощью {{ yandex-cloud }} CLI или API.

{% note info %}

Если вы задаете UID вручную, используйте значения в диапазоне от `1000` до `65534`. Использование этого диапазона позволит избежать совпадения UID профиля {{ oslogin }} и системных профилей операционной системы.

{% endnote %}

#### См. также {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Подключиться к узлу {{ k8s }} через {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](../tutorials/sa-oslogin-ansible.md)